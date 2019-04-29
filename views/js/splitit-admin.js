/**
 * @author Splitit
 * @copyright 2017-2018 Splitit
 * @since 1.6.0
 * @license BSD 2 License
 */
 
var isClicked = false;
var maxValue = 0;

function login(url){

    var api_key = $('#api_key').val();
    var api_user_name = $('#api_user_name').val();
    var api_password = $('#api_password').val();

    if(api_key == ''){
        alert('Please enter api key');
        return false;
    }else if(api_user_name == ''){
        alert('Please enter api user name');
        return false;
    }else if(api_password == ''){
        alert('Please enter api password');
        api_password;
        return false;
    }

    if(isClicked) {
        return;
    }

    isClicked = true;    
    $('#splitit_button').find('span').text('Checking...');
	
    $.post(url+"modules/splitit/ajax.php", {action:"login", reqInit: 'false', 'api_key' : api_key, 'api_user_name' : api_user_name, 'api_password' : api_password }, function(data){
        
        $('#splitit_button').find('span').text('Check Settings');
        isClicked = false;

        alert(data.message);

	},'json')
}

// SplitIt Admin Javascript Start Here
$(document).ready(function() {

	// Allowed Countries
    if($('#allowed_countries').val() == 0){
        $('#specific_countries').attr('disabled', false).removeClass('blur');
    }else{
        $('#specific_countries').attr('disabled', true).addClass('blur');
    }

    $('#allowed_countries'). on('change', function() {
        specific = $(this).val();
        //console.log(specific);
        if(specific == 0){
            $('#specific_countries').attr('disabled', false).removeClass('blur');

        }else{
            $('#specific_countries').attr('disabled', true).addClass('blur');
        }
    }); 

    // Show and Hide Installment Price Setup
    if($('#enable_price').val() == 0){
    	$('.instalment_price_row').hide();
    }else{
    	$('.instalment_price_row').show(500);
    }

    $('#enable_price'). on('change', function() {
        if($(this).val() == 0){
            $('.instalment_price_row').hide();

        }else{
            $('.instalment_price_row').show(500);
        }
    });

    // Check first payment Percentage
    $('#splitit_submit').on('click', function(e){

	    if($('#percentage_of_order').val() > 50){
	    	alert('Percentage should be less than or equal to 50%');
	    	return false;
	    }else{
	    	return true;
	    }


    });

    // First Payment

    if($('#first_payment').val() == 'percentage'){
		$('.percentage_of_order').show(500);
    }else{
		$('.percentage_of_order').hide();
    }

    $('#first_payment').on('change', function(){

    	if($(this).val() == 'percentage'){
    		$('.percentage_of_order').show(500);
    	}else{
    		$('.percentage_of_order').hide();
    	}

    });

    $('#splititpaymentform_submit').on('click',function(e){
        // e.preventDefault();
        var jsonData = [];
        var missingValue = false;
        $('#depending_on_cart_table tbody tr').find('input,select').removeClass('splitit_error').css("border","1px solid #ccc")
        if($('#installment_type').val()==2){
            $('#depending_on_cart_table tbody tr').each(function(){
                var f = $(this).find('[name="doc_from"]').val();
                var t = $(this).find('[name="doc_to"]').val();
                var ins = $(this).find('[name="doc_installments[]"]').val();
                if(f && t && ins && !isNaN(f) && !isNaN(t) && Array.isArray(ins)){
                    jsonData.push({
                        'from':parseFloat(f),
                        'to':parseFloat(t),
                        'installments':ins,
                    });                    
                }
                if(!f || isNaN(f)){
                    $(this).find('[name="doc_from"]').addClass('splitit_error');
                }
                if(!t || isNaN(t)){
                    $(this).find('[name="doc_to"]').addClass('splitit_error');
                }
                if(!ins || !Array.isArray(ins)){
                    $(this).find('[name="doc_installments[]"]').addClass('splitit_error');
                }
            });
        }
        if($('#depending_on_cart_table tbody').find('.splitit_error').length){
            $('.splitit_error').css("border","1px solid red");
            alert('Please fill all required fields.');
            return false;
        }
        /*console.log(jsonData);
        console.log(JSON.stringify(jsonData));
        console.log(JSON.parse(JSON.stringify(jsonData)));*/
        if($('#installment_type').val()==2){
            $('#depending_on_cart').val(JSON.stringify(jsonData));
        }
        // $('#splititpaymentform_configuration').submit();
    });

    $(document).on('blur','[name="doc_from"]',function(e){
        var from = parseFloat($(this).val());
        var to = parseFloat($(this).closest('td').find('[name="doc_to"]').val());
        // maxValue = to;
        var curObj = $(this).closest('td').find('[name="doc_to"]').get(0);
        var maxObj;
        console.log('blur called');
        if(from){
            $('#depending_on_cart_table tbody').find('[name="doc_to"]').each(function(){
                if(maxValue < $(this).val()){
                    maxValue = parseFloat($(this).val());
                    maxObj = this;
                    console.log(maxValue);
                }
            });
            console.log(curObj);
            console.log(maxObj);
            if(from <= maxValue && curObj!=maxObj){
                alert('value should be greater than '+parseFloat(maxValue));
                $(this).val('');
            }
        }
        if(from && to && from >= to){
            alert('From amount should be less than To amount');
            $(this).val('');
        }
    });
    $(document).on('blur','[name="doc_to"]',function(e){
        var to = parseFloat($(this).val());
        var from = parseFloat($(this).closest('td').find('[name="doc_from"]').val());
        if(to < 0){
            alert('To amount should be greater than 0');
            $(this).val('');            
        }
        if(from && to && from >= to){
            alert('From amount should be less than To amount');
            $(this).val('');
        }
    });
    $('#percentage_of_order').blur(function(){
        if(parseFloat($(this).val())>50){
            alert('Value cannot be greater than 50.');
            $(this).val(50);
        }
    });
    populateDocTable();
});

function addDependingOnCartRow(){
    var emptyFields = false;
    $('#depending_on_cart_table tbody').find('input,select').each(function(e){
        if(!$(this).val()){
            emptyFields =true;
        }
    });
    if(emptyFields){        
        alert('Please fill all fields before adding new.');
        return false;
    }
    var html = '<tr>';
    html+='<td>'
    + '<input required type="number" name="doc_from" placeholder="FROM"/><br/>'
    + '<input required type="number" name="doc_to" placeholder="TO"/>'
    + '</td>';
    html+='<td>'
    + '<select required name="doc_installments[]" multiple="multiple">';
    for (var $i = 2; $i <= 12; $i++) {
            html+= '<option value="'+$i+'">'+$i+ ' installments</option>';
    }
    html+= '</select>'
    + '</td><td><button type="button" onclick="$(this).closest(\'tr\').remove();">Delete</button></td>';    
    html+='</tr>';
    $('#depending_on_cart_table tbody').append(html);
}

function showRow(obj){
    var value = $(obj).val();
    if(value==1){
        $('#depending_on_cart_row').hide();
        $('#fixed_installments_row').show();
    } else if(value==2){
        $('#fixed_installments_row').hide();
        $('#depending_on_cart_row').show();
    } else{
        $('#depending_on_cart_row').hide();
        $('#fixed_installments_row').hide();
        alert('Invalid value');
    }
}

function populateDocTable(){
    var jsonData = $('#depending_on_cart').val();
    var html = '';
    if(jsonData){
        jsonData = JSON.parse(jsonData);
        for(var i in jsonData){
            html+='<tr>';
            html+='<td>'
            + '<input required type="number" name="doc_from" value="'+jsonData[i].from+'" placeholder="FROM"/><br/>'
            + '<input required type="number" name="doc_to" value="'+jsonData[i].to+'" placeholder="TO"/>'
            + '</td>';
            html+='<td>'
            + '<select required name="doc_installments[]" multiple="multiple">';
            for (var $i = 2; $i <= 12; $i++) {
                    html+= '<option value="'+$i+'"';
                    if($.inArray(''+$i,jsonData[i].installments) !== -1){
                        html+=' selected="selected"';
                    }
                    html+='>'+$i+ ' installments</option>';
            }
            html+= '</select>'
            + '</td><td><button type="button" onclick="$(this).closest(\'tr\').remove();">Delete</button></td>';
            html+='</tr>';
        }
        $('#depending_on_cart_table tbody').append(html);
    }
}

function checkFirstPayment(obj){
    var first_payment = $(obj).val();
    if(first_payment=='percentage'){
        $('#first_payment_row').show();
    } else {
        $('#first_payment_row').hide();
    }
}