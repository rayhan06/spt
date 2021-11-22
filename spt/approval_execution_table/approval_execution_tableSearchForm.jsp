
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="approval_execution_table.*"%>
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
<%@page import = "java.util.Enumeration"%>

<%@page import="org.apache.commons.codec.binary.*"%>



<%
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
String failureMessage = (String)request.getAttribute("failureMessage");
if(failureMessage == null || failureMessage.isEmpty())
{
	failureMessage = "";	
}

String value = "";
String Language = LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_LANGUAGE, loginDTO);
UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);

boolean isFiltered = false;
if(request.getParameter("isFiltered") != null)
{
	isFiltered = Boolean.parseBoolean(request.getParameter("isFiltered"));
}




Approval_execution_tableDAO approval_execution_tableDAO = (Approval_execution_tableDAO)request.getAttribute("approval_execution_tableDAO");


String navigator2 = SessionConstants.NAV_APPROVAL_EXECUTION_TABLE;
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


<%
Enumeration<String> parameterNames = request.getParameterNames();

while (parameterNames.hasMoreElements()) 
{

    String paramName = parameterNames.nextElement();
   
	if(!paramName.equalsIgnoreCase("actionType"))
	{
		String[] paramValues = request.getParameterValues(paramName);
	    for (int i = 0; i < paramValues.length; i++) 
	    {
	        String paramValue = paramValues[i];
	        
	        %>
	        <input type='hidden' name="extraParam" tag='<%=paramName%>' count='<%=i%>' value='<%=paramValue%>'/>
	        <%
	        
	    }
	}
   

}

%>				
			
				
				<div class="table-responsive">
					<table id="tableData" class="table table-bordered table-striped">
						<thead>
							<tr>
							
								<th>Module</th>
								<th>Action Date</th>
								
								
								<th><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_ACTION, loginDTO)%></th>
								<th>Approval Status</th>
								<th><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_USERID, loginDTO)%></th>
								
								<th><%=LM.getText(LC.HM_APPROVAL_PATH, loginDTO)%></th>
								<th><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_APPROVALPATHORDER, loginDTO)%></th>
								<th>Next Officer</th>
								<th><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_REMARKS, loginDTO)%></th>
								<th>Files</th>
								<th>Details</th>
								
								
							</tr>
						</thead>
						<tbody>
							<%
								ArrayList data = (ArrayList) session.getAttribute(SessionConstants.VIEW_APPROVAL_EXECUTION_TABLE);

								try
								{

									if (data != null) 
									{
										int size = data.size();										
										System.out.println("data not null and size = " + size + " data = " + data);
										for (int i = 0; i < size; i++) 
										{
											Approval_execution_tableDTO approval_execution_tableDTO = (Approval_execution_tableDTO) data.get(i);
																																
											
											%>
											<tr id = 'tr_<%=i%>'>
											<%
											
								%>
											
		
								<%  								
								    request.setAttribute("approval_execution_tableDTO",approval_execution_tableDTO);
								%>  
								
								 <jsp:include page="./approval_execution_tableSearchRow.jsp">
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


			