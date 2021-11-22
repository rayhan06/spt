<%@page pageEncoding="UTF-8" %>

<%@page import="approval_module_map.Approval_module_mapDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>


<%@ page import="pb.*" %>
<%@page import="sessionmanager.SessionConstants" %>
<%@page import="language.LanguageTextDTO" %>
<%@page import="language.LC" %>
<%@page import="language.LM" %>
<%@page import="login.LoginDTO" %>
<%@page import="org.apache.commons.codec.binary.*" %>
<%
    LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
    String Language = LM.getText(LC.APPROVAL_MODULE_MAP_EDIT_LANGUAGE, loginDTO);
    Approval_module_mapDTO row = (Approval_module_mapDTO) request.getAttribute("approval_module_mapDTO");
    if (row == null) {
        row = new Approval_module_mapDTO();
    }
    System.out.println("row = " + row);
    int i = Integer.parseInt(request.getParameter("rownum"));
    String deletedStyle = request.getParameter("deletedstyle");
    String failureMessage = (String) request.getAttribute("failureMessage");
    if (failureMessage == null || failureMessage.isEmpty()) {
        failureMessage = "";
    }
    out.println("<td style='display:none;'><input type='hidden' id='failureMessage_" + i + "' value='" + failureMessage + "'/></td>");
    String value = "";
    out.println("<td id = '" + i + "_tableName'>");
    value = row.tableName + "";
    out.println(value);
    out.println("</td>");
    out.println("<td id = '" + i + "_hasAddApproval'>");
    value = row.hasAddApproval + "";
    out.println(value);
    out.println("</td>");
    out.println("<td id = '" + i + "_hasEditApproval'>");
    value = row.hasEditApproval + "";
    out.println(value);
    out.println("</td>");
    out.println("<td id = '" + i + "_hasDeleteApproval'>");
    value = row.hasDeleteApproval + "";
    out.println(value);
    out.println("</td>");
    String onclickFunc = "\"fixedToEditable(" + i + ",'" + deletedStyle + "', '" + row.iD + "' )\"";
    out.println("<td id = '" + i + "_Edit'>");
    out.println("<a onclick=" + onclickFunc + ">" + LM.getText(LC.APPROVAL_MODULE_MAP_SEARCH_APPROVAL_MODULE_MAP_EDIT_BUTTON, loginDTO) + "</a>");
    out.println("</td>");
    out.println("<td>");
    out.println("<label id='chkEdit' class='kt-checkbox kt-checkbox--brand'><input type='checkbox' class='checkbox' name='ID' value='" + row.iD + "'><span></span></label>");
    out.println("</td>");