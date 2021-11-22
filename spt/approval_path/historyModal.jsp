
<%@page import="approval_execution_table.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%@page import="sessionmanager.SessionConstants"%>

<%@ page import="pb.*"%>


<!-- Modal -->
<div id="historyModal" class="modal fade" role="dialog">
	<div class="modal-dialog edms-modaldilog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"><%=LM.getText(LC.HM_HISTORY, loginDTO)%></h4>
			</div>
			<div class="modal-body">
				<div class="table-responsive">
					<table id="tableData" class="table table-bordered table-striped">
						<thead>
							<tr>

								<th>Action Date</th>


								<th><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_ACTION, loginDTO)%></th>
								<th>Approval Status</th>
								<th><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_USERID, loginDTO)%></th>

								<th><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_APPROVALPATHORDER, loginDTO)%></th>
								<th>Next Officer</th>
								<th><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_REMARKS, loginDTO)%></th>
								<th>Files</th>
								<th>Details</th>


							</tr>
						</thead>
						<tbody>
							<%
							List<Approval_execution_tableDTO> data = approval_execution_tableDAO.getDtosByTableNameAndUpdatedRowId(tableName, id);

								try
								{

									if (data != null) 
									{
										int size = data.size();										
										System.out.println("data not null and size = " + size + " data = " + data);
										for (i = 0; i < size; i++) 
										{
											approval_execution_tableDTO = (Approval_execution_tableDTO) data.get(i);
																																
											
											%>
							<tr id='tr_<%=i%>'>
								<%
											
								%>


								<%  								
								    request.setAttribute("approval_execution_tableDTO",approval_execution_tableDTO);
								%>

								<jsp:include
									page="../approval_execution_table/approval_execution_tableSearchRow.jsp">
									<jsp:param name="pageName" value="searchrow" />
									<jsp:param name="rownum" value="<%=i%>" />
									<jsp:param name="noModuleNoPath" value="true" />
								</jsp:include>


								<%

											%>
							</tr>
							<%
										}
										 
										System.out.println("printing done");
									}
									else
									{
										System.out.println("data  null");
									}
								}
								catch(Exception e)
								{
									System.out.println("JSP exception " + e);
								}
							%>



						</tbody>

					</table>
				</div>
			</div>
			<div class="modal-footer"></div>
		</div>

	</div>
</div>

