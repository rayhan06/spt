

<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="appointment.*"%>
<%@ page import="util.RecordNavigator"%>
<%@page import="workflow.WorkflowController"%>

<%@ page language="java"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="pb.*"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="org.apache.commons.codec.binary.*"%>
<%@page import="files.*"%>




<%
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
String actionName = "edit";
String failureMessage = (String)request.getAttribute("failureMessage");
if(failureMessage == null || failureMessage.isEmpty())
{
	failureMessage = "";	
}
out.println("<input type='hidden' id='failureMessage_general' value='" + failureMessage + "'/>");
String value = "";
String Language = LM.getText(LC.APPOINTMENT_EDIT_LANGUAGE, loginDTO);

String ID = request.getParameter("ID");
if(ID == null || ID.isEmpty())
{
	ID = "0";
}
long id = Long.parseLong(ID);
System.out.println("ID = " + ID);
AppointmentDAO appointmentDAO = new AppointmentDAO("appointment");
AppointmentDTO appointmentDTO = (AppointmentDTO)appointmentDAO.getDTOByID(id);
String Value = "";
int i = 0;
FilesDAO filesDAO = new FilesDAO();
SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy");

String context = request.getContextPath() + "/";
%>


<!-- <div class="modal-content viewmodal"> -->
<div class="menubottom">
            <div class="modal-header">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-9 col-sm-12">
                            
                        </div>
                        <div class="col-md-3 col-sm-12">
                            <div class="row">
                                <div class="col-md-6">
                                    <a href="javascript:" style="display: none" class="btn btn-success app_register" data-id="419637"> Register </a>
                                </div>
                                <div class="col-md-6">
                                    <a href="javascript:" style="display: none" class="btn btn-danger app_reject" data-id="419637"> Reject </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button type="button" class="btn btn-info" id = 'printer' onclick="printDiv('modalbody')" >Print</button>
                </div>


            </div>

            <div class="modal-body container" id="modalbody">
			
			<div class="row div_border office-div">

                    <div class="col-md-12">
                        <div class="logowizard">
							
						<div class="col-lg-3 col-md-3 col-sm-12 col-12">
							<div class="logocontent text-left">
								<img src="<%=context%>assets/static/parliament_logo.png" alt="logo" class="logo-default"  style="margin:0px !important"/>
							</div>						
						</div>
						
						</div>
						
					<div class="col-lg-6 col-md-6 col-sm-12 col-12">
						
						<div class="tablecontent">
							<h1 style="text-align: center;"><%=LM.getText(LC.HM_PARLIAMENT_MEDICAL_CENTRE, loginDTO)%></h1>
	                    	<h3 style="text-align: center;"><%=LM.getText(LC.HM_BANGLADESH_PARLIAMENT_SECRETARIAT, loginDTO)%></h3>
	                    	<h4 style="text-align: center;"><%=LM.getText(LC.HM_PARLIAMENT_ADDRESS, loginDTO)%></h4>
	                        <h5 style="text-align: center;"><%=LM.getText(LC.HM_PARLIAMENT_ADDRESS, loginDTO)%></h5>
						</div>
					</div>
						<h3 style="text-align: center;"><u><%=LM.getText(LC.HM_APPOINTMENT_TICKET, loginDTO)%></u></h3>
						<table class="table table-bordered table-striped">
									

							<tr>
								<td style="width:15%"><b><%=LM.getText(LC.HM_REGISTRATION_NUMBER, loginDTO)%></b></td>
								<td style="width:30%" colspan="2">
						
											<%
											value = appointmentDTO.iD + "";
											%>
											
											<%=Utils.getDigits(value, Language)%>
				
			
								</td>
								<td style="width:20%"><b><%=LM.getText(LC.APPOINTMENT_EDIT_VISITDATE, loginDTO)%></b></td>
								<td colspan="2">
						
											<%
											value = appointmentDTO.visitDate + "";
											%>
											<%
											String formatted_visitDate = simpleDateFormat.format(new Date(Long.parseLong(value))).toString();
											%>
											<%=Utils.getDigits(formatted_visitDate, Language)%>
				
			
								</td>
						
							</tr>
							
							
							<tr>
							
								<td style="width:20%"><b><%=LM.getText(LC.HM_PATIENT_NAME, loginDTO)%></b></td>
								<td colspan="2">
						
											<%
											value = appointmentDTO.patientName + "";
											%>
														
											<%=value%>
				
			
								</td>
								<td style="width:10%"><b><%=LM.getText(LC.HM_REFERENCE_EMPLOYEE, loginDTO)%></b></td>
								<td colspan="2">
						
											<%
											value = appointmentDTO.patientId + "";
											%>
														
											<%=Utils.getDigits(value, Language)%>
				
			
								</td>
						
							
								
						
							</tr>
							
							<tr>
								<td style="width:10%"><b><%=LM.getText(LC.HM_PHONE, loginDTO)%></b></td>
								<td style="width:20%">
						
											<%
											value = appointmentDTO.phoneNumber + "";
											%>
														
											<%=Utils.getDigits(value, Language)%>
				
			
								</td>
						
							
								<td style="width:10%"><b><%=LM.getText(LC.APPOINTMENT_EDIT_AGE, loginDTO)%></b></td>
								<td>
						
											<%
											value = appointmentDTO.age + "";
											%>
														
											<%=Utils.getDigits(value, Language)%>
				
			
								</td>
								
								<td style="width:20%"><b><%=LM.getText(LC.HM_GENDER, loginDTO)%></b></td>
								<td>
						
											<%
											value = CatDAO.getName(Language, "gender", appointmentDTO.genderCat);
											%>
														
											<%=value%>
				
			
								</td>
						
							</tr>


							<tr>
							
								<td style="width:10%" ><b><%=LM.getText(LC.HM_DOCTOR, loginDTO)%></b></td>
								<td style="width:30%" colspan="2">
						
											<%
											value = WorkflowController.getNameFromOrganogramId(appointmentDTO.doctorId, Language) + "";
											%>
														
											<%=value%>
				
			
								</td>
								<td style="width:10%"><b><%=LM.getText(LC.HM_DEPARTMENT, loginDTO)%></b></td>
								<td colspan="2">
											
											<%
											value = CatDAO.getName(Language, "department", appointmentDTO.specialityType);
											%>
														
											<%=value%>
				
			
								</td>
													
								
						
							</tr>


			
		
						</table>
                    </div>
			






			</div>	
			</div>
			
<script type="text/javascript"> 
    
        function printDiv(divName) {
	     var printContents = document.getElementById(divName).innerHTML;
	     var originalContents = document.body.innerHTML;

	     document.body.innerHTML = printContents;

	     window.print();

	     document.body.innerHTML = originalContents;
	}
</script>

               


        </div>