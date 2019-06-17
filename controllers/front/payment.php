<?php
/**
 * @author Splitit
 * @copyright 2017-2018 Splitit
 * @license BSD 2 License
 * @since 1.6.0
 */

class SplititpaymentformPaymentModuleFrontController extends ModuleFrontController
{
    public $ssl = true;
    public $display_column_left = false;
    public $display_column_right = false;

    public function __construct()
    {
        parent::__construct();
        $this->context = Context::getContext();
        include_once($this->module->getLocalPath().'splititpaymentform.php');
    }

    /**
     * @see FrontController::initContent()
     */
    public function initContent()
    {
        parent::initContent();

        $splititpaymentform = new Splititpaymentform();

        $cart = $this->context->cart;
        $this->context->cookie->isAsync = false;
        if ((!$this->module->checkCurrency($cart)
                    || $cart->id == ''
                    || ($cart->getOrderTotal() <= 0)
                    || !$splititpaymentform->active || !Configuration::get('SPLITITPAYMENTFORM_IS_ENABLED')
                    || !Configuration::get('SPLITITPAYMENTFORM_API_KEY')
                    || !Configuration::get('SPLITITPAYMENTFORM_API_USER_NAME')
                    || !Configuration::get('SPLITITPAYMENTFORM_API_PASSWORD'))&&Tools::getValue('process') != 'successasync') {
            Tools::redirect('index.php?controller=order');
        }
        $Error = '';
        try{            
            if (Tools::getValue('process') == 'success') {
                $this->successSplitit();
            }
            if (Tools::getValue('process') == 'successasync') {
                // die('testing async url');
                $this->context->cookie->isAsync = true;
                $this->successSplititAsync();
            }
        } catch(Exception $e){
            $Error = $e->getMessage();
            $this->errors[] = Tools::displayError($Error);
            Tools::redirect('order');
        }

        // Get saved credit cards types from configuration
        // $saved_credit_cards = explode(',', Configuration::get('SPLITITPAYMENTFORM_CARD_TYPES'));

        $currency = Currency::getCurrency((int)$this->context->cart->id_currency);
        $cart_total = $this->context->cart->getOrderTotal();
        // Installment Setup
        if (Configuration::get('SPLITITPAYMENTFORM_INSTALLMENT_SETUP') == IS_FIXED || Configuration::get('SPLITITPAYMENTFORM_INSTALLMENT_SETUP' == IS_DEPENDING_ON_CART)) {
            $fixed_installment = explode(',', Configuration::get('SPLITITPAYMENTFORM_FIXED_INSTALLMENT'));
            $front_drop = array();
            foreach ($fixed_installment as $installment) {
                $front_drop[$installment] = $installment. ' installments of '. Tools::displayPrice(round($cart_total / $installment, 2), $currency);
            }
        }
        /*$summary = $this->context->cart->getSummaryDetails();
        echo '<pre>';
        $customer = new Customer(intval($summary['delivery']->id_customer));
        echo $customer->email;
        echo "-----cart_id====".$this->context->cart->id;
        print_r($summary);die;*/

        $response = $splititpaymentform->login();
        if(!$response['status']){
            $Error = $response['code'].': '.$response['message'];
            $this->errors[] = Tools::displayError($Error);
        }
        $hasGatewayURL = false;
        if(!empty($response)&&isset($response['status'])&&$response['status']){
            if(isset($response['checkoutUrl'])&&$response['checkoutUrl']){
                $hasGatewayURL = true;                
            }
        }

        $this->context->smarty->assign(array(
            'nbProducts' => $cart->nbProducts(),
            'cust_currency' => $cart->id_currency,
            'currencies' => $this->module->getCurrency((int)$cart->id_currency),
            'total' => Tools::displayPrice($cart->getOrderTotal(true, Cart::BOTH)),
            'gateway_url' => ($hasGatewayURL)?$response['checkoutUrl']:false,
            'isoCode' => $this->context->language->iso_code,
            'this_path' => $this->module->getPathUri(),
            'this_path_splititpaymentform' => $this->module->getPathUri(),
            'this_path_ssl' => Tools::getShopDomainSsl(true, true).__PS_BASE_URI__.'modules/'.$this->module->name.'/',
            'splititpaymentform_ps_version' => _PS_VERSION_,
            /*'credit_cards' => SplitItpaymentform::getCreditCards(),
            'saved_credit_cards' => $saved_credit_cards,
            'months' => Splititpaymentform::getMonths(),
            'years' => Splititpaymentform::getYears(),*/
            'installments' => $front_drop,
            'method_title' => $splititpaymentform->getPaymentFormTitle(),
            'help_link_title' => $splititpaymentform->getHelpLinkTitle(),
            'help_link_url' => $splititpaymentform->getHelpLinkURL(),
            'payment_page_title' => $splititpaymentform->getPaymentPageTitle(),
            'payment_page_text' => $splititpaymentform->getPaymentPageText(),
            'path' => $this->module->getPathUri(),
            'splitit_error' => $response['message'],
            'error' => $Error,
        ));

        //$this->context->controller->addJS($this->module->getPathUri().'js/splitit.js');
        $this->context->controller->addJS($this->module->getPathUri().'views/js/jquery.payment.min.js');
        $this->context->controller->addJS($this->module->getPathUri().'views/js/splitit.js');
        $this->context->controller->addCSS($this->module->getPathUri().'views/css/splitit.css');

        $this->setTemplate('payment_execution.tpl');
    }

    public function successSplitit(){
        if(!Tools::getValue('InstallmentPlanNumber')){
            throw new Exception("Error Processing Request. InstallmentPlanNumber not found.");            
        }
        /*$summary = $this->context->cart->getSummaryDetails();
        echo '<pre>';
        $customer = new Customer(intval($summary['delivery']->id_customer));
        echo $customer->email;
        print_r($summary);die;*/
        $splititpaymentform = new Splititpaymentform();
        $result = $splititpaymentform->processPayment();
        if(isset($result['redirect'])&&$result['redirect']){
            Tools::redirectLink($result['redirect']);
        } else {
            $this->errors[] = Tools::displayError($result['message']);
            Tools::redirect('order');
        }
    }

    public function successSplititAsync(){
        if(!Tools::getValue('InstallmentPlanNumber')){
            throw new Exception("Error Processing Request. InstallmentPlanNumber not found.");            
        }
        /*var_dump($this->context->cookie->isAsync);die('===Async');*/
        $this->context->cookie->installmentPlanNumber = Tools::getValue('InstallmentPlanNumber');
        /*$summary = $this->context->cart->getSummaryDetails();
        echo '<pre>';
        $customer = new Customer(intval($summary['delivery']->id_customer));
        echo $customer->email;
        print_r($summary);die;*/
        $splititpaymentform = new Splititpaymentform();
        $result = $splititpaymentform->processPayment();
        if(isset($result['redirect'])&&$result['redirect']){
            Tools::redirectLink($result['redirect']);
        } else {
            $this->errors[] = Tools::displayError($result['message']);
            Tools::redirect('order');
        }
    }
}
