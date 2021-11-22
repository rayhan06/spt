<%@page pageEncoding="UTF-8" %>

<%@page import="sessionmanager.SessionConstants"%>
<%@page import="approval_notification_recipients.Approval_notification_recipientsDTO"%>
<%@page import="java.util.*"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>

<%
Approval_notification_recipientsDTO approval_notification_recipientsDTO = (Approval_notification_recipientsDTO)request.getAttribute("approval_notification_recipientsDTO");
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);

if(approval_notification_recipientsDTO == null)
{
	approval_notification_recipientsDTO = new Approval_notification_recipientsDTO();
	
}
System.out.println("approval_notification_recipientsDTO = " + approval_notification_recipientsDTO);

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
String Language = LM.getText(LC.APPROVAL_NOTIFICATION_RECIPIENTS_EDIT_LANGUAGE, loginDTO);
String Options;
SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
Date date = new Date();
String datestr = dateFormat.format(date);
%>

			
<%=("<td id = '" + i + "_iD" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='iD' id = 'iD_hidden_<%=i%>' value='<%=approval_notification_recipientsDTO.iD%>' tag='pb_html'/>
	
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_approvalPathId'>")%>
			

		<input type='hidden' class='form-control'  name='approvalPathId' id = 'approvalPathId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_notification_recipientsDTO.approvalPathId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_organogramId'>")%>
			

		<input type='hidden' class='form-control'  name='organogramId' id = 'organogramId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_notification_recipientsDTO.organogramId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_isDeleted" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='isDeleted' id = 'isDeleted_hidden_<%=i%>' value= <%=actionName.equals("edit")?("'" + approval_notification_recipientsDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_lastModificationTime" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>' value='<%=approval_notification_recipientsDTO.lastModificationTime%>' tag='pb_html'/>
		
												
<%=("</td>")%>
					
		