<%@page pageEncoding="UTF-8" %>

<%@page import="sessionmanager.SessionConstants"%>
<%@page import="approval_summary.Approval_summaryDTO"%>
<%@page import="java.util.*"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>

<%
Approval_summaryDTO approval_summaryDTO = (Approval_summaryDTO)request.getAttribute("approval_summaryDTO");
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);

if(approval_summaryDTO == null)
{
	approval_summaryDTO = new Approval_summaryDTO();
	
}
System.out.println("approval_summaryDTO = " + approval_summaryDTO);

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

%>




























	















<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ page import="pb.*"%>

<%
String Language = LM.getText(LC.APPROVAL_SUMMARY_EDIT_LANGUAGE, loginDTO);
String Options;
SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
Date date = new Date();
String datestr = dateFormat.format(date);
%>

			
<%=("<td id = '" + i + "_iD" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='iD' id = 'iD_hidden_<%=i%>' value='<%=approval_summaryDTO.iD%>' tag='pb_html'/>
	
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_tableName'>")%>
			
	
	<div class="form-inline" id = 'tableName_div_<%=i%>'>
		<input type='text' class='form-control'  name='tableName' id = 'tableName_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_summaryDTO.tableName + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_tableId'>")%>
			

		<input type='hidden' class='form-control'  name='tableId' id = 'tableId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_summaryDTO.tableId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_initiator'>")%>
			
	
	<div class="form-inline" id = 'initiator_div_<%=i%>'>
		<input type='text' class='form-control'  name='initiator' id = 'initiator_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_summaryDTO.initiator + "'"):("'" + "0" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_approvalStatusCat'>")%>
			
	
	<div class="form-inline" id = 'approvalStatusCat_div_<%=i%>'>
		<select class='form-control'  name='approvalStatusCat' id = 'approvalStatusCat_category_<%=i%>'   tag='pb_html'>		
<%
if(actionName.equals("edit"))
{
			Options = CatDAO.getOptions(Language, "approval_status", approval_summaryDTO.approvalStatusCat);
}
else
{			
			Options = CatDAO.getOptions(Language, "approval_status", -1);			
}
%>
<%=Options%>
		</select>
		
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_dateOfInitiation'>")%>
			
	
	<div class="form-inline" id = 'dateOfInitiation_div_<%=i%>'>
		<input type='date' class='form-control'  name='dateOfInitiation_Date_<%=i%>' id = 'dateOfInitiation_date_Date_<%=i%>' value=<%
if(actionName.equals("edit"))
{
	SimpleDateFormat format_dateOfInitiation = new SimpleDateFormat("dd-MM-yyyy");
	String formatted_dateOfInitiation = format_dateOfInitiation.format(new Date(approval_summaryDTO.dateOfInitiation)).toString();
	%>
	'<%=formatted_dateOfInitiation%>'
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
		<input type='hidden' class='form-control'  name='dateOfInitiation' id = 'dateOfInitiation_date_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_summaryDTO.dateOfInitiation + "'"):("'" + "0" + "'")%>  tag='pb_html'>
		
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_dateOfResolution'>")%>
			
	
	<div class="form-inline" id = 'dateOfResolution_div_<%=i%>'>
		<input type='date' class='form-control'  name='dateOfResolution_Date_<%=i%>' id = 'dateOfResolution_date_Date_<%=i%>' value=<%
if(actionName.equals("edit"))
{
	SimpleDateFormat format_dateOfResolution = new SimpleDateFormat("dd-MM-yyyy");
	String formatted_dateOfResolution = format_dateOfResolution.format(new Date(approval_summaryDTO.dateOfResolution)).toString();
	%>
	'<%=formatted_dateOfResolution%>'
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
		<input type='hidden' class='form-control'  name='dateOfResolution' id = 'dateOfResolution_date_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_summaryDTO.dateOfResolution + "'"):("'" + "0" + "'")%>  tag='pb_html'>
		
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_resolver'>")%>
			
	
	<div class="form-inline" id = 'resolver_div_<%=i%>'>
		<input type='text' class='form-control'  name='resolver' id = 'resolver_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_summaryDTO.resolver + "'"):("'" + "0" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_assignedTo'>")%>
			
	
	<div class="form-inline" id = 'assignedTo_div_<%=i%>'>
		<input type='text' class='form-control'  name='assignedTo' id = 'assignedTo_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_summaryDTO.assignedTo + "'"):("'" + "0" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_isDeleted" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='isDeleted' id = 'isDeleted_hidden_<%=i%>' value= <%=actionName.equals("edit")?("'" + approval_summaryDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_lastModificationTime" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>' value='<%=approval_summaryDTO.lastModificationTime%>' tag='pb_html'/>
		
												
<%=("</td>")%>
					
		