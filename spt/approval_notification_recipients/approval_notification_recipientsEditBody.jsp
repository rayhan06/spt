
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="login.LoginDTO"%>

<%@page import="approval_notification_recipients.*"%>
<%@page import="java.util.*"%>

<%@page pageEncoding="UTF-8" %>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.util.UUID"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>

<%@page import="geolocation.GeoLocationDAO2"%>


<%
Approval_notification_recipientsDTO approval_notification_recipientsDTO;
approval_notification_recipientsDTO = (Approval_notification_recipientsDTO)request.getAttribute("approval_notification_recipientsDTO");
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
if(approval_notification_recipientsDTO == null)
{
	approval_notification_recipientsDTO = new Approval_notification_recipientsDTO();
	
}
System.out.println("approval_notification_recipientsDTO = " + approval_notification_recipientsDTO);

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
	formTitle = LM.getText(LC.APPROVAL_NOTIFICATION_RECIPIENTS_EDIT_APPROVAL_NOTIFICATION_RECIPIENTS_EDIT_FORMNAME, loginDTO);
}
else
{
	formTitle = LM.getText(LC.APPROVAL_NOTIFICATION_RECIPIENTS_ADD_APPROVAL_NOTIFICATION_RECIPIENTS_ADD_FORMNAME, loginDTO);
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

%>



<div class="box box-primary">
	<div class="box-header with-border">
		<h3 class="box-title"><i class="fa fa-gift"></i><%=formTitle%></h3>
	</div>
	<div class="box-body">
		<form class="form-horizontal" action="Approval_notification_recipientsServlet?actionType=<%=actionName%>&identity=<%=ID%>"
		id="bigform" name="bigform"  method="POST" enctype = "multipart/form-data"
		onsubmit="return PreprocessBeforeSubmiting(0,'<%=actionName%>')">
			<div class="form-body">
				
				
				




























	















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


		<input type='hidden' class='form-control'  name='iD' id = 'iD_hidden_<%=i%>' value='<%=approval_notification_recipientsDTO.iD%>' tag='pb_html'/>
	
												

		<input type='hidden' class='form-control'  name='approvalPathId' id = 'approvalPathId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_notification_recipientsDTO.approvalPathId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												

		<input type='hidden' class='form-control'  name='organogramId' id = 'organogramId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_notification_recipientsDTO.organogramId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												

		<input type='hidden' class='form-control'  name='isDeleted' id = 'isDeleted_hidden_<%=i%>' value= <%=actionName.equals("edit")?("'" + approval_notification_recipientsDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
												

		<input type='hidden' class='form-control'  name='lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_notification_recipientsDTO.lastModificationTime + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
					
	







				<div class="form-actions text-center">
					<a class="btn btn-danger" href="<%=request.getHeader("referer")%>">
					<%
					if(actionName.equals("edit"))
					{
						%>
						<%=LM.getText(LC.APPROVAL_NOTIFICATION_RECIPIENTS_EDIT_APPROVAL_NOTIFICATION_RECIPIENTS_CANCEL_BUTTON, loginDTO)%>
						<%
					}
					else
					{
						%>
						<%=LM.getText(LC.APPROVAL_NOTIFICATION_RECIPIENTS_ADD_APPROVAL_NOTIFICATION_RECIPIENTS_CANCEL_BUTTON, loginDTO)%>
						<%
					}
					
					%>
					</a>
					<button class="btn btn-success" type="submit">
					<%
					if(actionName.equals("edit"))
					{
						%>
						<%=LM.getText(LC.APPROVAL_NOTIFICATION_RECIPIENTS_EDIT_APPROVAL_NOTIFICATION_RECIPIENTS_SUBMIT_BUTTON, loginDTO)%>
						<%
					}
					else
					{
						%>
						<%=LM.getText(LC.APPROVAL_NOTIFICATION_RECIPIENTS_ADD_APPROVAL_NOTIFICATION_RECIPIENTS_SUBMIT_BUTTON, loginDTO)%>
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


	return true;
}


function addrselected(value, htmlID, selectedIndex, tagname,  fieldName, row)
{	
	addrselectedFunc(value, htmlID, selectedIndex, tagname,  fieldName, row, false, "Approval_notification_recipientsServlet");	
}

function init(row)
{


	
}

var row = 0;
bkLib.onDomLoaded(function() 
{	
});
	
window.onload =function ()
{
	init(row);
}

var child_table_extra_id = <%=childTableStartingID%>;



</script>






