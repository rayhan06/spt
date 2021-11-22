<%
String context = "../../.."  + request.getContextPath() + "/";
%>
<link href="<%=context%>/assets/css/pagecustom.css" rel="stylesheet" type="text/css"/>
<jsp:include page="../common/layout.jsp" flush="true">
<jsp:param name="title" value="View" /> 
	<jsp:param name="body" value="../approval_test/approval_testViewBody.jsp" />
</jsp:include> 