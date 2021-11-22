<%@page import="sessionmanager.SessionConstants" %>
<%@page import="language.LanguageTextDTO" %>
<%@page import="language.LC" %>
<%@page import="language.LM" %>
<%@page import="login.LoginDTO" %>
<%@ page import="util.RecordNavigator" %>
<%@ page language="java" %>
<%@ page import="java.util.ArrayList" %>
<%
    String navigator2 = SessionConstants.NAV_APPROVAL_MODULE_MAP;
    String url = "Approval_module_mapServlet?actionType=search";
    String navigator = SessionConstants.NAV_APPROVAL_MODULE_MAP;
    LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
    String pageno = "";
    RecordNavigator rn = (RecordNavigator) session.getAttribute(navigator);
    pageno = (rn == null) ? "1" : "" + rn.getCurrentPageNo();
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
<jsp:include page="./approval_module_mapNav.jsp" flush="true">
    <jsp:param name="url" value="<%=url%>"/>
    <jsp:param name="navigator" value="<%=navigator%>"/>
    <jsp:param name="pageName"
               value="<%=LM.getText(LC.APPROVAL_MODULE_MAP_SEARCH_APPROVAL_MODULE_MAP_SEARCH_FORMNAME, loginDTO)%>"/>
</jsp:include>
<div class="py-5">
    <form action="Approval_module_mapServlet?actionType=delete" method="POST" id="tableForm"
          enctype="multipart/form-data">
        <jsp:include page="approval_module_mapSearchForm.jsp" flush="true">
            <jsp:param name="pageName"
                       value="<%=LM.getText(LC.APPROVAL_MODULE_MAP_SEARCH_APPROVAL_MODULE_MAP_SEARCH_FORMNAME, loginDTO)%>"/>
        </jsp:include>
    </form>
</div>
<% pagination_number = 1;%>
<%@include file="../common/pagination_with_go2.jsp" %>
</div>
<script src="<%=context%>/assets/global/plugins/bootbox/bootbox.min.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#tableForm').submit(function (e) {
            var currentForm = this;
            var selected = false;
            e.preventDefault();
            var set = $('#tableData').find('tbody > tr > td:last-child input[type="checkbox"]');
            $(set).each(function () {
                if ($(this).prop('checked')) {
                    selected = true;
                }
            });
            if (!selected) {

            } else {
                bootbox.confirm("Are you sure you want to delete the record(s)?", function (result) {
                    if (result) {
                        currentForm.submit();
                    }
                });
            }
        });
    });
    $(document).on("click", '#chkEdit', function () {
        debugger;
        $("#chkEdit").toggleClass("checked");
    });
    $(document).on("click", 'input[type="checkbox"]', function (e) {
        debugger;
        e.classList.toggle("checked");
    });
</script>