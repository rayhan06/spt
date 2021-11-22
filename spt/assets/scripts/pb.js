function processMultipleSelectBoxBeforeSubmit(name) 
{
	
	$( "[name='" + name + "']" ).each(function( i ) 
	{
		var selectedInputs = $(this).val();
		var temp = "";
        if(selectedInputs != null){
            selectedInputs.forEach(function(value, index, array){
                if(index > 0){
                    temp += ", ";
                }
                temp += value;
            });
        }
		$(this).append('<option value="' + temp + '"></option>');
        $(this).val(temp);
	}); 
}

function printAnyDiv(divName) 
{
     var printContents = document.getElementById(divName).innerHTML;
     var originalContents = document.body.innerHTML;

     document.body.innerHTML = printContents;

     window.print();

     document.body.innerHTML = originalContents;
}

function initCkEditor(id)
{
	CKEDITOR.replace(id, {
            toolbar: [
                ['Cut', 'Copy', 'Paste', 'Undo', 'Redo'],			// Defines toolbar group without name.
                {name: 'basicstyles', items: ['Bold', 'Italic', 'Underline']},
                {name: 'morestyles', items: ['Strike', 'Subscript', 'Superscript']},
                {
                    name: 'paragraph',
                    items: ['NumberedList', 'BulletedList']
                },
                {name: 'justify', items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock']},
                {name: 'styles', items: ['Styles', 'Format', 'Font', 'FontSize']},
                {name: 'colors', items: ['TextColor', 'BGColor']}
            ],
            height: '5em',
            width: 600
        });
}

function basicInit()
{
	$('.edms-datetimepicker').datetimepicker({
        format: 'LT'
    });

    /*$('.datepicker').datepicker({

        changeMonth: true,
        changeYear: true,
        dateFormat: 'dd/mm/yy',
        todayHighlight:	true,
        showButtonPanel: true
    });*/

	$(function () {
		$.bdatepicker.setDefaults(bn);
		$('.datepicker').bdatepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
		});
	});
}

function unit_selected(selectedElement, participant)
{
	console.log("selected " + selectedElement.value + " id = " + selectedElement.getAttribute("id"));
	var id = selectedElement.getAttribute("id");
	var option = $("#" + id).val();
	var text = $("#" + id + " option:selected" ).text();
	console.log("selected value = " + option + " text = " + text);
	var splitted = id.split("_");
	var rowID = splitted[splitted.length - 1];
	console.log("rowID = " + rowID);

	
	$("#" + participant + rowID + "> option").each(function() {
			if($(this).attr("unitname") != text && $(this).attr("value"))
			{
				 $(this).remove();
			}
	       
	});
	
	$( "#" + id ).prop( "disabled", true );
}

function unit_selected_nosplit(selectedElement, participant)
{
	console.log("selected " + selectedElement.value + " id = " + selectedElement.getAttribute("id"));
	var id = selectedElement.getAttribute("id");
	var option = $("#" + id).val();
	var text = $("#" + id + " option:selected" ).text();
	console.log("selected value = " + option + " text = " + text);


	
	$("#" + participant + "> option").each(function() {
			if($(this).attr("unitname") != text && $(this).attr("value"))
			{
				 $(this).remove();
			}
	       
	});
	
	//$( "#" + id ).prop( "disabled", true );
}

var origHtml;
var deptChanged = 0;

function dept_selected(selectedElement, participant)
{
	console.log("selected " + selectedElement.value + " id = " + selectedElement.getAttribute("id"));
	var id = selectedElement.getAttribute("id");
	var option = $("#" + id).val();
	var dept = $("#" + id).val();
	
	console.log("dept = " + dept);

	if(deptChanged == 0)
	{
		origHtml = $("#" + participant).html();
		deptChanged = 1;
	}
	else
	{
		$("#" + participant).html(origHtml);
	}
	
	$("#" + participant + "> option").each(function() {
			if($(this).attr("dept") != dept && $(this).attr("value"))
			{
				 $(this).remove();
			}
	       
	});
	
	$( "#" + participant ).prop( "disabled", false );
}

function deletefile(id, tdId, hiddenvar) {
	$("#" + tdId).remove();
	var newvalue = $("#" + hiddenvar).attr('value') + "," + id;
	$("#" + hiddenvar).attr('value', newvalue);
	hiddenvar
}

//*** This code is copyright 2002-2016 by Gavin Kistner, !@phrogz.net
//*** It is covered under the license viewable at http://phrogz.net/JS/_ReuseLicense.txt
Date.prototype.customFormat = function(formatString){
  var YYYY,YY,MMMM,MMM,MM,M,DDDD,DDD,DD,D,hhhh,hhh,hh,h,mm,m,ss,s,ampm,AMPM,dMod,th;
  YY = ((YYYY=this.getFullYear())+"").slice(-2);
  MM = (M=this.getMonth()+1)<10?('0'+M):M;
  MMM = (MMMM=["January","February","March","April","May","June","July","August","September","October","November","December"][M-1]).substring(0,3);
  DD = (D=this.getDate())<10?('0'+D):D;
  DDD = (DDDD=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"][this.getDay()]).substring(0,3);
  th=(D>=10&&D<=20)?'th':((dMod=D%10)==1)?'st':(dMod==2)?'nd':(dMod==3)?'rd':'th';
  formatString = formatString.replace("#YYYY#",YYYY).replace("#YY#",YY).replace("#MMMM#",MMMM).replace("#MMM#",MMM).replace("#MM#",MM).replace("#M#",M).replace("#DDDD#",DDDD).replace("#DDD#",DDD).replace("#DD#",DD).replace("#D#",D).replace("#th#",th);
  h=(hhh=this.getHours());
  if (h==0) h=24;
  if (h>12) h-=12;
  hh = h<10?('0'+h):h;
  hhhh = hhh<10?('0'+hhh):hhh;
  AMPM=(ampm=hhh<12?'am':'pm').toUpperCase();
  mm=(m=this.getMinutes())<10?('0'+m):m;
  ss=(s=this.getSeconds())<10?('0'+s):s;
  return formatString.replace("#hhhh#",hhhh).replace("#hhh#",hhh).replace("#hh#",hh).replace("#h#",h).replace("#mm#",mm).replace("#m#",m).replace("#ss#",ss).replace("#s#",s).replace("#ampm#",ampm).replace("#AMPM#",AMPM);
};

function getOfficer(officer_id, officer_select, ServetName) {
	console.log("getting officer");
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			if (this.responseText.includes('option')) {
				console.log("got response for officer");
				document.getElementById(officer_select).innerHTML = this.responseText;

				if (document.getElementById(officer_select).length > 1) {
					document.getElementById(officer_select).removeAttribute(
							"disabled");
				}
			} else {
				console.log("got errror response for officer");
			}

		} else if (this.readyState == 4 && this.status != 200) {
			alert('failed ' + this.status);
		}
	};
	xhttp.open("POST", ServetName + "?actionType=getGRSOffice&officer_id="
			+ officer_id, true);
	xhttp.send();
}

function fillDependentDiv(parentelement, dependentElement, ServetName) {
	console.log("getting Element");
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			document.getElementById(dependentElement).innerHTML = this.responseText;
		} else if (this.readyState == 4 && this.status != 200) {
			alert('failed ' + this.status);
		}
	};
	var value = document.getElementById(parentelement).value;
	console.log("selected value = " + value);

	xhttp.open("POST", ServetName + "?actionType=getDependentDiv&Value="
			+ value, true);
	xhttp.send();
}

function getLayer(layernum, layerID, childLayerID, selectedValue, ServetName) {
	console.log("getting layer");
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			if (this.responseText.includes('option')) {
				console.log("got response");
				document.getElementById(childLayerID).innerHTML = this.responseText;
			} else {
				console.log("got errror response");
			}

		} else if (this.readyState == 4 && this.status != 200) {
			alert('failed ' + this.status);
		}
	};
	xhttp.open("POST", ServetName + "?actionType=getGRSLayer&layernum="
			+ layernum + "&layerID=" + layerID + "&childLayerID="
			+ childLayerID + "&selectedValue=" + selectedValue, true);
	xhttp.send();
}

function layerselected(layernum, layerID, childLayerID, hiddenInput,
		hiddenInputForTopLayer, officerElement, ServetName) {
	var layervalue = document.getElementById(layerID).value;
	console.log("layervalue = " + layervalue);
	document.getElementById(hiddenInput).value = layervalue;
	if (layernum == 0) {
		document.getElementById(hiddenInputForTopLayer).value = layervalue;
	}
	if (layernum == 0
			|| (layernum == 1 && document
					.getElementById(hiddenInputForTopLayer).value == 3)) {
		document.getElementById(childLayerID).setAttribute("style",
				"display: inline;");
		getLayer(layernum, layerID, childLayerID, layervalue, ServetName);
	}

	if (officerElement !== null) {
		getOfficer(layervalue, officerElement, ServetName);
	}

}

function isNumeric(n) {
	return !isNaN(parseFloat(n)) && isFinite(n);
}

function addHTML(id, HTML) {
	document.getElementById(id).innerHTML += HTML;
}

function getRequests() {
	var s1 = location.search.substring(1, location.search.length).split('&'), r = {}, s2, i;
	for (i = 0; i < s1.length; i += 1) {
		s2 = s1[i].split('=');
		r[decodeURIComponent(s2[0]).toLowerCase()] = decodeURIComponent(s2[1]);
	}
	return r;
}

function Request(name) {
	return getRequests()[name.toLowerCase()];
}

function ShowExcelParsingResult(suffix) {
	var failureMessage = document.getElementById("failureMessage_" + suffix);
	if (failureMessage == null) {
		console.log("failureMessage_" + suffix + " not found");
	}
	console.log("value = " + failureMessage.value);
	if (failureMessage != null && failureMessage.value != "") {
		alert("Excel uploading result:" + failureMessage.value);
	}
}

function removeElement(elementId) {
	// Removes an element from the document
	var element = document.getElementById(elementId);
	element.parentNode.removeChild(element);
}

function approve(row_id, successMessage, i, ServletName, approveOrReject, redirect, isTextArea) {
	console.log("approving");
	// removeElement("approve_" + row_id);
	var element = document.getElementById("tdapprove_" + row_id);
	var reject_element = document.getElementById("tdreject_" + row_id);
	var edit = document.getElementById(i + "_Edit");
	var cb_td = document.getElementById(i + "_checkbox");
	var xhttp = new XMLHttpRequest();
	var jobCat = -1;
	
	console.log("i = " + i);
	console.log("ServletName = " + ServletName);
	

	var remarks_val;
	if(isTextArea == true)
	{
		remarks_val = CKEDITOR.instances[i + "_remarks"].getData();
	}
	else
	{
		remarks_val = document.getElementById(i + "_remarks").value;
	}
	
	
	
	var file_id_val = document
			.getElementById("approval_attached_fileDropzone_dropzone_" + i).value;
	console.log("remarks = " + remarks_val + " redirect = " + redirect);
	
	
	var actionType;
	var rejectTo = -1;
	if (approveOrReject == 1) 
	{
		actionType = "approve";
	}
	else if (approveOrReject == 0) 
	{
		actionType = "reject";
		rejectTo = document.getElementById('rejectTo').value;
		console.log("rejectTo = " + rejectTo);
	}
	else if (approveOrReject == 2) 
	{
		actionType = "terminate";
	}
	else if (approveOrReject == 3) 
	{
		actionType = "SendToApprovalPath";
		var e = document.getElementById("jobCat_category");
		jobCat = e.options[e.selectedIndex].value;
	}
	
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) 
		{
			if(!redirect)
			{
				if(approveOrReject == 1)
				{
					//element.innerHTML = successMessage;
					//reject_element.innerHTML = "Not in your office";
				}
				else if (approveOrReject == 0)
				{
					//element.innerHTML = "Not in your office";
					//reject_element.innerHTML = successMessage;
				}
				
				edit.innerHTML = "";
				cb_td.innerHTML = "";
			}
			else
			{
				location.replace(ServletName + "?actionType=getApprovalPage");
			}
			
		} 
		else if (this.readyState == 4 && this.status != 200) 
		{
			if(approveOrReject == 1)
			{
				//element.innerHTML = "Approval Failed";
			}
			else if (approveOrReject == 0)
			{
				//reject_element.innerHTML = "Rejection Failed";
			}
			
		}
	};
	
	var url = ServletName + "?actionType=" + actionType
		+ "&idToApprove=" + row_id + "&fileID="
		+ file_id_val + "&jobCat=" + jobCat
		+ "&rejectTo=" + rejectTo;
	
	console.log(url);
	var ajax;
	if(redirect == true)
	{
		url +=  "&redirect=" + redirect;
		ajax = false;
		var formData = new FormData();
		formData.append("remarks", remarks_val);
		xhttp.open("POST", url, ajax);
		xhttp.send(formData);
		
	}
	else
	{
		url +=  "&remarks=" + remarks_val;
		ajax = true;
		xhttp.open("POST", url, ajax);
		xhttp.send();
	}
	
	
}

function doEdit(params, i, id, deletedStyle, isPermanentTable, ServletName) {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			if (this.responseText != '') {
				var onclickFunc = "submitAjax(" + i + ",'" + deletedStyle
						+ "')";
				document.getElementById('tr_' + i).innerHTML = this.responseText;

				document.getElementById('tr_' + i).innerHTML += "<td id = '"
						+ i + "_Submit'></td>";

				if (document.getElementById('isPermanentTable').value !== 'true') {
					document.getElementById('tr_' + i).innerHTML += "<td></td><td></td><td></td>";
				}
				document.getElementById(i + '_Submit').innerHTML += "<a href='#' onclick=\""
						+ onclickFunc + "\">Submit</a>";
				document.getElementById('tr_' + i).innerHTML += "<td>"
						+ "<div class='checker'>"
						+ "<span class='' id='chkEdit'><input type='checkbox' name='ID' value='"
						+ id + "'/></span>" + "</td>";
				init(i);
			} else {
				document.getElementById('tr_' + i).innerHTML = 'NULL RESPONSE';
			}
		} else if (this.readyState == 4 && this.status != 200) {
			alert('failed ' + this.status);
		}
	};

	xhttp.open("Get", ServletName + "?isPermanentTable=" + isPermanentTable
			+ "&actionType=getEditPage" + params, true);
	xhttp.send();
}

function fixedToEditable(i, deletedStyle, id, isPermanentTable, ServletName) {
	console.log('fixedToEditable called, isPermanentTable = '
			+ isPermanentTable);
	var params = '&identity=' + id + '&inplaceedit=true' + '&deletedStyle='
			+ deletedStyle + '&ID=' + id + '&rownum=' + i + '&dummy=dummy';
	console.log('fixedToEditable i = ' + i + ' id = ' + id);
	doEdit(params, i, id, deletedStyle, isPermanentTable, ServletName);

}

function SetCheckBoxValues(tablename) {
	var i = 0;
	console.log("document.getElementById(tablename).childNodes.length = "
			+ document.getElementById(tablename).childNodes.length);
	var element = document.getElementById(tablename);

	var j = 0;
	for (i = 0; i < document.getElementById(tablename).childNodes.length; i++) {
		var tr = document.getElementById(tablename).childNodes[i];
		if (tr.nodeType === Node.ELEMENT_NODE) {
			console.log("tr.childNodes.length= " + tr.childNodes.length);
			var checkbox = tr.querySelector('input[type="checkbox"]');
			if(checkbox.name == "checkbox")
			{
				checkbox.id = tablename + "_cb_" + j;
				j++;
			}
			
		}

	}
}

var searchChanged = 0;

function setValues(x, value) {
	for (i = 0; i < x.length; i++) {
		x[i].value = value;
	}
}

function setInnerHTML(x, value) {
	for (i = 0; i < x.length; i++) {
		x[i].innerHTML = value;
	}
}

function setPageNoInAllFields(value) {
	var x = document.getElementsByName("pageno");
	setValues(x, value);
}

function setRPPInAllFields(value) {
	var x = document.getElementsByName("RECORDS_PER_PAGE");
	setValues(x, value);
}

function setTotalPageInAllFields(value) {
	var x = document.getElementsByName("totalpage");
	setInnerHTML(x, value);
}

function setPageNo() {

	setPageNoInAllFields(document.getElementById('hidden_pageno').value);
	setTotalPageInAllFields(document.getElementById('hidden_totalpage').value);
	console.log("totalpage now is "
			+ document.getElementById('hidden_totalpage').value);
	console.log("totalpage now is "
			+ document.getElementsByName('totalpage')[0].value);
	// document.getElementById('totalpage').innerHTML=
	// document.getElementById('hidden_totalpage').value;
}

function setSearchChanged() {
	searchChanged = 1;
}

function setPageNoAndSubmit(link) {
	var value = -1;
	if (link == 1) // next
	{
		value = parseInt(document.getElementsByName('pageno')[0].value, 10) + 1;
	} else if (link == 2) // previous
	{
		value = parseInt(document.getElementsByName('pageno')[0].value, 10) - 1;
	} else if (link == 3) // last
	{
		value = document.getElementById('hidden_totalpage').value;
	} else // 1st
	{
		value = 1
	}
	setPageNoInAllFields(value);
	console.log('pageno = ' + document.getElementsByName('pageno')[0].value);
	allfield_changed('go', 0);
}

function preprocessCheckBoxBeforeSubmitting(fieldname, row) {
	if (document.getElementById(fieldname + '_checkbox_' + row).checked) {
		document.getElementById(fieldname + '_checkbox_' + row).value = "true";
	} else {
		document.getElementById(fieldname + '_checkbox_' + row).value = "false";
	}
}

function preprocessDateBeforeSubmitting(fieldname, row) {
	console.log("found date = "
			+ document.getElementById(fieldname + '_date_Date_' + row).value);
	document.getElementById(fieldname + '_date_' + row).value = new Date(
			document.getElementById(fieldname + '_date_Date_' + row).value)
			.getTime();
}

function getFormattedDate(id) {
	
	var foundDate = document.getElementById(id).value;
	console.log("found date = "
			+ foundDate);
	if(foundDate === null || foundDate === '')
	{
		return '';
	}
	var date = new Date(
			document.getElementById(id).value)
			.getTime();
			
	console.log("date = " + date);
	return date;
}

function getBDFormattedDate(id) {
	
	var foundDate = document.getElementById(id).value;
	console.log("found date = "
			+ foundDate);
	if(foundDate === null || foundDate === '')
	{
		return '';
	}
	var df = foundDate.split("/");
	var year = df[2];
	var month = df[1] - 1;
	var day = df[0];
	var date = new Date(year, month, day)
			.getTime();
			
	console.log("date = " + date);
	return date;
}

function preprocessGeolocationBeforeSubmitting(fieldname, row, isReport) {
	if (isReport == true) {
		/*
		 * if(document.getElementById(fieldname + '_geolocation_' + row).value ==
		 * "1") { document.getElementById(fieldname + '_geolocation_' +
		 * row).value = ""; } if(document.getElementById(fieldname +
		 * '_geolocation_' + row).value != "" &&
		 * document.getElementById(fieldname + '_geoTextField_' + row).value !=
		 * "") { document.getElementById(fieldname + '_geolocation_' +
		 * row).value = document.getElementById(fieldname + '_geolocation_' +
		 * row).value + ":" + document.getElementById(fieldname +
		 * '_geoTextField_' + row).value; } else {
		 * document.getElementById(fieldname + '_geolocation_' + row).value =
		 * document.getElementById(fieldname + '_geolocation_' + row).value +
		 * document.getElementById(fieldname + '_geoTextField_' + row).value; }
		 * document.getElementById('address_geolocation_' + row).value =
		 * document.getElementById('address_geolocation_' + row).value.replace("<br>","");
		 * var lfcrRegexp = /\n\r?/g;
		 * document.getElementById('address_geolocation_' + row).value =
		 * document.getElementById('address_geolocation_' +
		 * row).value.replace(lfcrRegexp,"");
		 */

		var hiddenfield = document.getElementById(fieldname + '_geolocation_'
				+ row);
		var value = "%";

		$("#" + fieldname + "_geoDIV_" + row).find("select").each(
				function(index) {
					var id = $(this).attr('id');
					var option = $("#" + id + " option:selected").html();
					console.log("id = " + id + " option = " + option);
					if (option && !option.includes("Select")) {
						value += option + "%";
					}

				});
		value += document.getElementById(fieldname + '_geoTextField_' + row).value
				+ "%";
		hiddenfield.value = value;
	} else {
		document.getElementById(fieldname + '_geolocation_' + row).value = document
				.getElementById(fieldname + '_geolocation_' + row).value
				+ ":"
				+ document.getElementById(fieldname + '_geoTextField_' + row).value;
	}
	console.log("geo value = "
			+ document.getElementById(fieldname + '_geolocation_' + row).value);
}

function initGeoLocation(idPrefix, row, ServletName) {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			document.getElementById(idPrefix + row).innerHTML = this.responseText;
		} else if (this.readyState == 4 && this.status != 200) {
			alert('failed ' + this.status);
		}
	};
	xhttp.open("POST", ServletName + "?actionType=getGeo&myID=1", true);
	xhttp.send();
}

function addrselectedFunc(value, htmlID, selectedIndex, tagname, fieldName,
		row, isReport, ServletName) {
	var geodiv = fieldName + "_geoDIV_" + row;
	var hiddenfield = fieldName + "_geolocation_" + row;
	console.log('geodiv = ' + geodiv + ' hiddenfield = ' + hiddenfield);
	try {
		var elements, ids;
		elements = document.getElementById(geodiv).children;

		if (!isReport) {
			document.getElementById(hiddenfield).value = value;
		}

		ids = '';
		for (var i = elements.length - 1; i >= 0; i--) {
			var elemID = elements[i].id;
			if (elemID.includes(htmlID) && elemID > htmlID) {
				ids += elements[i].id + ' ';

				for (var j = elements[i].options.length - 1; j >= 0; j--) {

					elements[i].options[j].remove();
				}
				elements[i].remove();

			}
		}

		var newid = htmlID + '_1';

		document.getElementById(geodiv).innerHTML += "<select class='form-control' name='"
				+ tagname
				+ "' id = '"
				+ newid
				+ "' onChange=\"addrselected(this.value, this.id, this.selectedIndex, this.name, '"
				+ fieldName + "', '" + row + "')\"></select>";

		document.getElementById(htmlID).options[0].innerHTML = document
				.getElementById(htmlID).options[selectedIndex].innerHTML;
		document.getElementById(htmlID).options[0].value = document
				.getElementById(htmlID).options[selectedIndex].value;

		if (isReport) {
			elements = document.getElementById(geodiv).children;
			var geoText = '';
			var j = 0;
			for (var i = 0; i < elements.length; i++) {
				var elemID = elements[i].id;

				if (elements[i].options[0]
						&& elements[i].options[0].innerHTML != "") {
					if (j > 0) {
						geoText += ", ";
					}
					geoText += elements[i].options[0].innerHTML;
					j++;
				}

			}
			document.getElementById(hiddenfield).value = geoText;
			console.log("geoText now = " + geoText);
		}

		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				if (!this.responseText.includes('option')) {
					document.getElementById(newid).remove();
				} else {
					document.getElementById(newid).innerHTML = this.responseText;
				}

			} else if (this.readyState == 4 && this.status != 200) {
				alert('failed ' + this.status);
			}
		};

		xhttp.open("POST", ServletName + "?actionType=getGeo&myID=" + value,
				true);

		xhttp.send();
	} catch (err) {
		alert("got error: " + err);
	}
	return;
}