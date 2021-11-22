
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="approval_notification_recipients.*"%>
<%@ page import="util.RecordNavigator"%>

<%@ page language="java"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>



<%@ page import="pb.*"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="user.*"%>
<%@page import="org.apache.commons.codec.binary.*"%>


<%
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
String actionName = "edit";
String failureMessage = (String)request.getAttribute("failureMessage");
if(failureMessage == null || failureMessage.isEmpty())
{
	failureMessage = "";	
}

String value = "";
String Language = LM.getText(LC.APPROVAL_NOTIFICATION_RECIPIENTS_EDIT_LANGUAGE, loginDTO);
UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);


Approval_notification_recipientsDAO approval_notification_recipientsDAO = (Approval_notification_recipientsDAO)request.getAttribute("approval_notification_recipientsDAO");


String navigator2 = SessionConstants.NAV_APPROVAL_NOTIFICATION_RECIPIENTS;
System.out.println("navigator2 = " + navigator2);
RecordNavigator rn2 = (RecordNavigator)session.getAttribute(navigator2);
System.out.println("rn2 = " + rn2);
String pageno2 = ( rn2 == null ) ? "1" : "" + rn2.getCurrentPageNo();
String totalpage2 = ( rn2 == null ) ? "1" : "" + rn2.getTotalPages();
String totalRecords2 = ( rn2 == null ) ? "1" : "" + rn2.getTotalRecords();
String lastSearchTime = ( rn2 == null ) ? "0" : "" + rn2.getSearchTime();
boolean isPermanentTable = rn2.m_isPermanentTable;
String tableName = rn2.m_tableName;

String successMessageForwarded = "Forwarded to your Senior Office";
String successMessageApproved = "Approval Done";
%>				
<input type='hidden' id='failureMessage_general' value='<%=failureMessage%>'/>				
			
				
				<div class="table-responsive">
					<table id="tableData" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th><%=LM.getText(LC.APPROVAL_NOTIFICATION_RECIPIENTS_EDIT_APPROVALPATHID, loginDTO)%></th>
								<th><%=LM.getText(LC.APPROVAL_NOTIFICATION_RECIPIENTS_EDIT_ORGANOGRAMID, loginDTO)%></th>
								<%
								if(isPermanentTable)
								{
									%>
									<th><%=LM.getText(LC.APPROVAL_NOTIFICATION_RECIPIENTS_SEARCH_APPROVAL_NOTIFICATION_RECIPIENTS_EDIT_BUTTON, loginDTO)%></th>
									<%
								}
								else if (!isPermanentTable)
								{
									%>
									<th><%=LM.getText(LC.HM_VALIDATE, loginDTO)%></th>
									<%
								}
								%>
								
								
								<%
								if(!isPermanentTable)
								{
									%>									
									<th>Operation Type</th>
									<th>Original Value</th>
									<td><%=LM.getText(LC.HM_REMARKS, loginDTO )%></td>
									<td><%=LM.getText(LC.HM_ATTACHMENTS, loginDTO )%></td>
									<th><%=LM.getText(LC.HM_HISTORY, loginDTO)%></th>
									<th><%=LM.getText(LC.HM_APPROVE, loginDTO)%></th>
									<th><%=LM.getText(LC.HM_REJECT, loginDTO)%></th>
								<%
								}
								else
								{
								%>
									<th><input type="submit" class="btn btn-xs btn-danger" value="<%=LM.getText(LC.APPROVAL_TEST_SEARCH_APPROVAL_TEST_DELETE_BUTTON, loginDTO)%>" /></th>
								<%
								}
								%>
								
								
							</tr>
						</thead>
						<tbody>
							<%
								ArrayList data = (ArrayList) session.getAttribute(SessionConstants.VIEW_APPROVAL_NOTIFICATION_RECIPIENTS);

								try
								{

									if (data != null) 
									{
										int size = data.size();										
										System.out.println("data not null and size = " + size + " data = " + data);
										for (int i = 0; i < size; i++) 
										{
											Approval_notification_recipientsDTO approval_notification_recipientsDTO = (Approval_notification_recipientsDTO) data.get(i);
																																
											
											%>
											<tr id = 'tr_<%=i%>'>
											<%
											
								%>
											
		
								<%  								
								    request.setAttribute("approval_notification_recipientsDTO",approval_notification_recipientsDTO);
								%>  
								
								 <jsp:include page="./approval_notification_recipientsSearchRow.jsp">
								 		<jsp:param name="pageName" value="searchrow" />
								 		<jsp:param name="rownum" value="<%=i%>" />
								 </jsp:include>			

								
								<%

											%>
											</tr>
											<%
										}
										 
										System.out.println("printing done");
									}
									else
									{
										System.out.println("data  null");
									}
								}
								catch(Exception e)
								{
									System.out.println("JSP exception " + e);
								}
							%>



						</tbody>

					</table>
				</div>

<input type="hidden" id="hidden_pageno" value="<%=pageno2%>" />
<input type="hidden" id="hidden_totalpage" value="<%=totalpage2%>" />
<input type="hidden" id="hidden_totalrecords" value="<%=totalRecords2%>" />
<input type="hidden" id="hidden_lastSearchTime" value="<%=lastSearchTime%>" />
<input type="hidden" id="isPermanentTable" value="<%=isPermanentTable%>" />


<script src="nicEdit.js" type="text/javascript"></script>

<script type="text/javascript">

function getOriginal(i, tempID, parentID, ServletName)
{
	console.log("getOriginal called");
	var idToSubmit;
	var isPermanentTable;
	var state = document.getElementById(i + "_original_status").value;
	if(state == 0)
	{
		idToSubmit = parentID;
		isPermanentTable = true;
	}
	else
	{
		idToSubmit = tempID;
		isPermanentTable = false;
	}
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() 
	{
		if (this.readyState == 4 && this.status == 200) 
		{			
			var response = JSON.parse(this.responseText);
			document.getElementById(i + "_approvalPathId").innerHTML = response.approvalPathId;
			document.getElementById(i + "_organogramId").innerHTML = response.organogramId;
					
			if(state == 0)
			{
				document.getElementById(i + "_getOriginal").innerHTML = "View Edited";
				state = 1;
			}
			else
			{
				document.getElementById(i + "_getOriginal").innerHTML = "View Original";
				state = 0;
			}
			
			document.getElementById(i + "_original_status").value = state;
		}
		else if(this.readyState == 4 && this.status != 200)
		{
			alert('failed ' + this.status);
		}
	};
	xhttp.open("POST", ServletName + "?actionType=getDTO&ID=" + idToSubmit + "&isPermanentTable=" + isPermanentTable, true);
	xhttp.send();
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


	return true;
}


function addrselected(value, htmlID, selectedIndex, tagname,  fieldName, row)
{	
	addrselectedFunc(value, htmlID, selectedIndex, tagname,  fieldName, row, false, "Approval_notification_recipientsServlet");	
}

function init(row)
{


	
}




function submitAjax(i, deletedStyle)
{
	console.log('submitAjax called');
	var isSubmittable = PreprocessBeforeSubmiting(i, "inplaceedit");
	if(isSubmittable == false)
	{
		return;
	}
	var formData = new FormData();
	var value;
	value = document.getElementById('iD_hidden_' + i).value;
	console.log('submitAjax i = ' + i + ' id = ' + value);
	formData.append('iD', value);
	formData.append("identity", value);
	formData.append("ID", value);
	formData.append('approvalPathId', document.getElementById('approvalPathId_hidden_' + i).value);
	formData.append('organogramId', document.getElementById('organogramId_hidden_' + i).value);
	formData.append('isDeleted', document.getElementById('isDeleted_hidden_' + i).value);
	formData.append('lastModificationTime', document.getElementById('lastModificationTime_hidden_' + i).value);

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() 
	{
		if (this.readyState == 4 && this.status == 200) 
		{
			if(this.responseText !='')
			{				
				document.getElementById('tr_' + i).innerHTML = this.responseText ;
				ShowExcelParsingResult(i);
			}
			else
			{
				console.log("No Response");
				document.getElementById('tr_' + i).innerHTML = 'NULL RESPONSE';
			}
		}
		else if(this.readyState == 4 && this.status != 200)
		{
			alert('failed ' + this.status);
		}
	  };
	xhttp.open("POST", 'Approval_notification_recipientsServlet?actionType=edit&inplacesubmit=true&isPermanentTable=<%=isPermanentTable%>&deletedStyle=' + deletedStyle + '&rownum=' + i, true);
	xhttp.send(formData);
}

window.onload =function ()
{
	ShowExcelParsingResult('general');
	}	
</script>
			