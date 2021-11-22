<%@page import="workflow.WorkflowController"%>
<%@page pageEncoding="UTF-8" %>

<%@page import="approval_path.*"%>
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
<%@page import="OfficeUnitsEdms.*"%>
<%
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
String Language = LM.getText(LC.APPROVAL_PATH_EDIT_LANGUAGE, loginDTO);

Approval_pathDTO approval_pathDTO = (Approval_pathDTO)request.getAttribute("approval_pathDTO");
if(approval_pathDTO == null)
{
	approval_pathDTO = new Approval_pathDTO();
	
}
System.out.println("approval_pathDTO = " + approval_pathDTO);


int i = Integer.parseInt(request.getParameter("rownum"));
out.println("<td style='display:none;'><input type='hidden' id='failureMessage_" + i + "' value=''/></td>");

String value = "";

UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);
String navigator2 = SessionConstants.NAV_APPROVAL_PATH;
RecordNavigator rn2 = (RecordNavigator)session.getAttribute(navigator2);
boolean isPermanentTable = rn2.m_isPermanentTable;
String tableName = rn2.m_tableName;

String successMessageForwarded = "Forwarded to your Senior Office";
String successMessageApproved = "Approval Done";

Approval_pathDAO approval_pathDAO = (Approval_pathDAO)request.getAttribute("approval_pathDAO");
TempTableDTO tempTableDTO = null;


%>

											
		
											
											<td id = '<%=i%>_nameEn'>
											<%
											value = approval_pathDTO.nameEn + "";
											%>
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_Office'>
											<%
											value = WorkflowController.getOfficeUnitName(approval_pathDTO.officeUnitId);
											if(value.equalsIgnoreCase(""))
											{
												value = "All Offices";
											}
											
											%>
														
											<%=value%>
				
			
											</td>
		
											
											
											
										
		
											
		
											
		
	

											<td>
											<a href='Approval_pathServlet?actionType=view&ID=<%=approval_pathDTO.iD%>'>View</a>
											
											<!--<a href='#' data-toggle='modal' data-target='#viedFileModal_<%=i%>'>Modal</a>
											
											
											<div class='modal fade' id='viedFileModal_<%=i%>'>
											  <div class='modal-dialog modal-lg' role='document'>
											    <div class='modal-content'>
											      <div class='modal-body'>
											        <button type='button' class='close' data-dismiss='modal' aria-label='Close'>
											          <span aria-hidden='true'>&times;</span>
											        </button>											        
											        
											        <object type='text/html' data='Approval_pathServlet?actionType=view&modal=1&ID=<%=approval_pathDTO.iD%>' width='100%' height='500' style='height: 85vh;'>No Support</object>
											        
											      </div>
											    </div>
											  </div>
											</div>
											 -->
											</td>
	
										
											<%
											if(!isPermanentTable && userDTO.approvalOrder > -1)
											{
												String Successmessage = "";
												if(userDTO.approvalOrder < userDTO.maxApprovalOrder)
												{
													Successmessage = successMessageForwarded;
												}
												else
												{
													Successmessage= successMessageApproved;
												}
												%>
												<td id = 'tdapprove_<%=approval_pathDTO.iD%>'>
												<%
												if(userDTO.approvalOrder == tempTableDTO.approval_order)
												{
													%>													
													<a id = 'approve_<%=approval_pathDTO.iD%>' onclick='approve("<%=approval_pathDTO.iD%>", "<%=Successmessage%>", <%=i%>, "Approval_pathServlet")'><%=LM.getText(LC.HM_APPROVE, loginDTO)%></a>
												<%
												}
												else if(userDTO.approvalOrder > tempTableDTO.approval_order)
												{
												%>
													You cannot approve it yet
												<%
												}
												else
												{
													if(userDTO.approvalOrder < userDTO.maxApprovalOrder)
													{
														%>
														<%=Successmessage%>
														<%
													}													
												}
												%>
												</td>
												
												
												<td id = 'tdoperation_<%=approval_pathDTO.iD%>'>
												<%=SessionConstants.operation_names[tempTableDTO.operation_type]%>
												</td>
												
												<td id = 'original_<%=approval_pathDTO.iD%>'>
												<%
												if(tempTableDTO.operation_type == SessionConstants.UPDATE)
												{
													%>													
													<a id = '<%=i%>_getOriginal' onclick='getOriginal(<%=i%>, <%=approval_pathDTO.iD%>, <%=tempTableDTO.permanent_table_id%>, "Approval_pathServlet")'>View Original</a>
													<input type='hidden' id='<%=i%>_original_status' value='0'/>
													<%
												}
												%>
												</td>
											<%
											}
											%>											
											
											
											<td id='<%=i%>_checkbox'>
											<%
											if(isPermanentTable || (!isPermanentTable && userDTO.approvalOrder == tempTableDTO.approval_order))
											{
											%>
												
												<div class='checker'>
												<span id='chkEdit' ><input type='checkbox' name='ID' value='<%=approval_pathDTO.iD%>'/></span>
												</div>
											<%
											}
											%>
											</td>

