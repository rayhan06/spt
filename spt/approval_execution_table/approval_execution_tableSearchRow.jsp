<%@page pageEncoding="UTF-8" %>

<%@page import="approval_execution_table.*"%>
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
<%@page import="workflow.*"%>
<%
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
String Language = LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_LANGUAGE, loginDTO);

UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);


String navigator2 = SessionConstants.NAV_APPROVAL_EXECUTION_TABLE;

boolean isPermanentTable = true;
String tableName = "approval_execution_table";

System.out.println("isPermanentTable = " + isPermanentTable);
Approval_execution_tableDTO approval_execution_tableDTO = (Approval_execution_tableDTO)request.getAttribute("approval_execution_tableDTO");

Approval_execution_tableDAO approval_execution_tableDAO = new Approval_execution_tableDAO();
ApprovalPathDetailsDAO approvalPathDetailsDAO = new ApprovalPathDetailsDAO();

Approval_pathDAO approval_pathDAO = new Approval_pathDAO();
Approval_pathDTO approval_pathDTO =  (Approval_pathDTO)approval_pathDAO.getDTOByID(approval_execution_tableDTO.approvalPathId);

ApprovalPathDetailsDTO approvalPathDetailsDTO =  null;
ApprovalPathDetailsDTO approvalPathDetailsDTONext =  null;
boolean canApprove = false, canValidate = false;
boolean isInPreviousOffice = false;
String Message = "Done";



String servletName = approval_execution_tableDTO.tableName.substring(0, 1).toUpperCase() + approval_execution_tableDTO.tableName.substring(1);
servletName += "Servlet";

if(!isPermanentTable)
{
	approval_execution_tableDTO = (Approval_execution_tableDTO)approval_execution_tableDAO.getMostRecentDTOByUpdatedRowId("approval_execution_table", approval_execution_tableDTO.iD);
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

System.out.println("approval_execution_tableDTO = " + approval_execution_tableDTO);


int i = Integer.parseInt(request.getParameter("rownum"));
out.println("<td style='display:none;'><input type='hidden' id='failureMessage_" + i + "' value=''/></td>");

String value = "";



String successMessageForwarded = "Forwarded to your Senior Office";
String successMessageApproved = "Approval Done";



FilesDAO filesDAO = new FilesDAO();

boolean noModuleNoPath = false;
if(request.getParameter("noModuleNoPath") != null)
{
	noModuleNoPath = true;
}

%>

											<%
											if(!noModuleNoPath)
											{
											%>
											<td id = '<%=i%>_Module'>
											<%
											value = SessionConstants.tableNameMap.get(approval_execution_tableDTO.tableName).toString();
											%>
											
											<%=value%>
											
											</td>
											<%
											}
											%>
											
											<td id = '<%=i%>_lastModificationTime'>
											<%
											value = approval_execution_tableDTO.lastModificationTime + "";
											%>
											
											<%
											SimpleDateFormat date = new SimpleDateFormat("dd-M-yyyy hh:mm:ss");
											String formatted_date = date.format(new Date(Long.parseLong(value))).toString();
											%>
											<%=formatted_date%>
											
											</td>
														
											
										
		
											
											
		
											
											<td id = '<%=i%>_action'>
											
														
											<%=SessionConstants.operation_names[approval_execution_tableDTO.action]%>
				
			
											</td>
		
											
											<td id = '<%=i%>_approvalStatusCat'>
											<%
											value = approval_execution_tableDTO.approvalStatusCat + "";
											%>
											<%
											value = CatDAO.getName(Language, "approval_status", approval_execution_tableDTO.approvalStatusCat);
											%>											
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_userId'>
											<%
											
											String Name = WorkflowController.getNameFromUserId(approval_execution_tableDTO.userId , Language);
											%>
														
											<%=Name%>
				
			
											</td>
		
											
										
											<%
											if(!noModuleNoPath)
											{
											%>
											
											<td id = '<%=i%>_approvalPathId'>
											<%
											value = approval_pathDTO.nameEn + "";
											%>
														
											<%=value%>
				
			
											</td>
											<%
											}
											%>
		
											
											<td id = '<%=i%>_approvalPathOrder'>
											<%
											if(approval_execution_tableDTO.approvalPathOrder != -1)
											{
												value = approval_execution_tableDTO.approvalPathOrder + "";
											}
											else
											{
												value = "Final Step";
											}
											%>
														
											<%=value%>
				
			
											</td>
											
											<td id = '<%=i%>_nextOfficer'>
											<%
											approvalPathDetailsDTONext = approvalPathDetailsDAO.getApprovalPathDetailsDTOListByApprovalPathIDandApprovalOrder(approval_execution_tableDTO.approvalPathId, approval_execution_tableDTO.approvalPathOrder);
											if(approvalPathDetailsDTONext != null)
											{
												value = WorkflowController.getNameFromOrganogramId(approvalPathDetailsDTONext.organogramId, Language);
											}
											else
											{
												value = "Not applicable";
											}
											
											%>
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_remarks'>
											<%
											value = approval_execution_tableDTO.remarks + "";
											%>
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_fileDropzone'>
											<%
											value = approval_execution_tableDTO.fileDropzone + "";
											%>
											<%
											{
												List<FilesDTO> FilesDTOList = filesDAO.getMiniDTOsByFileID(approval_execution_tableDTO.fileDropzone);
												%>
												<table>
												<tr>
												<%
												if(FilesDTOList != null)
												{
													for(int j = 0; j < FilesDTOList.size(); j ++)
													{
														FilesDTO filesDTO = FilesDTOList.get(j);
														byte[] encodeBase64 = org.apache.commons.codec.binary.Base64.encodeBase64(filesDTO.thumbnailBlob);
														%>
														<td>
														<%
														if(filesDTO.fileTypes.contains("image") && encodeBase64!= null)
														{
															%>
															<img src='data:<%=filesDTO.fileTypes%>;base64,<%=new String(encodeBase64)%>' style='width:100px' />
															<%
														}
														%>
														<a href = 'Approval_execution_tableServlet?actionType=downloadDropzoneFile&id=<%=filesDTO.iD%>' download><%=filesDTO.fileTitle%></a>
														</td>
													<%
													}
												}
												%>
												</tr>
												</table>
											<%												
											}
											%>
				
			
											</td>
		
											
											<td>
											<a href='<%=servletName%>?actionType=view&ID=<%=approval_execution_tableDTO.updatedRowId%>&isPermanentTable=false'>View</a>
											</td>
											
		
	

	
																						
											
											 
											


