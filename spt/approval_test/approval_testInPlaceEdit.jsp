<%@page pageEncoding="UTF-8" %>

<%@page import="sessionmanager.SessionConstants"%>
<%@page import="approval_test.Approval_testDTO"%>
<%@page import="java.util.*"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>

<%
Approval_testDTO approval_testDTO = (Approval_testDTO)request.getAttribute("approval_testDTO");
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);

if(approval_testDTO == null)
{
	approval_testDTO = new Approval_testDTO();
	
}
System.out.println("approval_testDTO = " + approval_testDTO);

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
String Language = LM.getText(LC.APPROVAL_TEST_EDIT_LANGUAGE, loginDTO);
String Options;
SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
Date date = new Date();
String datestr = dateFormat.format(date);
%>

			
<%=("<td id = '" + i + "_iD" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='iD' id = 'iD_hidden_<%=i%>' value='<%=approval_testDTO.iD%>' tag='pb_html'/>
	
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_description'>")%>
			
	
	<div class="form-inline" id = 'description_div_<%=i%>'>
		<input type='text' class='form-control'  name='description' id = 'description_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_testDTO.description + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_jobCat" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='jobCat' id = 'jobCat_hidden_<%=i%>' value='<%=approval_testDTO.jobCat%>' tag='pb_html'/>
		
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_isDeleted" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='isDeleted' id = 'isDeleted_hidden_<%=i%>' value= <%=actionName.equals("edit")?("'" + approval_testDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_lastModificationTime" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>' value='<%=approval_testDTO.lastModificationTime%>' tag='pb_html'/>
		
												
<%=("</td>")%>
					
	
											<td>
												<a href='Approval_testServlet?actionType=view&ID=<%=approval_testDTO.iD%>'>View</a>
												
												<a href='#' data-toggle='modal' data-target='#viedFileModal_<%=i%>'>Modal</a>
												
												<div class='modal fade' id='viedFileModal_<%=i%>'>
												  <div class='modal-dialog modal-lg' role='document'>
													<div class='modal-content'>
													  <div class='modal-body'>
														<button type='button' class='close' data-dismiss='modal' aria-label='Close'>
														  <span aria-hidden='true'>&times;</span>
														</button>											        
														
														<object type='text/html' data='Approval_testServlet?actionType=view&modal=1&ID=<%=approval_testDTO.iD%>' width='100%' height='500' style='height: 85vh;'>No Support</object>
														
													  </div>
													</div>
												  </div>
												</div>
											</td>

	