<%@page pageEncoding="UTF-8" %>

<%@page import="sessionmanager.SessionConstants"%>
<%@page import="approval_execution_table.Approval_execution_tableDTO"%>
<%@page import="java.util.*"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@page import="files.*"%>
<%@page import="dbm.*" %>

<%
Approval_execution_tableDTO approval_execution_tableDTO = (Approval_execution_tableDTO)request.getAttribute("approval_execution_tableDTO");
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);

if(approval_execution_tableDTO == null)
{
	approval_execution_tableDTO = new Approval_execution_tableDTO();
	
}
System.out.println("approval_execution_tableDTO = " + approval_execution_tableDTO);

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

long ColumnID;
FilesDAO filesDAO = new FilesDAO();
%>




























	















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
<td></td>
			
<%=("<td id = '" + i + "_iD" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='iD' id = 'iD_hidden_<%=i%>' value='<%=approval_execution_tableDTO.iD%>' tag='pb_html'/>
	
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_tableName'>")%>
			
	
	<div class="form-inline" id = 'tableName_div_<%=i%>'>
		<input type='text' class='form-control'  name='tableName' id = 'tableName_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.tableName + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_previousRowId'>")%>
			

		<input type='hidden' class='form-control'  name='previousRowId' id = 'previousRowId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.previousRowId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_updatedRowId'>")%>
			

		<input type='hidden' class='form-control'  name='updatedRowId' id = 'updatedRowId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.updatedRowId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_operation'>")%>
			
	
	<div class="form-inline" id = 'operation_div_<%=i%>'>
		<input type='text' class='form-control'  name='operation' id = 'operation_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.operation + "'"):("'" + "0" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_action'>")%>
			
	
	<div class="form-inline" id = 'action_div_<%=i%>'>
		<input type='text' class='form-control'  name='action' id = 'action_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.action + "'"):("'" + "0" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_approvalStatusCat'>")%>
			
	
	<div class="form-inline" id = 'approvalStatusCat_div_<%=i%>'>
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
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_userId'>")%>
			

		<input type='hidden' class='form-control'  name='userId' id = 'userId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.userId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_userIp'>")%>
			
	
	<div class="form-inline" id = 'userIp_div_<%=i%>'>
		<input type='text' class='form-control'  name='userIp' id = 'userIp_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.userIp + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_approvalPathId'>")%>
			

		<input type='hidden' class='form-control'  name='approvalPathId' id = 'approvalPathId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.approvalPathId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_approvalPathOrder'>")%>
			
	
	<div class="form-inline" id = 'approvalPathOrder_div_<%=i%>'>
		<input type='text' class='form-control'  name='approvalPathOrder' id = 'approvalPathOrder_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.approvalPathOrder + "'"):("'" + "0" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_remarks'>")%>
			
	
	<div class="form-inline" id = 'remarks_div_<%=i%>'>
		<input type='text' class='form-control'  name='remarks' id = 'remarks_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_execution_tableDTO.remarks + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_fileDropzone'>")%>
			
	
	<div class="form-inline" id = 'fileDropzone_div_<%=i%>'>
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
				
<%=("</td>")%>
			
<%=("<td id = '" + i + "_isDeleted" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='isDeleted' id = 'isDeleted_hidden_<%=i%>' value= <%=actionName.equals("edit")?("'" + approval_execution_tableDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
												
<%=("</td>")%>
			
<%=("<td id = '" + i + "_lastModificationTime" +  "' style='display:none;'>")%>
			

		<input type='hidden' class='form-control'  name='lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>' value='<%=approval_execution_tableDTO.lastModificationTime%>' tag='pb_html'/>
		
												
<%=("</td>")%>
					
		