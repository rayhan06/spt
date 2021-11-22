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
<%@page import="org.apache.commons.codec.binary.*"%>
<%@ page import="util.RecordNavigator"%>
<%@ page import="approval_execution_table.*"%>
<%@ page import="approval_path.*"%>
<%@page import="dbm.*" %>
<%@page import="util.*" %>
<%
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
String Language = LM.getText(LC.APPROVAL_TEST_EDIT_LANGUAGE, loginDTO);
String Language2 = Language;

UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);


String navigator2 = SessionConstants.NAV_APPROVAL_TEST;
RecordNavigator rn2 = (RecordNavigator)session.getAttribute(navigator2);
boolean isPermanentTable = rn2.m_isPermanentTable;
String tableName = rn2.m_tableName;

System.out.println("isPermanentTable = " + isPermanentTable);
Approval_testDTO approval_testDTO = (Approval_testDTO)request.getAttribute("approval_testDTO");
CommonDTO commonDTO = approval_testDTO;
String servletName = "Approval_testServlet";

Approval_execution_tableDAO approval_execution_tableDAO = new Approval_execution_tableDAO();
ApprovalPathDetailsDAO approvalPathDetailsDAO = new ApprovalPathDetailsDAO();
Approval_execution_tableDTO approval_execution_tableDTO = null;
String Message = "Done";
approval_execution_tableDTO = (Approval_execution_tableDTO)approval_execution_tableDAO.getMostRecentDTOByUpdatedRowId("approval_test", approval_testDTO.iD);

System.out.println("approval_testDTO = " + approval_testDTO);


int i = Integer.parseInt(request.getParameter("rownum"));
out.println("<td style='display:none;'><input type='hidden' id='failureMessage_" + i + "' value=''/></td>");

String value = "";


Approval_testDAO approval_testDAO = (Approval_testDAO)request.getAttribute("approval_testDAO");


String Options = "";
boolean formSubmit = false;

%>

											
		
											
											<td id = '<%=i%>_description'>
											<%
											value = approval_testDTO.description + "";
											%>
														
											<%=value%>
				
			
											</td>
		
											
		
											
		
											
		
	

											<td>
											<a href='Approval_testServlet?actionType=view&ID=<%=approval_testDTO.iD%>'>View</a>
											
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
	
											<td id = '<%=i%>_Edit'>																																	
	
												<a href='Approval_testServlet?actionType=getEditPage&ID=<%=approval_testDTO.iD%>'><%=LM.getText(LC.APPROVAL_TEST_SEARCH_APPROVAL_TEST_EDIT_BUTTON, loginDTO)%></a>
																				
											</td>											
											
											
											<td>
											<%
												if(approval_testDTO.isDeleted == 0 && approval_execution_tableDTO != null)
												{
											%>
												<a href="Approval_execution_tableServlet?actionType=search&tableName=approval_test&previousRowId=<%=approval_execution_tableDTO.previousRowId%>"  ><%=LM.getText(LC.HM_HISTORY, loginDTO)%></a>
											<%
												}
												else
												{
											%>
												<%=LM.getText(LC.HM_NO_HISTORY_IS_AVAILABLE, loginDTO)%>
											<%
												}
											%>
											</td>
											
											<td>
											<%
											if(approval_testDTO.jobCat == SessionConstants.DEFAULT_JOB_CAT)
											{
											%>
												<button type="button" class="btn btn-success" data-toggle="modal" data-target="#sendToApprovalPathModal" >
													<%=LM.getText(LC.HM_SEND_TO_APPROVAL_PATH, loginDTO)%>
												</button>
												<%@include file="../inbox_internal/sendToApprovalPathModal.jsp"%>
											<%
											}
											else
											{
											%>
											<%=LM.getText(LC.HM_NO_ACTION_IS_REQUIRED, loginDTO)%>
											<%
											}
											%>
											</td>
											<td id='<%=i%>_checkbox'>
												<div class='checker'>
													<span id='chkEdit' ><input type='checkbox' name='ID' value='<%=approval_testDTO.iD%>'/></span>
												</div>
											</td>
																						
											
<script>
window.onload =function ()
{
    console.log("using ckEditor");
    CKEDITOR.replaceAll();
}
	
</script>	

