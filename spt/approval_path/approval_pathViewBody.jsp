

<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="approval_path.*"%>
<%@ page import="util.RecordNavigator"%>

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
<%@page import="workflow.*"%>
<%@page import="approval_notification_recipients.*"%>




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
String Language = LM.getText(LC.APPROVAL_PATH_EDIT_LANGUAGE, loginDTO);

String ID = request.getParameter("ID");
if(ID == null || ID.isEmpty())
{
	ID = "0";
}
long id = Long.parseLong(ID);
System.out.println("ID = " + ID);
Approval_pathDAO approval_pathDAO = new Approval_pathDAO("approval_path");
Approval_pathDTO approval_pathDTO = (Approval_pathDTO)approval_pathDAO.getDTOByID(id);
int pathCategory = approval_pathDTO.approvalPathCat;
String officeTablename = "office_origin_unit_organograms";
if(pathCategory == Approval_pathDTO.ASSIGNED_PATH)
{
	officeTablename = "office_unit_organograms";
}
String Value = "";
int i = 0;
Approval_notification_recipientsDAO approval_notification_recipientsDAO = new Approval_notification_recipientsDAO();
%>


<div class="modal-content viewmodal">
            <div class="modal-header">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-9 col-sm-12">
                            <h5 class="modal-title">APPROVAL PATH DETAILS</h5>
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
                </div>


            </div>

            <div class="modal-body container">

			
                <div class="row div_border office-div">

                    <div class="col-md-12">
                        <h5>Approval Path</h5>
                    </div>
				
                    <div class="col-md-6">
                        <label class="col-md-5" style="padding-right: 0px;"><b><span><%=LM.getText(LC.APPROVAL_PATH_EDIT_NAMEEN, loginDTO)%></span><span style="float:right;">:</span></b></label>
                        <label id="nameEn">
						
											<%
											value = approval_pathDTO.nameEn + "";
											%>
														
											<%=value%>
				
			
						
                        </label>
                    </div>

				

			
				
                    <div class="col-md-6">
                        <label class="col-md-5" style="padding-right: 0px;"><b><span>Office</span><span style="float:right;">:</span></b></label>
                        <label id="Office">
						
											<%
											value = WorkflowController.getOfficeUnitName(approval_pathDTO.officeUnitId);
											if(value.equalsIgnoreCase(""))
											{
												value = "All Offices";
											}
											
											%>
														
											<%=value%>
			
						
                        </label>
                    </div>

				

				
           

			
                <div class="row div_border office-div">

                    
				
                  
				

			
			
			
		

				</div>
	
				

                <div class="row div_border attachement-div">
                    <div class="col-md-12">
                        <h5>Approval Path Details</h5>
						<table class="table table-bordered table-striped">
							<tr>
								<%if(pathCategory == Approval_pathDTO.ASSIGNED_PATH) {%> <th>Office Unit</th> <%}%>
								<th>Designation</th>
								<%if(pathCategory == Approval_pathDTO.ASSIGNED_PATH) {%> <th>UserName</th> <%}%>
								<%if(pathCategory == Approval_pathDTO.ASSIGNED_PATH) {%> <th>Name</th> <%}%>
								<th>Approval Role</th>
								<th><%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_PATH_EDIT_APPROVAL_PATH_DETAILS_APPROVALORDER, loginDTO)):(LM.getText(LC.APPROVAL_PATH_ADD_APPROVAL_PATH_DETAILS_APPROVALORDER, loginDTO))%></th>
								<th><%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_PATH_EDIT_APPROVAL_PATH_DETAILS_DAYSREQUIRED, loginDTO)):(LM.getText(LC.APPROVAL_PATH_ADD_APPROVAL_PATH_DETAILS_DAYSREQUIRED, loginDTO))%></th>
								<th>Permanently Assigned Officer</th>
							</tr>
							<%
                        	ApprovalPathDetailsDAO approvalPathDetailsDAO = new ApprovalPathDetailsDAO();
                         	List<ApprovalPathDetailsDTO> approvalPathDetailsDTOs = approvalPathDetailsDAO.getApprovalPathDetailsDTOListByApprovalPathID(approval_pathDTO.iD);
                         	
                         	for(ApprovalPathDetailsDTO approvalPathDetailsDTO: approvalPathDetailsDTOs)
                         	{
                         		String permanentOrganogramName = WorkflowController.getNameFromOrganogramId(approvalPathDetailsDTO.permanentOrganogramId, Language);
                         		String permanentOrganogramDesignation = CommonDAO.getName((int)approvalPathDetailsDTO.permanentOrganogramId, officeTablename, Language.equals("English")?"designation_eng":"designation_bng", "id");
                         		String permanentOrganogramOffice = WorkflowController.getUnitNameFromOrganogramId(approvalPathDetailsDTO.permanentOrganogramId, Language);
                         		String permanentOrganogramSummary = permanentOrganogramName + ", " + permanentOrganogramDesignation + ", " + permanentOrganogramOffice;
                         		%>
                         			<tr>
                         			<%if(pathCategory == Approval_pathDTO.ASSIGNED_PATH) {%> <td><%=WorkflowController.getUnitNameFromOrganogramId(approvalPathDetailsDTO.organogramId, Language)%></td> <%}%>
                         			<td><%=CommonDAO.getName((int)approvalPathDetailsDTO.organogramId, officeTablename, Language.equals("English")?"designation_eng":"designation_bng", "id")%></td>
                         			<%if(pathCategory == Approval_pathDTO.ASSIGNED_PATH) {%><td><%=WorkflowController.getUserNameFromOrganogramId(approvalPathDetailsDTO.organogramId)%></td> <%}%>
                         			<%if(pathCategory == Approval_pathDTO.ASSIGNED_PATH) {%><td><%=WorkflowController.getNameFromOrganogramId(approvalPathDetailsDTO.organogramId, Language)%></td> <%}%>
										
										<td>
											<%
											value = approvalPathDetailsDTO.approvalRoleCat + "";
											%>
											<%
											value = CatDAO.getName(Language, "approval_role", approvalPathDetailsDTO.approvalRoleCat);
											%>											
														
											<%=value%>
				
			
										</td>
										<td>
											<%
											value = approvalPathDetailsDTO.approvalOrder + "";
											%>
														
											<%=value%>
				
			
										</td>
										<td>
											<%
											value = approvalPathDetailsDTO.daysRequired + "";
											%>
														
											<%=value%>
				
			
										</td>
										
										<td>
											<%=permanentOrganogramSummary%>
										</td>
                         			</tr>
                         		<%
                         		
                         	}
                         	
                        %>
						</table>
                    </div>                    
                </div>
                
                <%if(pathCategory == Approval_pathDTO.ASSIGNED_PATH) {%>
                <div class="row div_border attachement-div">
                    <div class="col-md-12">
                        <h5>Approval Notification Recipients</h5>
						<table class="table table-bordered table-striped">
							<tr>
								<th>Unit</th>
								<th>Designation</th>
								<th>UserName</th>
								<th>Name</th>								
							</tr>
							<%
                         	List<Approval_notification_recipientsDTO> approval_notification_recipientsDTOs = approval_notification_recipientsDAO.getDTOsByApprovalPathID(approval_pathDTO.iD);
                         	
                         	for(Approval_notification_recipientsDTO approval_notification_recipientsDTO: approval_notification_recipientsDTOs)
                         	{
                         		%>
                         			<tr>
                         			<td><%=WorkflowController.getUnitNameFromOrganogramId(approval_notification_recipientsDTO.organogramId, Language)%></td>
                         			<td><%=CommonDAO.getName((int)approval_notification_recipientsDTO.organogramId, officeTablename, Language.equals("English")?"designation_eng":"designation_bng", "id")%></td>
                         			<td><%=WorkflowController.getUserNameFromOrganogramId(approval_notification_recipientsDTO.organogramId)%></td>
                         			<td><%=WorkflowController.getNameFromOrganogramId(approval_notification_recipientsDTO.organogramId, Language)%></td>
										
                         			</tr>
                         		<%
                         		
                         	}
                         	
                        %>
						</table>
                    </div>                    
                </div>
                <%} %>
               
               

            <div class="modal-footer" style="justify-content:flex-start">



              

            </div>

        </div>