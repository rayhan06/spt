

<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="approval_path.*"%>
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
<%@page import="workflow.*"%>




<%
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
String actionName = "edit";

String value = "";
String Language = LM.getText(LC.APPROVAL_PATH_EDIT_LANGUAGE, loginDTO);


long id = (long)request.getAttribute("id");

System.out.println("In details plain, id = " + id);

Approval_pathDAO approval_pathDAO = new Approval_pathDAO("approval_path");
Approval_pathDTO approval_pathDTO = (Approval_pathDTO)approval_pathDAO.getDTOByID(id);
int pathCategory = approval_pathDTO.approvalPathCat;
String officeTablename = "office_origin_unit_organograms";
if(pathCategory != 2)
{
	officeTablename = "office_unit_organograms";
}
String Value = "";
int i = 0;
%>					
					
					
					
					<div class="col-md-12">
                        
						<table class="table table-bordered table-striped">
							<tr>
								<th><%=LM.getText(LC.HM_OFFICE_UNIT, loginDTO)%></th>
								<th><%=LM.getText(LC.HM_DESIGNATION, loginDTO)%></th>
								<th><%=LM.getText(LC.HM_USER_NAME, loginDTO)%></th>
								<th><%=LM.getText(LC.HM_NAME, loginDTO)%></th>
								<th><%=LM.getText(LC.HM_APPROVAL_ROLE, loginDTO)%></th>
								<th><%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_PATH_EDIT_APPROVAL_PATH_DETAILS_APPROVALORDER, loginDTO)):(LM.getText(LC.APPROVAL_PATH_ADD_APPROVAL_PATH_DETAILS_APPROVALORDER, loginDTO))%></th>
								<th><%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_PATH_EDIT_APPROVAL_PATH_DETAILS_DAYSREQUIRED, loginDTO)):(LM.getText(LC.APPROVAL_PATH_ADD_APPROVAL_PATH_DETAILS_DAYSREQUIRED, loginDTO))%></th>
							</tr>
							<%
                        	ApprovalPathDetailsDAO approvalPathDetailsDAO = new ApprovalPathDetailsDAO();
                         	List<ApprovalPathDetailsDTO> approvalPathDetailsDTOs = approvalPathDetailsDAO.getApprovalPathDetailsDTOListByApprovalPathID(approval_pathDTO.iD);
                         	
                         	for(ApprovalPathDetailsDTO approvalPathDetailsDTO: approvalPathDetailsDTOs)
                         	{
                         		%>
                         			<tr>
                         			<td><%=WorkflowController.getUnitNameFromOrganogramId(approvalPathDetailsDTO.organogramId, Language)%></td>
                         			<td><%=CommonDAO.getName((int)approvalPathDetailsDTO.organogramId, officeTablename, Language.equals("English")?"designation_eng":"designation_bng", "id")%></td>
                         			<td><%=WorkflowController.getUserNameFromOrganogramId(approvalPathDetailsDTO.organogramId)%></td>
                         			<td><%=WorkflowController.getNameFromOrganogramId(approvalPathDetailsDTO.organogramId, Language)%></td>
										
										<td>
											<%
											value = approvalPathDetailsDTO.approvalRoleCat + "";
											%>
											<%
											value = CatDAO.getName(Language, "approval_role", approvalPathDetailsDTO.approvalRoleCat);
											%>											
														
											<%=value%>
				
			
										</td>
										<td>
											<%
											value = approvalPathDetailsDTO.approvalOrder + "";
											%>
														
											<%=value%>
				
			
										</td>
										<td>
											<%
											value = approvalPathDetailsDTO.daysRequired + "";
											%>
														
											<%=value%>
				
			
										</td>
                         			</tr>
                         		<%
                         		
                         	}
                         	
                        %>
						</table>
                    </div>           