
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="login.LoginDTO"%>

<%@page import="appointment.*"%>
<%@page import="java.util.*"%>

<%@page pageEncoding="UTF-8" %>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.util.UUID"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>

<%@page import="geolocation.GeoLocationDAO2"%>
<%@page import="util.TimeFormat"%>
<%@page import="family.*"%>

<%

FamilyDAO familyDAO = new FamilyDAO();
FamilyMemberDAO familyMemberDAO = new FamilyMemberDAO("family_member");
AppointmentDTO appointmentDTO;
appointmentDTO = (AppointmentDTO)request.getAttribute("appointmentDTO");
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
boolean dtoFound = true;
if(appointmentDTO == null)
{
	appointmentDTO = new AppointmentDTO();
	dtoFound = false;
	
}
System.out.println("appointmentDTO = " + appointmentDTO);

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
System.out.println("actionName = " + actionName);

String formTitle = LM.getText(LC.APPOINTMENT_ADD_APPOINTMENT_ADD_FORMNAME, loginDTO);


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
		<form class="form-horizontal" action="AppointmentServlet?actionType=<%=actionName%>&isPermanentTable=<%=isPermanentTable%>"
		id="bigform" name="bigform"  method="POST" enctype = "multipart/form-data"
		onsubmit="return PreprocessBeforeSubmiting(0,'<%=actionName%>')">
			<div class="form-body">
	

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ page import="pb.*"%>

<%
String Language = LM.getText(LC.APPOINTMENT_EDIT_LANGUAGE, loginDTO);
String Options;
SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
Date date = new Date();
String datestr = dateFormat.format(date);
%>


		<input type='hidden' class='form-control'  name='iD' id = 'iD_hidden_<%=i%>' value='<%=appointmentDTO.iD%>' tag='pb_html'/>
	
												
	
<label class="col-lg-3 control-label">
	<%=LM.getText(LC.APPOINTMENT_ADD_VISITDATE, loginDTO)%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'visitDate_div_<%=i%>'>	
		<input type='text' class='form-control formRequired datepicker' name="visitDate" readonly="readonly" data-label="Document Date" id = 'visitDate_date_<%=i%>' value=<%
if(actionName.equals("edit"))
{
	String formatted_visitDate = dateFormat.format(new Date(appointmentDTO.visitDate)).toString();
	%>
	'<%=formatted_visitDate%>'
	<%
}
else
{
	%>
	'<%=datestr%>'
	<%
}
%>
   tag='pb_html'>
		
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=LM.getText(LC.HM_DEPARTMENT, loginDTO)%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'specialityType_div_<%=i%>'>	
		<select class='form-control'  name='specialityType' id = 'specialityType_select_<%=i%>' onchange="dept_selected(this, 'doctorId_select2_<%=i%>')"  tag='pb_html'>
<%
if(dtoFound)
{
			Options = CatDAO.getOptions(Language, "department", (int)appointmentDTO.specialityType);
}
else
{
	%>
			<option value="-1">Select Speciality</option>
	<%
			Options = CatDAO.getOptions(Language, "department", -1);			
}
%>
<%=Options%>
		</select>
		
	</div>
</div>			
				

<label class="col-lg-3 control-label">
	<%=LM.getText(LC.HM_DOCTOR, loginDTO)%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'doctorId_div_<%=i%>'>	
		<select class='form-control' required  name='doctorId' id = 'doctorId_select2_<%=i%>'   tag='pb_html'>
<%
if(dtoFound)
{
			Options = CommonDAO.getOrganogramsByOrganogramID(appointmentDTO.doctorId);
}
else
{			
			Options = CommonDAO.getOrganogramsByOrganogramID();			
}
%>
<%=Options%>
		</select>
		
	</div>
</div>													
	
<label class="col-lg-3 control-label">
	<%=LM.getText(LC.HM_SHIFT, loginDTO)%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'shiftCat_div_<%=i%>'>	
		<select class='form-control'  name='shiftCat' id = 'shiftCat_category_<%=i%>' onchange="shiftSelected()"  tag='pb_html'>		
<%
if(actionName.equals("edit"))
{
			Options = CatDAO.getOptions(Language, "shift", appointmentDTO.shiftCat);
}
else
{
	%>
			<option value = "-1">Select Shift</option>
	<%
			Options = CatDAO.getOptions(Language, "shift", -1);			
}
%>
<%=Options%>
		</select>
		
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=LM.getText(LC.APPOINTMENT_ADD_AVAILABLETIMESLOT, loginDTO)%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'availableTimeSlot_div_<%=i%>'>	
		<select class='form-control'  name='availableTimeSlot' id = 'availableTimeSlot_text_<%=i%>' tag='pb_html'>
		</select>					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=LM.getText(LC.APPOINTMENT_ADD_REMARKS, loginDTO)%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'remarks_div_<%=i%>'>	
		<input type='text' class='form-control'  name='remarks' id = 'remarks_text_<%=i%>' value=<%=dtoFound?("'" + appointmentDTO.remarks + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
</div>

		
				
<h3 class="col-lg-3 control-label">
	<%=LM.getText(LC.APPOINTMENT_ADD_PATIENTNAME, loginDTO)%>
</h3>
<div class="form-group ">						
</div>

<label class="col-lg-3 control-label">
	<%=LM.getText(LC.HM_SELECT_EMPLOYEE, loginDTO)%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'doctorId_div_<%=i%>'>	
		<input type='text' class='form-control' name='patientId' onfocusout="patient_inputted(this.value)" id = 'patientId_hidden_<%=i%>'
		 value=<%=dtoFound?("'" + appointmentDTO.patientId + "'"):("'" + "" + "'")%>   tag='pb_html'/>
	</div>
</div>	

<label class="col-lg-3 control-label">
	<%=LM.getText(LC.SELECT_PATIENT_HM, loginDTO)%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'whoIsThePatientCat_div_<%=i%>'>	
		<select class='form-control'  name='whoIsThePatientCat' onchange="getPatientInfo(this.value)"
		 id = 'whoIsThePatientCat_category_<%=i%>'   tag='pb_html'>		
<%
if(dtoFound)
{
	if(appointmentDTO.whoIsThePatientCat == -1)
	{
		Options = "<option value = '-1'>Own</option>";
	}
	else
	{
		FamilyMemberDTO familyMemberDTO = familyMemberDAO.getDTOByID(appointmentDTO.whoIsThePatientCat);
		Options = "<option value = '" + familyMemberDTO.iD +  "'>"
				+ familyMemberDTO.nameEn 
				+ " (" + CatDAO.getName("English", "relationship", familyMemberDTO.relationshipCat) + ")"
				+ "</option>";
	}
}
else
{			
	Options = "";				
}
%>
<%=Options%>
		</select>
		
	</div>
</div>			
				
												
	
<label class="col-lg-3 control-label">
	<%=LM.getText(LC.APPOINTMENT_ADD_PATIENTNAME, loginDTO)%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'patientName_div_<%=i%>'>	
		<input type='text' class='form-control'  name='patientName' id = 'patientName_text_<%=i%>' value=<%=dtoFound?("'" + appointmentDTO.patientName + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=LM.getText(LC.APPOINTMENT_ADD_PHONENUMBER, loginDTO)%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'phoneNumber_div_<%=i%>'>	
		<input type='text' class='form-control'  name='phoneNumber' id = 'phoneNumber_number_<%=i%>'  value=<%=dtoFound?("'" + appointmentDTO.phoneNumber + "'"):("'" + 880 + "'")%>  tag='pb_html'>
						
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=LM.getText(LC.APPOINTMENT_ADD_DATEOFBIRTH, loginDTO)%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'dateOfBirth_div_<%=i%>'>	
		<input type='text' class='form-control formRequired datepicker' name="dateOfBirth" readonly="readonly" data-label="Document Date" id = 'dateOfBirth_date_<%=i%>' value=<%
if(dtoFound)
{
	String formatted_dateOfBirth = dateFormat.format(new Date(appointmentDTO.dateOfBirth)).toString();
	%>
	'<%=formatted_dateOfBirth%>'
	<%
}
else
{
	%>
	'<%=datestr%>'
	<%
}
%>
   tag='pb_html'>
		
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=LM.getText(LC.APPOINTMENT_ADD_GENDERCAT, loginDTO)%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'genderCat_div_<%=i%>'>	
		<select class='form-control'  name='genderCat' id = 'genderCat_category_<%=i%>'   tag='pb_html'>		
<%
if(dtoFound)
{
			Options = CatDAO.getOptions(Language, "gender", appointmentDTO.genderCat);
}
else
{			
			Options = CatDAO.getOptions(Language, "gender", -1);			
}
%>
<%=Options%>
		</select>
		
	</div>
</div>			
				
						
	
<label class="col-lg-3 control-label">
	<%=LM.getText(LC.HM_CHARGE, loginDTO)%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'isChargeNeeded_div_<%=i%>'>	
		<input type='checkbox' class='form-control'  name='isChargeNeeded' id = 'isChargeNeeded_checkbox_<%=i%>' value='true' <%=(actionName.equals("edit") && String.valueOf(appointmentDTO.isChargeNeeded).equals("true"))?("checked"):""%>   tag='pb_html'><br>
	</div>
</div>			
				

		<input type='hidden' class='form-control'  name='isDeleted' id = 'isDeleted_hidden_<%=i%>' value= <%=actionName.equals("edit")?("'" + appointmentDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
												

		<input type='hidden' class='form-control'  name='lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + appointmentDTO.lastModificationTime + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
					
	






				<div class="form-actions text-center">
					<a class="btn btn-danger" href="<%=request.getHeader("referer")%>">
					<%
					if(actionName.equals("edit"))
					{
						%>
						<%=LM.getText(LC.APPOINTMENT_EDIT_APPOINTMENT_CANCEL_BUTTON, loginDTO)%>
						<%
					}
					else
					{
						%>
						<%=LM.getText(LC.APPOINTMENT_ADD_APPOINTMENT_CANCEL_BUTTON, loginDTO)%>
						<%
					}
					
					%>
					</a>
					<button class="btn btn-success" type="submit">
					<%
					if(actionName.equals("edit"))
					{
						%>
						<%=LM.getText(LC.APPOINTMENT_EDIT_APPOINTMENT_SUBMIT_BUTTON, loginDTO)%>
						<%
					}
					else
					{
						%>
						<%=LM.getText(LC.APPOINTMENT_ADD_APPOINTMENT_SUBMIT_BUTTON, loginDTO)%>
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

function patientSelected(select)
{
	console.log($("#" + select).find('option:selected').attr('empname'));
	var name = $("#" + select).find('option:selected').attr('empname');
	$("#patientName_text_0").val(name);
}

function shiftSelected() {
	console.log("shiftSelected");
	
	var shift = $("#shiftCat_category_<%=i%>").val();
	var doctor = $("#doctorId_select2_<%=i%>").val();
	var date = $("#visitDate_date_<%=i%>").val();
	
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			if (this.responseText.includes('option')) {
				console.log("got response");
				$("#availableTimeSlot_text_<%=i%>").html(this.responseText);
			} else {
				console.log("got errror response");
			}

		} else if (this.readyState == 4 && this.status != 200) {
			alert('failed ' + this.status);
		}
	};
	xhttp.open("GET", "AppointmentServlet?actionType=getSlot&date=" + date
				+ "&doctor=" + doctor
				+ "&shift=" + shift
				, true);
	xhttp.send();
}


$(document).ready( function(){

    basicInit();
});

function PreprocessBeforeSubmiting(row, validate)
{
	
	$( "select" ).prop( "disabled", false );
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

	preprocessCheckBoxBeforeSubmitting('isChargeNeeded', row);		

	return true;
}


function addrselected(value, htmlID, selectedIndex, tagname,  fieldName, row)
{	
	addrselectedFunc(value, htmlID, selectedIndex, tagname,  fieldName, row, false, "AppointmentServlet");	
}

function init(row)
{


	
}

function getPatientInfo(value)
{
	console.log( 'changed value: ' +  value );
	
	var patientId = value;
	var type = 1; // relative
	if(patientId == -1)
	{
		patientId = $("#patientId_hidden_<%=i%>").val();
		type = 0;
	}
	
	
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function () {
		if (this.readyState == 4 && this.status == 200) 
		{
			var familyMemberDTO = JSON.parse(this.responseText); 
			
			$('#patientName_text_<%=i%>').val(familyMemberDTO.nameEn);
			$('#phoneNumber_number_<%=i%>').val(familyMemberDTO.mobile);
			$('#dateOfBirth_date_<%=i%>').val(familyMemberDTO.dateOfBirthFormatted);
			$('#genderCat_category_<%=i%>').val(familyMemberDTO.genderCat);
		}
		else
		{
			//console.log('failed status = ' + this.status + " this.readyState = " + this.readyState);
		}
	};

	xhttp.open("POST", "FamilyServlet?actionType=getPatientDetails&patientId=" + patientId + "&type=" + type, true);
	xhttp.send();
	
}

function patient_inputted(value)
{
	console.log( 'changed value: ' +  value );

	
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function () {
		if (this.readyState == 4 && this.status == 200) 
		{
			var options = this.responseText;			
			$("#whoIsThePatientCat_category_<%=i%>").html(options);
		}
		else
		{
			//console.log('failed status = ' + this.status + " this.readyState = " + this.readyState);
		}
	};

	xhttp.open("POST", "FamilyServlet?actionType=getFamily&organogramId=" + value, true);
	xhttp.send();
}

var row = 0;
	
window.onload =function ()
{
	init(row);
	CKEDITOR.replaceAll();
}

var child_table_extra_id = <%=childTableStartingID%>;



</script>






