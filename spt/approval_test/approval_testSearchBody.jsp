
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="language.LanguageTextDTO"%>
<%@page import="language.LC"%>
<%@page import="language.LM"%>
<%@page import="login.LoginDTO"%>
<%@ page import="util.RecordNavigator"%>

<%@ page language="java"%>
<%@ page import="java.util.ArrayList"%>
<%-- <%@ page errorPage="failure.jsp"%> --%>
<%
String url = "Approval_testServlet?actionType=search";
String navigator = SessionConstants.NAV_APPROVAL_TEST;
LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);

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
%>
	<jsp:include page="./approval_testNav.jsp" flush="true">
		<jsp:param name="url" value="<%=url%>" />
		<jsp:param name="navigator" value="<%=navigator%>" />
		<jsp:param name="pageName" value="<%=LM.getText(LC.APPROVAL_TEST_SEARCH_APPROVAL_TEST_SEARCH_FORMNAME, loginDTO)%>" />
	</jsp:include>


<div class="portlet box">
	<div class="portlet-body">
		<form action="Approval_testServlet?isPermanentTable=<%=isPermanentTable%>&actionType=delete" method="POST" id="tableForm" enctype = "multipart/form-data">
			<jsp:include page="approval_testSearchForm.jsp" flush="true">
				<jsp:param name="pageName" value="<%=LM.getText(LC.APPROVAL_TEST_SEARCH_APPROVAL_TEST_SEARCH_FORMNAME, loginDTO)%>" />
			</jsp:include>	
		</form>
	</div>
</div>

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


