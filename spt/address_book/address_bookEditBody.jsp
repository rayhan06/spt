
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="login.LoginDTO"%>

<%@page import="address_book.*"%>
<%@page import="java.util.*"%>

<%@page pageEncoding="UTF-8" %>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.util.UUID"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>

<%@page import="geolocation.GeoLocationDAO2"%>


<%
Address_bookDTO address_bookDTO;
address_bookDTO = (Address_bookDTO)request.getAttribute("address_bookDTO");
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
if(address_bookDTO == null)
{
	address_bookDTO = new Address_bookDTO();
	
}
System.out.println("address_bookDTO = " + address_bookDTO);

String actionName;
System.out.println("actionType = " + request.getParameter("actionType"));
if (request.getParameter("actionType").equalsIgnoreCase("getAddPage"))
{
	actionName = "add";
}
else
{
	actionName = "edit";
}
String formTitle;
if(actionName.equals("edit"))
{
	formTitle = LM.getText(LC.ADDRESS_BOOK_EDIT_ADDRESS_BOOK_EDIT_FORMNAME, loginDTO);
}
else
{
	formTitle = LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_ADD_FORMNAME, loginDTO);
}

String ID = request.getParameter("ID");
if(ID == null || ID.isEmpty())
{
	ID = "0";
}
System.out.println("ID = " + ID);
int i = 0;

String value = "";

int childTableStartingID = 1;

boolean isPermanentTable = true;
%>



<div class="box box-primary">
	<div class="box-header with-border">
		<h3 class="box-title"><i class="fa fa-gift"></i><%=formTitle%></h3>
	</div>
	<div class="box-body">
		<form class="form-horizontal" action="Address_bookServlet?actionType=<%=actionName%>&isPermanentTable=<%=isPermanentTable%>"
		id="bigform" name="bigform"  method="POST" enctype = "multipart/form-data"
		onsubmit="return PreprocessBeforeSubmiting(0,'<%=actionName%>')">
			<div class="form-body">
				
				
				




























	















<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ page import="pb.*"%>

<%
String Language = LM.getText(LC.ADDRESS_BOOK_EDIT_LANGUAGE, loginDTO);
String Options;
SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
Date date = new Date();
String datestr = dateFormat.format(date);
%>


		<input type='hidden' class='form-control'  name='iD' id = 'iD_hidden_<%=i%>' value='<%=address_bookDTO.iD%>' tag='pb_html'/>
	
												
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.ADDRESS_BOOK_EDIT_NAMEEN, loginDTO)):(LM.getText(LC.ADDRESS_BOOK_ADD_NAMEEN, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'nameEn_div_<%=i%>'>	
		<input type='text' class='form-control'  name='nameEn' id = 'nameEn_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + address_bookDTO.nameEn + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.ADDRESS_BOOK_EDIT_NAMEBN, loginDTO)):(LM.getText(LC.ADDRESS_BOOK_ADD_NAMEBN, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'nameBn_div_<%=i%>'>	
		<input type='text' class='form-control'  name='nameBn' id = 'nameBn_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + address_bookDTO.nameBn + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				
	
	
		<input type='hidden' class='form-control'  name='createdBy' id = 'createdBy_text_<%=i%>' value='unknown' tag='pb_html'/>	

		<input type='hidden' class='form-control'  name='isDeleted' id = 'isDeleted_hidden_<%=i%>' value= <%=actionName.equals("edit")?("'" + address_bookDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
												

		<input type='hidden' class='form-control'  name='lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + address_bookDTO.lastModificationTime + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
					
	





				<div class="col-md-12" style="padding-top: 20px;">
					<legend class="text-left content_legend"><%=LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_DETAIL, loginDTO)%></legend>
				</div>

				<div class="col-md-12">

					<div class="table-responsive">
						<table class="table table-bordered table-striped">
								<thead>
									<tr>
										<th>Select Office Unit</th>
										<th>Recipient Name</th>
										<th><%=(actionName.equals("edit"))?(LM.getText(LC.ADDRESS_BOOK_EDIT_ADDRESS_BOOK_DETAIL_NAME, loginDTO)):(LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_DETAIL_NAME, loginDTO))%></th>
										<th><%=(actionName.equals("edit"))?(LM.getText(LC.ADDRESS_BOOK_EDIT_ADDRESS_BOOK_DETAIL_EMPLOYEEDESIGNATION, loginDTO)):(LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_DETAIL_EMPLOYEEDESIGNATION, loginDTO))%></th>
										<th><%=(actionName.equals("edit"))?(LM.getText(LC.ADDRESS_BOOK_EDIT_ADDRESS_BOOK_DETAIL_EMPLOYEEOFFICEUNIT, loginDTO)):(LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_DETAIL_EMPLOYEEOFFICEUNIT, loginDTO))%></th>
										<th><%=(actionName.equals("edit"))?(LM.getText(LC.ADDRESS_BOOK_EDIT_ADDRESS_BOOK_DETAIL_EMPLOYEEEMAIL, loginDTO)):(LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_DETAIL_EMPLOYEEEMAIL, loginDTO))%></th>										
										<th><%=(actionName.equals("edit"))?(LM.getText(LC.ADDRESS_BOOK_EDIT_ADDRESS_BOOK_DETAIL_PHONENUMBER, loginDTO)):(LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_DETAIL_PHONENUMBER, loginDTO))%></th>
										<th><%=LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_DETAIL_REMOVE, loginDTO)%></th>
									</tr>
								</thead>
								<tbody id="field-AddressBookDetail">
						
						
<%
	if(actionName.equals("edit")){
		int index = -1;
		
		
		for(AddressBookDetailDTO addressBookDetailDTO: address_bookDTO.addressBookDetailDTOList)
		{
			index++;
			
			System.out.println("index index = "+index);

%>	
							
									<tr id = "AddressBookDetail_<%=index + 1%>">
										<td style="display: none;">











		<input type='hidden' class='form-control'  name='addressBookDetail.iD' id = 'iD_hidden_<%=childTableStartingID%>' value='<%=addressBookDetailDTO.iD%>' tag='pb_html'/>
	
										</td>
										<td style="display: none;">











		<input type='hidden' class='form-control'  name='addressBookDetail.addressBookId' id = 'addressBookId_hidden_<%=childTableStartingID%>' value=<%=actionName.equals("edit")?("'" + addressBookDetailDTO.addressBookId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
										</td>
										
										<td>										


		<select class='form-control' style='width:395px' onchange="unit_selected(this, 'employeeOrganogramId_hidden_')"  name='participant.office_unit' id = 'office_unit_<%=childTableStartingID%>'   tag='pb_html'>
		<option value = "-1">Select Office</option>
		<%			
			Options = CommonDAO.getOptions("office_units", "unit_name_eng");	
		%>
		<%=Options%>
		</select>
		
									</td>
										<td>										


		<select class='form-control' style='width:395px' onchange="participant_selected(this)"  name='addressBookDetail.employeeOrganogramId' id = 'employeeOrganogramId_hidden_<%=childTableStartingID%>'   tag='pb_html'>
<%
if(actionName.equals("edit"))
{			
	Options = CommonDAO.getOrganogramsByOrganogramID(addressBookDetailDTO.employeeOrganogramId);	
}
else
{			
	Options = CommonDAO.getOrganogramsByOrganogramID();				
}
%>
<%=Options%>
		</select>
		
										</td>
										<td>										











		<input type='text' class='form-control'  name='addressBookDetail.name' oninput="name_added(this)" id = 'name_text_<%=childTableStartingID%>' value=<%=actionName.equals("edit")?("'" + addressBookDetailDTO.name + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
										</td>
										<td>										











		<input type='text' class='form-control'  name='addressBookDetail.employeeDesignation' id = 'employeeDesignation_text_<%=childTableStartingID%>' value=<%=actionName.equals("edit")?("'" + addressBookDetailDTO.employeeDesignation + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
										</td>
										<td>										











		<input type='text' class='form-control'  name='addressBookDetail.employeeOfficeUnit' id = 'employeeOfficeUnit_text_<%=childTableStartingID%>' value=<%=actionName.equals("edit")?("'" + addressBookDetailDTO.employeeOfficeUnit + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
										</td>
										<td>										











		<input type='text' class='form-control'  name='addressBookDetail.employeeEmail' id = 'employeeEmail_text_<%=childTableStartingID%>' value=<%=actionName.equals("edit")?("'" + addressBookDetailDTO.employeeEmail + "'"):("'" + "" + "'")%> <% 
	if(!actionName.equals("edit"))
	{
%>
		required="required"  pattern="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$" title="employeeEmail must be a of valid email address format"
<%
	}
%>
  tag='pb_html'/>					
										</td>
										
										<td>										











		<input type='text' class='form-control'  name='addressBookDetail.phoneNumber' id = 'phoneNumber_number_<%=childTableStartingID%>' value=<%=actionName.equals("edit")?("'" + addressBookDetailDTO.phoneNumber + "'"):("'88'")%>  tag='pb_html'>
						
										</td>
										<td style="display: none;">











		<input type='hidden' class='form-control'  name='addressBookDetail.lastModificationTime' id = 'lastModificationTime_hidden_<%=childTableStartingID%>' value=<%=actionName.equals("edit")?("'" + addressBookDetailDTO.lastModificationTime + "'"):("'" + "0" + "'")%> tag='pb_html'/>
										</td>
										<td><div class='checker'><span id='chkEdit' ><input type='checkbox' id='addressBookDetail_cb_<%=index%>' name='checkbox' value=''/></span></div></td>
									</tr>								
<%	
			childTableStartingID ++;
		}
	}
%>						
						
								</tbody>
							</table>
						
						
						
					</div>
					<div class="form-group">
						<div class="col-xs-9 text-right">

							<button id="remove-AddressBookDetail" name="removeAddressBookDetail" type="button"
									class="btn btn-danger remove-me1"><%=LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_DETAIL_REMOVE, loginDTO)%></button>

							<button id="add-more-AddressBookDetail" name="add-moreAddressBookDetail" type="button"
									class="btn btn-primary"><%=LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_DETAIL_ADD_MORE, loginDTO)%></button>

						</div>
					</div>
					
					<%AddressBookDetailDTO addressBookDetailDTO = new AddressBookDetailDTO();%>
					
					<template id="template-AddressBookDetail" >						
								<tr>
									<td style="display: none;">











		<input type='hidden' class='form-control'  name='addressBookDetail.iD' id = 'iD_hidden_' value='<%=addressBookDetailDTO.iD%>' tag='pb_html'/>
	
									</td>
									<td style="display: none;">











		<input type='hidden' class='form-control'  name='addressBookDetail.addressBookId' id = 'addressBookId_hidden_' value=<%=actionName.equals("edit")?("'" + addressBookDetailDTO.addressBookId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
									</td>
									
									<td>
					<select class='form-control' style='width:395px' onchange="unit_selected(this, 'employeeOrganogramId_hidden_')"  name='participant.office_unit' id = 'office_unit_'   tag='pb_html'>
					<option value = "-1">Select Office</option>
					<%			
						Options = CommonDAO.getOptions("office_units", "unit_name_eng");	
					%>
					<%=Options%>
					</select>				
									</td>
									
									<td>


		<select class='form-control' style='width:395px' onchange="participant_selected(this)"  name='addressBookDetail.employeeOrganogramId' id = 'employeeOrganogramId_hidden_' value=<%=actionName.equals("edit")?("'" + addressBookDetailDTO.employeeOrganogramId + "'"):("'" + "0" + "'")%>   tag='pb_html'>
<%
if(actionName.equals("edit"))
{
	Options = CommonDAO.getOrganogramsByOrganogramID(addressBookDetailDTO.employeeOrganogramId);
}
else
{			
	Options = CommonDAO.getOrganogramsByOrganogramID();			
}
%>
<%=Options%>
		</select>
									</td>									
									<td>











		<input type='text' class='form-control'  name='addressBookDetail.name' oninput="name_added(this)" id = 'name_text_' value=<%=actionName.equals("edit")?("'" + addressBookDetailDTO.name + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
									</td>
									<td>











		<input type='text' class='form-control'  name='addressBookDetail.employeeDesignation' id = 'employeeDesignation_text_' value=<%=actionName.equals("edit")?("'" + addressBookDetailDTO.employeeDesignation + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
									</td>
									<td>











		<input type='text' class='form-control'  name='addressBookDetail.employeeOfficeUnit' id = 'employeeOfficeUnit_text_' value=<%=actionName.equals("edit")?("'" + addressBookDetailDTO.employeeOfficeUnit + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
									</td>
									<td>











		<input type='text' class='form-control'  name='addressBookDetail.employeeEmail' id = 'employeeEmail_text_' value=<%=actionName.equals("edit")?("'" + addressBookDetailDTO.employeeEmail + "'"):("'" + "" + "'")%> <% 
	if(!actionName.equals("edit"))
	{
%>
		required="required"  pattern="^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$" title="employeeEmail must be a of valid email address format"
<%
	}
%>
  tag='pb_html'/>					
									</td>
									
									<td>











		<input type='text' class='form-control'  name='addressBookDetail.phoneNumber' id = 'phoneNumber_number_'  value=<%=actionName.equals("edit")?("'" + addressBookDetailDTO.phoneNumber + "'"):("'88'")%>  tag='pb_html'>
						
									</td>
									<td style="display: none;">











		<input type='hidden' class='form-control'  name='addressBookDetail.lastModificationTime' id = 'lastModificationTime_hidden_' value=<%=actionName.equals("edit")?("'" + addressBookDetailDTO.lastModificationTime + "'"):("'" + "0" + "'")%> tag='pb_html'/>
									</td>
									<td><div><span id='chkEdit' ><input type='checkbox' name='checkbox' value=''/></span></div></td>
								</tr>								
						
					</template>
				</div>		

				<div class="form-actions text-center">
					<a class="btn btn-danger" href="<%=request.getHeader("referer")%>">
					<%
					if(actionName.equals("edit"))
					{
						%>
						<%=LM.getText(LC.ADDRESS_BOOK_EDIT_ADDRESS_BOOK_CANCEL_BUTTON, loginDTO)%>
						<%
					}
					else
					{
						%>
						<%=LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_CANCEL_BUTTON, loginDTO)%>
						<%
					}
					
					%>
					</a>
					<button class="btn btn-success" type="submit">
					<%
					if(actionName.equals("edit"))
					{
						%>
						<%=LM.getText(LC.ADDRESS_BOOK_EDIT_ADDRESS_BOOK_SUBMIT_BUTTON, loginDTO)%>
						<%
					}
					else
					{
						%>
						<%=LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_SUBMIT_BUTTON, loginDTO)%>
						<%
					}
					%>
					</button>
				</div>
							
			</div>
		
		</form>

	</div>
</div>
<script src="nicEdit.js" type="text/javascript"></script>
<script type="text/javascript">

var selected = [
	<%
	if(actionName.equals("edit"))
	{
		for(AddressBookDetailDTO addressBookDetailDTO2: address_bookDTO.addressBookDetailDTOList)
		{
			%>
			<%=addressBookDetailDTO2.employeeOrganogramId%>,
			<%
			
		}
	}
	%>
];

function name_added(textElement)
{
	console.log("name typed");
	var splitted = textElement.getAttribute("id").split("_");
	var rowID = splitted[splitted.length - 1];
	var select2 = "employeeOrganogramId_hidden_" + rowID;
	$("#" + select2).prop('disabled', true);
	$("#add-more-AddressBookDetail").prop('disabled', false);
}

function participant_selected(selectedElement)
{
	console.log("selected " + selectedElement.value + " id = " + selectedElement.getAttribute("id"));
	var option = selectedElement.options[selectedElement.selectedIndex];
	console.log("selected value = " + option.value + " empname = " + option.getAttribute("empname"));
	var splitted = selectedElement.getAttribute("id").split("_");
	var rowID = splitted[splitted.length - 1];
	console.log("rowID = " + rowID);
	selected[rowID - 1] = option.value;
	
	document.getElementById("name_text_" + rowID).value = option.getAttribute("empname");
	document.getElementById("name_text_" + rowID).disabled = true;
	document.getElementById("employeeDesignation_text_" + rowID).value = option.getAttribute("designation");
	document.getElementById("employeeDesignation_text_" + rowID).disabled = true;
	document.getElementById("employeeOfficeUnit_text_" + rowID).value = option.getAttribute("unitname");
	document.getElementById("employeeOfficeUnit_text_" + rowID).disabled = true;
	document.getElementById("phoneNumber_number_" + rowID).value = option.getAttribute("phonenumber");
	document.getElementById("phoneNumber_number_" + rowID).disabled = true;
	document.getElementById("employeeEmail_text_" + rowID).value = option.getAttribute("email");
	document.getElementById("employeeEmail_text_" + rowID).disabled = true;
	
	$("#add-more-AddressBookDetail").prop('disabled', false);
	$("#" + selectedElement.getAttribute("id")).prop('disabled', true);
}


function remove_selected(rowID)
{
	console.log("in remove_selected " + rowID);
	var selectobject = document.getElementById("employeeOrganogramId_hidden_" + rowID);
	
	
	for(var j = 0; j < selected.length; j ++)
	{
		console.log("j = " + j + " element = " + selected[j]);
		$("#employeeOrganogramId_hidden_" + rowID + " option[value='" + selected[j] +  "']").remove();
	}	
	
}


function PreprocessBeforeSubmiting(row, validate)
{
	if(validate == "report")
	{
	}
	else
	{
		var empty_fields = "";
		var i = 0;


		if(empty_fields != "")
		{
			if(validate == "inplaceedit")
			{
				$('<input type="submit">').hide().appendTo($('#tableForm')).click().remove(); 
				return false;
			}
		}

	}


	for(i = 1; i < child_table_extra_id; i ++)
	{
	}
	$("input").prop("disabled", false);
	//$('select').select2('enable',false);
	$("select").prop("disabled", false);
	return true;
}


function addrselected(value, htmlID, selectedIndex, tagname,  fieldName, row)
{	
	addrselectedFunc(value, htmlID, selectedIndex, tagname,  fieldName, row, false, "Address_bookServlet");	
}

function init(row)
{


	for(i = 1; i < child_table_extra_id; i ++)
	{
			$("#employeeOrganogramId_hidden_" + i).select2({
				dropdownAutoWidth: true
			});
	}
	
	
}

var row = 0;
	
window.onload =function ()
{
	console.log("onload 1");
	init(row);
	console.log("onload 2");
	//CKEDITOR.replaceAll();
}

function printTime(time)
{
	console.log("time = " + time.value);
}

var child_table_extra_id = <%=childTableStartingID%>;

	$("#add-more-AddressBookDetail").click(
        function(e) 
		{
            e.preventDefault();
            var t = $("#template-AddressBookDetail");

            $("#field-AddressBookDetail").append(t.html());
			SetCheckBoxValues("field-AddressBookDetail");
			
			var tr = $("#field-AddressBookDetail").find("tr:last-child");
			
			tr.attr("id","AddressBookDetail_" + child_table_extra_id);
			
			console.log("adding, row_id = " + child_table_extra_id);
			
			tr.find("[tag='pb_html']").each(function( index ) 
			{
				var prev_id = $( this ).attr('id');
				$( this ).attr('id', prev_id + child_table_extra_id);
				//console.log( index + ": " + $( this ).attr('id') );
			});
			
			remove_selected(child_table_extra_id);
			var select2 = "employeeOrganogramId_hidden_" + child_table_extra_id;
			
			child_table_extra_id ++;
			$("#" + select2).select2({
				dropdownAutoWidth: true
			});
			
			$("#add-more-AddressBookDetail").prop('disabled', true);

        });

    
      $("#remove-AddressBookDetail").click(function(e){
    	$("#add-more-AddressBookDetail").prop('disabled', false);
	    var tablename = 'field-AddressBookDetail';
	    var i = 0;
		console.log("document.getElementById(tablename).childNodes.length = " + document.getElementById(tablename).childNodes.length);
		var element = document.getElementById(tablename);

		var j = 0;
		for(i = document.getElementById(tablename).childNodes.length - 1; i >= 0 ; i --)
		{
			var tr = document.getElementById(tablename).childNodes[i];
			if(tr.nodeType === Node.ELEMENT_NODE)
			{
				
				var checkbox = tr.querySelector('input[type="checkbox"]');				
				if(checkbox.checked == true)
				{
					console.log("tr id = " + tr.id);
					var splitted = tr.id.split("_");
					var rowID = splitted[splitted.length - 1];
					console.log("rowID = " + rowID);
					selected[rowID - 1] = -1;
					tr.remove();
				}
				j ++;
			}
			
		}    	
    });
	


</script>







