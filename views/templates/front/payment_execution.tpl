{*
*  @author Splitit
*  @copyright  2017-2018 Splitit
*  @since 1.6.0
*  @license BSD 2 License
*}

{literal}
<script>

//var baseUrl = "{/literal}{$base_dir|escape:'htmlall':'UTF-8'}{literal}";

var baseUrl = window.location.origin+'/';
</script>
{/literal}

{capture name=path}
	<a href="{$link->getPageLink('order', true, NULL, "step=3")|escape:'html':'UTF-8'}" title="{l s='Go back to the Checkout' mod='splititpaymentform'}">{l s='Checkout' mod='splititpaymentform'}</a><span class="navigation-pipe">{$navigationPipe}</span>{$payment_page_title}
{/capture}

<h2>{l s='Order summary' mod='splititpaymentform'}</h2>


{assign var='current_step' value='payment'}
{include file="$tpl_dir./order-steps.tpl"}

{if $error}
<p class="error">{$error}</p>
{/if}
{if $nbProducts <= 0}
<p class="warning">{l s='Your shopping cart is empty.' mod='splititpaymentform'}</p>
{else}

<form name="splititpaymentform_form" id="splititpaymentform_form" action="{$link->getModuleLink('splititpaymentform', 'validation', [], true)|escape:'html'}" method="post">
    <div class="splitit-payment-errors"></div>
    <div class="box">
        <input type="hidden" name="confirm" value="1">
        <h3 class="page-subheading">{$payment_page_title}{if $help_link_title} <a style="float: none; font-weight: normal; font-size: 13px; padding-left: 10px; color: #bd519c; text-transform: none;" href="{$help_link_url}" onclick="popWin(this.href, '{$help_link_title}', 'width=800,height=1075,left=0,top=0,location=no,status=no,resizable=no'); return false;">{$help_link_title}</a>{/if}</h3>
        {str_replace('$$$',$total,$payment_page_text)}     
        <div class="monthly-img">
        <img width="311px" src="data:image/svg+xml;base64,PHN2ZyBpZD0iTGF5ZXJfMSIgZGF0YS1uYW1lPSJMYXllciAxIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxNzIgMzEuNSI+PGRlZnM+PHN0eWxlPi5jbHMtMXtmb250LXNpemU6OS44MXB4O2ZvbnQtZmFtaWx5Ok9wZW5TYW5zLVNlbWlCb2xkLCBPcGVuIFNhbnM7Zm9udC13ZWlnaHQ6NzAwO30uY2xzLTEsLmNscy0ye2ZpbGw6Izk1OGRjNDt9PC9zdHlsZT48L2RlZnM+PHRpdGxlPnNwbGl0aXRfbW9udGhseV9wYXltZW50c19iYW5uZXI8L3RpdGxlPjxwYXRoIGQ9Ik0xODguNTQsMjYuMTlhMy41NSwzLjU1LDAsMCwxLTEuNDksMy4wOEE2LjgzLDYuODMsMCwwLDEsMTgzLDMwLjM0YTcuNjMsNy42MywwLDAsMS0zLjM4LS43LDUuNyw1LjcsMCwwLDEtMi4yMS0xLjlsLS45MSwxYTcuNjEsNy42MSwwLDAsMCw2LjIyLDIuNywxMC42MiwxMC42MiwwLDAsMCwyLjg4LS4zN0E2Ljg4LDYuODgsMCwwLDAsMTg3LjksMzBhNSw1LDAsMCwwLDEuNTItMS43OCw1LjM0LDUuMzQsMCwwLDAsLjU0LTIuNDQsNC40LDQuNCwwLDAsMC0uMDUtLjY1aC0xLjU3QTIuNTksMi41OSwwLDAsMSwxODguNTQsMjYuMTlaIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtNjkuNSAtNS4yNSkiLz48cGF0aCBkPSJNMTg4LjU3LDIzLjFhNS45LDUuOSwwLDAsMC0xLjYxLS43OWMtLjYzLS4yMi0xLjMzLS40MS0yLjA5LS42cy0xLjMyLS4zNC0xLjg1LS41MWE1Ljc0LDUuNzQsMCwwLDEtMS4zMy0uNTksMi4zLDIuMywwLDAsMS0uOC0uNzgsMi4xOSwyLjE5LDAsMCwxLS4yNy0xLjEyLDQuNzgsNC43OCwwLDAsMSwuMzItMS43NSwzLjQ1LDMuNDUsMCwwLDEsMS0xLjM4LDQuOTIsNC45MiwwLDAsMSwxLjczLS45Myw4LjIyLDguMjIsMCwwLDEsMi41NS0uMzVjMiwwLDMuNDQuNjYsNC4yNSwybC44OC0xYTUsNSwwLDAsMC0yLTEuNTksNy4zMiw3LjMyLDAsMCwwLTIuODctLjUyLDkuNzYsOS43NiwwLDAsMC0yLjg3LjQxLDYuNzksNi43OSwwLDAsMC0yLjI5LDEuMTcsNS40Myw1LjQzLDAsMCwwLTIuMDgsNC4zOCwzLjA2LDMuMDYsMCwwLDAsLjMyLDEuNDQsMi45NCwyLjk0LDAsMCwwLC45MiwxLDYuNTgsNi41OCwwLDAsMCwxLjQ4LjczLDE5LjQzLDE5LjQzLDAsMCwwLDIsLjU2QTExLjkzLDExLjkzLDAsMCwxLDE4Ny4yOCwyNGgyLjE4QTMuNDksMy40OSwwLDAsMCwxODguNTcsMjMuMVoiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OS41IC01LjI1KSIvPjxwYXRoIGQ9Ik0xOTUsMjIuNTdhMy40OCwzLjQ4LDAsMCwxLC44Mi0xLjM0LDcuMjgsNy4yOCwwLDAsMSwxLjMzLTEuMTQsNy41Miw3LjUyLDAsMCwxLDEuNTEtLjc5LDQuMzQsNC4zNCwwLDAsMSwxLjQ1LS4yOSwzLjMzLDMuMzMsMCwwLDEsMS41OS4zNywzLjgyLDMuODIsMCwwLDEsMS4yMiwxLDQuOTEsNC45MSwwLDAsMSwuNzgsMS40Nyw1LjgyLDUuODIsMCwwLDEsLjI4LDEuNzhjMCwuMTMsMCwuMjUsMCwuMzdoMS4zYzAtLjE4LDAtLjM2LDAtLjU1YTcuMTQsNy4xNCwwLDAsMC0uMzEtMi4xMSw1LjgxLDUuODEsMCwwLDAtLjkxLTEuNzksNC41MSw0LjUxLDAsMCwwLTEuNDctMS4yNCw0LjI5LDQuMjksMCwwLDAtMi0uNDUsNS43NSw1Ljc1LDAsMCwwLTIuODcuOCw4LjYxLDguNjEsMCwwLDAtMi40NywyLjA3bC41Ni0yLjY1aC0xLjE0TDE5My40NCwyNGgxLjI1WiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTY5LjUgLTUuMjUpIi8+PHBhdGggZD0iTTIwMy41LDI2LjA3YTcuNTcsNy41NywwLDAsMS0xLjMyLDIuMTgsNy4zMSw3LjMxLDAsMCwxLTEuOTMsMS41OCw0Ljg2LDQuODYsMCwwLDEtMi4zNC42MSwzLjU0LDMuNTQsMCwwLDEtMS4zOC0uMjcsMy42NCwzLjY0LDAsMCwxLTEuMTQtLjc1LDQuNjksNC42OSwwLDAsMS0uODQtMS4xMiw1LjE5LDUuMTksMCwwLDEtLjQ5LTEuMzdsLjM4LTEuNzdIMTkzLjJsLTIuNDYsMTEuNTlIMTkybDEuNzUtOC4yN2E1LjIyLDUuMjIsMCwwLDAsMS41NCwyLjIsNCw0LDAsMCwwLDIuNjYuOSw2LjIxLDYuMjEsMCwwLDAsMi44My0uNjgsNy44NSw3Ljg1LDAsMCwwLDIuMzQtMS44NCw4LjkyLDguOTIsMCwwLDAsMS41OC0yLjYsOS4yMyw5LjIzLDAsMCwwLC40LTEuM2gtMS4zMkE2LjM5LDYuMzksMCwwLDEsMjAzLjUsMjYuMDdaIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtNjkuNSAtNS4yNSkiLz48cG9seWdvbiBwb2ludHM9IjE0Mi42OCA3LjUgMTQxLjQxIDcuNSAxMzkuMDQgMTguNzYgMTQwLjMgMTguNzYgMTQyLjY4IDcuNSIvPjxwYXRoIGQ9Ik0yMDcuNDcsMjkuMDlhMy4xOSwzLjE5LDAsMCwwLS4wOC42NCwxLjcsMS43LDAsMCwwLC40OCwxLjI4LDEuODIsMS44MiwwLDAsMCwxLjM1LjQ3LDcsNywwLDAsMCwxLjA3LS4xMSw1LjQ5LDUuNDksMCwwLDAsMS4wOC0uM3YtMWEzLjg5LDMuODksMCwwLDEtLjcxLjE5LDQuNDYsNC40NiwwLDAsMS0uNjYuMDYsMS4yNywxLjI3LDAsMCwxLS45Mi0uMywxLjEsMS4xLDAsMCwxLS4zMi0uODQsMS41NSwxLjU1LDAsMCwxLDAtLjIzLDIuMjMsMi4yMywwLDAsMSwwLS4yM2wuNzUtMy41NUgyMDguM1oiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OS41IC01LjI1KSIvPjxwb2x5Z29uIHBvaW50cz0iMTQzLjg5IDI2LjA4IDE0NS4xNiAyNi4wOCAxNDYuNDUgMTkuOTEgMTQ1LjE5IDE5LjkxIDE0My44OSAyNi4wOCIvPjxwb2x5Z29uIHBvaW50cz0iMTQ5LjA4IDcuNSAxNDcuODEgNy41IDE0Ny4zMyA5Ljg0IDE0OC42IDkuODQgMTQ5LjA4IDcuNSIvPjxwb2x5Z29uIHBvaW50cz0iMTQ3Ljk0IDEyLjg1IDE0Ni42NyAxMi44NSAxNDUuNDMgMTguNzYgMTQ2LjY5IDE4Ljc2IDE0Ny45NCAxMi44NSIvPjxwb2x5Z29uIHBvaW50cz0iMTUzLjUgMTMuODkgMTU2LjQxIDEzLjg5IDE1Ni42NCAxMi44NSAxNTMuNzMgMTIuODUgMTU0LjY3IDguMzEgMTUzLjQgOC4zMSAxNTIuNDcgMTIuODUgMTUwLjcgMTIuODUgMTUwLjQ3IDEzLjg5IDE1Mi4yNCAxMy44OSAxNTEuMiAxOC43NiAxNTIuNDcgMTguNzYgMTUzLjUgMTMuODkiLz48cGF0aCBkPSJNMjE5LjYxLDI5LjExYzAsLjExLDAsLjIsMCwuM2EyLjQ2LDIuNDYsMCwwLDAsMCwuMjYsMS42LDEuNiwwLDAsMCwuNTksMS4zNSwyLjI0LDIuMjQsMCwwLDAsMS40Ni40Niw0Ljg5LDQuODksMCwwLDAsMS0uMDksNC42NSw0LjY1LDAsMCwwLC44NC0uMjNjLjI1LS4wOS40Ny0uMTguNjQtLjI2YTMsMywwLDAsMCwuMzctLjIxbC0uMTUtMWExLjA3LDEuMDcsMCwwLDEtLjI3LjE0bC0uNDYuMjFhNSw1LDAsMCwxLS42Mi4xOSwzLjQsMy40LDAsMCwxLS43My4wOCwxLjM1LDEuMzUsMCwwLDEtLjg5LS4zLDEsMSwwLDAsMS0uMzctLjg4LDYuODcsNi44NywwLDAsMSwuMTgtMWwuNjItMi45NGgtMS4yN1oiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OS41IC01LjI1KSIvPjxwb2x5Z29uIHBvaW50cz0iMTYzLjQ3IDcuNSAxNjAuNjkgNy41IDE2MC4wNiAxMC41OCAxNjIuODQgMTAuNTggMTYzLjQ3IDcuNSIvPjxwb2x5Z29uIHBvaW50cz0iMTYyLjM4IDEyLjc3IDE1OS42IDEyLjc3IDE1OC4zMyAxOC43NiAxNjEuMTEgMTguNzYgMTYyLjM4IDEyLjc3Ii8+PHBvbHlnb24gcG9pbnRzPSIxNTYuNzcgMjYuMDggMTU5LjU1IDI2LjA4IDE2MC44NyAxOS45MSAxNTguMDggMTkuOTEgMTU2Ljc3IDI2LjA4Ii8+PHBhdGggZD0iTTIzNy4yOSwyNS4xNkgyMzQuNWwtLjcyLDMuMzRhNCw0LDAsMCwwLS4xLjg0LDEuOTEsMS45MSwwLDAsMCwuNzQsMS42NywzLDMsMCwwLDAsMS44Mi41Miw3Ljg0LDcuODQsMCwwLDAsMi0uMjYsNi4xMiw2LjEyLDAsMCwwLDEuNTQtLjYzbC0uMS0yLjIxLS44MS4zM2EzLjI1LDMuMjUsMCwwLDEtMS4xMS4yLDEuMTUsMS4xNSwwLDAsMS0uNzQtLjIzLjg2Ljg2LDAsMCwxLS4zLS43MywxLjcxLDEuNzEsMCwwLDEsLjA1LS4zOVoiIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02OS41IC01LjI1KSIvPjxwb2x5Z29uIHBvaW50cz0iMTY4Ljg0IDE0LjkzIDE3MS41NCAxNC45MyAxNzIgMTIuNzcgMTY5LjI3IDEyLjc3IDE3MC4yIDguMzkgMTY3LjQyIDguMzkgMTY2LjQ4IDEyLjc3IDE2NC44NCAxMi43NyAxNjQuMzYgMTQuOTMgMTY2LjA1IDE0LjkzIDE2NS4yNCAxOC43NiAxNjguMDMgMTguNzYgMTY4Ljg0IDE0LjkzIi8+PHRleHQgY2xhc3M9ImNscy0xIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgwLjE3IDIyLjMyKSI+TW9udGhseSBQYXltZW50cyBCeSA8L3RleHQ+PHJlY3QgY2xhc3M9ImNscy0yIiB3aWR0aD0iMTcyIiBoZWlnaHQ9IjIiLz48cG9seWxpbmUgY2xhc3M9ImNscy0yIiBwb2ludHM9IjkzIDEuNSA4NiA4LjUgNzkgMS41Ii8+PC9zdmc+"/>
        </div>
    </div>

    <p class="cart_navigation" id="cart_navigation">
		<a href="{$link->getPageLink('order', true, NULL, "step=3")|escape:'html'}" class="button-exclusive btn btn-default"><i class="icon-chevron-left"></i> {l s='Other payment methods' mod='splititpaymentform'}</a>
        <button type="button" id="splititpaymentform_confirm" class="button btn btn-default button-medium" onclick="{if $gateway_url} window.location='{$gateway_url}' {else} alert('{l s=$splitit_error mod='splititpaymentform'}') {/if}"><span>{l s='Proceed to Pay' mod='splititpaymentform'}</span></button>
    </p>

</form>
<div id="overlay"><img src="{$path|escape:'htmlall':'UTF-8'}views/img/opc-ajax-loader.gif"/></div>    

{/if}






