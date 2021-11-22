<%@page pageEncoding="UTF-8" %>

<%@page import="approval_summary.*"%>
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
<%@ page import="approval_execution_table.*"%>
<%@ page import="approval_path.*"%>
<%@page import="dbm.*" %>
<%
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
String Language = LM.getText(LC.APPROVAL_SUMMARY_EDIT_LANGUAGE, loginDTO);

UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);


String navigator2 = SessionConstants.NAV_APPROVAL_SUMMARY;
RecordNavigator rn2 = (RecordNavigator)session.getAttribute(navigator2);
boolean isPermanentTable = rn2.m_isPermanentTable;
String tableName = rn2.m_tableName;

System.out.println("isPermanentTable = " + isPermanentTable);
Approval_summaryDTO approval_summaryDTO = (Approval_summaryDTO)request.getAttribute("approval_summaryDTO");

Approval_execution_tableDAO approval_execution_tableDAO = new Approval_execution_tableDAO();
ApprovalPathDetailsDAO approvalPathDetailsDAO = new ApprovalPathDetailsDAO();
Approval_execution_tableDTO approval_execution_tableDTO = null;
ApprovalPathDetailsDTO approvalPathDetailsDTO =  null;
boolean canApprove = false, canValidate = false;
boolean isInPreviousOffice = false;
String Message = "Done";

if(!isPermanentTable)
{
	approval_execution_tableDTO = (Approval_execution_tableDTO)approval_execution_tableDAO.getMostRecentDTOByUpdatedRowId("approval_summary", approval_summaryDTO.iD);
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
}	

System.out.println("approval_summaryDTO = " + approval_summaryDTO);


int i = Integer.parseInt(request.getParameter("rownum"));
out.println("<td style='display:none;'><input type='hidden' id='failureMessage_" + i + "' value=''/></td>");

String value = "";


Approval_summaryDAO approval_summaryDAO = (Approval_summaryDAO)request.getAttribute("approval_summaryDAO");


%>

											
		
											
											<td id = '<%=i%>_tableName'>
											<%
											value = approval_summaryDTO.tableName.toUpperCase().replace('_', ' ');
											%>
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_tableId'>
											<%
											value = approval_summaryDTO.tableId + "";
											%>
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_initiator'>
											<%
											value = approval_summaryDTO.initiator + "";
											%>
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_approvalStatusCat'>
											<%
											value = approval_summaryDTO.approvalStatusCat + "";
											%>
											<%
											value = CatDAO.getName(Language, "approval_status", approval_summaryDTO.approvalStatusCat);
											%>											
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_dateOfInitiation'>
											<%
											value = approval_summaryDTO.dateOfInitiation + "";
											%>
											<%
											SimpleDateFormat format_dateOfInitiation = new SimpleDateFormat("dd-MM-yyyy");
											String formatted_dateOfInitiation = format_dateOfInitiation.format(new Date(Long.parseLong(value))).toString();
											%>
											<%=formatted_dateOfInitiation%>
				
			
											</td>
		
											
											<td id = '<%=i%>_dateOfResolution'>
											<%
											value = approval_summaryDTO.dateOfResolution + "";
											%>
											<%
											SimpleDateFormat format_dateOfResolution = new SimpleDateFormat("dd-MM-yyyy");
											String formatted_dateOfResolution = format_dateOfResolution.format(new Date(Long.parseLong(value))).toString();
											%>
											<%=formatted_dateOfResolution%>
				
			
											</td>
		
											
											<td id = '<%=i%>_resolver'>
											<%
											value = approval_summaryDTO.resolver + "";
											%>
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_assignedTo'>
											<%
											value = approval_summaryDTO.assignedTo + "";
											%>
														
											<%=value%>
				
			
											</td>
		
											
		
											
		
	

	
											<td id = '<%=i%>_Edit'>
											<%
											if(isPermanentTable || canValidate)
											{
											%>																						
												<a href="#"  onclick='fixedToEditable(<%=i%>,"", "<%=approval_summaryDTO.iD%>", <%=isPermanentTable%>, "Approval_summaryServlet")'><%=LM.getText(LC.APPROVAL_SUMMARY_SEARCH_APPROVAL_SUMMARY_EDIT_BUTTON, loginDTO)%></a>
									
											<%
											}
											else
											{
											%>
												You cannot Validate this.
											<%
											}
											%>
											</td>											
											<%
											if(!isPermanentTable)
											{
											%>
											<td>
												<%=approval_execution_tableDTO !=null ? SessionConstants.operation_names[approval_execution_tableDTO.operation]: "Invalid Operation"%>
											</td>
											<td>
											<%
												if(approval_execution_tableDTO.operation == SessionConstants.UPDATE)
												{
													%>													
													<a href="#" id = '<%=i%>_getOriginal' onclick='getOriginal(<%=i%>, <%=approval_summaryDTO.iD%>, <%=approval_execution_tableDTO.previousRowId%>, "Approval_summaryServlet")'>View Original</a>
													<input type='hidden' id='<%=i%>_original_status' value='0'/>
													<%
												}
												%>
											</td>
											
											<td>
											<%
												if(canApprove)
												{
											%>
													<input type='text' class='form-control'  name='remarks' id = '<%=i%>_remarks'    tag='pb_html'/>
											<%
												}
											%>
											</td>
											<td>
											<%
												if(canApprove)
												{
											%>
													<%long ColumnID = DBMW.getInstance().getNextSequenceId("fileid"); %>			
													<div class="dropzone" action="Approval_execution_tableServlet?pageType=add&actionType=UploadFilesFromDropZone&columnName=approval_attached_fileDropzone&ColumnID=<%=ColumnID%>">
														<input type='file' style="display:none"  name='approval_attached_fileDropzoneFile' id = 'approval_attached_fileDropzone_dropzone_File_<%=i%>'  tag='pb_html'/>			
													</div>								
													<input type='hidden'  name='approval_attached_fileDropzoneFilesToDelete' id = 'approval_attached_fileDropzoneFilesToDelete_<%=i%>' value=''  tag='pb_html'/>
													<input type='hidden' name='approval_attached_fileDropzone' id = 'approval_attached_fileDropzone_dropzone_<%=i%>'  tag='pb_html' value='<%=ColumnID%>'/>	
											<%
												}
											%>
											</td>
											<td>
												<a href="Approval_execution_tableServlet?actionType=search&tableName=approval_summary&previousRowId=<%=approval_execution_tableDTO.previousRowId%>"  ><%=LM.getText(LC.HM_HISTORY, loginDTO)%></a>
											</td>
											
											<td id = 'tdapprove_<%=approval_summaryDTO.iD%>'>
												<%
												if(canApprove)
												{
												%>													
													<a href="#"  id = 'approve_<%=approval_summaryDTO.iD%>' onclick='approve("<%=approval_execution_tableDTO.updatedRowId%>", "<%=Message%>", <%=i%>, "Approval_summaryServlet", true)'><%=LM.getText(LC.HM_APPROVE, loginDTO)%></a>
												<%
												}
												else 
												{
												%>
													Not in your Office.
												<%
												}
												%>
											</td>
											<td id = 'tdreject_<%=approval_summaryDTO.iD%>'>
											<%
												if(canApprove)
												{
												%>
												<a href="#"  id = 'reject_<%=approval_summaryDTO.iD%>' onclick='approve("<%=approval_summaryDTO.iD%>", "<%=Message%>", <%=i%>, "Approval_summaryServlet", false)'><%=LM.getText(LC.HM_REJECT, loginDTO)%></a>
												<%
												}
												else 
												{
												%>
													Not in your Office.
												<%
												}
												%>
											</td>
												
											<%
											}
											else
											{
											%>
												<td id='<%=i%>_checkbox'>
													<div class='checker'>
														<span id='chkEdit' ><input type='checkbox' name='ID' value='<%=approval_summaryDTO.iD%>'/></span>
													</div>
												</td>
											<%
											}
											%>											
											

