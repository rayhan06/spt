							
							<!-- Modal -->
							<%@page import="workflow.WorkflowController"%>
<div id="approvalModal" class="modal fade" role="dialog">
							  <div class="modal-dialog">
							
							    <!-- Modal content-->
							    <div class="modal-content">
							      <div class="modal-header">
							        <button type="button" class="close" data-dismiss="modal">&times;</button>
							        <h4 class="modal-title"><%=LM.getText(LC.HM_APPROVE, loginDTO)%></h4>
							      </div>
							      <div class="modal-body">
							        <%
							        ApprovalPathDetailsDTO nextPath = approvalPathDetailsDAO.getApprovalPathDetailsDTOListByApprovalPathIDandApprovalOrder(approval_execution_tableDTO.approvalPathId, (int)(approval_execution_tableDTO.approvalPathOrder + 1));
							        String employeeName;
							        if(nextPath != null)
							        {
							        	employeeName = WorkflowController.getNameFromOrganogramId(nextPath.organogramId, "English");
							        	%>
							        	Send to <%=employeeName%> for review?
							        	<%
							        }
							        else
							        {
							        %>
							        	Finally Approve?
							        <%
							        }
							        %>
							       	
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-default" onclick='approve("<%=id%>", "<%=Message%>", <%=i%>, "<%=servletName%>", 1, true, true)'>Confirm</button>
							      </div>
							    </div>
							
							  </div>
							</div>