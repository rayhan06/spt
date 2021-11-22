<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="pb.*"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="approval_path.*"%>
<%@page import="workflow.*"%>
<%
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);

String Language = LM.getText(LC.CENTRE_EDIT_LANGUAGE, loginDTO);

String actionType = request.getParameter("actionType");
String servletType2 = request.getParameter("servletType");
String parentElementID = request.getParameter("parentElementID");

int pathCategory = 2;
String officeTablename = "office_origin_unit_organograms";

String nameText = "";
String Options = "";

List<ApprovalPathDetailsDTO> data = (List<ApprovalPathDetailsDTO>)request.getAttribute("approval_path_detailsDTOList");
ApprovalPathDetailsDAO approval_path_detailsDAO = new ApprovalPathDetailsDAO();

long officeID = (long)request.getAttribute("officeID");

String value = "";
%>

<table class="table table-bordered table-hover">
		
						<thead>
							<tr>
								

								
								<th><%=LM.getText(LC.APPROVAL_PATH_DETAILS_EDIT_APPROVALORDER, loginDTO)%></th>
								<th>Details</th>
								<th><%=LM.getText(LC.APPROVAL_PATH_DETAILS_EDIT_APPROVALROLECAT, loginDTO)%></th>
								<th>Select</th>								
								
							</tr>
						</thead>
						<tbody name="tbodytoload" >
		<%
								try
								{

									if (data != null) 
									{
										int size = data.size();										
										System.out.println("data not null and size = " + size + " data = " + data);
										for (int i = 0; i < size; i++) 
										{
											ApprovalPathDetailsDTO approvalPathDetailsDTO = (ApprovalPathDetailsDTO) data.get(i);

											out.println("<tr id = 'tr_" + i + "'>");
											%>
											

											<td id = '<%=i%>_approvalOrder'>
											<%
											value = approvalPathDetailsDTO.approvalOrder + "";
											%>
														
											<%=value%>
				
			
											</td>
											
											<td id = '<%=i%>_organogramId'>
											<%
											value = approvalPathDetailsDTO.organogramId + "";
											%>
											<%
											value = CommonDAO.getName(Integer.parseInt(value), officeTablename, Language.equals("English")?"designation_eng":"designation_bng", "id");
											String userName = WorkflowController.getUserNameFromOrganogramId(approvalPathDetailsDTO.organogramId);
											String designation = value;
											String eName = "";
											String unitName = "";
											String text = "";
											%>
														
											
											<%
											long organogramID = WorkflowController.getUnitOrganogramIDByUnitOriginOrganogramID(approvalPathDetailsDTO.organogramId, officeID);
											if(pathCategory != 2)
											{
											%> Organogram ID: <%=approvalPathDetailsDTO.organogramId%>, Designation: <%=value%>, UserName: <%=userName%>, Name: <%=WorkflowController.getNameFromOrganogramId(approvalPathDetailsDTO.organogramId, Language)%>
											<%
											}
											else
											{
												long ERID = WorkflowController.getEmployeeRecordIDFromOrganogramID(organogramID);
												eName = WorkflowController.getNameFromEmployeeRecordID(ERID);
												unitName = WorkflowController.getUnitNameFromOrganogramId(organogramID, Language);
												text = eName + ", " + designation + ", " + unitName;
									
												if(!eName.equalsIgnoreCase(""))
												{
											%>
												<%=text%>
											<%
												}
												else
												{
													%>
														<%=value%>
													<%
												}
											}
											%>
														
											
			
											</td>
											
											<td id = '<%=i%>_approvalRoleType'>
											<%
											value = approvalPathDetailsDTO.approvalRoleCat + "";
											%>
											<%
											value = CatDAO.getName(Language, "approval_role", approvalPathDetailsDTO.approvalRoleCat);
											String approval_role = value;
											%>											
														
											<%=value%>
														
											
				
			
											</td>
		
											
								
		
											
											<% 
											
											
																					
											
											
											%>
											
											<%
											out.println("<td>");
											if(organogramID != -1 && WorkflowController.getEmployeeRecordIDFromOrganogramID(organogramID) != -1)
											{
												designation = designation.replace("'","");
												

												out.println("<input type='checkbox' id='approval_template_cb_" +  organogramID + "'"
														+ "onclick='assignOrganogram(\"" + text.replace("'", "") +  "\", " + approvalPathDetailsDTO.approvalRoleCat + ", " + organogramID + ")' name='ID' value='" + organogramID + ")'/>");

											}
											out.println("</td>");
											out.println("</tr>");
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
									e.printStackTrace();
								}
							%>

		</tbody>
</table>


		