<%@page pageEncoding="UTF-8" %>

<%@page import="applicant_profile.*"%>
<%@page import="geolocation.GeoLocationDAO2"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>


<%@ page import="pb.*"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="user.*"%>
<%@page import="org.apache.commons.codec.binary.*"%>
<%@ page import="util.RecordNavigator"%>
<%
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
String Language = LM.getText(LC.APPLICANT_PROFILE_EDIT_LANGUAGE, loginDTO);

Applicant_profileDTO row = (Applicant_profileDTO)request.getAttribute("applicant_profileDTO");
if(row == null)
{
	row = new Applicant_profileDTO();
	
}
System.out.println("row = " + row);


int i = Integer.parseInt(request.getParameter("rownum"));
out.println("<td style='display:none;'><input type='hidden' id='failureMessage_" + i + "' value=''/></td>");

String value = "";

UserDTO userDTO = UserRepository.getInstance().getUserDTOByUserID(loginDTO);
String navigator2 = SessionConstants.NAV_APPLICANT_PROFILE;
RecordNavigator rn2 = (RecordNavigator)session.getAttribute(navigator2);
boolean isPermanentTable = rn2.m_isPermanentTable;
String tableName = rn2.m_tableName;

String successMessageForwarded = "Forwarded to your Senior Office";
String successMessageApproved = "Approval Done";

Applicant_profileDAO applicant_profileDAO = (Applicant_profileDAO)request.getAttribute("applicant_profileDAO");
TempTableDTO tempTableDTO = null;
if(!isPermanentTable)
{
	tempTableDTO = applicant_profileDAO.getTempTableDTOFromTableById(tableName, row.iD);
}



											
		
											
											out.println("<td id = '" + i + "_applicantType'>");
											value = row.serviceType + "";
											
											value = CommonDAO.getName(Integer.parseInt(value), "applicant", Language.equals("English")?"name_en":"name_bn", "id");
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_serviceId'>");
											value = row.serviceId + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_serviceType'>");
											value = row.serviceType + "";
											
											value = CommonDAO.getName(Integer.parseInt(value), "service", Language.equals("English")?"name_en":"name_bn", "id");
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_chiefShareholderInfo'>");
											value = row.chiefShareholderInfo + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_name'>");
											value = row.name + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_fatherName'>");
											value = row.fatherName + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_husbandName'>");
											value = row.husbandName + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_addressPresent'>");
											value = row.addressPresent + "";
											out.println(GeoLocationDAO2.parseText(value));
											{
												String addressdetails = GeoLocationDAO2.parseDetails(value);
												if(!addressdetails.equals(""))
												{
													out.println(", " + addressdetails);
												}
											}
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_addressPermanent'>");
											value = row.addressPermanent + "";
											out.println(GeoLocationDAO2.parseText(value));
											{
												String addressdetails = GeoLocationDAO2.parseDetails(value);
												if(!addressdetails.equals(""))
												{
													out.println(", " + addressdetails);
												}
											}
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_nameBn'>");
											value = row.nameBn + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_fatherNameBn'>");
											value = row.fatherNameBn + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_husbandNameBn'>");
											value = row.husbandNameBn + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_addressPresentBn'>");
											value = row.addressPresentBn + "";
											out.println(GeoLocationDAO2.parseText(value));
											{
												String addressdetails = GeoLocationDAO2.parseDetails(value);
												if(!addressdetails.equals(""))
												{
													out.println(", " + addressdetails);
												}
											}
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_addressPermanentBn'>");
											value = row.addressPermanentBn + "";
											out.println(GeoLocationDAO2.parseText(value));
											{
												String addressdetails = GeoLocationDAO2.parseDetails(value);
												if(!addressdetails.equals(""))
												{
													out.println(", " + addressdetails);
												}
											}
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_nationality'>");
											value = row.nationality + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_age'>");
											value = row.age + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_gender'>");
											value = row.gender + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_nid'>");
											value = row.nid + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_capital'>");
											value = row.capital + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_previous'>");
											value = row.previous + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_bankSolvency'>");
											value = row.bankSolvency + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
											out.println("<td id = '" + i + "_picture'>");
											value = row.picture + "";
														
											out.println(value);
				
			
											out.println("</td>");
		
											
		
											
		
	

	
											out.println("<td id = '" + i + "_Edit'>");
											if(isPermanentTable || (!isPermanentTable && userDTO.approvalRole == SessionConstants.VALIDATOR && userDTO.approvalOrder == tempTableDTO.approval_order))
											{
																							
	
												out.println("<a href='Applicant_profileServlet?actionType=getEditPage&ID=" +row.iD + "'>" + LM.getText(LC.APPLICANT_PROFILE_SEARCH_APPLICANT_PROFILE_EDIT_BUTTON, loginDTO) + "</a>");
																						
											}
											out.println("</td>");
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
												out.println("<td id = 'tdapprove_" + row.iD + "'>");
												if(userDTO.approvalOrder == tempTableDTO.approval_order)
												{
													String onclickFunc = "\"approve('" + row.iD + "' , '" + Successmessage + "' , " + i + ", 'Applicant_profileServlet')\"";	
													out.println("<a id = 'approve_" + row.iD + "' onclick=" + onclickFunc + "><%=LM.getText(LC.HM_APPROVE, loginDTO)%></a>");
												}
												else if(userDTO.approvalOrder > tempTableDTO.approval_order)
												{
													out.println("You cannot approve it yet");
												}
												else
												{
													if(userDTO.approvalOrder < userDTO.maxApprovalOrder)
													{
														out.println(Successmessage);
													}
													
												}
												out.println("</td>");
												
												
												out.println("<td id = 'tdoperation_" + row.iD + "'>");
												out.println(SessionConstants.operation_names[tempTableDTO.operation_type]);
												out.println("</td>");
												
												out.println("<td id = 'original_" + row.iD + "'>");
												if(tempTableDTO.operation_type == SessionConstants.UPDATE)
												{
													String onclickFunc = "\"getOriginal(" + i + ", " + row.iD + " , " + tempTableDTO.permanent_table_id + ", " + " 'Applicant_profileServlet')\"";
													out.println("<a id = '" + i + "_getOriginal' onclick=" + onclickFunc + ">View Original</a>");
													out.println("<input type='hidden' id='" + i + "_original_status' value='0'/>");
												}
												out.println("</td>");
											}		
											
											
											out.println("<td id='" + i + "_link'>");
											
											if(row.serviceType == util.CommonConstant.SERVICE_TYPE_EXPLORATION)
											{
												out.println("<a href='InboxDetailsServlet?actionType=ExplorationApplicantDetails&id=" +row.iD + "'>" + LM.getText(LC.APPLICANT_PROFILE_SEARCH_VIEW, loginDTO) + "</a>");
												
											}
											else if(row.serviceType == util.CommonConstant.SERVICE_TYPE_MINE)
											{
												out.println("<a href='InboxDetailsServlet?actionType=MineApplicantDetails&id=" +row.iD + "'>" + LM.getText(LC.APPLICANT_PROFILE_SEARCH_VIEW, loginDTO) + "</a>");
												
											}
											else if(row.serviceType == util.CommonConstant.SERVICE_TYPE_PUBLIC_QUARRY)
											{
												out.println("<a href='InboxDetailsServlet?actionType=PublicQuarryApplicantDetails&id=" +row.iD + "'>" + LM.getText(LC.APPLICANT_PROFILE_SEARCH_VIEW, loginDTO) + "</a>");
												
											}
											else if(row.serviceType == util.CommonConstant.SERVICE_TYPE_PRIVATE_QUARRY)
											{
												out.println("<a href='InboxDetailsServlet?actionType=PrivateQuarryApplicantDetails&id=" +row.iD + "'>" + LM.getText(LC.APPLICANT_PROFILE_SEARCH_VIEW, loginDTO) + "</a>");
												
											}
											
											
											
										
										
										out.println("</td>");
											
											out.println("<td id='" + i + "_checkbox'>");
											if(isPermanentTable || (!isPermanentTable && userDTO.approvalOrder == tempTableDTO.approval_order))
											{
												out.println("<div class='checker'>");
												out.println("<span id='chkEdit' ><input type='checkbox' name='ID' value='" + row.iD + "'/></span>");
												out.println("</div");
											}
											out.println("</td>");%>

