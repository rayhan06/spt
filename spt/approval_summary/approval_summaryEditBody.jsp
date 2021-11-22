
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="login.LoginDTO"%>

<%@page import="approval_summary.*"%>
<%@page import="java.util.*"%>

<%@page pageEncoding="UTF-8" %>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.util.UUID"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>

<%@page import="geolocation.GeoLocationDAO2"%>


<%
Approval_summaryDTO approval_summaryDTO;
approval_summaryDTO = (Approval_summaryDTO)request.getAttribute("approval_summaryDTO");
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
if(approval_summaryDTO == null)
{
	approval_summaryDTO = new Approval_summaryDTO();
	
}
System.out.println("approval_summaryDTO = " + approval_summaryDTO);

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
	formTitle = LM.getText(LC.APPROVAL_SUMMARY_EDIT_APPROVAL_SUMMARY_EDIT_FORMNAME, loginDTO);
}
else
{
	formTitle = LM.getText(LC.APPROVAL_SUMMARY_ADD_APPROVAL_SUMMARY_ADD_FORMNAME, loginDTO);
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
		<form class="form-horizontal" action="Approval_summaryServlet?actionType=<%=actionName%>&identity=<%=ID%>"
		id="bigform" name="bigform"  method="POST" enctype = "multipart/form-data"
		onsubmit="return PreprocessBeforeSubmiting(0,'<%=actionName%>')">
			<div class="form-body">
				
				
				




























	















<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ page import="pb.*"%>

<%
String Language = LM.getText(LC.APPROVAL_SUMMARY_EDIT_LANGUAGE, loginDTO);
String Options;
SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
Date date = new Date();
String datestr = dateFormat.format(date);
%>


		<input type='hidden' class='form-control'  name='iD' id = 'iD_hidden_<%=i%>' value='<%=approval_summaryDTO.iD%>' tag='pb_html'/>
	
												
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_SUMMARY_EDIT_TABLENAME, loginDTO)):(LM.getText(LC.APPROVAL_SUMMARY_ADD_TABLENAME, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'tableName_div_<%=i%>'>	
		<input type='text' class='form-control'  name='tableName' id = 'tableName_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_summaryDTO.tableName + "'"):("'" + "" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				

		<input type='hidden' class='form-control'  name='tableId' id = 'tableId_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_summaryDTO.tableId + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_SUMMARY_EDIT_INITIATOR, loginDTO)):(LM.getText(LC.APPROVAL_SUMMARY_ADD_INITIATOR, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'initiator_div_<%=i%>'>	
		<input type='text' class='form-control'  name='initiator' id = 'initiator_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_summaryDTO.initiator + "'"):("'" + "0" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_SUMMARY_EDIT_APPROVALSTATUSCAT, loginDTO)):(LM.getText(LC.APPROVAL_SUMMARY_ADD_APPROVALSTATUSCAT, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'approvalStatusCat_div_<%=i%>'>	
		<select class='form-control'  name='approvalStatusCat' id = 'approvalStatusCat_category_<%=i%>'   tag='pb_html'>		
<%
if(actionName.equals("edit"))
{
			Options = CatDAO.getOptions(Language, "approval_status", approval_summaryDTO.approvalStatusCat);
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
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_SUMMARY_EDIT_DATEOFINITIATION, loginDTO)):(LM.getText(LC.APPROVAL_SUMMARY_ADD_DATEOFINITIATION, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'dateOfInitiation_div_<%=i%>'>	
		<input type='date' class='form-control'  name='dateOfInitiation_Date_<%=i%>' id = 'dateOfInitiation_date_Date_<%=i%>' value=<%
if(actionName.equals("edit"))
{
	SimpleDateFormat format_dateOfInitiation = new SimpleDateFormat("dd-MM-yyyy");
	String formatted_dateOfInitiation = format_dateOfInitiation.format(new Date(approval_summaryDTO.dateOfInitiation)).toString();
	%>
	'<%=formatted_dateOfInitiation%>'
	<%
}
else
{
	%>
	'<%=datestr%>'
	<%
}
%>
   tag='pb_html'>
		<input type='hidden' class='form-control'  name='dateOfInitiation' id = 'dateOfInitiation_date_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_summaryDTO.dateOfInitiation + "'"):("'" + "0" + "'")%>  tag='pb_html'>
		
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_SUMMARY_EDIT_DATEOFRESOLUTION, loginDTO)):(LM.getText(LC.APPROVAL_SUMMARY_ADD_DATEOFRESOLUTION, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'dateOfResolution_div_<%=i%>'>	
		<input type='date' class='form-control'  name='dateOfResolution_Date_<%=i%>' id = 'dateOfResolution_date_Date_<%=i%>' value=<%
if(actionName.equals("edit"))
{
	SimpleDateFormat format_dateOfResolution = new SimpleDateFormat("dd-MM-yyyy");
	String formatted_dateOfResolution = format_dateOfResolution.format(new Date(approval_summaryDTO.dateOfResolution)).toString();
	%>
	'<%=formatted_dateOfResolution%>'
	<%
}
else
{
	%>
	'<%=datestr%>'
	<%
}
%>
   tag='pb_html'>
		<input type='hidden' class='form-control'  name='dateOfResolution' id = 'dateOfResolution_date_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_summaryDTO.dateOfResolution + "'"):("'" + "0" + "'")%>  tag='pb_html'>
		
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_SUMMARY_EDIT_RESOLVER, loginDTO)):(LM.getText(LC.APPROVAL_SUMMARY_ADD_RESOLVER, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'resolver_div_<%=i%>'>	
		<input type='text' class='form-control'  name='resolver' id = 'resolver_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_summaryDTO.resolver + "'"):("'" + "0" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				
	
<label class="col-lg-3 control-label">
	<%=(actionName.equals("edit"))?(LM.getText(LC.APPROVAL_SUMMARY_EDIT_ASSIGNEDTO, loginDTO)):(LM.getText(LC.APPROVAL_SUMMARY_ADD_ASSIGNEDTO, loginDTO))%>
</label>
<div class="form-group ">					
	<div class="col-lg-6 " id = 'assignedTo_div_<%=i%>'>	
		<input type='text' class='form-control'  name='assignedTo' id = 'assignedTo_text_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_summaryDTO.assignedTo + "'"):("'" + "0" + "'")%>   tag='pb_html'/>					
	</div>
</div>			
				

		<input type='hidden' class='form-control'  name='isDeleted' id = 'isDeleted_hidden_<%=i%>' value= <%=actionName.equals("edit")?("'" + approval_summaryDTO.isDeleted + "'"):("'" + "false" + "'")%> tag='pb_html'/>
											
												

		<input type='hidden' class='form-control'  name='lastModificationTime' id = 'lastModificationTime_hidden_<%=i%>' value=<%=actionName.equals("edit")?("'" + approval_summaryDTO.lastModificationTime + "'"):("'" + "0" + "'")%> tag='pb_html'/>
												
					
	







				<div class="form-actions text-center">
					<a class="btn btn-danger" href="<%=request.getHeader("referer")%>">
					<%
					if(actionName.equals("edit"))
					{
						%>
						<%=LM.getText(LC.APPROVAL_SUMMARY_EDIT_APPROVAL_SUMMARY_CANCEL_BUTTON, loginDTO)%>
						<%
					}
					else
					{
						%>
						<%=LM.getText(LC.APPROVAL_SUMMARY_ADD_APPROVAL_SUMMARY_CANCEL_BUTTON, loginDTO)%>
						<%
					}
					
					%>
					</a>
					<button class="btn btn-success" type="submit">
					<%
					if(actionName.equals("edit"))
					{
						%>
						<%=LM.getText(LC.APPROVAL_SUMMARY_EDIT_APPROVAL_SUMMARY_SUBMIT_BUTTON, loginDTO)%>
						<%
					}
					else
					{
						%>
						<%=LM.getText(LC.APPROVAL_SUMMARY_ADD_APPROVAL_SUMMARY_SUBMIT_BUTTON, loginDTO)%>
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

	preprocessDateBeforeSubmitting('dateOfInitiation', row);	
	preprocessDateBeforeSubmitting('dateOfResolution', row);	

	return true;
}


function addrselected(value, htmlID, selectedIndex, tagname,  fieldName, row)
{	
	addrselectedFunc(value, htmlID, selectedIndex, tagname,  fieldName, row, false, "Approval_summaryServlet");	
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






