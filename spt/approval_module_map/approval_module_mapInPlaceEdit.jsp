<%@page pageEncoding="UTF-8" %>
<%@page import="sessionmanager.SessionConstants" %>
<%@page import="approval_module_map.Approval_module_mapDTO" %>
<%@page import="java.util.UUID" %>
<%@page import="language.LanguageTextDTO" %>
<%@page import="language.LC" %>
<%@page import="language.LM" %>
<%@page import="login.LoginDTO" %>
<%
    Approval_module_mapDTO approval_module_mapDTO = (Approval_module_mapDTO) request.getAttribute("approval_module_mapDTO");
    LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
    if (approval_module_mapDTO == null) {
        approval_module_mapDTO = new Approval_module_mapDTO();
    }
    System.out.println("approval_module_mapDTO = " + approval_module_mapDTO);
    String actionName = "edit";
    String ID = request.getParameter("ID");
    if (ID == null || ID.isEmpty()) {
        ID = "0";
    }
    System.out.println("ID = " + ID);
    int i = Integer.parseInt(request.getParameter("rownum"));
    String deletedStyle = request.getParameter("deletedstyle");
    String value = "";
    Approval_module_mapDTO row = approval_module_mapDTO;
%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="pb.*" %>
<%
    String Language = LM.getText(LC.APPROVAL_MODULE_MAP_EDIT_LANGUAGE, loginDTO);
    String Options;
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date date = new Date();
    String datestr = dateFormat.format(date);
%>
<%=("<td id = '" + i + "_iD" + "' style='display:none;'>")%>
<input type='hidden' class='form-control' name='iD' id='iD_hidden_<%=i%>' value='<%=ID%>'/>
<%=("</td>")%>
<%=("<td id = '" + i + "_tableName'>")%>
<div class="form-inline" id='tableName_div_<%=i%>'>
    <input type='text' class='form-control' name='tableName' id='tableName_text_<%=i%>'
           value=<%=actionName.equals("edit")?("'" + approval_module_mapDTO.tableName + "'"):("''")%> required="required"
    />
</div>
<%=("</td>")%>
<%=("<td id = '" + i + "_hasAddApproval'>")%>
<div class="form-inline" id='hasAddApproval_div_<%=i%>'>
    <input type='checkbox' class='form-control' name='hasAddApproval' id='hasAddApproval_checkbox_<%=i%>'
           value='true' <%=(actionName.equals("edit") && String.valueOf(approval_module_mapDTO.hasAddApproval).equals("true"))?("checked"):""%>  ><br>
</div>
<%=("</td>")%>
<%=("<td id = '" + i + "_hasEditApproval'>")%>
<div class="form-inline" id='hasEditApproval_div_<%=i%>'>
    <input type='checkbox' class='form-control' name='hasEditApproval' id='hasEditApproval_checkbox_<%=i%>'
           value='true' <%=(actionName.equals("edit") && String.valueOf(approval_module_mapDTO.hasEditApproval).equals("true"))?("checked"):""%>  ><br>
</div>
<%=("</td>")%>
<%=("<td id = '" + i + "_hasDeleteApproval'>")%>
<div class="form-inline" id='hasDeleteApproval_div_<%=i%>'>
    <input type='checkbox' class='form-control' name='hasDeleteApproval' id='hasDeleteApproval_checkbox_<%=i%>'
           value='true' <%=(actionName.equals("edit") && String.valueOf(approval_module_mapDTO.hasDeleteApproval).equals("true"))?("checked"):""%>  ><br>
</div>
<%=("</td>")%>
<%=("<td id = '" + i + "_isDeleted" + "' style='display:none;'>")%>
<input type='hidden' class='form-control' name='isDeleted' id='isDeleted_hidden_<%=i%>'
       value= <%=actionName.equals("edit") ? ("'" + approval_module_mapDTO.isDeleted + "'") : ("'" + "false" + "'")%>/>
<%=("</td>")%>
<%=("<td id = '" + i + "_lastModificationTime" + "' style='display:none;'>")%>
<input type='hidden' class='form-control' name='lastModificationTime' id='lastModificationTime_hidden_<%=i%>'
       value='<%=approval_module_mapDTO.lastModificationTime%>'/>
<%=("</td>")%>