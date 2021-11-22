
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="approval_path.*"%>
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
String Language = LM.getText(LC.APPROVAL_PATH_EDIT_LANGUAGE, loginDTO);
UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);


Approval_pathDAO approval_pathDAO = (Approval_pathDAO)request.getAttribute("approval_pathDAO");


String navigator2 = SessionConstants.NAV_APPROVAL_PATH;
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
								<th><%=LM.getText(LC.APPROVAL_PATH_EDIT_NAMEEN, loginDTO)%></th>
								<th>Office</th>
								
								<th><%=LM.getText(LC.HM_VIEW_DETAILS, loginDTO)%></th>
								<%
								if(isPermanentTable)
								{
									%>
									
									<%
								}
								else if (!isPermanentTable && userDTO.approvalRole == SessionConstants.VALIDATOR)
								{
									%>
									<th><%=LM.getText(LC.HM_VALIDATE, loginDTO)%></th>
									<%
								}
								%>
								
								
								<%
								if(!isPermanentTable && userDTO.approvalOrder > -1)
								{
									%>
									<th><%=LM.getText(LC.HM_APPROVE, loginDTO)%></th>
									<th>Operation Type</th>
									<th>Original Value</th>
									<%
								}								
								%>
								<th><input type="submit" class="btn btn-xs btn-danger" value="
								<%
								if(isPermanentTable)
								{
									%>
									<%=LM.getText(LC.APPROVAL_PATH_SEARCH_APPROVAL_PATH_DELETE_BUTTON, loginDTO)%>
									<%
								}
								else
								{
									%><%=LM.getText(LC.HM_REJECT, loginDTO)%><%
								}
								%>
								" /></th>
								
							</tr>
						</thead>
						<tbody>
							<%
								ArrayList data = (ArrayList) session.getAttribute(SessionConstants.VIEW_APPROVAL_PATH);

								try
								{

									if (data != null) 
									{
										int size = data.size();										
										System.out.println("data not null and size = " + size + " data = " + data);
										for (int i = 0; i < size; i++) 
										{
											Approval_pathDTO approval_pathDTO = (Approval_pathDTO) data.get(i);
											TempTableDTO tempTableDTO = null;
																																
											
											%>
											<tr id = 'tr_<%=i%>'>
											<%
											
								%>
											
		
								<%  								
								    request.setAttribute("approval_pathDTO",approval_pathDTO);
								%>  
								
								 <jsp:include page="./approval_pathSearchRow.jsp">
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


			