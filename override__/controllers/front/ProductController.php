<?php
/**
 * @author Splitit
 * @copyright 2017-2018 Splitit
 * @license BSD 2 License
 * @since 1.6.0
 */
require('../../../../splitit/override/controllers/front/ProductController.php');
class ProductController extends ProductController
{
    /**
     * Assign template vars related to page content
     * @see FrontController::initContent()
     */
    public function initContent()
    {
        parent::initContent();

        $this->context->smarty->assign(
            'HOOK_SPLITITPAYMENTFORM_INSTALLMENT',
            Hook::exec('displaySplititpaymentformInstallment', array('product' => $this->product))
        );
    }
}
