
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="login.LoginDTO"%>

<%@page import="applicant_profile.*"%>
<%@page import="java.util.*"%>

<%@page pageEncoding="UTF-8" %>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.util.UUID"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="geolocation.GeoLocationDAO2"%>
<%@page import="applicant_type.*"%>
<%@page import="application_type.*"%>
<%@page import="user.UserDTO"%>
<%@page import="user.UserTypeDTO"%>
<%@page import="user.UserTypeRepository"%>
<%@page import="user.UserRepository"%>
<%@page import="project_tracker.*"%>


<%
Applicant_profileDTO applicant_profileDTO;
applicant_profileDTO = (Applicant_profileDTO)request.getAttribute("applicant_profileDTO");
Applicant_typeDAO applicant_typeDAO = (Applicant_typeDAO) request.getAttribute("applicant_typeDAO");

Application_typeDAO application_typeDAO = (Application_typeDAO) request.getAttribute("application_typeDAO");
//request.getAttribute("application_typeDAO",application_typeDAO);

List<Applicant_typeDTO> tempApplicantTypeList = applicant_typeDAO.getAllApplicant_type(true);

List<Application_typeDTO> tempApplicantionTypeList = application_typeDAO.getAllApplication_type(true);


LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);

UserDTO userDTO = UserRepository.getInstance().getUserDTOByUserID(loginDTO);


if(applicant_profileDTO == null)
{
	applicant_profileDTO = new Applicant_profileDTO();
	
}
System.out.println("applicant_profileDTO = " + applicant_profileDTO);

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
	formTitle = LM.getText(LC.APPLICANT_PROFILE_EDIT_APPLICANT_PROFILE_EDIT_FORMNAME, loginDTO);
}
else
{
	formTitle = LM.getText(LC.APPLICANT_PROFILE_ADD_APPLICANT_PROFILE_ADD_FORMNAME, loginDTO);
}

String ID = request.getParameter("ID");
if(ID == null || ID.isEmpty())
{
	ID = "0";
}
System.out.println("ID = " + ID);
int i = 0;

String value = "";
Applicant_profileDTO row = applicant_profileDTO;
%>



<div class="box box-primary">
	<div class="box-header with-border">
		<h3 class="box-title"><i class="fa fa-gift"></i><%=formTitle%></h3>
	</div>
	<div class="box-body">
		<form class="form-horizontal" action="Applicant_profileServlet?actionType=<%=actionName%>&identity=<%=ID%>"
		id="bigform" name="bigform"  method="POST" enctype = "multipart/form-data"
		onsubmit="return PreprocessBeforeSubmiting(0,'<%=actionName%>')">
			<div class="form-body">

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


		<input type='hidden' class='form-control'  name='iD' id = 'iD_hidden_<%=i%>' value='<%=ID%>'/>
	
												
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_APPLICANTTYPE, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_APPLICANTTYPE, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'applicantType_div_<%=i%>'>	
		<select class='form-control'  name='applicantType' id = 'applicantType_select_<%=i%>'>
		
			<% 
			for(int k = 0; k < tempApplicantTypeList.size(); k++)
			{ 
			%>

				<%
				if(userDTO.languageID == 1)
				{
					%>
					<option value="<%=tempApplicantTypeList.get(k).iD %>">
						<%=tempApplicantTypeList.get(k).description %>
					</option>
					
					<% 
				}
				else
				{
					
					%>
					<option value="<%=tempApplicantTypeList.get(k).iD %>">
						<%=tempApplicantTypeList.get(k).descriptionBangla %>
					</option>
					<%
				}
				
				%>
				
			<% 
			} 
			%>
			
		</select>
		
	</div>
</div>			
				

		<input type='hidden' class='form-control'  name='serviceId' id = 'serviceId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.serviceId + "'"):("'" + "0" + "'")%>/>
												
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_SERVICETYPE, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_SERVICETYPE, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'serviceType_div_<%=i%>'>	
		<select class='form-control'  name='serviceType' id = 'serviceType_select_<%=i%>'>
			
			<% 
			for(int k = 0; k < tempApplicantionTypeList.size(); k++)
			{ 
			%>

				<%
				if(userDTO.languageID == 1)
				{
					%>
					<option value="<%=tempApplicantionTypeList.get(k).iD %>">
						<%=tempApplicantionTypeList.get(k).desription %>
					</option>
					
					<% 
				}
				else
				{
					
					%>
					<option value="<%=tempApplicantionTypeList.get(k).iD %>">
						<%=tempApplicantionTypeList.get(k).descriptionBangla %>
					</option>
					<%
				}
				
				%>
				
			<% 
			} 
			%>
			
		</select>
		
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_CHIEFSHAREHOLDERINFO, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_CHIEFSHAREHOLDERINFO, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'chiefShareholderInfo_div_<%=i%>'>	
		<input type='text' class='form-control'  name='chiefShareholderInfo' id = 'chiefShareholderInfo_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.chiefShareholderInfo + "'"):("'" + " " + "'")%>   />					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_NAME, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_NAME, loginDTO))%>
	<span class="required"> * </span>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'name_div_<%=i%>'>	
		<input type='text' class='form-control'  name='name' id = 'name_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.name + "'"):("''")%> required="required"
  />					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_FATHERNAME, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_FATHERNAME, loginDTO))%>
	<span class="required"> * </span>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'fatherName_div_<%=i%>'>	
		<input type='text' class='form-control'  name='fatherName' id = 'fatherName_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.fatherName + "'"):("''")%> required="required"
  />					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_HUSBANDNAME, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_HUSBANDNAME, loginDTO))%>
	<span class="required"> * </span>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'husbandName_div_<%=i%>'>	
		<input type='text' class='form-control'  name='husbandName' id = 'husbandName_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.husbandName + "'"):("''")%> required="required"
  />					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_ADDRESSPRESENT, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_ADDRESSPRESENT, loginDTO))%>
	<span class="required"> * </span>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'addressPresent_div_<%=i%>'>	
		<div id ='addressPresent_geoDIV_<%=i%>'>
			<select class='form-control' name='addressPresent_active' id = 'addressPresent_geoSelectField_<%=i%>' onChange="addrselected(this.value, this.id, this.selectedIndex, this.name, 'addressPresent_geoDIV_<%=i%>', 'addressPresent_geolocation_<%=i%>')" required="required"  pattern="^((?!select division).)*$" title="addressPresent must be selected"
></select>
		</div>
		<input type='text' class='form-control' name='addressPresent_text' id = 'addressPresent_geoTextField_<%=i%>' value=<%=actionName.equals("edit")?("'" +  GeoLocationDAO2.parseDetails(applicant_profileDTO.addressPresent)  + "'"):("''")%> placeholder='Road Number, House Number etc'>
		<input type='hidden' class='form-control'  name='addressPresent' id = 'addressPresent_geolocation_<%=i%>' value=<%=actionName.equals("edit")?("'" + "1" + "'"):("''")%>>
						
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_ADDRESSPERMANENT, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_ADDRESSPERMANENT, loginDTO))%>
	<span class="required"> * </span>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'addressPermanent_div_<%=i%>'>	
		<div id ='addressPermanent_geoDIV_<%=i%>'>
			<select class='form-control' name='addressPermanent_active' id = 'addressPermanent_geoSelectField_<%=i%>' onChange="addrselected(this.value, this.id, this.selectedIndex, this.name, 'addressPermanent_geoDIV_<%=i%>', 'addressPermanent_geolocation_<%=i%>')" required="required"  pattern="^((?!select division).)*$" title="addressPermanent must be selected"
></select>
		</div>
		<input type='text' class='form-control' name='addressPermanent_text' id = 'addressPermanent_geoTextField_<%=i%>' value=<%=actionName.equals("edit")?("'" +  GeoLocationDAO2.parseDetails(applicant_profileDTO.addressPermanent)  + "'"):("''")%> placeholder='Road Number, House Number etc'>
		<input type='hidden' class='form-control'  name='addressPermanent' id = 'addressPermanent_geolocation_<%=i%>' value=<%=actionName.equals("edit")?("'" + "1" + "'"):("''")%>>
						
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_NAMEBN, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_NAMEBN, loginDTO))%>
	<span class="required"> * </span>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'nameBn_div_<%=i%>'>	
		<input type='text' class='form-control'  name='nameBn' id = 'nameBn_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.nameBn + "'"):("''")%> required="required"
  />					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_FATHERNAMEBN, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_FATHERNAMEBN, loginDTO))%>
	<span class="required"> * </span>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'fatherNameBn_div_<%=i%>'>	
		<input type='text' class='form-control'  name='fatherNameBn' id = 'fatherNameBn_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.fatherNameBn + "'"):("''")%> required="required"
  />					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_HUSBANDNAMEBN, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_HUSBANDNAMEBN, loginDTO))%>
	<span class="required"> * </span>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'husbandNameBn_div_<%=i%>'>	
		<input type='text' class='form-control'  name='husbandNameBn' id = 'husbandNameBn_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.husbandNameBn + "'"):("''")%> required="required"
  />					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_ADDRESSPRESENTBN, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_ADDRESSPRESENTBN, loginDTO))%>
	<span class="required"> * </span>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'addressPresentBn_div_<%=i%>'>	
		<div id ='addressPresentBn_geoDIV_<%=i%>'>
			<select class='form-control' name='addressPresentBn_active' id = 'addressPresentBn_geoSelectField_<%=i%>' onChange="addrselected(this.value, this.id, this.selectedIndex, this.name, 'addressPresentBn_geoDIV_<%=i%>', 'addressPresentBn_geolocation_<%=i%>')" required="required"  pattern="^((?!select division).)*$" title="addressPresentBn must be selected"
></select>
		</div>
		<input type='text' class='form-control' name='addressPresentBn_text' id = 'addressPresentBn_geoTextField_<%=i%>' value=<%=actionName.equals("edit")?("'" +  GeoLocationDAO2.parseDetails(applicant_profileDTO.addressPresentBn)  + "'"):("''")%> placeholder='Road Number, House Number etc'>
		<input type='hidden' class='form-control'  name='addressPresentBn' id = 'addressPresentBn_geolocation_<%=i%>' value=<%=actionName.equals("edit")?("'" + "1" + "'"):("''")%>>
						
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_ADDRESSPERMANENTBN, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_ADDRESSPERMANENTBN, loginDTO))%>
	<span class="required"> * </span>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'addressPermanentBn_div_<%=i%>'>	
		<div id ='addressPermanentBn_geoDIV_<%=i%>'>
			<select class='form-control' name='addressPermanentBn_active' id = 'addressPermanentBn_geoSelectField_<%=i%>' onChange="addrselected(this.value, this.id, this.selectedIndex, this.name, 'addressPermanentBn_geoDIV_<%=i%>', 'addressPermanentBn_geolocation_<%=i%>')" required="required"  pattern="^((?!select division).)*$" title="addressPermanentBn must be selected"
></select>
		</div>
		<input type='text' class='form-control' name='addressPermanentBn_text' id = 'addressPermanentBn_geoTextField_<%=i%>' value=<%=actionName.equals("edit")?("'" +  GeoLocationDAO2.parseDetails(applicant_profileDTO.addressPermanentBn)  + "'"):("''")%> placeholder='Road Number, House Number etc'>
		<input type='hidden' class='form-control'  name='addressPermanentBn' id = 'addressPermanentBn_geolocation_<%=i%>' value=<%=actionName.equals("edit")?("'" + "1" + "'"):("''")%>>
						
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_NATIONALITY, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_NATIONALITY, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'nationality_div_<%=i%>'>	
		<select class='form-control'  name='nationality' id = 'nationality_select_<%=i%>'  >
			<option class='form-control'  value='Bangladeshi' <%=(actionName.equals("edit") && String.valueOf(applicant_profileDTO.nationality).equals("Bangladeshi"))?("selected"):""%>>Bangladeshi<br>
		</select>
		
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_AGE, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_AGE, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'age_div_<%=i%>'>	
		<input type='text' class='form-control'  name='age' id = 'age_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.age + "'"):("'" + " " + "'")%>   />					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_GENDER, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_GENDER, loginDTO))%>
	<span class="required"> * </span>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'gender_div_<%=i%>'>	
		<select class='form-control'  name='gender' id = 'gender_select_<%=i%>'  >
			<option class='form-control'  value='Male' <%=(actionName.equals("edit") && String.valueOf(applicant_profileDTO.gender).equals("Male"))?("selected"):""%>>Male<br>
			<option class='form-control'  value='Female' <%=(actionName.equals("edit") && String.valueOf(applicant_profileDTO.gender).equals("Female"))?("selected"):""%>>Female<br>
			<option class='form-control'  value='Other' <%=(actionName.equals("edit") && String.valueOf(applicant_profileDTO.gender).equals("Other"))?("selected"):""%>>Other<br>
		</select>
		
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_NID, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_NID, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'nid_div_<%=i%>'>	
		<input type='text' class='form-control'  name='nid' id = 'nid_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.nid + "'"):("'" + " " + "'")%>   />					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_CAPITAL, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_CAPITAL, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'capital_div_<%=i%>'>	
		<input type='text' class='form-control'  name='capital' id = 'capital_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.capital + "'"):("'" + "0.0" + "'")%>   />					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_PREVIOUS, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_PREVIOUS, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'previous_div_<%=i%>'>	
		<input type='text' class='form-control'  name='previous' id = 'previous_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.previous + "'"):("'" + " " + "'")%>   />					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_BANKSOLVENCY, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_BANKSOLVENCY, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'bankSolvency_div_<%=i%>'>	
		<input type='text' class='form-control'  name='bankSolvency' id = 'bankSolvency_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.bankSolvency + "'"):("'" + " " + "'")%>   />					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPLICANT_PROFILE_EDIT_PICTURE, loginDTO)):(LM.getText(LC.APPLICANT_PROFILE_ADD_PICTURE, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'picture_div_<%=i%>'>	
		<input type='text' class='form-control'  name='picture' id = 'picture_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.picture + "'"):("'" + " " + "'")%>   />					
	</div>
</div>

	<!-- Existing Files -->
	<%if(actionName.equals("edit")){ %>
		<div class="">
			<label class="control-label">Existing Files</label>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>Name</th>
						<th>File</th>
						<th>Title</th>
						<th>Tag</th>
					</tr>
				</thead>
				<tbody>
				
				<% for(int k= 0; k < applicant_profileDTO.files.size(); k++ ){
					
					String encode = Base64.getEncoder().encodeToString(applicant_profileDTO.files.get(k).fileData);
		            request.setAttribute("imgBase", encode);			            
		          			           
		           String dataURL = "data:application/pdf;base64," + applicant_profileDTO.files.get(k).fileData;
		           
		           String tempTest = "dataFileModal_1_0_" + k;
					
					%>
					<tr>
						<td><% out.print(applicant_profileDTO.files.get(k).fileTitle); %></td>
						<td>
							<a href="Project_trackerServlet?actionType=getFile&id=<%=applicant_profileDTO.files.get(k).iD%>" class="download_file">Download</a>
							<a href="#" data-toggle="modal" data-target="#dataFileModal_1_<%=k%>">View</a>
							<div class="modal fade" id="dataFileModal_1_<%=k%>">
								<div class="modal-dialog modal-lg" role="document">
									<div class="modal-content">
										<div class="modal-body">
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
												<span aria-hidden="true">×</span>
											</button>
											<object type="<%=applicant_profileDTO.files.get(k).fileType%>" data="data:<%=applicant_profileDTO.files.get(k).fileType%>;base64,<%out.write(encode) ;%>" width="100%" height="500" style="height: 85vh;">No Support</object>
										</div>
									</div>
								</div>
							</div>
	
						</td>
						<td>
							<input type="hidden"  name='projectTrackerFiles.titleedit.id' id = 'dataFile_file_id_<%=k%>' value='<%=applicant_profileDTO.files.get(k).iD%>'/>
							<input type='text' class='form-control'  name='projectTrackerFiles.titleedit' id = 'dataFile_file_title_<%=k%>' value='<%=applicant_profileDTO.files.get(k).fileTitle %>'/>
						</td>
						<td>
							<input type='text' class='form-control'  name='projectTrackerFiles.tagedit' id = 'dataFile_file_tag_<%=k%>' value='<%=applicant_profileDTO.files.get(k).fileTag %>'/>
						</td>
					</tr>
					
					<%}%>
				</tbody>
			</table>
		</div>
	<%} %>
	<!-- End Existing Files -->


	<!-- multiple file upload form -->
	<div class="col-md-12">
	
		<div class="table-responsive">
			<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th>Data File</th>
							<th>File Title</th>
							<th>File Tag</th>
							<th>Remove</th>
						</tr>
					</thead>
					<tbody id="field-ProjectTrackerFiles">					
			
					</tbody>
				</table>
			
			
			
		</div>
		<div class="form-group">
			<div class="col-xs-9 text-right">
	
				<button id="remove-ProjectTrackerFiles" name="removeProjectTrackerFiles" type="button"
						class="btn btn-danger remove-me1">Remove</button>
	
				<button id="add-more-ProjectTrackerFiles" name="add-moreProjectTrackerFiles" type="button"
						class="btn btn-primary">Add More</button>
	
			</div>
		</div>
		
		<%FilesDTO projectTrackerFilesDTO = new FilesDTO();%>
		
		<template id="template-ProjectTrackerFiles" >						
			<tr>
				<td style="display: none;">
					<input type='hidden' class='form-control'  name='projectTrackerFiles.iD' id = 'iD_hidden_<%=i%>' value='<%=ID%>'/>
				</td>
				<td style="display: none;">
					<input type='hidden' class='form-control'  name='projectTrackerFiles.projectTrackerId' id = 'projectTrackerId_hidden_<%=i%>'/>
				</td>
				<td>
					<input type='file' class='form-control'  name='projectTrackerFiles.dataFile' id = 'dataFile_file_<%=i%>'/>
				</td>
				<td style="display: none;">
					<input type='hidden' class='form-control'  name='projectTrackerFiles.isDeleted' id = 'isDeleted_hidden_<%=i%>'/>		
				</td>
				<td style="display: none;">
					<input type='hidden' class='form-control'  name='projectTrackerFiles.lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>'/>
				</td>
				<td>
					<input type='text' class='form-control'  name='projectTrackerFiles.title' id = 'dataFile_file_title_<%=i%>'/>
				</td>
				<td>
					<input type='text' class='form-control'  name='projectTrackerFiles.tag' id = 'dataFile_file_tag_<%=i%>'/>
				</td>
				<td>
					<div>
					<span id='chkEdit' ><input type='checkbox' name='checkbox' value=''/></span>
					</div>
				</td>
			</tr>								
			
		</template>
	</div>
	<!-- multiple file upload form -->	
				

		<input type='hidden' class='form-control'  name='isDeleted' id = 'isDeleted_hidden_<%=i%>' value= <%=actionName.equals("edit")?("'" + applicant_profileDTO.isDeleted + "'"):("'" + "false" + "'")%>/>
											
												

		<input type='hidden' class='form-control'  name='lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + applicant_profileDTO.lastModificationTime + "'"):("'" + "0" + "'")%>/>
												
					
	







				<div class="form-actions text-center">
					<a class="btn btn-danger" href="<%=request.getHeader("referer")%>">
					<%
					if(actionName.equals("edit"))
					{
						out.print(LM.getText(LC.APPLICANT_PROFILE_EDIT_APPLICANT_PROFILE_CANCEL_BUTTON, loginDTO));
					}
					else
					{
						out.print(LM.getText(LC.APPLICANT_PROFILE_ADD_APPLICANT_PROFILE_CANCEL_BUTTON, loginDTO));
					}
					
					%>
					</a>
					<button class="btn btn-success" type="submit">
					<%
					if(actionName.equals("edit"))
					{
						out.print(LM.getText(LC.APPLICANT_PROFILE_EDIT_APPLICANT_PROFILE_SUBMIT_BUTTON, loginDTO));
					}
					else
					{
						out.print(LM.getText(LC.APPLICANT_PROFILE_ADD_APPLICANT_PROFILE_SUBMIT_BUTTON, loginDTO));
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




function PreprocessBeforeSubmiting(row, validate)
{
	if(validate == "report")
	{
	}
	else
	{
		var empty_fields = "";
		var i = 0;
		if(!document.getElementById('name_text_' + row).checkValidity())
		{
			empty_fields += "'name'";
			if(i > 0)
			{
				empty_fields += ", ";
			}
			i ++;
		}
		if(!document.getElementById('fatherName_text_' + row).checkValidity())
		{
			empty_fields += "'fatherName'";
			if(i > 0)
			{
				empty_fields += ", ";
			}
			i ++;
		}
		if(!document.getElementById('husbandName_text_' + row).checkValidity())
		{
			empty_fields += "'husbandName'";
			if(i > 0)
			{
				empty_fields += ", ";
			}
			i ++;
		}
		if(!document.getElementById('addressPresent_geolocation_' + row).checkValidity())
		{
			empty_fields += "'addressPresent'";
			if(i > 0)
			{
				empty_fields += ", ";
			}
			i ++;
		}
		if(!document.getElementById('addressPermanent_geolocation_' + row).checkValidity())
		{
			empty_fields += "'addressPermanent'";
			if(i > 0)
			{
				empty_fields += ", ";
			}
			i ++;
		}
		if(!document.getElementById('nameBn_text_' + row).checkValidity())
		{
			empty_fields += "'nameBn'";
			if(i > 0)
			{
				empty_fields += ", ";
			}
			i ++;
		}
		if(!document.getElementById('fatherNameBn_text_' + row).checkValidity())
		{
			empty_fields += "'fatherNameBn'";
			if(i > 0)
			{
				empty_fields += ", ";
			}
			i ++;
		}
		if(!document.getElementById('husbandNameBn_text_' + row).checkValidity())
		{
			empty_fields += "'husbandNameBn'";
			if(i > 0)
			{
				empty_fields += ", ";
			}
			i ++;
		}
		if(!document.getElementById('addressPresentBn_geolocation_' + row).checkValidity())
		{
			empty_fields += "'addressPresentBn'";
			if(i > 0)
			{
				empty_fields += ", ";
			}
			i ++;
		}
		if(!document.getElementById('addressPermanentBn_geolocation_' + row).checkValidity())
		{
			empty_fields += "'addressPermanentBn'";
			if(i > 0)
			{
				empty_fields += ", ";
			}
			i ++;
		}
		if(!document.getElementById('gender_select_' + row).checkValidity())
		{
			empty_fields += "'gender'";
			if(i > 0)
			{
				empty_fields += ", ";
			}
			i ++;
		}


		if(empty_fields != "")
		{
			if(validate == "inplaceedit")
			{
				$('<input type="submit">').hide().appendTo($('#tableForm')).click().remove(); 
				return false;
			}
		}

	}

	document.getElementById('addressPresent_geolocation_' + row).value = document.getElementById('addressPresent_geolocation_' + row).value + ":" + document.getElementById('addressPresent_geoTextField_' + row).value;
	console.log("geo value = " + document.getElementById('addressPresent_geolocation_' + row).value);
	document.getElementById('addressPermanent_geolocation_' + row).value = document.getElementById('addressPermanent_geolocation_' + row).value + ":" + document.getElementById('addressPermanent_geoTextField_' + row).value;
	console.log("geo value = " + document.getElementById('addressPermanent_geolocation_' + row).value);
	document.getElementById('addressPresentBn_geolocation_' + row).value = document.getElementById('addressPresentBn_geolocation_' + row).value + ":" + document.getElementById('addressPresentBn_geoTextField_' + row).value;
	console.log("geo value = " + document.getElementById('addressPresentBn_geolocation_' + row).value);
	document.getElementById('addressPermanentBn_geolocation_' + row).value = document.getElementById('addressPermanentBn_geolocation_' + row).value + ":" + document.getElementById('addressPermanentBn_geoTextField_' + row).value;
	console.log("geo value = " + document.getElementById('addressPermanentBn_geolocation_' + row).value);
	return true;
}

function PostprocessAfterSubmiting(row)
{
	document.getElementById('addressPresent_geolocation_' + row).value = "1";
	document.getElementById('addressPermanent_geolocation_' + row).value = "1";
	document.getElementById('addressPresentBn_geolocation_' + row).value = "1";
	document.getElementById('addressPermanentBn_geolocation_' + row).value = "1";
}

function addrselected(value, htmlID, selectedIndex, tagname, geodiv, hiddenfield)
{
	console.log('geodiv = ' + geodiv + ' hiddenfield = ' + hiddenfield);
	try 
	{
		var elements, ids;
		elements = document.getElementById(geodiv).children;
		
		document.getElementById(hiddenfield).value = value;
		
		ids = '';
		for(var i = elements.length - 1; i >= 0; i--) 
		{
			var elemID = elements[i].id;
			if(elemID.includes(htmlID) && elemID > htmlID)
			{
				ids += elements[i].id + ' ';
				
				for(var j = elements[i].options.length - 1; j >= 0; j--)
				{
				
					elements[i].options[j].remove();
				}
				elements[i].remove();
				
			}
		}
				

		var newid = htmlID + '_1';

		document.getElementById(geodiv).innerHTML += "<select class='form-control' name='" + tagname + "' id = '" + newid 
		+ "' onChange=\"addrselected(this.value, this.id, this.selectedIndex, this.name, '" + geodiv +"', '" + hiddenfield +"')\"></select>";
		//console.log('innerHTML= ' + document.getElementById(geodiv).innerHTML);
		document.getElementById(htmlID).options[0].innerHTML = document.getElementById(htmlID).options[selectedIndex].innerHTML;
		document.getElementById(htmlID).options[0].value = document.getElementById(htmlID).options[selectedIndex].value;
		//console.log('innerHTML again = ' + document.getElementById(geodiv).innerHTML);
		
		
		
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() 
		{
			if (this.readyState == 4 && this.status == 200) 
			{
				if(!this.responseText.includes('option'))
				{
					document.getElementById(newid).remove();
				}
				else
				{
					document.getElementById(newid).innerHTML = this.responseText ;
				}
				
			}
			else if(this.readyState == 4 && this.status != 200)
			{
				alert('failed ' + this.status);
			}
		};
		 
		xhttp.open("POST", "Applicant_profileServlet?actionType=getGeo&myID="+value, true);
		xhttp.send();
	}
	catch(err) 
	{
		alert("got error: " + err);
	}	  
	return;
}

function init(row)
{
		
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() 
	{
		if (this.readyState == 4 && this.status == 200) 
		{
	    	document.getElementById('addressPresent_geoSelectField_' + row).innerHTML = this.responseText ;
	    	document.getElementById('addressPermanent_geoSelectField_' + row).innerHTML = this.responseText ;
	    	document.getElementById('addressPresentBn_geoSelectField_' + row).innerHTML = this.responseText ;
	    	document.getElementById('addressPermanentBn_geoSelectField_' + row).innerHTML = this.responseText ;
		}
	    else if(this.readyState == 4 && this.status != 200)
		{
			alert('failed ' + this.status);
		}
	 };
	xhttp.open("POST", "Applicant_profileServlet?actionType=getGeo&myID=1", true);
	xhttp.send();
}var row = 0;
bkLib.onDomLoaded(function() 
{	
});
	
window.onload =function ()
{
	init(row);
}


//multiple file upload
	$("#add-more-ProjectTrackerFiles").click(function(e) {
		e.preventDefault();
		var t = $("#template-ProjectTrackerFiles");
		$("#field-ProjectTrackerFiles").append(t.html());
		SetCheckBoxValues("field-ProjectTrackerFiles");

	});
	
    
    $("#remove-ProjectTrackerFiles").click(function(e){
	    var tablename = 'field-ProjectTrackerFiles';
	    var i = 0;
		console.log("document.getElementById(tablename).childNodes.length = " + document.getElementById(tablename).childNodes.length);
		var element = document.getElementById(tablename);

		var j = 0;
		for(i = document.getElementById(tablename).childNodes.length - 1; i >= 0 ; i --)
		{
			var tr = document.getElementById(tablename).childNodes[i];
			if(tr.nodeType === Node.ELEMENT_NODE)
			{
				console.log("tr.childNodes.length= " + tr.childNodes.length);
				var checkbox = tr.querySelector('input[type="checkbox"]');				
				if(checkbox.checked == true)
				{
					tr.remove();
				}
				j ++;
			}
			
		}    	
    });

// Multiple file upload


</script>






