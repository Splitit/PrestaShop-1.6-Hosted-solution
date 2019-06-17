{*
*  @author Splitit
*  @copyright  2017-2018 Splitit
*  @since 1.6.0
*  @license BSD 2 License
*}

{if isset($splititpaymentform_save_success)}
<div class="alert alert-success" role="alert">
    <strong>{l s='Congratulation !' mod='splititpaymentform'}</strong>        
    {if $sandbox_mode == 0}
    {l s='You can now start accepting Payment with Splitit.' mod='splititpaymentform'}
    {elseif $sandbox_mode == 1}
    {l s='You can now start testing Splitit Payment Form. Don\'t forget to comeback to this page and activate the live mode in order to start accepting payements.' mod='splititpaymentform'}
    {/if}
</div>
{/if}
<div class="container" style="width: 100%;padding-left: 25px;">

    <div class="row">
        <h3>{l s='Splitit Payment Form Settings' mod='splititpaymentform'}</h3>    

        <div class="col-sm-12">
            <div class="comment">
                <a href="{$split_url|escape:'htmlall':'UTF-8'}" target="_blank">
                    {l s='Click here to sign up for a Splitit account' mod='splititpaymentform'}
                </a>
            </div>
            <form method="post" action="{$smarty.server.REQUEST_URI|escape:'htmlall':'UTF-8'}" id="splititpaymentform_configuration">
                <table cellspacing="0" class="table">
                    <tbody>
                        <tr>
                            <td>
                                <label for="is_enabled"> {l s='Enabled' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <select id="is_enabled" name="is_enabled">
                                    <option value="1" {if $is_enabled == 1}selected="selected"{/if}>{l s='Yes' mod='splititpaymentform'}</option>
                                    <option value="0" {if $is_enabled == 0}selected="selected"{/if}>{l s='No' mod='splititpaymentform'}</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"><h4 class="splitit_label_header"> {l s='General settings' mod='splititpaymentform'}</h4></td>
                        </tr>
                        <tr>
                            <td>
                                <label> {l s='Terminal API key' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <input id="api_key" name="api_key" value="{$api_key|escape:'htmlall':'UTF-8'}" class=" input-text" type="text" >
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label> {l s='API Username' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <input id="api_user_name" name="api_user_name" value="{$api_user_name|escape:'htmlall':'UTF-8'}" class=" input-text" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label> {l s='API Password' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <input id="api_password" name="api_password" value="{$api_password|escape:'htmlall':'UTF-8'}" class=" input-text" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label> {l s='Sandbox Mode' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <select id="sandbox_mode" name="sandbox_mode">
                                    <option value="1" {if $sandbox_mode == 1}selected="selected"{/if}>{l s='Yes' mod='splititpaymentform'}</option>
                                    <option value="0" {if $sandbox_mode == 0}selected="selected"{/if}>{l s='No' mod='splititpaymentform'}</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label> {l s='Check Credential API' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <button id="splititpaymentform_button" title="Check Settings" type="button" class="btn btn-primary" onClick="login('{$baseUrl|escape:'htmlall':'UTF-8'}');"><span>{l s='Check Settings' mod='splititpaymentform'}</span>
                                    </span>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label> {l s='Payment method title' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                               <input id="method_title" name="method_title" value="{if isset($method_title) && $method_title}{$method_title|escape:'htmlall':'UTF-8'}{else}{l s='Payment Form - Monthly payments - 0% Interest' mod='splititpaymentform'}{/if}" class=" input-text" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label> {l s='Payment page title' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                               <input id="payment_page_title" name="payment_page_title" value="{if isset($payment_page_title) && $payment_page_title}{$payment_page_title|escape:'htmlall':'UTF-8'}{else}{l s='Splitit Payment Form' mod='splititpaymentform'}{/if}" class=" input-text" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label> {l s='Payment page text' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <!-- <script type="text/javascript" src="{$baseUrl}js/tiny_mce/tiny_mce.js"></script>
                                <script language="javascript" type="text/javascript">
                                $(function() {
                                    tinySetup();
                                });
                                </script> -->
                                <script type="text/javascript">
                                    var iso = '{$iso|escape:'quotes':'UTF-8'}';
                                    var pathCSS = '{$smarty.const._THEME_CSS_DIR_|escape:'quotes':'UTF-8'}';
                                    var ad = '{$ad|escape:'quotes':'UTF-8'}';
                                    $(document).ready(function(){


                                            tinySetup({
                                                editor_selector :"autoload_rte",
                                                relative_urls : false,
                                                plugins : "colorpicker link image paste pagebreak table contextmenu filemanager table code media autoresize textcolor fullpage",
                                                extended_valid_elements : "em[class|name|id],html,head"
                                            });


                                    });
                                </script>
                               <textarea id="payment_page_text" name="payment_page_text" class="rte autoload_rte">{if isset($payment_page_text) && $payment_page_text}{$payment_page_text}{/if}</textarea>
                               <span class="important">NOTE: also add <b>$$$</b> where you wish to show order total</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label> {l s='3DSecure enable' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <select id="secure_3d" name="secure_3d">
                                    <option value="1" {if isset($secure_3d) && $secure_3d == 1}selected="selected"{/if}>{l s='Yes' mod='splititpaymentform'}</option>
                                    <option value="0" {if isset($secure_3d) && $secure_3d == 0}selected="selected"{/if}>{l s='No' mod='splititpaymentform'}</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label> {l s='Min amount for 3D Secure' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                               <input min="0" id="secure_3d_min_amount" name="secure_3d_min_amount" value="{if isset($secure_3d_min_amount)}{$secure_3d_min_amount}{else}0{/if}" class=" input-text" type="number">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label> {l s='Help link title' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                               <input id="help_link_title" name="help_link_title" value="{if isset($help_link_title) && $help_link_title}{$help_link_title|escape:'htmlall':'UTF-8'}{else}{l s='Tell me more' mod='splititpaymentform'}{/if}" class=" input-text" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label> {l s='Help link URL' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                               <input id="help_link_url" name="help_link_url" value="{if isset($help_link_url) && $help_link_url}{$help_link_url|escape:'htmlall':'UTF-8'}{else}https://s3.amazonaws.com/splitit-images-prod/learnmore/en-us/V1-USD.png{/if}" class=" input-text" type="text">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <h4 class="splitit_label_header"> {l s='Shop Setup' mod='splititpaymentform'}</h4>
                            </td>
                        </tr>
                        <!-- <tr>
                            <td>
                                <label> {l s='Credit Card Types' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <select id="card_types" name="card_types[]" size="10" multiple="multiple">
                                    {foreach from=$credit_cards key=card_key item=credit_card}
                                        <option value="{$card_key|escape:'htmlall':'UTF-8'}" {if $card_key|in_array:$card_types}selected="selected"{/if}>{$credit_card|escape:'htmlall':'UTF-8'}</option>
                                    {/foreach}                                
                                </select>
                            </td>
                        </tr> -->
                        <tr>
                            <td>
                                <label> {l s='Payment action' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <select id="payment_action" name="payment_action">
                                    <option value="purchase" {if isset($payment_action) && $payment_action == 'purchase'}selected="selected"{/if}>{l s='Charge my consumer at the time of the purchase' mod='splititpaymentform'}</option>
                                    <option value="shipped" {if isset($payment_action) && $payment_action == 'shipped'}selected="selected"{/if}>{l s='Charge my consumer when the shipment is ready' mod='splititpaymentform'}</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <h4 class="splitit_label_header"> {l s='Installment Setup' mod='splititpaymentform'}</h4>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>{l s='First Payment' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <select id="first_payment" name="first_payment" onchange="checkFirstPayment(this);">
                                    <option value="disable" {if isset($first_payment) && $first_payment == 'disable'}selected="selected"{/if}>{l s='Disable' mod='splititpaymentform'}</option>
                                    <option value="percentage" {if isset($first_payment) && $first_payment == 'percentage'}selected="selected"{/if}>{l s='Equal to percentage of the order [X]' mod='splititpaymentform'}</option>
                                    <option value="shipping" {if isset($first_payment) && $first_payment == 'shipping'}selected="selected"{/if}>{l s='Only Shipping' mod='splititpaymentform'}</option>
                                </select>
                            </td>
                        </tr>
                        <tr id="first_payment_row" style="{if isset($first_payment) && $first_payment != 'percentage'}display: none;{/if}">
                            <td>
                                <label> {l s='Percentage of order %' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                               <input min="1" max="50" id="percentage_of_order" name="percentage_of_order" value="{$percentage_of_order|escape:'htmlall':'UTF-8'}" class=" input-text" type="number">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>{l s='Installment Type' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <select id="installment_type" class="{$installment_type}" name="installment_type" onchange="showRow(this);">
                                    <option value="1" {if isset($installment_type) && $installment_type == 1}selected="selected"{/if}>{l s='Fixed' mod='splititpaymentform'}</option>
                                    <option value="2" {if isset($installment_type) && $installment_type == 2}selected="selected"{/if}>{l s='Depending on cart total' mod='splititpaymentform'}</option>
                                </select>
                            </td>
                        </tr>
                        <tr id="fixed_installments_row" class="fixed_installments" style="{if isset($installment_type) && $installment_type != 1}display: none;{/if}">
                            <td>
                                <label for="fixed_installment"> {l s='Select Installments' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <select id="fixed_installment" name="fixed_installment[]" size="10" multiple="multiple">
                                    {foreach from=$installments key=installment_key item=installment}
                                        <option value="{$installment_key|escape:'htmlall':'UTF-8'}" {if $installment_key|in_array:$fixed_installment}selected="selected"{/if}>{$installment|escape:'htmlall':'UTF-8'}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr id="depending_on_cart_row" class="depending_on_cart" style="{if isset($installment_type) && $installment_type != 2}display: none;{/if}">
                            <td>
                                <label for="depending_on_cart"> {l s='Select Installments' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <input type="hidden" id="depending_on_cart" name="depending_on_cart" value="{$depending_on_cart|escape:'htmlall':'UTF-8'}">
                                <table id="depending_on_cart_table" style="border: 1 solid;">
                                    <thead>
                                        <tr>
                                            <th>{l s='Cart Amount' mod='splititpaymentform'}</th>
                                            <th>{l s='Installments' mod='splititpaymentform'}</th>
                                            <th>{l s='Action' mod='splititpaymentform'}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="3">
                                                <button type="button" onclick="addDependingOnCartRow();">
                                                    {l s='Add Row' mod='splititpaymentform'}
                                                </button>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <h4 class="splitit_label_header"> {l s='Installment price setup' mod='splititpaymentform'}</h4></td>
                        </tr>
                        <tr>
                            <td>
                                <label> {l s='Enable Installment Price' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <select id="enable_price" name="enable_price">
                                    <option value="1" {if $enable_price == 1}selected="selected"{/if}>{l s='Yes' mod='splititpaymentform'}</option>
                                    <option value="0" {if $enable_price == 0}selected="selected"{/if}>{l s='No' mod='splititpaymentform'}</option>
                                </select>
                            </td>

                            <script type="text/javascript">

                            </script>
                        </tr>
                        <tr class="instalment_price_row">
                            <td>
                                <label> {l s='Display Installment Price on pages' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <select id="installment_price_on_pages" name="installment_price_on_pages[]" size="10" multiple="multiple">
                                    {foreach from=$show_on_pages key=page_key item=show_on_page}
                                        <option value="{$page_key|escape:'htmlall':'UTF-8'}" {if $page_key|in_array:$installment_price_on_pages}selected="selected"{/if}>{$show_on_page|escape:'htmlall':'UTF-8'}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr class="instalment_price_row">
                            <td>
                                <label> {l s='Number of installments for display' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <select id="installemnt_count" name="installemnt_count">
                                    {foreach from=$installments key=installment_key item=installment}
                                        <option value="{$installment_key|escape:'htmlall':'UTF-8'}" {if $installment_key == $installemnt_count}selected="selected"{/if}>{$installment|escape:'htmlall':'UTF-8'}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr class="instalment_price_row">
                            <td>
                                <label> {l s='Installment price text' mod='splititpaymentform'}</label>
                            </td>
                            <td>
                                <input id="price_text" name="price_text" value="{$price_text|escape:'htmlall':'UTF-8'}" class="form-control" type="text">
                            </td>
                        </tr>                                         
                        <tr>
                            <td colspan="2"><input type="submit" name="submitSplititpaymentform" value="{l s='Save' mod='splititpaymentform'}" id="splititpaymentform_submit" class="btn btn-primary pull-right" /></td>
                        </tr>

                    </tbody>
                </table>
            </form>    
        </div>
    </div>

</div>


