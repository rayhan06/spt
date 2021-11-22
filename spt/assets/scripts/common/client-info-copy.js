$(document).ready(function() {
	
	$("#checkbox-using-existing-client-info").css("display", "block");
	
	var swap="newClient";
	$("#existing-check").click(function(){
		if ($("#existing-check").parent().hasClass("checked")){
			$("#using-existing-client-div").hide();
			$("#login-information").show();
		}else{
			$("#using-existing-client-div").show();
			$("#login-information").hide();
		}
	});
	
	function showAccountInfo(type){
	   $("#clientCategoryType").val(type);
	   $(".fileType").hide();
	   $('.identityLabel').html("");
	   clearIdentityList();
	   if(type==1){
			$("#regIndividualInfo").removeClass('hidden');
			$("#regCompanyInfo").addClass('hidden');
			
			$("#regCompanyInfo").find("input, select").attr("disabled", true);
			$("#regIndividualInfo").find("input, select").attr("disabled", false);
			
			$(".individual").addClass("regi");
			$(".company").removeClass("regi");
			
			
		}else{
	   	 	$("#regCompanyInfo").removeClass('hidden');
	   	 	$("#regIndividualInfo").addClass('hidden');
	   	 	
	   	 	$("#regIndividualInfo").find("input, select").attr("disabled", true);
	   	 	$("#regCompanyInfo").find("input, select").attr("disabled", false);
	   	 	$("#regCompanyInfo").find(".checker").removeClass("disabled");
	   	 	$("#regCompanyInfo").find(".radio").removeClass("disabled");
	   	 	
	   	 	$(".individual").removeClass("regi");
			$(".company").addClass("regi");
		}
	   
	   if(!(($('input[name="accountType"][value="'+type+'"]')).hasClass('checked'))){
		   $('input[name="accountType"][value="'+type+'"]').prop('checked', true);
		   $('input[name="accountType"][value="'+type+'"]').parent().addClass('checked');
	   }
	   if(( $('input[name="accountType"]:not([value="'+type+'"])')).parent().hasClass('checked')){
		   $('input[name="accountType"]:not([value="'+type+'"])').prop('checked', false);
		   $('input[name="accountType"]:not([value="'+type+'"])').parent().removeClass('checked');
	   }
	   $('#forwardingLetter').closest('.radio-inline').hide();
	}
	
	
	function populateForm(data){
		//clientCategoryType
		var clientCategoryType = data['clientDetailsDTO.clientCategoryType'];
		
		if(clientCategoryType==1){
			showAccountInfo(1);
			//Client Individual
			$('input[name="clientDetailsDTO.registrantType"]').val("0");
			$('input[name="clientDetailsDTO.regiCat"]').val("0");
			$('input[name="registrantContactDetails.registrantsName"]').val(data['registrantContactDetails.registrantsName']);
			$('input[name="registrantContactDetails.registrantsLastName"]').val(data['registrantContactDetails.registrantsLastName']);
			$('input[name="registrantContactDetails.fatherName"]').val(data['registrantContactDetails.fatherName']);
			$('input[name="registrantContactDetails.motherName"]').val(data['registrantContactDetails.motherName']);
			$('input[name="registrantContactDetails.gender"]').val(data['registrantContactDetails.gender']);
			$('input[name="registrantContactDetails.email"]').val(data['registrantContactDetails.email']);
			
			var phoneNumber = data['registrantContactDetails.phoneNumber'];
			$('input[name="intlMobileNumber"]').intlTelInput("setNumber", phoneNumber+"");
			$('input[name="registrantContactDetails.faxNumber"]').val(data['registrantContactDetails.faxNumber']);
			$('input[name="registrantContactDetails.dateOfBirth"]').val(data['registrantContactDetails.dateOfBirth']);
			$('input[name="registrantContactDetails.occupation"]').val(data['registrantContactDetails.occupation']);
			
		} else if (clientCategoryType==2){
			showAccountInfo(2);
			//Client Company
			$('input[name="registrantContactDetails.registrantsName"]').val(data['registrantContactDetails.registrantsName']);
			$('input[name="registrantContactDetails.registrantsLastName"]').val(data['registrantContactDetails.registrantsLastName']);
			$('input[name="registrantContactDetails.webAddress"]').val(data['registrantContactDetails.webAddress']);
			$('input[name="registrantContactDetails.email"]').val(data['registrantContactDetails.email']);
			
			$('input[name="clientDetailsDTO.registrantType"]').val("0");
			$('input[name="clientDetailsDTO.regiCat"]').val("0");

			var phoneNumber = data['registrantContactDetails.phoneNumber'];
			$('input[name="intlMobileNumber"]').intlTelInput("setNumber", phoneNumber+"");
			$('input[name="registrantContactDetails.faxNumber"]').val(data['registrantContactDetails.faxNumber']);
		}
		
		$('input[name="registrantContactDetails.landlineNumber"]').val(data['registrantContactDetails.landlineNumber']);
		$('input[name="registrantContactDetails.country"]').val(data['registrantContactDetails.country']);
		$('input[name="registrantContactDetails.city"]').val(data['registrantContactDetails.city']);
		$('input[name="registrantContactDetails.postCode"]').val(data['registrantContactDetails.postCode']);
		$('textarea[name="registrantContactDetails.address"]').val(data['registrantContactDetails.address']);
		
		$('input[name="billingContactDetails.registrantsName"]').val(data['billingContactDetails.registrantsName']);
		$('input[name="billingContactDetails.registrantsLastName"]').val(data['billingContactDetails.registrantsLastName']);
		$('input[name="billingContactDetails.email"]').val(data['billingContactDetails.email']);
		$('input[name="billingContactDetails.phoneNumber"]').val(data['billingContactDetails.phoneNumber']);
		$('input[name="billingContactDetails.landlineNumber"]').val(data['billingContactDetails.landlineNumber']);
		$('input[name="billingContactDetails.faxNumber"]').val(data['billingContactDetails.faxNumber']);
		$('input[name="billingContactDetails.city"]').val(data['billingContactDetails.city']);
		$('input[name="billingContactDetails.postCode"]').val(data['billingContactDetails.postCode']);
		$('textarea[name="billingContactDetails.address"]').val(data['billingContactDetails.address']);
		
		$('input[name="adminContactDetails.registrantsName"]').val(data['adminContactDetails.registrantsName']);
		$('input[name="adminContactDetails.registrantsLastName"]').val(data['adminContactDetails.registrantsLastName']);
		$('input[name="adminContactDetails.email"]').val(data['adminContactDetails.email']);
		$('input[name="adminContactDetails.phoneNumber"]').val(data['adminContactDetails.phoneNumber']);
		$('input[name="adminContactDetails.landlineNumber"]').val(data['adminContactDetails.landlineNumber']);
		$('input[name="adminContactDetails.faxNumber"]').val(data['adminContactDetails.faxNumber']);
		$('input[name="adminContactDetails.city"]').val(data['adminContactDetails.city']);
		$('input[name="adminContactDetails.postCode"]').val(data['adminContactDetails.postCode']);
		$('textarea[name="adminContactDetails.address"]').val(data['adminContactDetails.address']);
		
		$('input[name="technicalContactDetails.registrantsName"]').val(data['technicalContactDetails.registrantsName']);
		$('input[name="technicalContactDetails.registrantsLastName"]').val(data['technicalContactDetails.registrantsLastName']);
		$('input[name="technicalContactDetails.email"]').val(data['technicalContactDetails.email']);
		$('input[name="technicalContactDetails.phoneNumber"]').val(data['technicalContactDetails.phoneNumber']);
		$('input[name="technicalContactDetails.landlineNumber"]').val(data['technicalContactDetails.landlineNumber']);
		$('input[name="technicalContactDetails.faxNumber"]').val(data['technicalContactDetails.faxNumber']);
		$('input[name="technicalContactDetails.city"]').val(data['technicalContactDetails.city']);
		$('input[name="technicalContactDetails.postCode"]').val(data['technicalContactDetails.postCode']);
		$('textarea[name="technicalContactDetails.address"]').val(data['technicalContactDetails.address']);
		
		$('input[name="registrantContactDetails.phoneNumber"]').val(data['registrantContactDetails.phoneNumber']);
	
	}
	
	$("#client-module-selected").change(function(){
		if((($("#client-module-selected")).val())=="-1"){
		}else{
			var formData={};
			formData.moduleID = $("#client-module-selected").val();
			formData.clientID = $("#client-id-autocomplete").val();
			var url=  context + 'GetClientFormData.do';
			ajax(url, formData, populateForm, "GET", []);
		}
	});
	
	
	function populateModuleList(data){
		var thisModule = ($('input[name="clientDetailsDTO.moduleID"]').val());
		var isClientAlreadyRegisteredInThisModule=false;
		
		$.each(data, function(index, value){
			if(value.moduleID==thisModule){
				isClientAlreadyRegisteredInThisModule = true;
			}
		});
		
		if(!isClientAlreadyRegisteredInThisModule){
			$("#client-module-selected").empty();
			$("#client-module-selected").append('<option value="-1">Select a Source Module</option>');
			$.each(data, function(index, value){
				$("#client-module-selected").append('<option value="'+value.moduleID+'">'+value.moduleName+'</option>');
			});
		}else{
			toastr.error("Client Already Registered in this Module!");
			$('#client-id-autocomplete').val('-1');
		}
	}

	function getModulesForSelectedClient(clientID){
		var url = context + 'AutoComplete.do?need=modulesForClient';
		var formData = {};
		formData.clientID = clientID;
		callAjax(url, formData, populateModuleList, "GET");
	}
	
	$("#client-name-autocomplete").autocomplete({
		source : function(request, response) {
			$("#client-id-autocomplete").val(-1);
			var term = request.term;
			var url = context + 'AutoComplete.do?need=allclient';
			var formData = {};
			formData['name'] = term;
			if (term.length >= 3) {
				callAjax(url, formData, response, "GET");
			} else {
				delay(function() {
					toastr.info("Your search name should be at lest 3 characters");
				}, systemConfig.getTypingDelay());
			}
		},
		minLength : 1,
		select : function(e, ui) {
			$('#client-id-autocomplete').val(ui.item.id);
			$('#client-name-autocomplete').val(ui.item.data);
			getModulesForSelectedClient(ui.item.id);
			return false;
		},
	}).autocomplete("instance")._renderItem = function(ul, item) {
		return $("<li>").append("<a>" + item.data + "</a>").appendTo(ul);
	};
	
	if(($('#client-id-autocomplete')).val()!="-1"){
		getModulesForSelectedClient(($('#client-id-autocomplete')).val());
	}
	
	
	
});