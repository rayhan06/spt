
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="login.LoginDTO"%>

<%@page import="approval_execution_table.*"%>
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


<%
Approval_execution_tableDTO approval_execution_tableDTO;
approval_execution_tableDTO = (Approval_execution_tableDTO)request.getAttribute("approval_execution_tableDTO");
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
if(approval_execution_tableDTO == null)
{
	approval_execution_tableDTO = new Approval_execution_tableDTO();
	
}
System.out.println("approval_execution_tableDTO = " + approval_execution_tableDTO);

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
	formTitle = LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_APPROVAL_EXECUTION_TABLE_EDIT_FORMNAME, loginDTO);
}
else
{
	formTitle = LM.getText(LC.APPROVAL_EXECUTION_TABLE_ADD_APPROVAL_EXECUTION_TABLE_ADD_FORMNAME, loginDTO);
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
%>



<div class="box box-primary">
	<div class="box-header with-border">
		<h3 class="box-title"><i class="fa fa-gift"></i><%=formTitle%></h3>
	</div>
	<div class="box-body">
		<form class="form-horizontal" action="Approval_execution_tableServlet?actionType=<%=actionName%>&identity=<%=ID%>"
		id="bigform" name="bigform"  method="POST" enctype = "multipart/form-data"
		onsubmit="return PreprocessBeforeSubmiting(0,'<%=actionName%>')">
			<div class="form-body">
				
				
				




























	















<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ page import="pb.*"%>

<%
String Language = LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_LANGUAGE, loginDTO);
String Options;
SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
Date date = new Date();
String datestr = dateFormat.format(date);
%>


		<input type='hidden' class='form-control'  name='iD' id = 'iD_hidden_<%=i%>' value='<%=approval_execution_tableDTO.iD%>' tag='pb_html'/>
	
												
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_TABLENAME, loginDTO)):(LM.getText(LC.APPROVAL_EXECUTION_TABLE_ADD_TABLENAME, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'tableName_div_<%=i%>'>	
		<input type='text' class='form-control'  name='tableName' id = 'tableName_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.tableName + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				

		<input type='hidden' class='form-control'  name='previousRowId' id = 'previousRowId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.previousRowId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												

		<input type='hidden' class='form-control'  name='updatedRowId' id = 'updatedRowId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.updatedRowId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_OPERATION, loginDTO)):(LM.getText(LC.APPROVAL_EXECUTION_TABLE_ADD_OPERATION, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'operation_div_<%=i%>'>	
		<input type='text' class='form-control'  name='operation' id = 'operation_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.operation + "'"):("'" + "0" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_ACTION, loginDTO)):(LM.getText(LC.APPROVAL_EXECUTION_TABLE_ADD_ACTION, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'action_div_<%=i%>'>	
		<input type='text' class='form-control'  name='action' id = 'action_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.action + "'"):("'" + "0" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_APPROVALSTATUSCAT, loginDTO)):(LM.getText(LC.APPROVAL_EXECUTION_TABLE_ADD_APPROVALSTATUSCAT, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'approvalStatusCat_div_<%=i%>'>	
		<select class='form-control'  name='approvalStatusCat' id = 'approvalStatusCat_category_<%=i%>'   tag='pb_html'>		
<%
if(actionName.equals("edit"))
{
			Options = CatDAO.getOptions(Language, "approval_status", approval_execution_tableDTO.approvalStatusCat);
}
else
{			
			Options = CatDAO.getOptions(Language, "approval_status", -1);			
}
%>
<%=Options%>
		</select>
		
	</div>
</div>			
				

		<input type='hidden' class='form-control'  name='userId' id = 'userId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.userId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_USERIP, loginDTO)):(LM.getText(LC.APPROVAL_EXECUTION_TABLE_ADD_USERIP, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'userIp_div_<%=i%>'>	
		<input type='text' class='form-control'  name='userIp' id = 'userIp_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.userIp + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				

		<input type='hidden' class='form-control'  name='approvalPathId' id = 'approvalPathId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.approvalPathId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_APPROVALPATHORDER, loginDTO)):(LM.getText(LC.APPROVAL_EXECUTION_TABLE_ADD_APPROVALPATHORDER, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'approvalPathOrder_div_<%=i%>'>	
		<input type='text' class='form-control'  name='approvalPathOrder' id = 'approvalPathOrder_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.approvalPathOrder + "'"):("'" + "0" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_REMARKS, loginDTO)):(LM.getText(LC.APPROVAL_EXECUTION_TABLE_ADD_REMARKS, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'remarks_div_<%=i%>'>	
		<input type='text' class='form-control'  name='remarks' id = 'remarks_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.remarks + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_FILEDROPZONE, loginDTO)):(LM.getText(LC.APPROVAL_EXECUTION_TABLE_ADD_FILEDROPZONE, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'fileDropzone_div_<%=i%>'>	
		<%
		if(actionName.equals("edit"))
		{
			List<FilesDTO> fileDropzoneDTOList = filesDAO.getMiniDTOsByFileID(approval_execution_tableDTO.fileDropzone);
			%>			
			<table>
				<tr>
			<%
			if(fileDropzoneDTOList != null)
			{
				for(int j = 0; j < fileDropzoneDTOList.size(); j ++)
				{
					FilesDTO filesDTO = fileDropzoneDTOList.get(j);
					byte[] encodeBase64 = org.apache.commons.codec.binary.Base64.encodeBase64(filesDTO.thumbnailBlob);
					%>
					<td id = 'fileDropzone_td_<%=filesDTO.iD%>'>
					<%
					if(filesDTO.fileTypes.contains("image") && encodeBase64!= null)
					{
						%>
						<img src='data:<%=filesDTO.fileTypes%>;base64,<%=new String(encodeBase64) 
						%>' style='width:100px' />
						<%
					}
					%>
					<a href = 'Approval_execution_tableServlet?actionType=downloadDropzoneFile&id=<%=filesDTO.iD%>' download><%=filesDTO.fileTitle%></a>
					<a class='btn btn-danger' onclick='deletefile(<%=filesDTO.iD%>, "fileDropzone_td_<%=filesDTO.iD%>", "fileDropzoneFilesToDelete_<%=i%>")'>x</a>		
					</td>
					<%
				}
			}
			%>
			</tr>
			</table>
			<%
		}
		%>
		
		<%ColumnID = DBMW.getInstance().getNextSequenceId("fileid"); %>			
		<div class="dropzone" action="Approval_execution_tableServlet?pageType=<%=actionName%>&actionType=UploadFilesFromDropZone&columnName=fileDropzone&ColumnID=<%=actionName.equals("edit")?approval_execution_tableDTO.fileDropzone:ColumnID%>">
			<input type='file' style="display:none"  name='fileDropzoneFile' id = 'fileDropzone_dropzone_File_<%=i%>'  tag='pb_html'/>			
		</div>								
		<input type='hidden'  name='fileDropzoneFilesToDelete' id = 'fileDropzoneFilesToDelete_<%=i%>' value=''  tag='pb_html'/>
		<input type='hidden' name='fileDropzone' id = 'fileDropzone_dropzone_<%=i%>'  tag='pb_html' value='<%=ColumnID%>'/>		


	</div>
</div>			
				

		<input type='hidden' class='form-control'  name='isDeleted' id = 'isDeleted_hidden_<%=i%>' value= <%=actionName.equals("edit")?("'" + approval_execution_tableDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
												

		<input type='hidden' class='form-control'  name='lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.lastModificationTime + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
					
	







				<div class="form-actions text-center">
					<a class="btn btn-danger" href="<%=request.getHeader("referer")%>">
					<%
					if(actionName.equals("edit"))
					{
						%>
						<%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_APPROVAL_EXECUTION_TABLE_CANCEL_BUTTON, loginDTO)%>
						<%
					}
					else
					{
						%>
						<%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_ADD_APPROVAL_EXECUTION_TABLE_CANCEL_BUTTON, loginDTO)%>
						<%
					}
					
					%>
					</a>
					<button class="btn btn-success" type="submit">
					<%
					if(actionName.equals("edit"))
					{
						%>
						<%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_APPROVAL_EXECUTION_TABLE_SUBMIT_BUTTON, loginDTO)%>
						<%
					}
					else
					{
						%>
						<%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_ADD_APPROVAL_EXECUTION_TABLE_SUBMIT_BUTTON, loginDTO)%>
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


	return true;
}


function addrselected(value, htmlID, selectedIndex, tagname,  fieldName, row)
{	
	addrselectedFunc(value, htmlID, selectedIndex, tagname,  fieldName, row, false, "Approval_execution_tableServlet");	
}

function init(row)
{


	
}

var row = 0;
bkLib.onDomLoaded(function() 
{	
});
	
window.onload =function ()
{
	init(row);
}

var child_table_extra_id = <%=childTableStartingID%>;



</script>






