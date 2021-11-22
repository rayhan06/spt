<%@page pageEncoding="UTF-8" %>

<%@page import="approval_test.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>


<%@ page import="pb.*"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="user.*"%>
<%@page import="files.*"%>
<%@page import="org.apache.commons.codec.binary.*"%>
<%@ page import="util.RecordNavigator"%>
<%@ page import="approval_execution_table.*"%>
<%@ page import="approval_path.*"%>
<%@ page import="workflow.*"%>
<%@page import="dbm.*" %>
<%@page import="holidays.*" %>
<%@page import="approval_summary.*" %>


<%
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
String Language = LM.getText(LC.APPROVAL_TEST_EDIT_LANGUAGE, loginDTO);

UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);


String navigator2 = SessionConstants.NAV_APPROVAL_TEST;
RecordNavigator rn2 = (RecordNavigator)session.getAttribute(navigator2);
boolean isPermanentTable = rn2.m_isPermanentTable;
String tableName = rn2.m_tableName;

System.out.println("isPermanentTable = " + isPermanentTable);
Approval_testDTO approval_testDTO = (Approval_testDTO)request.getAttribute("approval_testDTO");

Approval_execution_tableDAO approval_execution_tableDAO = new Approval_execution_tableDAO();
Approval_summaryDAO approval_summaryDAO = new Approval_summaryDAO();
ApprovalPathDetailsDAO approvalPathDetailsDAO = new ApprovalPathDetailsDAO();
Approval_execution_tableDTO approval_execution_tableDTO = null;
ApprovalPathDetailsDTO approvalPathDetailsDTO =  null;
boolean canApprove = false, canValidate = false, isInitiator = false, canTerminate = false;
boolean isInPreviousOffice = false;
String Message = "Done";

approval_execution_tableDTO = (Approval_execution_tableDTO)approval_execution_tableDAO.getMostRecentDTOByUpdatedRowId("approval_test", approval_testDTO.iD);
Approval_summaryDTO approval_summaryDTO = approval_summaryDAO.getDTOByTableNameAndTableID("approval_test", approval_execution_tableDTO.previousRowId);
System.out.println("approval_execution_tableDTO = " + approval_execution_tableDTO);
approvalPathDetailsDTO = approvalPathDetailsDAO.getApprovalPathDetailsDTOListByApprovalPathIDandApprovalOrder(approval_execution_tableDTO.approvalPathId, (int)approval_execution_tableDTO.approvalPathOrder);
if(approvalPathDetailsDTO!= null && approvalPathDetailsDTO.organogramId == userDTO.organogramID)
{
	canApprove = true;
	if(approvalPathDetailsDTO.approvalRoleCat == SessionConstants.VALIDATOR)
	{
		canValidate = true;
	}
}

isInitiator = WorkflowController.isInitiator(tableName, approval_execution_tableDTO.previousRowId, userDTO.organogramID);

canTerminate = isInitiator && approval_testDTO.isDeleted == 2;

Approval_pathDAO approval_pathDAO = new Approval_pathDAO();
Approval_pathDTO approval_pathDTO =  (Approval_pathDTO)approval_pathDAO.getDTOByID(approval_execution_tableDTO.approvalPathId);
	

System.out.println("approval_testDTO = " + approval_testDTO);


int i = Integer.parseInt(request.getParameter("rownum"));
out.println("<td style='display:none;'><input type='hidden' id='failureMessage_" + i + "' value=''/></td>");

String value = "";


Approval_testDAO approval_testDAO = (Approval_testDAO)request.getAttribute("approval_testDAO");

FilesDAO filesDAO = new FilesDAO();

SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy");

boolean isOverDue = false;

Date fromDate = new Date(approval_execution_tableDTO.lastModificationTime);
Date dueDate = null;
if(fromDate != null && approvalPathDetailsDTO!= null)
{
	dueDate = CalenderUtil.getDateAfter(fromDate, approvalPathDetailsDTO.daysRequired);
	long today = System.currentTimeMillis();
	boolean timeOver = today > dueDate.getTime();
	isOverDue  =  (approval_execution_tableDTO.approvalStatusCat == Approval_execution_tableDTO.PENDING) && timeOver;
	
	System.out.println("time dif = " + (today - dueDate.getTime()));
}
String formatted_dueDate;

System.out.println("i = " + i  + " OVERDUE = " + isOverDue);

if(isOverDue)
{
%>
<style>
#tr_<%=i%> {
  color: red;
}
</style>
<%
}
%>

											
		
											
											<td id = '<%=i%>_description'>
											<%
											value = approval_testDTO.description + "";
											%>
														
											<%=value%>
				
			
											</td>
		
											
		
											
		
											
		
	

<td>
											<a href='Approval_testServlet?actionType=view&ID=<%=approval_testDTO.iD%>&isPermanentTable=false'>View</a>
											
											<a href='#' data-toggle='modal' data-target='#viedFileModal_<%=i%>'>Modal</a>
											
											<div class='modal fade' id='viedFileModal_<%=i%>'>
											  <div class='modal-dialog modal-lg' role='document'>
											    <div class='modal-content'>
											      <div class='modal-body'>
											        <button type='button' class='close' data-dismiss='modal' aria-label='Close'>
											          <span aria-hidden='true'>&times;</span>
											        </button>											        
											        
											        <object type='text/html' data='Approval_testServlet?actionType=view&modal=1&ID=<%=approval_testDTO.iD%>' width='100%' height='500' style='height: 85vh;'>No Support</object>
											        
											      </div>
											    </div>
											  </div>
											</div>
											</td>
											
											<td>
												<%
												value = approval_pathDTO.nameEn;
												%>											
															
												<%=value%>
											</td>
											
											<td>
												<%
												value = WorkflowController.getNameFromUserId(approval_summaryDTO.initiator, Language);
												%>											
															
												<%=value%>
											</td>
											
											<td id = '<%=i%>_dateOfInitiation'>
												<%
												value = approval_summaryDTO.dateOfInitiation + "";
												%>
												<%

												String formatted_dateOfInitiation = simpleDateFormat.format(new Date(Long.parseLong(value))).toString();
												%>
												<%=formatted_dateOfInitiation%>
				
			
											</td>
											
											
											<td>
												<%
												value = WorkflowController.getNameFromOrganogramId(approval_summaryDTO.assignedTo, Language);
												%>											
															
												<%=value%>
											</td>
											
											<td >
												<%
												String formatted_dateOfAssignment = simpleDateFormat.format(new Date(approval_execution_tableDTO.lastModificationTime)).toString();
												%>
												<%=formatted_dateOfAssignment%>
				
			
											</td>
											
											<td>
											
												<%
												
												
												if(dueDate!= null)
												{
													formatted_dueDate = simpleDateFormat.format(dueDate).toString();
												}
												else
												{
													formatted_dueDate = "";
												}
												%>
												<%=formatted_dueDate%>
				
			
											</td>
		
											
											
											<td>
												<%
												if(isOverDue)
												{
													value = "OVERDUE";
												}
												else
												{
													value = CatDAO.getName(Language, "approval_status", approval_summaryDTO.approvalStatusCat);
												}
												
												%>											
															
												<%=value%>
											</td>
	
											<td>
											<%
											if(canApprove || canTerminate)
											{
												%>
												<a href='Approval_testServlet?actionType=view&ID=<%=approval_testDTO.iD%>&isPermanentTable=<%=isPermanentTable%>'>View</a>
												
												<%
											}
											else
											{
											
											 	%>
											 	<%=LM.getText(LC.HM_NO_ACTION_IS_REQUIRED, loginDTO)%>.
											 	<%
											}
											 %>																						
											</td>
											
											<td>
											<%
											if(canValidate)
											{
												%>
												<a href='Approval_testServlet?actionType=getEditPage&ID=<%=approval_testDTO.iD%>&isPermanentTable=<%=isPermanentTable%>'>View</a>
												
												<%
											}
											else
											{
											
											 	%>
											 	<%=LM.getText(LC.HM_NO_ACTION_IS_REQUIRED, loginDTO)%>.
											 	<%
											}
											 %>																						
											</td>
											
											
											<td>
												<a href="Approval_execution_tableServlet?actionType=search&tableName=approval_test&previousRowId=<%=approval_execution_tableDTO.previousRowId%>"  ><%=LM.getText(LC.HM_HISTORY, loginDTO)%></a>
											</td>
											

