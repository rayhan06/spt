							
							<!-- Modal -->
							<div id="rejectionModal" class="modal fade" role="dialog">
							  <div class="modal-dialog">
							
							    <!-- Modal content-->
							    <div class="modal-content">
							      <div class="modal-header">
							        <button type="button" class="close" data-dismiss="modal">&times;</button>
							        <h4 class="modal-title">Choose an Employee To Reject/Review To</h4>
							      </div>
							      <div class="modal-body">
							        <%
							        List<ApprovalPathDetailsDTO> approvalPathDetailsDTOs = approvalPathDetailsDAO.getAllLessThanOrder(approval_execution_tableDTO.approvalPathId, (int)approval_execution_tableDTO.approvalPathOrder);
							        %>
							       <select class='form-control' name='rejectTo' id='rejectTo'>
									<%
                                        for(ApprovalPathDetailsDTO approvalPathDetailsDTO2 : approvalPathDetailsDTOs)
                                        {
                                        	String name = WorkflowController.getNameFromOrganogramId(approvalPathDetailsDTO2.organogramId, "English");
                                        	%>
                                        	<option value = '<%=approvalPathDetailsDTO2.approvalOrder%>'><%=approvalPathDetailsDTO2.approvalOrder%>: <%=name%> </option>
                                        	<%
                                        	
                                        }
                                    %>
                                    	<option value = '-1'>Totally Reject</option>
									</select>
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-default" onclick='approve("<%=id%>", "<%=Message%>", <%=i%>, "<%=servletName%>", 0, true, true)'><%=LM.getText(LC.HM_REJECT, loginDTO)%></button>
							      </div>
							    </div>
							
							  </div>
							</div>