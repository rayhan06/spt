

<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="address_book.*"%>
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
String Language = LM.getText(LC.ADDRESS_BOOK_EDIT_LANGUAGE, loginDTO);

String ID = request.getParameter("ID");
if(ID == null || ID.isEmpty())
{
	ID = "0";
}
long id = Long.parseLong(ID);
System.out.println("ID = " + ID);
Address_bookDAO address_bookDAO = new Address_bookDAO("address_book");
Address_bookDTO address_bookDTO = (Address_bookDTO)address_bookDAO.getDTOByID(id);
String Value = "";
int i = 0;
FilesDAO filesDAO = new FilesDAO();
SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-yyyy");
%>


<div class="modal-content viewmodal">
            <div class="modal-header">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-9 col-sm-12">
                            <h5 class="modal-title">Address Book Details</h5>
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
                        <h5>Address Book</h5>
                    </div>
			



			

                    <div class="col-md-6">
                        <label class="col-md-5" style="padding-right: 0px;"><b><span><%=LM.getText(LC.ADDRESS_BOOK_EDIT_NAMEEN, loginDTO)%></span><span style="float:right;">:</span></b></label>
                        <label id="nameEn">
						
											<%
											value = address_bookDTO.nameEn + "";
											%>
														
											<%=value%>
				
			
						
                        </label>
                    </div>

				


			

                    <div class="col-md-6">
                        <label class="col-md-5" style="padding-right: 0px;"><b><span><%=LM.getText(LC.ADDRESS_BOOK_EDIT_NAMEBN, loginDTO)%></span><span style="float:right;">:</span></b></label>
                        <label id="nameBn">
						
											<%
											value = address_bookDTO.nameBn + "";
											%>
														
											<%=value%>
				
			
						
                        </label>
                    </div>

				





			</div>	

                <div class="row div_border attachement-div">
                    <div class="col-md-12">
                        <h5>Address Book Detail</h5>
						<table class="table table-bordered table-striped">
							<tr>
								<th><%=(actionName.equals("edit"))?(LM.getText(LC.ADDRESS_BOOK_EDIT_ADDRESS_BOOK_DETAIL_EMPLOYEEDESIGNATION, loginDTO)):(LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_DETAIL_EMPLOYEEDESIGNATION, loginDTO))%></th>
								<th><%=(actionName.equals("edit"))?(LM.getText(LC.ADDRESS_BOOK_EDIT_ADDRESS_BOOK_DETAIL_EMPLOYEEOFFICEUNIT, loginDTO)):(LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_DETAIL_EMPLOYEEOFFICEUNIT, loginDTO))%></th>
								<th><%=(actionName.equals("edit"))?(LM.getText(LC.ADDRESS_BOOK_EDIT_ADDRESS_BOOK_DETAIL_EMPLOYEEEMAIL, loginDTO)):(LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_DETAIL_EMPLOYEEEMAIL, loginDTO))%></th>
								<th><%=(actionName.equals("edit"))?(LM.getText(LC.ADDRESS_BOOK_EDIT_ADDRESS_BOOK_DETAIL_NAME, loginDTO)):(LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_DETAIL_NAME, loginDTO))%></th>
								<th><%=(actionName.equals("edit"))?(LM.getText(LC.ADDRESS_BOOK_EDIT_ADDRESS_BOOK_DETAIL_PHONENUMBER, loginDTO)):(LM.getText(LC.ADDRESS_BOOK_ADD_ADDRESS_BOOK_DETAIL_PHONENUMBER, loginDTO))%></th>
							</tr>
							<%
                        	AddressBookDetailDAO addressBookDetailDAO = new AddressBookDetailDAO();
                         	List<AddressBookDetailDTO> addressBookDetailDTOs = addressBookDetailDAO.getAddressBookDetailDTOListByAddressBookID(address_bookDTO.iD);
                         	
                         	for(AddressBookDetailDTO addressBookDetailDTO: addressBookDetailDTOs)
                         	{
                         		%>
                         			<tr>
										<td>
											<%
											value = addressBookDetailDTO.employeeDesignation + "";
											%>
														
											<%=value%>
				
			
										</td>
										<td>
											<%
											value = addressBookDetailDTO.employeeOfficeUnit + "";
											%>
														
											<%=value%>
				
			
										</td>
										<td>
											<%
											value = addressBookDetailDTO.employeeEmail + "";
											%>
														
											<%=value%>
				
			
										</td>
										<td>
											<%
											value = addressBookDetailDTO.name + "";
											%>
														
											<%=value%>
				
			
										</td>
										<td>
											<%
											value = addressBookDetailDTO.phoneNumber + "";
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