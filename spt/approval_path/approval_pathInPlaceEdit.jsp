<%@page pageEncoding="UTF-8" %>

<%@page import="sessionmanager.SessionConstants"%>
<%@page import="approval_path.Approval_pathDTO"%>
<%@page import="java.util.*"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>

<%
Approval_pathDTO approval_pathDTO = (Approval_pathDTO)request.getAttribute("approval_pathDTO");
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);

if(approval_pathDTO == null)
{
	approval_pathDTO = new Approval_pathDTO();
	
}
System.out.println("approval_pathDTO = " + approval_pathDTO);

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
String Language = LM.getText(LC.APPROVAL_PATH_EDIT_LANGUAGE, loginDTO);
String Options;
SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
Date date = new Date();
String datestr = dateFormat.format(date);
%>

			
<%=("<td id = '" + i + "_iD" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='iD' id = 'iD_hidden_<%=i%>' value='<%=approval_pathDTO.iD%>' tag='pb_html'/>
	
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_nameEn'>")%>
			
	
	<div class="form-inline" id = 'nameEn_div_<%=i%>'>
		<input type='text' class='form-control'  name='nameEn' id = 'nameEn_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_pathDTO.nameEn + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_nameBn'>")%>
			
	
	<div class="form-inline" id = 'nameBn_div_<%=i%>'>
		<input type='text' class='form-control'  name='nameBn' id = 'nameBn_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_pathDTO.nameBn + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_officeId'>")%>
			

		<input type='hidden' class='form-control'  name='officeId' id = 'officeId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_pathDTO.officeId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_approvalPathCat'>")%>
			
	
	<div class="form-inline" id = 'approvalPathCat_div_<%=i%>'>
		<select class='form-control'  name='approvalPathCat' id = 'approvalPathCat_category_<%=i%>'   tag='pb_html'>		
<%
if(actionName.equals("edit"))
{
			Options = CatDAO.getOptions(Language, "approval_path", approval_pathDTO.approvalPathCat);
}
else
{			
			Options = CatDAO.getOptions(Language, "approval_path", -1);			
}
%>
<%=Options%>
		</select>
		
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_jobCat'>")%>
			
	
	<div class="form-inline" id = 'jobCat_div_<%=i%>'>
		<select class='form-control'  name='jobCat' id = 'jobCat_category_<%=i%>'   tag='pb_html'>		
<%
if(actionName.equals("edit"))
{
			Options = CatDAO.getOptions(Language, "job", approval_pathDTO.jobCat);
}
else
{			
			Options = CatDAO.getOptions(Language, "job", -1);			
}
%>
<%=Options%>
		</select>
		
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_isDeleted" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='isDeleted' id = 'isDeleted_hidden_<%=i%>' value= <%=actionName.equals("edit")?("'" + approval_pathDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_lastModificationTime" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>' value='<%=approval_pathDTO.lastModificationTime%>' tag='pb_html'/>
		
												
<%=("</td>")%>
					
	
											<td>
												<a href='Approval_pathServlet?actionType=view&ID=<%=approval_pathDTO.iD%>'>View</a>
												
												<a href='#' data-toggle='modal' data-target='#viedFileModal_<%=i%>'>Modal</a>
												
												<div class='modal fade' id='viedFileModal_<%=i%>'>
												  <div class='modal-dialog modal-lg' role='document'>
													<div class='modal-content'>
													  <div class='modal-body'>
														<button type='button' class='close' data-dismiss='modal' aria-label='Close'>
														  <span aria-hidden='true'>&times;</span>
														</button>											        
														
														<object type='text/html' data='Approval_pathServlet?actionType=view&modal=1&ID=<%=approval_pathDTO.iD%>' width='100%' height='500' style='height: 85vh;'>No Support</object>
														
													  </div>
													</div>
												  </div>
												</div>
											</td>

	