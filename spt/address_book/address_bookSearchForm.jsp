
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="address_book.*"%>
<%@ page import="util.RecordNavigator"%>

<%@ page language="java"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@page import = "java.util.Enumeration"%>



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
String Language = LM.getText(LC.ADDRESS_BOOK_EDIT_LANGUAGE, loginDTO);
UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);


Address_bookDAO address_bookDAO = (Address_bookDAO)request.getAttribute("address_bookDAO");


String navigator2 = SessionConstants.NAV_ADDRESS_BOOK;
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
								<th><%=LM.getText(LC.ADDRESS_BOOK_EDIT_NAMEEN, loginDTO)%></th>
								<th><%=LM.getText(LC.ADDRESS_BOOK_EDIT_NAMEBN, loginDTO)%></th>
								<th><%=LM.getText(LC.HM_VIEW_DETAILS, loginDTO)%></th>
								<th><%=LM.getText(LC.ADDRESS_BOOK_SEARCH_ADDRESS_BOOK_EDIT_BUTTON, loginDTO)%></th>
								<th><input type="submit" class="btn btn-xs btn-danger" value="<%=LM.getText(LC.ADDRESS_BOOK_SEARCH_ADDRESS_BOOK_DELETE_BUTTON, loginDTO)%>" /></th>
								
								
							</tr>
						</thead>
						<tbody>
							<%
								ArrayList data = (ArrayList) session.getAttribute(SessionConstants.VIEW_ADDRESS_BOOK);

								try
								{

									if (data != null) 
									{
										int size = data.size();										
										System.out.println("data not null and size = " + size + " data = " + data);
										for (int i = 0; i < size; i++) 
										{
											Address_bookDTO address_bookDTO = (Address_bookDTO) data.get(i);
																																
											
											%>
											<tr id = 'tr_<%=i%>'>
											<%
											
								%>
											
		
								<%  								
								    request.setAttribute("address_bookDTO",address_bookDTO);
								%>  
								
								 <jsp:include page="./address_bookSearchRow.jsp">
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


			