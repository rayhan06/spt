<%@page pageEncoding="UTF-8" %>

<%@page import="sessionmanager.SessionConstants"%>
<%@page import="address_book.Address_bookDTO"%>
<%@page import="java.util.*"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>

<%
Address_bookDTO address_bookDTO = (Address_bookDTO)request.getAttribute("address_bookDTO");
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);

if(address_bookDTO == null)
{
	address_bookDTO = new Address_bookDTO();
	
}
System.out.println("address_bookDTO = " + address_bookDTO);

String actionName = "edit";


String ID = request.getParameter("ID");
if(ID == null || ID.isEmpty())
{
	ID = "0";
}
System.out.println("ID = " + ID);
int i = Integer.parseInt(request.getParameter("rownum"));
String deletedStyle = request.getParameter("deletedstyle");

String value = "";

%>




























	















<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ page import="pb.*"%>

<%
String Language = LM.getText(LC.ADDRESS_BOOK_EDIT_LANGUAGE, loginDTO);
String Options;
SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
Date date = new Date();
String datestr = dateFormat.format(date);
%>

			
<%=("<td id = '" + i + "_iD" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='iD' id = 'iD_hidden_<%=i%>' value='<%=address_bookDTO.iD%>' tag='pb_html'/>
	
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_nameEn'>")%>
			
	
	<div class="form-inline" id = 'nameEn_div_<%=i%>'>
		<input type='text' class='form-control'  name='nameEn' id = 'nameEn_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + address_bookDTO.nameEn + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_nameBn'>")%>
			
	
	<div class="form-inline" id = 'nameBn_div_<%=i%>'>
		<input type='text' class='form-control'  name='nameBn' id = 'nameBn_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + address_bookDTO.nameBn + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_createdBy'>")%>
			
	
	<div class="form-inline" id = 'createdBy_div_<%=i%>'>
		<input type='text' class='form-control'  name='createdBy' id = 'createdBy_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + address_bookDTO.createdBy + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_isDeleted" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='isDeleted' id = 'isDeleted_hidden_<%=i%>' value= <%=actionName.equals("edit")?("'" + address_bookDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_lastModificationTime" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>' value='<%=address_bookDTO.lastModificationTime%>' tag='pb_html'/>
		
												
<%=("</td>")%>
					
	
											<td>
												<a href='Address_bookServlet?actionType=view&ID=<%=address_bookDTO.iD%>'>View</a>
												
												<a href='#' data-toggle='modal' data-target='#viedFileModal_<%=i%>'>Modal</a>
												
												<div class='modal fade' id='viedFileModal_<%=i%>'>
												  <div class='modal-dialog modal-lg' role='document'>
													<div class='modal-content'>
													  <div class='modal-body'>
														<button type='button' class='close' data-dismiss='modal' aria-label='Close'>
														  <span aria-hidden='true'>&times;</span>
														</button>											        
														
														<object type='text/html' data='Address_bookServlet?actionType=view&modal=1&ID=<%=address_bookDTO.iD%>' width='100%' height='500' style='height: 85vh;'>No Support</object>
														
													  </div>
													</div>
												  </div>
												</div>
											</td>

	