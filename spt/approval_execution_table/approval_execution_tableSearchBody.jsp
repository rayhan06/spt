
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@ page import="util.RecordNavigator"%>

<%@ page language="java"%>
<%@ page import="java.util.ArrayList"%>
<%@page import="workflow.*"%>
<%@ page import="approval_execution_table.*"%>
<%@page import="user.*"%>
<%-- <%@ page errorPage="failure.jsp"%> --%>
<%



String url = "Approval_execution_tableServlet?actionType=search";
String navigator = SessionConstants.NAV_APPROVAL_EXECUTION_TABLE;
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
UserDTO userDTO = UserRepository.getUserDTOByUserID(loginDTO);
String pageno = "";

RecordNavigator rn = (RecordNavigator) session.getAttribute(navigator);
pageno = (rn == null) ? "1" : "" + rn.getCurrentPageNo();
boolean isPermanentTable = rn.m_isPermanentTable;

System.out.println("rn " + rn);

String action = url;
String context = "../../.." + request.getContextPath() + "/";
String link = context + url;
String concat = "?";
if (url.contains("?")) {
	concat = "&";
}
int pagination_number = 0;

String tableToView = null;
boolean isInitiator = false, canSkip = false;
long previousRowId = -1;
String servletName = "";

if(request.getParameter("tableName") != null)
{
	tableToView = request.getParameter("tableName");
	previousRowId= Long.parseLong(request.getParameter("previousRowId"));
	isInitiator = WorkflowController.isInitiator(tableToView, previousRowId, userDTO.organogramID);
	Approval_execution_tableDAO approval_execution_tableDAO = new Approval_execution_tableDAO();
	int isDeleted = approval_execution_tableDAO.getIsDeleted(tableToView, previousRowId);
	canSkip = isInitiator && isDeleted == 2;
	servletName = tableToView.substring(0, 1).toUpperCase() + tableToView.substring(1);
	servletName += "Servlet";
}
System.out.println("Is initiator = " + isInitiator);
%>
	<jsp:include page="./approval_execution_tableNav.jsp" flush="true">
		<jsp:param name="url" value="<%=url%>" />
		<jsp:param name="navigator" value="<%=navigator%>" />
		<jsp:param name="pageName" value="<%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_SEARCH_APPROVAL_EXECUTION_TABLE_SEARCH_FORMNAME, loginDTO)%>" />
	</jsp:include>


<div class="portlet box">
	<div class="portlet-body">
		<form action="Approval_execution_tableServlet?isPermanentTable=<%=isPermanentTable%>&actionType=delete" method="POST" id="tableForm" enctype = "multipart/form-data">
			<jsp:include page="approval_execution_tableSearchForm.jsp" flush="true">
				<jsp:param name="pageName" value="<%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_SEARCH_APPROVAL_EXECUTION_TABLE_SEARCH_FORMNAME, loginDTO)%>" />
			</jsp:include>	
		</form>
	</div>
</div>

<%
if (canSkip) {
%>
<form class="form-horizontal"
	action="<%=servletName%>?actionType=skipStep&id=<%=previousRowId%>"
	id="bigform" name="bigform" method="POST">
	<div class="form-body">
		<textarea class='form-control' name='remarks' tag='pb_html'></textarea>
		<button class="btn btn-success" type="submit">Skip Step</button>
	</div>
</form>
<%
	}
%>

<% pagination_number = 1;%>
<%@include file="../common/pagination_with_go2.jsp"%>
<link href="<%=context%>/assets/css/custom.css" rel="stylesheet" type="text/css"/>
<script src="<%=context%>/assets/global/plugins/bootbox/bootbox.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#tableForm').submit(function(e) {
	    var currentForm = this;
	    var selected=false;
	    e.preventDefault();
	    var set = $('#tableData').find('tbody > tr > td:last-child input[type="checkbox"]');
	    $(set).each(function() {
	    	if($(this).prop('checked')){
	    		selected=true;
	    	}
	    });
	    if(!selected){
	    	 bootbox.confirm("Select rows to delete!", function(result) { });
	    }else{
	    	 bootbox.confirm("Are you sure you want to delete the record(s)?", function(result) {
	             if (result) {
	                 currentForm.submit();
	             }
	         });
	    }
	});
	CKEDITOR.replaceAll();
});


$(document).on("click",'#chkEdit',function(){
	debugger;
	$("#chkEdit").toggleClass("checked");
});
$(document).on("click",'input[type="checkbox"]',function(e){
	debugger;
	e.classList.toggle("checked");
});

</script>


