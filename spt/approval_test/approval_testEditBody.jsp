
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="login.LoginDTO"%>

<%@page import="approval_test.*"%>
<%@page import="java.util.*"%>

<%@page pageEncoding="UTF-8" %>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.util.UUID"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>

<%@page import="geolocation.GeoLocationDAO2"%>
<%@page import="files.*"%>
<%@page import="dbm.*" %>
<%@ page import="approval_execution_table.*"%>
<%@ page import="approval_path.*"%>
<%@ page import="user.*"%>

<%@page import="workflow.*"%>


<%
Approval_testDTO approval_testDTO;
approval_testDTO = (Approval_testDTO)request.getAttribute("approval_testDTO");
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);
if(approval_testDTO == null)
{
	approval_testDTO = new Approval_testDTO();
	
}
System.out.println("approval_testDTO = " + approval_testDTO);

String actionName;
System.out.println("actionType = " + request.getParameter("actionType"));
if (request.getParameter("actionType").equalsIgnoreCase("getAddPage"))
{
	actionName = "add";
}
else
{
	actionName = "edit";
}
String formTitle;
if(actionName.equals("edit"))
{
	formTitle = LM.getText(LC.APPROVAL_TEST_EDIT_APPROVAL_TEST_EDIT_FORMNAME, loginDTO);
}
else
{
	formTitle = LM.getText(LC.APPROVAL_TEST_ADD_APPROVAL_TEST_ADD_FORMNAME, loginDTO);
}

String ID = request.getParameter("ID");
if(ID == null || ID.isEmpty())
{
	ID = "0";
}
System.out.println("ID = " + ID);
int i = 0;

String value = "";

int childTableStartingID = 1;

long ColumnID;
FilesDAO filesDAO = new FilesDAO();
boolean isPermanentTable = true;
if(request.getParameter("isPermanentTable") != null)
{
	isPermanentTable = Boolean.parseBoolean(request.getParameter("isPermanentTable"));
}

Approval_execution_tableDAO approval_execution_tableDAO = new Approval_execution_tableDAO();
ApprovalPathDetailsDAO approvalPathDetailsDAO = new ApprovalPathDetailsDAO();
Approval_execution_tableDTO approval_execution_tableDTO = null;
Approval_execution_tableDTO approval_execution_table_initiationDTO = null;
ApprovalPathDetailsDTO approvalPathDetailsDTO =  null;

String tableName = "approval_test";

boolean canApprove = false, canValidate = false, isInitiator = false, canTerminate = false;

if(!isPermanentTable)
{
	approval_execution_tableDTO = (Approval_execution_tableDTO)approval_execution_tableDAO.getMostRecentDTOByUpdatedRowId("approval_test", approval_testDTO.iD);
	System.out.println("approval_execution_tableDTO = " + approval_execution_tableDTO);
	approvalPathDetailsDTO = approvalPathDetailsDAO.getApprovalPathDetailsDTOListByApprovalPathIDandApprovalOrder(approval_execution_tableDTO.approvalPathId, (int)approval_execution_tableDTO.approvalPathOrder);
	approval_execution_table_initiationDTO = (Approval_execution_tableDTO)approval_execution_tableDAO.getInitiationDTOByUpdatedRowId("approval_test", approval_testDTO.iD);
	if(approvalPathDetailsDTO!= null && approvalPathDetailsDTO.organogramId == userDTO.organogramID)
	{
		canApprove = true;
		if(approvalPathDetailsDTO.approvalRoleCat == SessionConstants.VALIDATOR)
		{
			canValidate = true;
		}
	}
	
	isInitiator = WorkflowController.isInitiator(tableName, approval_execution_tableDTO.previousRowId, userDTO.organogramID);
	
	canTerminate = isInitiator && approval_testDTO.isDeleted == 2;
}
%>



<div class="box box-primary">
	<div class="box-header with-border">
		<h3 class="box-title"><i class="fa fa-gift"></i><%=formTitle%></h3>
	</div>
	<div class="box-body">
		<form class="form-horizontal" action="Approval_testServlet?actionType=<%=actionName%>&isPermanentTable=<%=isPermanentTable%>"
		id="bigform" name="bigform"  method="POST" enctype = "multipart/form-data"
		onsubmit="return PreprocessBeforeSubmiting(0,'<%=actionName%>')">
			<div class="form-body">
				
				
				




























	















<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ page import="pb.*"%>

<%
String Language = LM.getText(LC.APPROVAL_TEST_EDIT_LANGUAGE, loginDTO);
String Options;
SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
Date date = new Date();
String datestr = dateFormat.format(date);
%>


		<input type='hidden' class='form-control'  name='iD' id = 'iD_hidden_<%=i%>' value='<%=approval_testDTO.iD%>' tag='pb_html'/>
	
												
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_TEST_EDIT_DESCRIPTION, loginDTO)):(LM.getText(LC.APPROVAL_TEST_ADD_DESCRIPTION, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'description_div_<%=i%>'>	
		<input type='text' class='form-control'  name='description' id = 'description_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_testDTO.description + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				

		<input type='hidden' class='form-control'  name='jobCat' id = 'jobCat_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_testDTO.jobCat + "'"):("'" + "-1" + "'")%> tag='pb_html'/>
												

		<input type='hidden' class='form-control'  name='isDeleted' id = 'isDeleted_hidden_<%=i%>' value= <%=actionName.equals("edit")?("'" + approval_testDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
												

		<input type='hidden' class='form-control'  name='lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_testDTO.lastModificationTime + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
					
	





				<div class="col-md-12" style="padding-top: 20px;">
					<legend class="text-left content_legend"><%=LM.getText(LC.APPROVAL_TEST_ADD_APPROVAL_TEST_BABY, loginDTO)%></legend>
				</div>

				<div class="col-md-12">

					<div class="table-responsive">
						<table class="table table-bordered table-striped">
								<thead>
									<tr>
										<th><%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_TEST_EDIT_APPROVAL_TEST_BABY_INSCRIPTION, loginDTO)):(LM.getText(LC.APPROVAL_TEST_ADD_APPROVAL_TEST_BABY_INSCRIPTION, loginDTO))%></th>
										<th><%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_TEST_EDIT_APPROVAL_TEST_BABY_ANUMBER, loginDTO)):(LM.getText(LC.APPROVAL_TEST_ADD_APPROVAL_TEST_BABY_ANUMBER, loginDTO))%></th>
										<th><%=LM.getText(LC.APPROVAL_TEST_ADD_APPROVAL_TEST_BABY_REMOVE, loginDTO)%></th>
									</tr>
								</thead>
								<tbody id="field-ApprovalTestBaby">
						
						
<%
	if(actionName.equals("edit")){
		int index = -1;
		
		
		for(ApprovalTestBabyDTO approvalTestBabyDTO: approval_testDTO.approvalTestBabyDTOList)
		{
			index++;
			
			System.out.println("index index = "+index);

%>	
							
									<tr>
										<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalTestBaby.iD' id = 'iD_hidden_<%=childTableStartingID%>' value='<%=approvalTestBabyDTO.iD%>' tag='pb_html'/>
	
										</td>
										<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalTestBaby.approvalTestId' id = 'approvalTestId_hidden_<%=childTableStartingID%>' value=<%=actionName.equals("edit")?("'" + approvalTestBabyDTO.approvalTestId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
										</td>
										<td>										











		<input type='text' class='form-control'  name='approvalTestBaby.inscription' id = 'inscription_text_<%=childTableStartingID%>' value=<%=actionName.equals("edit")?("'" + approvalTestBabyDTO.inscription + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
										</td>
										<td>										











		<input type='number' class='form-control'  name='approvalTestBaby.aNumber' id = 'aNumber_number_<%=childTableStartingID%>' min='0' max='1000000' value=<%=actionName.equals("edit")?("'" + approvalTestBabyDTO.aNumber + "'"):("'" + 0 + "'")%>  tag='pb_html'>
						
										</td>
										<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalTestBaby.isDeleted' id = 'isDeleted_hidden_<%=childTableStartingID%>' value= <%=actionName.equals("edit")?("'" + approvalTestBabyDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
										</td>
										<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalTestBaby.lastModificationTime' id = 'lastModificationTime_hidden_<%=childTableStartingID%>' value=<%=actionName.equals("edit")?("'" + approvalTestBabyDTO.lastModificationTime + "'"):("'" + "0" + "'")%> tag='pb_html'/>
										</td>
										<td><div class='checker'><span id='chkEdit' ><input type='checkbox' id='approvalTestBaby_cb_<%=index%>' name='checkbox' value=''/></span></div></td>
									</tr>								
<%	
			childTableStartingID ++;
		}
	}
%>						
						
								</tbody>
							</table>
						
						
						
					</div>
					<div class="form-group">
						<div class="col-xs-9 text-right">

							<button id="remove-ApprovalTestBaby" name="removeApprovalTestBaby" type="button"
									class="btn btn-danger remove-me1"><%=LM.getText(LC.APPROVAL_TEST_ADD_APPROVAL_TEST_BABY_REMOVE, loginDTO)%></button>

							<button id="add-more-ApprovalTestBaby" name="add-moreApprovalTestBaby" type="button"
									class="btn btn-primary"><%=LM.getText(LC.APPROVAL_TEST_ADD_APPROVAL_TEST_BABY_ADD_MORE, loginDTO)%></button>

						</div>
					</div>
					
					<%ApprovalTestBabyDTO approvalTestBabyDTO = new ApprovalTestBabyDTO();%>
					
					<template id="template-ApprovalTestBaby" >						
								<tr>
									<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalTestBaby.iD' id = 'iD_hidden_' value='<%=approvalTestBabyDTO.iD%>' tag='pb_html'/>
	
									</td>
									<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalTestBaby.approvalTestId' id = 'approvalTestId_hidden_' value=<%=actionName.equals("edit")?("'" + approvalTestBabyDTO.approvalTestId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
									</td>
									<td>











		<input type='text' class='form-control'  name='approvalTestBaby.inscription' id = 'inscription_text_' value=<%=actionName.equals("edit")?("'" + approvalTestBabyDTO.inscription + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
									</td>
									<td>











		<input type='number' class='form-control'  name='approvalTestBaby.aNumber' id = 'aNumber_number_' min='0' max='1000000' value=<%=actionName.equals("edit")?("'" + approvalTestBabyDTO.aNumber + "'"):("'" + 0 + "'")%>  tag='pb_html'>
						
									</td>
									<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalTestBaby.isDeleted' id = 'isDeleted_hidden_' value= <%=actionName.equals("edit")?("'" + approvalTestBabyDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
									</td>
									<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalTestBaby.lastModificationTime' id = 'lastModificationTime_hidden_' value=<%=actionName.equals("edit")?("'" + approvalTestBabyDTO.lastModificationTime + "'"):("'" + "0" + "'")%> tag='pb_html'/>
									</td>
									<td><div><span id='chkEdit' ><input type='checkbox' name='checkbox' value=''/></span></div></td>
								</tr>								
						
					</template>
				</div>		

				<%if(canValidate)
				{
				%>	
				<div class="row div_border attachement-div">
							<div class="col-md-12">
								<h5><%=LM.getText(LC.HM_ATTACHMENTS, loginDTO )%></h5>
								<%
									ColumnID = DBMW.getInstance().getNextSequenceId("fileid");
								%>
								<div class="dropzone"
									 action="Approval_execution_tableServlet?pageType=add&actionType=UploadFilesFromDropZone&columnName=approval_attached_fileDropzone&ColumnID=<%=ColumnID%>">
									<input type='file' style="display: none"
										   name='approval_attached_fileDropzoneFile'
										   id='approval_attached_fileDropzone_dropzone_File_<%=i%>'
										   tag='pb_html' />
								</div>
								<input type='hidden'
									   name='approval_attached_fileDropzoneFilesToDelete'
									   id='approval_attached_fileDropzoneFilesToDelete_<%=i%>' value=''
									   tag='pb_html' /> <input type='hidden'
															   name='approval_attached_fileDropzone'
															   id='approval_attached_fileDropzone_dropzone_<%=i%>' tag='pb_html'
															   value='<%=ColumnID%>' />
							</div>
				
							<div class="col-md-12">
								<h5><%=LM.getText(LC.HM_REMARKS, loginDTO )%></h5>
				
								<textarea class='form-control'  name='remarks' id = '<%=i%>_remarks'   tag='pb_html'></textarea>
							</div>
						</div>
				<%
				}
				%>
				<div class="form-actions text-center">
					<a class="btn btn-danger" href="<%=request.getHeader("referer")%>">
					<%
					if(actionName.equals("edit"))
					{
						%>
						<%=LM.getText(LC.APPROVAL_TEST_EDIT_APPROVAL_TEST_CANCEL_BUTTON, loginDTO)%>
						<%
					}
					else
					{
						%>
						<%=LM.getText(LC.APPROVAL_TEST_ADD_APPROVAL_TEST_CANCEL_BUTTON, loginDTO)%>
						<%
					}
					
					%>
					</a>
					<button class="btn btn-success" type="submit">
					<%
					if(actionName.equals("edit"))
					{
						%>
						<%=LM.getText(LC.APPROVAL_TEST_EDIT_APPROVAL_TEST_SUBMIT_BUTTON, loginDTO)%>
						<%
					}
					else
					{
						%>
						<%=LM.getText(LC.APPROVAL_TEST_ADD_APPROVAL_TEST_SUBMIT_BUTTON, loginDTO)%>
						<%
					}
					%>
					</button>
				</div>
							
			</div>
		
		</form>

	</div>
</div>
<script src="nicEdit.js" type="text/javascript"></script>
<script type="text/javascript">




function PreprocessBeforeSubmiting(row, validate)
{
	if(validate == "report")
	{
	}
	else
	{
		var empty_fields = "";
		var i = 0;


		if(empty_fields != "")
		{
			if(validate == "inplaceedit")
			{
				$('<input type="submit">').hide().appendTo($('#tableForm')).click().remove(); 
				return false;
			}
		}

	}


	for(i = 1; i < child_table_extra_id; i ++)
	{
	}
	return true;
}


function addrselected(value, htmlID, selectedIndex, tagname,  fieldName, row)
{	
	addrselectedFunc(value, htmlID, selectedIndex, tagname,  fieldName, row, false, "Approval_testServlet");	
}

function init(row)
{


	for(i = 1; i < child_table_extra_id; i ++)
	{
	}
	
}

var row = 0;
	
window.onload =function ()
{
	init(row);
	CKEDITOR.replaceAll();
}

var child_table_extra_id = <%=childTableStartingID%>;

	$("#add-more-ApprovalTestBaby").click(
        function(e) 
		{
            e.preventDefault();
            var t = $("#template-ApprovalTestBaby");

            $("#field-ApprovalTestBaby").append(t.html());
			SetCheckBoxValues("field-ApprovalTestBaby");
			
			var tr = $("#field-ApprovalTestBaby").find("tr:last-child");
			
			tr.attr("id","ApprovalTestBaby_" + child_table_extra_id);
			
			tr.find("[tag='pb_html']").each(function( index ) 
			{
				var prev_id = $( this ).attr('id');
				$( this ).attr('id', prev_id + child_table_extra_id);
				console.log( index + ": " + $( this ).attr('id') );
			});
			
			
			child_table_extra_id ++;

        });

    
      $("#remove-ApprovalTestBaby").click(function(e){    	
	    var tablename = 'field-ApprovalTestBaby';
	    var i = 0;
		console.log("document.getElementById(tablename).childNodes.length = " + document.getElementById(tablename).childNodes.length);
		var element = document.getElementById(tablename);

		var j = 0;
		for(i = document.getElementById(tablename).childNodes.length - 1; i >= 0 ; i --)
		{
			var tr = document.getElementById(tablename).childNodes[i];
			if(tr.nodeType === Node.ELEMENT_NODE)
			{
				console.log("tr.childNodes.length= " + tr.childNodes.length);
				var checkbox = tr.querySelector('input[type="checkbox"]');				
				if(checkbox.checked == true)
				{
					tr.remove();
				}
				j ++;
			}
			
		}    	
    });


</script>






