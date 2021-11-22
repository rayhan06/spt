
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="approval_test.*"%>
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
String failureMessage = (String)request.getAttribute("failureMessage");
if(failureMessage == null || failureMessage.isEmpty())
{
	failureMessage = "";	
}

String value = "";
String Language = LM.getText(LC.APPROVAL_TEST_EDIT_LANGUAGE, loginDTO);
UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);


Approval_testDAO approval_testDAO = (Approval_testDAO)request.getAttribute("approval_testDAO");
String ViewAll;
if(request.getParameter("ViewAll") != null)
{
	ViewAll= request.getParameter("ViewAll");
}
else
{
	ViewAll= "0";
}

String navigator2 = SessionConstants.NAV_APPROVAL_TEST;
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
								<th><%=LM.getText(LC.APPROVAL_TEST_EDIT_DESCRIPTION, loginDTO)%></th>

								<th><%=LM.getText(LC.HM_VIEW_DETAILS, loginDTO)%></th>
								
								<th><%=LM.getText(LC.HM_APPROVAL_PATH, loginDTO)%></th>
								
								<th><%=LM.getText(LC.HM_INITIATED_BY, loginDTO)%></th
								
								<th><%=LM.getText(LC.HM_DATE_OF_INITIATION, loginDTO)%></th>
								
								<th><%=LM.getText(LC.HM_ASSIGNED_TO, loginDTO)%></th>
								
								<th><%=LM.getText(LC.HM_ASSIGNMENT_DATE, loginDTO)%></th>
								
								<th><%=LM.getText(LC.HM_DUE_DATE, loginDTO)%></th>
								
								<th><%=LM.getText(LC.HM_STATUS, loginDTO)%></th>

								<th><%=LM.getText(LC.HM_WORKFLOW_ACTION, loginDTO)%></th>
								
								<th><%=LM.getText(LC.HM_VALIDATE, loginDTO)%></th>
								

								<th><%=LM.getText(LC.HM_HISTORY, loginDTO)%></th>
								
								
							</tr>
						</thead>
						<tbody>
							<%
								ArrayList data = (ArrayList) session.getAttribute(SessionConstants.VIEW_APPROVAL_TEST);

								try
								{

									if (data != null) 
									{
										int size = data.size();										
										System.out.println("data not null and size = " + size + " data = " + data);
										for (int i = 0; i < size; i++) 
										{
											Approval_testDTO approval_testDTO = (Approval_testDTO) data.get(i);
																																
											
											%>
											<tr id = 'tr_<%=i%>'>
											<%
											
								%>
											
		
								<%  								
								    request.setAttribute("approval_testDTO",approval_testDTO);
								%>  
								
								 <jsp:include page="./approval_testApprovalRow.jsp">
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
<input type="hidden" id="ViewAll" value="<%=ViewAll%>" />
