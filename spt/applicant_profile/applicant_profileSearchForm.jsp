
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="applicant_profile.*"%>
<%@page import="geolocation.GeoLocationDAO2"%>
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
out.println("<input type='hidden' id='failureMessage_general' value='" + failureMessage + "'/>");
String value = "";
String Language = LM.getText(LC.APPLICANT_PROFILE_EDIT_LANGUAGE, loginDTO);
UserDTO userDTO = UserRepository.getInstance().getUserDTOByUserID(loginDTO);


Applicant_profileDAO applicant_profileDAO = (Applicant_profileDAO)request.getAttribute("applicant_profileDAO");


String navigator2 = SessionConstants.NAV_APPLICANT_PROFILE;
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
				
			
				
				<div class="table-responsive">
					<table id="tableData" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_APPLICANTTYPE, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_SERVICEID, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_SERVICETYPE, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_CHIEFSHAREHOLDERINFO, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_NAME, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_FATHERNAME, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_HUSBANDNAME, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_ADDRESSPRESENT, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_ADDRESSPERMANENT, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_NAMEBN, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_FATHERNAMEBN, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_HUSBANDNAMEBN, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_ADDRESSPRESENTBN, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_ADDRESSPERMANENTBN, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_NATIONALITY, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_AGE, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_GENDER, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_NID, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_CAPITAL, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_PREVIOUS, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_BANKSOLVENCY, loginDTO)%></th>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_EDIT_PICTURE, loginDTO)%></th>
								<%
								if(isPermanentTable)
								{
									out.println("<th>" + LM.getText(LC.APPLICANT_PROFILE_SEARCH_APPLICANT_PROFILE_EDIT_BUTTON, loginDTO) + "</th>");
								}
								else if (!isPermanentTable && userDTO.approvalRole == SessionConstants.VALIDATOR)
								{
									out.println("<th><%=LM.getText(LC.HM_VALIDATE, loginDTO)%></th>");
								}
								%>
								
								
								<%
								if(!isPermanentTable && userDTO.approvalOrder > -1)
								{
									out.println("<th><%=LM.getText(LC.HM_APPROVE, loginDTO)%></th>");
									out.println("<th>Operation Type</th>");
									out.println("<th>Original Value</th>");
								}								
								%>
								<th><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_VIEW, loginDTO)%></th>
								<th><input type="submit" class="btn btn-xs btn-danger" value="
								<%
								if(isPermanentTable)
								{
									out.println(LM.getText(LC.APPLICANT_PROFILE_SEARCH_APPLICANT_PROFILE_DELETE_BUTTON, loginDTO));
								}
								else
								{
									out.println("REJECT");
								}
								%>
								" /></th>
								
							</tr>
						</thead>
						<tbody>
							<%
								ArrayList data = (ArrayList) session.getAttribute(SessionConstants.VIEW_APPLICANT_PROFILE);

								try
								{

									if (data != null) 
									{
										int size = data.size();										
										System.out.println("data not null and size = " + size + " data = " + data);
										for (int i = 0; i < size; i++) 
										{
											Applicant_profileDTO row = (Applicant_profileDTO) data.get(i);
											TempTableDTO tempTableDTO = null;
											if(!isPermanentTable)
											{
												tempTableDTO = applicant_profileDAO.getTempTableDTOFromTableById(tableName, row.iD);
											}																						
											
											out.println("<tr id = 'tr_" + i + "'>");
											
								%>
											
		
								<%  								
								    request.setAttribute("applicant_profileDTO",row);
								%>  
								
								 <jsp:include page="./applicant_profileSearchRow.jsp">
								 		<jsp:param name="pageName" value="searchrow" />
								 		<jsp:param name="rownum" value="<%=i%>" />
								 </jsp:include>			

								
								<%

											out.println("</tr>");
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


			