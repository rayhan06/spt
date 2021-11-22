
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="appointment.*"%>
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
String actionName = "edit";
String failureMessage = (String)request.getAttribute("failureMessage");
if(failureMessage == null || failureMessage.isEmpty())
{
	failureMessage = "";	
}

String value = "";
String Language = LM.getText(LC.APPOINTMENT_EDIT_LANGUAGE, loginDTO);
UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);


AppointmentDAO appointmentDAO = (AppointmentDAO)request.getAttribute("appointmentDAO");


String navigator2 = SessionConstants.NAV_APPOINTMENT;
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

String ajax = (String)request.getParameter("ajax");
boolean hasAjax = false;
if(ajax != null && !ajax.equalsIgnoreCase(""))
{
	hasAjax = true;
}
%>				
<input type='hidden' id='failureMessage_general' value='<%=failureMessage%>'/>	

<%

if(hasAjax == false)
{
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
}

%>				
			
				
				<div class="table-responsive">
					<table id="tableData" class="table table-bordered table-striped">
						<thead>
							<tr>
								<th><%=LM.getText(LC.APPOINTMENT_ADD_VISITDATE, loginDTO)%></th>
								<th><%=LM.getText(LC.HM_DEPARTMENT, loginDTO)%></th>
								<th><%=LM.getText(LC.HM_DOCTOR, loginDTO)%></th>
								<th><%=LM.getText(LC.HM_SHIFT, loginDTO)%></th>
								<th><%=LM.getText(LC.APPOINTMENT_ADD_AVAILABLETIMESLOT, loginDTO)%></th>
								<th><%=LM.getText(LC.APPOINTMENT_ADD_REMARKS, loginDTO)%></th>
								<th><%=LM.getText(LC.HM_SELECT_EMPLOYEE, loginDTO)%></th>
								<th><%=LM.getText(LC.SELECT_PATIENT_HM, loginDTO)%></th>
								<th><%=LM.getText(LC.APPOINTMENT_ADD_PHONENUMBER, loginDTO)%></th>
								<th><%=LM.getText(LC.APPOINTMENT_ADD_DATEOFBIRTH, loginDTO)%></th>
								<th><%=LM.getText(LC.APPOINTMENT_ADD_AGE, loginDTO)%></th>
								<th><%=LM.getText(LC.APPOINTMENT_ADD_GENDERCAT, loginDTO)%></th>
								<th><%=LM.getText(LC.HM_CHARGE, loginDTO)%></th>
								
								<th><%=LM.getText(LC.HM_VIEW_DETAILS, loginDTO)%></th>
								<th><%=LM.getText(LC.APPOINTMENT_SEARCH_APPOINTMENT_EDIT_BUTTON, loginDTO)%></th>
								
								
								<th><%=LM.getText(LC.HM_ADD_PATIENT_MEASUREMENT, loginDTO)%></th>
								<th><%=LM.getText(LC.HM_PRESCRIPTION, loginDTO)%></th>
								
								<th><input type="submit" class="btn btn-xs btn-danger" value="<%=LM.getText(LC.APPOINTMENT_SEARCH_APPOINTMENT_DELETE_BUTTON, loginDTO)%>" /></th>
								
								
							</tr>
						</thead>
						<tbody>
							<%
								ArrayList data = (ArrayList) session.getAttribute(SessionConstants.VIEW_APPOINTMENT);

								try
								{

									if (data != null) 
									{
										int size = data.size();										
										System.out.println("data not null and size = " + size + " data = " + data);
										for (int i = 0; i < size; i++) 
										{
											AppointmentDTO appointmentDTO = (AppointmentDTO) data.get(i);
																																
											
											%>
											<tr id = 'tr_<%=i%>'>
											<%
											
								%>
											
		
								<%  								
								    request.setAttribute("appointmentDTO",appointmentDTO);
								%>  
								
								 <jsp:include page="./appointmentSearchRow.jsp">
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


			