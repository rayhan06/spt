
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="login.LoginDTO"%>

<%@page import="approval_path.*"%>
<%@page import="java.util.*"%>

<%@page pageEncoding="UTF-8" %>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.util.UUID"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>

<%@page import="geolocation.GeoLocationDAO2"%>


<%
Approval_pathDTO approval_pathDTO;
approval_pathDTO = (Approval_pathDTO)request.getAttribute("approval_pathDTO");
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
if(approval_pathDTO == null)
{
	approval_pathDTO = new Approval_pathDTO();
	
}
System.out.println("approval_pathDTO = " + approval_pathDTO);

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
	formTitle = LM.getText(LC.APPROVAL_PATH_EDIT_APPROVAL_PATH_EDIT_FORMNAME, loginDTO);
}
else
{
	formTitle = LM.getText(LC.APPROVAL_PATH_ADD_APPROVAL_PATH_ADD_FORMNAME, loginDTO);
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

%>



<div class="box box-primary">
	<div class="box-header with-border">
		<h3 class="box-title"><i class="fa fa-gift"></i><%=formTitle%></h3>
	</div>
	<div class="box-body">
		<form class="form-horizontal" action="Approval_pathServlet?actionType=<%=actionName%>&identity=<%=ID%>"
		id="bigform" name="bigform"  method="POST" enctype = "multipart/form-data"
		onsubmit="return PreprocessBeforeSubmiting(0,'<%=actionName%>')">
			<div class="form-body">
				
				
				




























	















<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ page import="pb.*"%>

<%
String Language = LM.getText(LC.APPROVAL_PATH_EDIT_LANGUAGE, loginDTO);
String Options;
SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
Date date = new Date();
String datestr = dateFormat.format(date);
%>


		<input type='hidden' class='form-control'  name='iD' id = 'iD_hidden_<%=i%>' value='<%=approval_pathDTO.iD%>' tag='pb_html'/>
	
												
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_PATH_EDIT_NAMEEN, loginDTO)):(LM.getText(LC.APPROVAL_PATH_ADD_NAMEEN, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'nameEn_div_<%=i%>'>	
		<input type='text' class='form-control'  name='nameEn' id = 'nameEn_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_pathDTO.nameEn + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_PATH_EDIT_NAMEBN, loginDTO)):(LM.getText(LC.APPROVAL_PATH_ADD_NAMEBN, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'nameBn_div_<%=i%>'>	
		<input type='text' class='form-control'  name='nameBn' id = 'nameBn_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_pathDTO.nameBn + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				

		<input type='hidden' class='form-control'  name='officeId' id = 'officeId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_pathDTO.officeId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_PATH_EDIT_APPROVALPATHCAT, loginDTO)):(LM.getText(LC.APPROVAL_PATH_ADD_APPROVALPATHCAT, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'approvalPathCat_div_<%=i%>'>	
		<select class='form-control'  name='approvalPathCat' id = 'approvalPathCat_category_<%=i%>'   tag='pb_html'>		
<%
if(actionName.equals("edit"))
{
			Options = CatDAO.getOptions(Language, "approval_path", approval_pathDTO.approvalPathCat);
}
else
{			
			Options = CatDAO.getOptions(Language, "approval_path", -1);			
}
%>
<%=Options%>
		</select>
		
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_PATH_EDIT_JOBCAT, loginDTO)):(LM.getText(LC.APPROVAL_PATH_ADD_JOBCAT, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'jobCat_div_<%=i%>'>	
		<select class='form-control'  name='jobCat' id = 'jobCat_category_<%=i%>'   tag='pb_html'>		
<%
if(actionName.equals("edit"))
{
			Options = CatDAO.getOptions(Language, "job", approval_pathDTO.jobCat);
}
else
{			
			Options = CatDAO.getOptions(Language, "job", -1);			
}
%>
<%=Options%>
		</select>
		
	</div>
</div>			
				

		<input type='hidden' class='form-control'  name='isDeleted' id = 'isDeleted_hidden_<%=i%>' value= <%=actionName.equals("edit")?("'" + approval_pathDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
												

		<input type='hidden' class='form-control'  name='lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_pathDTO.lastModificationTime + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
					
	





				<div class="col-md-12" style="padding-top: 20px;">
					<legend class="text-left content_legend"><%=LM.getText(LC.APPROVAL_PATH_ADD_APPROVAL_PATH_DETAILS, loginDTO)%></legend>
				</div>

				<div class="col-md-12">

					<div class="table-responsive">
						<table class="table table-bordered table-striped">
								<thead>
									<tr>
										<th><%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_PATH_EDIT_APPROVAL_PATH_DETAILS_APPROVALROLECAT, loginDTO)):(LM.getText(LC.APPROVAL_PATH_ADD_APPROVAL_PATH_DETAILS_APPROVALROLECAT, loginDTO))%></th>
										<th><%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_PATH_EDIT_APPROVAL_PATH_DETAILS_APPROVALORDER, loginDTO)):(LM.getText(LC.APPROVAL_PATH_ADD_APPROVAL_PATH_DETAILS_APPROVALORDER, loginDTO))%></th>
										<th><%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_PATH_EDIT_APPROVAL_PATH_DETAILS_DAYSREQUIRED, loginDTO)):(LM.getText(LC.APPROVAL_PATH_ADD_APPROVAL_PATH_DETAILS_DAYSREQUIRED, loginDTO))%></th>
										<th><%=LM.getText(LC.APPROVAL_PATH_ADD_APPROVAL_PATH_DETAILS_REMOVE, loginDTO)%></th>
									</tr>
								</thead>
								<tbody id="field-ApprovalPathDetails">
						
						
<%
	if(actionName.equals("edit")){
		int index = -1;
		
		
		for(ApprovalPathDetailsDTO approvalPathDetailsDTO: approval_pathDTO.approvalPathDetailsDTOList)
		{
			index++;
			
			System.out.println("index index = "+index);

%>	
							
									<tr>
										<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalPathDetails.iD' id = 'iD_hidden_<%=childTableStartingID%>' value='<%=approvalPathDetailsDTO.iD%>' tag='pb_html'/>
	
										</td>
										<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalPathDetails.approvalPathId' id = 'approvalPathId_hidden_<%=childTableStartingID%>' value=<%=actionName.equals("edit")?("'" + approvalPathDetailsDTO.approvalPathId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
										</td>
										<td>										











		<select class='form-control'  name='approvalPathDetails.approvalRoleCat' id = 'approvalRoleCat_category_<%=childTableStartingID%>'   tag='pb_html'>		
<%
if(actionName.equals("edit"))
{
			Options = CatDAO.getOptions(Language, "approval_role", approvalPathDetailsDTO.approvalRoleCat);
}
else
{			
			Options = CatDAO.getOptions(Language, "approval_role", -1);			
}
%>
<%=Options%>
		</select>
		
										</td>
										<td>										











		<input type='number' class='form-control'  name='approvalPathDetails.approvalOrder' id = 'approvalOrder_number_<%=childTableStartingID%>' min='0' max='10000' value=<%=actionName.equals("edit")?("'" + approvalPathDetailsDTO.approvalOrder + "'"):("'" + 0 + "'")%>  tag='pb_html'>
						
										</td>
										<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalPathDetails.organogramId' id = 'organogramId_hidden_<%=childTableStartingID%>' value=<%=actionName.equals("edit")?("'" + approvalPathDetailsDTO.organogramId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
										</td>
										<td>										











		<input type='text' class='form-control'  name='approvalPathDetails.daysRequired' id = 'daysRequired_text_<%=childTableStartingID%>' value=<%=actionName.equals("edit")?("'" + approvalPathDetailsDTO.daysRequired + "'"):("'" + "0" + "'")%>   tag='pb_html'/>					
										</td>
										<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalPathDetails.isDeleted' id = 'isDeleted_hidden_<%=childTableStartingID%>' value= <%=actionName.equals("edit")?("'" + approvalPathDetailsDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
										</td>
										<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalPathDetails.lastModificationTime' id = 'lastModificationTime_hidden_<%=childTableStartingID%>' value=<%=actionName.equals("edit")?("'" + approvalPathDetailsDTO.lastModificationTime + "'"):("'" + "0" + "'")%> tag='pb_html'/>
										</td>
										<td><div class='checker'><span id='chkEdit' ><input type='checkbox' id='approvalPathDetails_cb_<%=index%>' name='checkbox' value=''/></span></div></td>
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

							<button id="remove-ApprovalPathDetails" name="removeApprovalPathDetails" type="button"
									class="btn btn-danger remove-me1"><%=LM.getText(LC.APPROVAL_PATH_ADD_APPROVAL_PATH_DETAILS_REMOVE, loginDTO)%></button>

							<button id="add-more-ApprovalPathDetails" name="add-moreApprovalPathDetails" type="button"
									class="btn btn-primary"><%=LM.getText(LC.APPROVAL_PATH_ADD_APPROVAL_PATH_DETAILS_ADD_MORE, loginDTO)%></button>

						</div>
					</div>
					
					<%ApprovalPathDetailsDTO approvalPathDetailsDTO = new ApprovalPathDetailsDTO();%>
					
					<template id="template-ApprovalPathDetails" >						
								<tr>
									<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalPathDetails.iD' id = 'iD_hidden_' value='<%=approvalPathDetailsDTO.iD%>' tag='pb_html'/>
	
									</td>
									<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalPathDetails.approvalPathId' id = 'approvalPathId_hidden_' value=<%=actionName.equals("edit")?("'" + approvalPathDetailsDTO.approvalPathId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
									</td>
									<td>











		<select class='form-control'  name='approvalPathDetails.approvalRoleCat' id = 'approvalRoleCat_category_'   tag='pb_html'>		
<%
if(actionName.equals("edit"))
{
			Options = CatDAO.getOptions(Language, "approval_role", approvalPathDetailsDTO.approvalRoleCat);
}
else
{			
			Options = CatDAO.getOptions(Language, "approval_role", -1);			
}
%>
<%=Options%>
		</select>
		
									</td>
									<td>











		<input type='number' class='form-control'  name='approvalPathDetails.approvalOrder' id = 'approvalOrder_number_' min='0' max='10000' value=<%=actionName.equals("edit")?("'" + approvalPathDetailsDTO.approvalOrder + "'"):("'" + 0 + "'")%>  tag='pb_html'>
						
									</td>
									<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalPathDetails.organogramId' id = 'organogramId_hidden_' value=<%=actionName.equals("edit")?("'" + approvalPathDetailsDTO.organogramId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
									</td>
									<td>











		<input type='text' class='form-control'  name='approvalPathDetails.daysRequired' id = 'daysRequired_text_' value=<%=actionName.equals("edit")?("'" + approvalPathDetailsDTO.daysRequired + "'"):("'" + "0" + "'")%>   tag='pb_html'/>					
									</td>
									<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalPathDetails.isDeleted' id = 'isDeleted_hidden_' value= <%=actionName.equals("edit")?("'" + approvalPathDetailsDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
									</td>
									<td style="display: none;">











		<input type='hidden' class='form-control'  name='approvalPathDetails.lastModificationTime' id = 'lastModificationTime_hidden_' value=<%=actionName.equals("edit")?("'" + approvalPathDetailsDTO.lastModificationTime + "'"):("'" + "0" + "'")%> tag='pb_html'/>
									</td>
									<td><div><span id='chkEdit' ><input type='checkbox' name='checkbox' value=''/></span></div></td>
								</tr>								
						
					</template>
				</div>		


				<div class="form-actions text-center">
					<a class="btn btn-danger" href="<%=request.getHeader("referer")%>">
					<%
					if(actionName.equals("edit"))
					{
						%>
						<%=LM.getText(LC.APPROVAL_PATH_EDIT_APPROVAL_PATH_CANCEL_BUTTON, loginDTO)%>
						<%
					}
					else
					{
						%>
						<%=LM.getText(LC.APPROVAL_PATH_ADD_APPROVAL_PATH_CANCEL_BUTTON, loginDTO)%>
						<%
					}
					
					%>
					</a>
					<button class="btn btn-success" type="submit">
					<%
					if(actionName.equals("edit"))
					{
						%>
						<%=LM.getText(LC.APPROVAL_PATH_EDIT_APPROVAL_PATH_SUBMIT_BUTTON, loginDTO)%>
						<%
					}
					else
					{
						%>
						<%=LM.getText(LC.APPROVAL_PATH_ADD_APPROVAL_PATH_SUBMIT_BUTTON, loginDTO)%>
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
	addrselectedFunc(value, htmlID, selectedIndex, tagname,  fieldName, row, false, "Approval_pathServlet");	
}

function init(row)
{


	for(i = 1; i < child_table_extra_id; i ++)
	{
	}
	
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

	$("#add-more-ApprovalPathDetails").click(
        function(e) 
		{
            e.preventDefault();
            var t = $("#template-ApprovalPathDetails");

            $("#field-ApprovalPathDetails").append(t.html());
			SetCheckBoxValues("field-ApprovalPathDetails");
			
			var tr = $("#field-ApprovalPathDetails").find("tr:last-child");
			
			tr.attr("id","ApprovalPathDetails_" + child_table_extra_id);
			
			tr.find("[tag='pb_html']").each(function( index ) 
			{
				var prev_id = $( this ).attr('id');
				$( this ).attr('id', prev_id + child_table_extra_id);
				console.log( index + ": " + $( this ).attr('id') );
			});
			
			
			child_table_extra_id ++;

        });

    
      $("#remove-ApprovalPathDetails").click(function(e){    	
	    var tablename = 'field-ApprovalPathDetails';
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






