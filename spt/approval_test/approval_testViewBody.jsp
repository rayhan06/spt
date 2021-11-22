

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
String Language = LM.getText(LC.APPROVAL_TEST_EDIT_LANGUAGE, loginDTO);

String ID = request.getParameter("ID");
if(ID == null || ID.isEmpty())
{
	ID = "0";
}
long id = Long.parseLong(ID);
System.out.println("ID = " + ID);
Approval_testDAO approval_testDAO = new Approval_testDAO("approval_test");
Approval_testDTO approval_testDTO = (Approval_testDTO)approval_testDAO.getDTOByID(id);
String Value = "";
int i = 0;
FilesDAO filesDAO = new FilesDAO();
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
               


        </div>