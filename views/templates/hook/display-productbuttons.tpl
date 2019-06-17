{*
*  @author Splitit
*  @copyright  2017-2018 Splitit
*  @since 1.6.0
*  @license BSD 2 License
*}

<!-- <div class="splitit_installment_price_product"><strong>{$outputHtml|escape:'htmlall':'UTF-8'}</strong></div> -->
<div class="splitit_installment_price_product" style="text-align: center;font-size: 18px;padding-bottom: 10px;"><img src="https://www.splitit.com/wp-content/uploads/2018/10/splitit.svg" class="desktop" alt="Splitit" style="
    background: #3E505B;
    height: 25%;
    width: 25%;
    padding: 5px;
"><strong style="padding-left: 6px;">{$outputHtml|escape:'htmlall':'UTF-8'}</strong></div>
{literal} 
	<script>$("div.splitit_installment_price").hide();</script>
{/literal}