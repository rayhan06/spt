<%@page pageEncoding="UTF-8" %>

<%@page import="address_book.*"%>
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
<%@page import="dbm.*" %>
<%@page import="util.*" %>
<%
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
String Language = LM.getText(LC.ADDRESS_BOOK_EDIT_LANGUAGE, loginDTO);
String Language2 = Language;

UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);


String navigator2 = SessionConstants.NAV_ADDRESS_BOOK;
RecordNavigator rn2 = (RecordNavigator)session.getAttribute(navigator2);
boolean isPermanentTable = rn2.m_isPermanentTable;
String tableName = rn2.m_tableName;

System.out.println("isPermanentTable = " + isPermanentTable);
Address_bookDTO address_bookDTO = (Address_bookDTO)request.getAttribute("address_bookDTO");
CommonDTO commonDTO = address_bookDTO;
String servletName = "Address_bookServlet";


System.out.println("address_bookDTO = " + address_bookDTO);


int i = Integer.parseInt(request.getParameter("rownum"));
out.println("<td style='display:none;'><input type='hidden' id='failureMessage_" + i + "' value=''/></td>");

String value = "";


Address_bookDAO address_bookDAO = (Address_bookDAO)request.getAttribute("address_bookDAO");


String Options = "";
boolean formSubmit = false;
SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy");

%>

											
		
											
											<td id = '<%=i%>_nameEn'>
											<%
											value = address_bookDTO.nameEn + "";
											%>
														
											<%=value%>
				
			
											</td>
		
											
											<td id = '<%=i%>_nameBn'>
											<%
											value = address_bookDTO.nameBn + "";
											%>
														
											<%=value%>
				
			
											</td>
											
		
											
		
	

											<td>
												<a href='Address_bookServlet?actionType=view&ID=<%=address_bookDTO.iD%>'>View</a>
											
											</td>
	
											<td id = '<%=i%>_Edit'>																																	
	
												<a href='Address_bookServlet?actionType=getEditPage&ID=<%=address_bookDTO.iD%>'><%=LM.getText(LC.ADDRESS_BOOK_SEARCH_ADDRESS_BOOK_EDIT_BUTTON, loginDTO)%></a>
																				
											</td>											
											
											
											<td id='<%=i%>_checkbox'>
												<div class='checker'>
													<span id='chkEdit' ><input type='checkbox' name='ID' value='<%=address_bookDTO.iD%>'/></span>
												</div>
											</td>
																						
											

