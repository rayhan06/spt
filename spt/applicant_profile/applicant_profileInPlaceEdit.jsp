<%@page pageEncoding="UTF-8" %>

<%@page import="sessionmanager.SessionConstants"%>
<%@page import="applicant_profile.Applicant_profileDTO"%>
<%@page import="java.util.UUID"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="geolocation.GeoLocationDAO2"%>

<%
Applicant_profileDTO applicant_profileDTO = (Applicant_profileDTO)request.getAttribute("applicant_profileDTO");
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);

if(applicant_profileDTO == null)
{
	applicant_profileDTO = new Applicant_profileDTO();
	
}
System.out.println("applicant_profileDTO = " + applicant_profileDTO);

String actionName = "edit";


String ID = request.getParameter("ID");
if(ID == null || ID.isEmpty())
{
	ID = "0";
}
System.out.println("ID = " + ID);
int i = Integer.parseInt(request.getParameter("rownum"));
String deletedStyle = request.getParameter("deletedstyle");

String value = "";
Applicant_profileDTO row = applicant_profileDTO;
%>




























	














<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ page import="pb.*"%>

<%
String Language = LM.getText(LC.APPLICANT_PROFILE_EDIT_LANGUAGE, loginDTO);
String Options;
SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
Date date = new Date();
String datestr = dateFormat.format(date);
%>

			
<%=("<td id = '" + i + "_iD" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='iD' id = 'iD_hidden_<%=i%>' value='<%=ID%>'/>
	
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_applicantType'>")%>
			
	
	<div class="form-inline" id = 'applicantType_div_<%=i%>'>
		<select class='form-control'  name='applicantType' id = 'applicantType_select_<%=i%>'  >
<%
if(actionName.equals("edit"))
{
			Options = CommonDAO.getOptions(Language, "select", "applicant", "applicantType_select_" + i, "form-control", "applicantType", applicant_profileDTO.applicantType + "");
}
else
{			
			Options = CommonDAO.getOptions(Language, "select", "applicant", "applicantType_select_" + i, "form-control", "applicantType" );			
}
out.print(Options);
%>
		</select>
		
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_serviceId'>")%>
			

		<input type='hidden' class='form-control'  name='serviceId' id = 'serviceId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.serviceId + "'"):("'" + "0" + "'")%>/>
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_serviceType'>")%>
			
	
	<div class="form-inline" id = 'serviceType_div_<%=i%>'>
		<select class='form-control'  name='serviceType' id = 'serviceType_select_<%=i%>'  >
<%
if(actionName.equals("edit"))
{
			Options = CommonDAO.getOptions(Language, "select", "service", "serviceType_select_" + i, "form-control", "serviceType", applicant_profileDTO.serviceType + "");
}
else
{			
			Options = CommonDAO.getOptions(Language, "select", "service", "serviceType_select_" + i, "form-control", "serviceType" );			
}
out.print(Options);
%>
		</select>
		
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_chiefShareholderInfo'>")%>
			
	
	<div class="form-inline" id = 'chiefShareholderInfo_div_<%=i%>'>
		<input type='text' class='form-control'  name='chiefShareholderInfo' id = 'chiefShareholderInfo_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.chiefShareholderInfo + "'"):("'" + " " + "'")%>   />					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_name'>")%>
			
	
	<div class="form-inline" id = 'name_div_<%=i%>'>
		<input type='text' class='form-control'  name='name' id = 'name_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.name + "'"):("''")%> required="required"
  />					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_fatherName'>")%>
			
	
	<div class="form-inline" id = 'fatherName_div_<%=i%>'>
		<input type='text' class='form-control'  name='fatherName' id = 'fatherName_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.fatherName + "'"):("''")%> required="required"
  />					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_husbandName'>")%>
			
	
	<div class="form-inline" id = 'husbandName_div_<%=i%>'>
		<input type='text' class='form-control'  name='husbandName' id = 'husbandName_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.husbandName + "'"):("''")%> required="required"
  />					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_addressPresent'>")%>
			
	
	<div class="form-inline" id = 'addressPresent_div_<%=i%>'>
		<div id ='addressPresent_geoDIV_<%=i%>'>
			<select class='form-control' name='addressPresent_active' id = 'addressPresent_geoSelectField_<%=i%>' onChange="addrselected(this.value, this.id, this.selectedIndex, this.name, 'addressPresent_geoDIV_<%=i%>', 'addressPresent_geolocation_<%=i%>')" required="required"  pattern="^((?!select division).)*$" title="addressPresent must be selected"
></select>
		</div>
		<input type='text' class='form-control' name='addressPresent_text' id = 'addressPresent_geoTextField_<%=i%>' value=<%=actionName.equals("edit")?("'" +  GeoLocationDAO2.parseDetails(applicant_profileDTO.addressPresent)  + "'"):("''")%> placeholder='Road Number, House Number etc'>
		<input type='hidden' class='form-control'  name='addressPresent' id = 'addressPresent_geolocation_<%=i%>' value=<%=actionName.equals("edit")?("'" + "1" + "'"):("''")%>>
						
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_addressPermanent'>")%>
			
	
	<div class="form-inline" id = 'addressPermanent_div_<%=i%>'>
		<div id ='addressPermanent_geoDIV_<%=i%>'>
			<select class='form-control' name='addressPermanent_active' id = 'addressPermanent_geoSelectField_<%=i%>' onChange="addrselected(this.value, this.id, this.selectedIndex, this.name, 'addressPermanent_geoDIV_<%=i%>', 'addressPermanent_geolocation_<%=i%>')" required="required"  pattern="^((?!select division).)*$" title="addressPermanent must be selected"
></select>
		</div>
		<input type='text' class='form-control' name='addressPermanent_text' id = 'addressPermanent_geoTextField_<%=i%>' value=<%=actionName.equals("edit")?("'" +  GeoLocationDAO2.parseDetails(applicant_profileDTO.addressPermanent)  + "'"):("''")%> placeholder='Road Number, House Number etc'>
		<input type='hidden' class='form-control'  name='addressPermanent' id = 'addressPermanent_geolocation_<%=i%>' value=<%=actionName.equals("edit")?("'" + "1" + "'"):("''")%>>
						
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_nameBn'>")%>
			
	
	<div class="form-inline" id = 'nameBn_div_<%=i%>'>
		<input type='text' class='form-control'  name='nameBn' id = 'nameBn_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.nameBn + "'"):("''")%> required="required"
  />					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_fatherNameBn'>")%>
			
	
	<div class="form-inline" id = 'fatherNameBn_div_<%=i%>'>
		<input type='text' class='form-control'  name='fatherNameBn' id = 'fatherNameBn_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.fatherNameBn + "'"):("''")%> required="required"
  />					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_husbandNameBn'>")%>
			
	
	<div class="form-inline" id = 'husbandNameBn_div_<%=i%>'>
		<input type='text' class='form-control'  name='husbandNameBn' id = 'husbandNameBn_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.husbandNameBn + "'"):("''")%> required="required"
  />					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_addressPresentBn'>")%>
			
	
	<div class="form-inline" id = 'addressPresentBn_div_<%=i%>'>
		<div id ='addressPresentBn_geoDIV_<%=i%>'>
			<select class='form-control' name='addressPresentBn_active' id = 'addressPresentBn_geoSelectField_<%=i%>' onChange="addrselected(this.value, this.id, this.selectedIndex, this.name, 'addressPresentBn_geoDIV_<%=i%>', 'addressPresentBn_geolocation_<%=i%>')" required="required"  pattern="^((?!select division).)*$" title="addressPresentBn must be selected"
></select>
		</div>
		<input type='text' class='form-control' name='addressPresentBn_text' id = 'addressPresentBn_geoTextField_<%=i%>' value=<%=actionName.equals("edit")?("'" +  GeoLocationDAO2.parseDetails(applicant_profileDTO.addressPresentBn)  + "'"):("''")%> placeholder='Road Number, House Number etc'>
		<input type='hidden' class='form-control'  name='addressPresentBn' id = 'addressPresentBn_geolocation_<%=i%>' value=<%=actionName.equals("edit")?("'" + "1" + "'"):("''")%>>
						
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_addressPermanentBn'>")%>
			
	
	<div class="form-inline" id = 'addressPermanentBn_div_<%=i%>'>
		<div id ='addressPermanentBn_geoDIV_<%=i%>'>
			<select class='form-control' name='addressPermanentBn_active' id = 'addressPermanentBn_geoSelectField_<%=i%>' onChange="addrselected(this.value, this.id, this.selectedIndex, this.name, 'addressPermanentBn_geoDIV_<%=i%>', 'addressPermanentBn_geolocation_<%=i%>')" required="required"  pattern="^((?!select division).)*$" title="addressPermanentBn must be selected"
></select>
		</div>
		<input type='text' class='form-control' name='addressPermanentBn_text' id = 'addressPermanentBn_geoTextField_<%=i%>' value=<%=actionName.equals("edit")?("'" +  GeoLocationDAO2.parseDetails(applicant_profileDTO.addressPermanentBn)  + "'"):("''")%> placeholder='Road Number, House Number etc'>
		<input type='hidden' class='form-control'  name='addressPermanentBn' id = 'addressPermanentBn_geolocation_<%=i%>' value=<%=actionName.equals("edit")?("'" + "1" + "'"):("''")%>>
						
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_nationality'>")%>
			
	
	<div class="form-inline" id = 'nationality_div_<%=i%>'>
		<select class='form-control'  name='nationality' id = 'nationality_select_<%=i%>'  >
			<option class='form-control'  value='Bangladeshi' <%=(actionName.equals("edit") && String.valueOf(applicant_profileDTO.nationality).equals("Bangladeshi"))?("selected"):""%>>Bangladeshi<br>
		</select>
		
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_age'>")%>
			
	
	<div class="form-inline" id = 'age_div_<%=i%>'>
		<input type='text' class='form-control'  name='age' id = 'age_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.age + "'"):("'" + " " + "'")%>   />					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_gender'>")%>
			
	
	<div class="form-inline" id = 'gender_div_<%=i%>'>
		<select class='form-control'  name='gender' id = 'gender_select_<%=i%>'  >
			<option class='form-control'  value='Male' <%=(actionName.equals("edit") && String.valueOf(applicant_profileDTO.gender).equals("Male"))?("selected"):""%>>Male<br>
			<option class='form-control'  value='Female' <%=(actionName.equals("edit") && String.valueOf(applicant_profileDTO.gender).equals("Female"))?("selected"):""%>>Female<br>
			<option class='form-control'  value='Other' <%=(actionName.equals("edit") && String.valueOf(applicant_profileDTO.gender).equals("Other"))?("selected"):""%>>Other<br>
		</select>
		
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_nid'>")%>
			
	
	<div class="form-inline" id = 'nid_div_<%=i%>'>
		<input type='text' class='form-control'  name='nid' id = 'nid_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.nid + "'"):("'" + " " + "'")%>   />					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_capital'>")%>
			
	
	<div class="form-inline" id = 'capital_div_<%=i%>'>
		<input type='text' class='form-control'  name='capital' id = 'capital_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.capital + "'"):("'" + "0.0" + "'")%>   />					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_previous'>")%>
			
	
	<div class="form-inline" id = 'previous_div_<%=i%>'>
		<input type='text' class='form-control'  name='previous' id = 'previous_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.previous + "'"):("'" + " " + "'")%>   />					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_bankSolvency'>")%>
			
	
	<div class="form-inline" id = 'bankSolvency_div_<%=i%>'>
		<input type='text' class='form-control'  name='bankSolvency' id = 'bankSolvency_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.bankSolvency + "'"):("'" + " " + "'")%>   />					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_picture'>")%>
			
	
	<div class="form-inline" id = 'picture_div_<%=i%>'>
		<input type='text' class='form-control'  name='picture' id = 'picture_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.picture + "'"):("'" + " " + "'")%>   />					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_isDeleted" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='isDeleted' id = 'isDeleted_hidden_<%=i%>' value= <%=actionName.equals("edit")?("'" + applicant_profileDTO.isDeleted + "'"):("'" + "false" + "'")%>/>
											
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_lastModificationTime" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>' value='<%=applicant_profileDTO.lastModificationTime%>'/>
		
												
<%=("</td>")%>
					
		