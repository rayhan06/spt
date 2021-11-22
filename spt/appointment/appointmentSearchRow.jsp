<%@page pageEncoding="UTF-8" %>

<%@page import="appointment.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>


<%@ page import="pb.*"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="user.*"%>
<%@page import="org.apache.commons.codec.binary.*"%>
<%@ page import="util.RecordNavigator"%>
<%@page import="dbm.*" %>
<%@page import="util.*" %>
<%@page import="workflow.WorkflowController"%>
<%@page import="family.*"%>
<%@page import="prescription_details.*"%>
<%@page import="patient_measurement.*"%>
<%
FamilyMemberDAO familyMemberDAO = new FamilyMemberDAO("family_member");
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
String Language = LM.getText(LC.APPOINTMENT_EDIT_LANGUAGE, loginDTO);
String Language2 = Language;

UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);


String navigator2 = SessionConstants.NAV_APPOINTMENT;
RecordNavigator rn2 = (RecordNavigator)session.getAttribute(navigator2);
boolean isPermanentTable = rn2.m_isPermanentTable;
String tableName = rn2.m_tableName;

System.out.println("isPermanentTable = " + isPermanentTable);
AppointmentDTO appointmentDTO = (AppointmentDTO)request.getAttribute("appointmentDTO");
CommonDTO commonDTO = appointmentDTO;
String servletName = "AppointmentServlet";


System.out.println("appointmentDTO = " + appointmentDTO);


int i = Integer.parseInt(request.getParameter("rownum"));
out.println("<td style='display:none;'><input type='hidden' id='failureMessage_" + i + "' value=''/></td>");

String value = "";


AppointmentDAO appointmentDAO = (AppointmentDAO)request.getAttribute("appointmentDAO");


String Options = "";
boolean formSubmit = false;
SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat hourFormat = new SimpleDateFormat("HH:mm:ss");

Prescription_detailsDAO prescription_detailsDAO = new Prescription_detailsDAO();
Prescription_detailsDTO prescription_detailsDTO = prescription_detailsDAO.getDTOByappointmentId(appointmentDTO.iD);

boolean hasPrescription = (prescription_detailsDTO!=null);


%>

											
		
											
											<td id = '<%=i%>_visitDate'>
											<%
											value = appointmentDTO.visitDate + "";
											%>
											<%
											String formatted_visitDate = simpleDateFormat.format(new Date(Long.parseLong(value))).toString();
											%>
											<%=formatted_visitDate%>
				
			
											</td>
		
											
											<td id = '<%=i%>_specialityType'>
											<%
											value = CatDAO.getName(Language, "department", (int)appointmentDTO.specialityType);
											%>
											
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_doctorId'>
											<%
											value = WorkflowController.getNameFromOrganogramId(appointmentDTO.doctorId, "English");
											%>
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_shiftCat'>
											<%
											value = appointmentDTO.shiftCat + "";
											%>
											<%
											value = CatDAO.getName(Language, "shift", appointmentDTO.shiftCat);
											%>											
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_availableTimeSlot'>
											<%
											
											value = appointmentDTO.availableTimeSlot + "";
											value = hourFormat.format(new Date(Long.parseLong(value))).toString();
											%>
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_remarks'>
											<%
											value = appointmentDTO.remarks + "";
											%>
														
											<%=value%>
				
			
											</td>
											
											<td id = '<%=i%>_patientId'>
											<%
											value = appointmentDTO.patientId + "";
											%>
														
											<%=value%>
				
			
											</td>

											
											
											
											<td id = '<%=i%>_whoIsThePatientCat'>
											<%
											if(appointmentDTO.whoIsThePatientCat == -1)
											{
												value = appointmentDTO.patientName + "";
											}
											else
											{
												FamilyMemberDTO familyMemberDTO = familyMemberDAO.getDTOByID(appointmentDTO.whoIsThePatientCat);
												value = familyMemberDTO.nameEn 
														+ " (" + CatDAO.getName("English", "relationship", familyMemberDTO.relationshipCat) + ")";
											}
											
											%>
																					
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_phoneNumber'>
											<%
											value = appointmentDTO.phoneNumber + "";
											%>
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_dateOfBirth'>
											<%
											value = appointmentDTO.dateOfBirth + "";
											%>
											<%
											String formatted_dateOfBirth = simpleDateFormat.format(new Date(Long.parseLong(value))).toString();
											%>
											<%=formatted_dateOfBirth%>
				
			
											</td>
		
											
											<td id = '<%=i%>_age'>
											<%
											value = appointmentDTO.age + "";
											%>
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_genderCat'>
											<%
											value = appointmentDTO.genderCat + "";
											%>
											<%
											value = CatDAO.getName(Language, "gender", appointmentDTO.genderCat);
											%>																						
														
											<%=value%>
				
			
											</td>
		
											
													
											
											<td id = '<%=i%>_isChargeNeeded'>
											<%
											value = appointmentDTO.isChargeNeeded + "";
											%>
														
											<%=value%>
				
			
											</td>
		
											
		
											
		
	

											<td>
												<a href='AppointmentServlet?actionType=view&ID=<%=appointmentDTO.iD%>'>View</a>
										
											</td>
	
											<td id = '<%=i%>_Edit'>																																	
	
												<a href='AppointmentServlet?actionType=getEditPage&ID=<%=appointmentDTO.iD%>'><%=LM.getText(LC.APPOINTMENT_SEARCH_APPOINTMENT_EDIT_BUTTON, loginDTO)%></a>
																				
											</td>

											<td>
											
											<a class="btn btn-success" 
												href='Patient_measurementServlet?actionType=getFormattedAddPage&organogramId=<%=appointmentDTO.patientId%>&whoIsThePatientCat=<%=appointmentDTO.whoIsThePatientCat%>'>Add/Update Patient Measurement</a>
											</td>
											
											<td id = '<%=i%>_Addp'>	
											
											<%if(!hasPrescription && userDTO.roleID == SessionConstants.DOCTOR_ROLE && userDTO.organogramID == appointmentDTO.doctorId)
												{
												%>																																
	
												<a class="btn btn-success" 
												href='Prescription_detailsServlet?actionType=getAddPage&appointmentId=<%=appointmentDTO.iD%>'>Add Prescription</a>
												<%
												}
											else if(hasPrescription)
											{
												%>
												<a class="btn btn-info" 
												href='Prescription_detailsServlet?justView=1&actionType=view&ID=<%=prescription_detailsDTO.iD%>'>View Prescription</a>
												<%
											}
											%>
																				
											</td>	
											
											
											<td id='<%=i%>_checkbox'>
												<div class='checker'>
													<span class='chkEdit' ><input type='checkbox' name='ID' value='<%=appointmentDTO.iD%>'/></span>
												</div>
											</td>
																						
											

