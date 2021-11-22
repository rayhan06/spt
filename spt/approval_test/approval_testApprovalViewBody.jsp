

<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="approval_test.*"%>
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
<%@page import="files.*"%>
<%@page import="dbm.*" %>
<%@ page import="approval_execution_table.*"%>
<%@ page import="approval_path.*"%>
<%@page import="user.*"%>
<%@page import="workflow.*"%>
<%@ page import="util.CommonConstant" %>


<%
	String servletName = "Approval_testServlet";
	LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
	String Language = LM.getText(LC.APPROVAL_TEST_EDIT_LANGUAGE, loginDTO);

	UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);

	String actionName = "edit";
	String failureMessage = (String)request.getAttribute("failureMessage");
	if(failureMessage == null || failureMessage.isEmpty())
	{
		failureMessage = "";
	}
	out.println("<input type='hidden' id='failureMessage_general' value='" + failureMessage + "'/>");
	String value = "";


	String ID = request.getParameter("ID");
	boolean isPermanentTable = Boolean.parseBoolean(request.getParameter("isPermanentTable"));

	if(ID == null || ID.isEmpty())
	{
		ID = "0";
	}
	long id = Long.parseLong(ID);
	System.out.println("ID = " + ID + " isPermanentTable = " + isPermanentTable);
	Approval_testDAO approval_testDAO = new Approval_testDAO("approval_test");
	Approval_testDTO approval_testDTO = (Approval_testDTO)approval_testDAO.getDTOByID(id);
	String Value = "";
	int i = 0;
	FilesDAO filesDAO = new FilesDAO();
	
	String tableName = "approval_test";

	Approval_execution_tableDAO approval_execution_tableDAO = new Approval_execution_tableDAO();
	ApprovalPathDetailsDAO approvalPathDetailsDAO = new ApprovalPathDetailsDAO();
	Approval_execution_tableDTO approval_execution_tableDTO = null;
	Approval_execution_tableDTO approval_execution_table_initiationDTO = null;
	ApprovalPathDetailsDTO approvalPathDetailsDTO =  null;

	boolean canApprove = false, canValidate = false, isInitiator = false, canTerminate = false;
	boolean isInPreviousOffice = false;
	String Message = "Done";

	if(!isPermanentTable)
	{
		approval_execution_tableDTO = (Approval_execution_tableDTO)approval_execution_tableDAO.getMostRecentDTOByUpdatedRowId("approval_test", approval_testDTO.iD);
		System.out.println("approval_execution_tableDTO = " + approval_execution_tableDTO);
		approvalPathDetailsDTO = approvalPathDetailsDAO.getApprovalPathDetailsDTOListByApprovalPathIDandApprovalOrder(approval_execution_tableDTO.approvalPathId, (int)approval_execution_tableDTO.approvalPathOrder);
		approval_execution_table_initiationDTO = (Approval_execution_tableDTO)approval_execution_tableDAO.getInitiationDTOByPreviousRowId("approval_test", approval_execution_tableDTO.previousRowId);
		if(approvalPathDetailsDTO!= null && approvalPathDetailsDTO.organogramId == userDTO.organogramID 
				&& approval_execution_tableDTO.iD == approval_execution_tableDAO.getMostRecentExecutionIDByPreviousRowID("approval_test", approval_execution_tableDTO.previousRowId))
		{
			canApprove = true;
			if(approvalPathDetailsDTO.approvalRoleCat == SessionConstants.VALIDATOR)
			{
				canValidate = true;
			}
		}
		
		isInitiator = WorkflowController.isInitiator(tableName, approval_execution_tableDTO.previousRowId, userDTO.organogramID);
		
		canTerminate = isInitiator && approval_testDTO.isDeleted == 2;
	}	

%>

<div class="modal-content viewmodal">
            <div class="modal-header">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-9 col-sm-12">
                            <h5 class="modal-title">Approval Test Details</h5>
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
                        <h5>Approval Test</h5>
                    </div>
			



			

                    <div class="col-md-6">
                        <label class="col-md-5" style="padding-right: 0px;"><b><span><%=LM.getText(LC.APPROVAL_TEST_EDIT_DESCRIPTION, loginDTO)%></span><span style="float:right;">:</span></b></label>
                        <label id="description">
						
											<%
											value = approval_testDTO.description + "";
											%>
														
											<%=value%>
				
			
						
                        </label>
                    </div>

				


			
			
			
			
		

				<div class="col-md-6">
				<label class="col-md-5" style="padding-right: 0px;"><b><span>Initiator Instructions</span><span style="float:right;">:</span></b></label>
				<label id="referenceNo">

					<%
						value = approval_execution_table_initiationDTO.remarks + "";
					%>

					<%=value%>



				</label>
			</div>
			
			<div class="col-md-6">
				<label class="col-md-5" style="padding-right: 0px;"><b><span>Initiator Files</span><span style="float:right;">:</span></b></label>
				<label id="filesDropzone"></label> <br/>

				
				<%
					{
					List<FilesDTO>  FilesDTOList = filesDAO.getMiniDTOsByFileID(approval_execution_table_initiationDTO.fileDropzone);
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
			</div>

			</div>
				

                <div class="row div_border attachement-div">
                    <div class="col-md-12">
                        <h5>Approval Test Baby</h5>
						<table class="table table-bordered table-striped">
							<tr>
								<th><%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_TEST_EDIT_APPROVAL_TEST_BABY_INSCRIPTION, loginDTO)):(LM.getText(LC.APPROVAL_TEST_ADD_APPROVAL_TEST_BABY_INSCRIPTION, loginDTO))%></th>
								<th><%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_TEST_EDIT_APPROVAL_TEST_BABY_ANUMBER, loginDTO)):(LM.getText(LC.APPROVAL_TEST_ADD_APPROVAL_TEST_BABY_ANUMBER, loginDTO))%></th>
							</tr>
							<%
                        	ApprovalTestBabyDAO approvalTestBabyDAO = new ApprovalTestBabyDAO();
                         	List<ApprovalTestBabyDTO> approvalTestBabyDTOs = approvalTestBabyDAO.getApprovalTestBabyDTOListByApprovalTestID(approval_testDTO.iD);
                         	
                         	for(ApprovalTestBabyDTO approvalTestBabyDTO: approvalTestBabyDTOs)
                         	{
                         		%>
                         			<tr>
										<td>
											<%
											value = approvalTestBabyDTO.inscription + "";
											%>
														
											<%=value%>
				
			
										</td>
										<td>
											<%
											value = approvalTestBabyDTO.aNumber + "";
											%>
														
											<%=value%>
				
			
										</td>
                         			</tr>
                         		<%
                         		
                         	}
                         	
                        %>
						</table>
                    </div>                    
                </div>
               


        

					<%if(!isPermanentTable && (canApprove || canTerminate)) {%>
				
						<div class="row div_border attachement-div">
							<div class="col-md-12">
								<h5><%=LM.getText(LC.HM_ATTACHMENTS, loginDTO )%></h5>
								<%
									long ColumnID = DBMW.getInstance().getNextSequenceId("fileid");
								%>
								<div class="dropzone"
									 action="Approval_execution_tableServlet?pageType=add&actionType=UploadFilesFromDropZone&columnName=approval_attached_fileDropzone&ColumnID=<%=ColumnID%>">
									<input type='file' style="display: none"
										   name='approval_attached_fileDropzoneFile'
										   id='approval_attached_fileDropzone_dropzone_File_<%=i%>'
										   tag='pb_html' />
								</div>
								<input type='hidden'
									   name='approval_attached_fileDropzoneFilesToDelete'
									   id='approval_attached_fileDropzoneFilesToDelete_<%=i%>' value=''
									   tag='pb_html' /> <input type='hidden'
															   name='approval_attached_fileDropzone'
															   id='approval_attached_fileDropzone_dropzone_<%=i%>' tag='pb_html'
															   value='<%=ColumnID%>' />
							</div>
				
							<div class="col-md-12">
								<h5><%=LM.getText(LC.HM_REMARKS, loginDTO )%></h5>
				
								<textarea class='form-control'  name='remarks' id = '<%=i%>_remarks'   tag='pb_html'></textarea>
							</div>
						</div>
						<%}%>
						<div class="form-actions text-center">
						<%
							if(canApprove)
							{
							%>
							<button type="submit"  class="btn btn-success" id = 'approve_<%=id%>' data-toggle="modal" data-target="#approvalModal" ><%=LM.getText(LC.HM_APPROVE, loginDTO)%></button>
							<%@include file="../approval_path/approvalModal.jsp"%>
							<button type="submit" class="btn btn-danger" id = 'reject_<%=approval_testDTO.iD%>' data-toggle="modal" data-target="#rejectionModal" ><%=LM.getText(LC.HM_REJECT, loginDTO)%></button>
							<%@include file="../approval_path/rejectionModal.jsp"%>
							<%
							}
							if(canTerminate)
							{
							%>
							<button type="submit"  class="btn btn-success" id = 'approve_<%=approval_testDTO.iD%>' onclick='approve("<%=approval_execution_tableDTO.updatedRowId%>", "<%=Message%>", <%=i%>, "Approval_testServlet", 2, true, true)'><%=LM.getText(LC.HM_TERMINATE, loginDTO)%></button>
							<%
							}							
							if(canValidate)
							{
							%>
							<a type="submit"  class="btn btn-success" id = 'validate_<%=approval_testDTO.iD%>' href='Approval_testServlet?actionType=getEditPage&ID=<%=approval_testDTO.iD%>&isPermanentTable=<%=isPermanentTable%>'><%=LM.getText(LC.HM_VALIDATE, loginDTO)%></a>
							<%
							}
							%>
							<button type="submit"  class="btn btn-success" id = 'history_<%=id%>' data-toggle="modal" data-target="#historyModal"><%=LM.getText(LC.HM_HISTORY, loginDTO)%></button>
							<%@include file="../approval_path/historyModal.jsp"%>												
						</div>
					
           

        </div>
        
        
 <script type="text/javascript">
 window.onload =function ()
 {
     console.log("using ckEditor");
     CKEDITOR.replaceAll();
 }
 </script>