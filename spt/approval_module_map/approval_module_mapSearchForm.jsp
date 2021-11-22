<%@page import="language.LC" %>
<%@page import="language.LM" %>
<%@page import="login.LoginDTO" %>
<%@page import="sessionmanager.SessionConstants" %>
<%@page import="approval_module_map.Approval_module_mapDTO" %>
<%@ page import="util.RecordNavigator" %>
<%@ page language="java" %>
<%@ page import="java.util.ArrayList" %>
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
    String actionName = "edit";
    String failureMessage = (String) request.getAttribute("failureMessage");
    if (failureMessage == null || failureMessage.isEmpty()) {
        failureMessage = "";
    }
    out.println("<input type='hidden' id='failureMessage_general' value='" + failureMessage + "'/>");
    String value = "";
    String Language = LM.getText(LC.APPROVAL_MODULE_MAP_EDIT_LANGUAGE, loginDTO);
%>
<div class="table-responsive">
    <table id="tableData" class="table table-bordered table-striped">
        <thead class="thead-light text-center">
        <tr>
            <th><%=LM.getText(LC.APPROVAL_MODULE_MAP_EDIT_TABLENAME, loginDTO)%>
            </th>
            <th><%=LM.getText(LC.APPROVAL_MODULE_MAP_EDIT_HASADDAPPROVAL, loginDTO)%>
            </th>
            <th><%=LM.getText(LC.APPROVAL_MODULE_MAP_EDIT_HASEDITAPPROVAL, loginDTO)%>
            </th>
            <th><%=LM.getText(LC.APPROVAL_MODULE_MAP_EDIT_HASDELETEAPPROVAL, loginDTO)%>
            </th>
            <th><%out.print(LM.getText(LC.APPROVAL_MODULE_MAP_SEARCH_APPROVAL_MODULE_MAP_EDIT_BUTTON, loginDTO));%></th>
            <th>
                <div class="d-flex flex-row">
                    <label class="kt-checkbox kt-checkbox--brand">
                        <input type="checkbox" class="checkbox"><span></span>
                    </label>
                    <button type="submit" class="btn btn-xs btn-danger" id="delete-btn">
                        <i class="far fa-trash-alt"></i>
                    </button>
                </div>
            </th>
        </tr>
        </thead>
        <tbody>
        <%
            ArrayList data = (ArrayList) session.getAttribute(SessionConstants.VIEW_APPROVAL_MODULE_MAP);
            try {
                if (data != null) {
                    int size = data.size();
                    System.out.println("data not null and size = " + size + " data = " + data);
                    for (int i = 0; i < size; i++) {
                        Approval_module_mapDTO row = (Approval_module_mapDTO) data.get(i);
                        String deletedStyle = "color:red";
                        if (!row.isDeleted) deletedStyle = "";
                        out.println("<tr id = 'tr_" + i + "'>");
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
                        out.println("<a class='btn btn-success btn-elevate btn-icon btn-square btn-sm' onclick=" + onclickFunc + "><i class='far fa-edit'></i></a>");
                        out.println("</td>");
                        out.println("<td>");
                        out.println("<label id='chkEdit' class='kt-checkbox kt-checkbox--brand'><input class='checkbox' type='checkbox' name='ID' value='" + row.iD + "'/><span></span></label>");
                        out.println("</td>");
                        out.println("</tr>");
                    }
                    System.out.println("printing done");
                } else {
                    System.out.println("data  null");
                }
            } catch (Exception e) {
                System.out.println("JSP exception " + e);
            }
        %>
        </tbody>
    </table>
</div>
<%
    String navigator2 = SessionConstants.NAV_APPROVAL_MODULE_MAP;
    System.out.println("navigator2 = " + navigator2);
    RecordNavigator rn2 = (RecordNavigator) session.getAttribute(navigator2);
    System.out.println("rn2 = " + rn2);
    String pageno2 = (rn2 == null) ? "1" : "" + rn2.getCurrentPageNo();
    String totalpage2 = (rn2 == null) ? "1" : "" + rn2.getTotalPages();
    String totalRecords2 = (rn2 == null) ? "1" : "" + rn2.getTotalRecords();
    String lastSearchTime = (rn2 == null) ? "0" : "" + rn2.getSearchTime();
%>
<input type="hidden" id="hidden_pageno" value="<%=pageno2%>"/>
<input type="hidden" id="hidden_totalpage" value="<%=totalpage2%>"/>
<input type="hidden" id="hidden_totalrecords" value="<%=totalRecords2%>"/>
<input type="hidden" id="hidden_lastSearchTime" value="<%=lastSearchTime%>"/>
<script src="nicEdit.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).on("change", "th .checkbox", function () {
        if ($(this).is(":checked")) {
            $("td .checkbox").prop('checked', true);
            $("delete-btn").classList.add('d-block');
        } else {
            $("td .checkbox").prop('checked', false);
        }
    });
    function getOfficer(officer_id, officer_select) {
        console.log("getting officer");
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                if (this.responseText.includes('option')) {
                    console.log("got response for officer");
                    document.getElementById(officer_select).innerHTML = this.responseText;
                    if (document.getElementById(officer_select).length > 1) {
                        document.getElementById(officer_select).removeAttribute("disabled");
                    }
                }
                else {
                    console.log("got errror response for officer");
                }
            }
            else if (this.readyState == 4 && this.status != 200) {
                alert('failed ' + this.status);
            }
        };
        xhttp.open("POST", "Approval_module_mapServlet?actionType=getGRSOffice&officer_id=" + officer_id, true);
        xhttp.send();
    }
    function getLayer(layernum, layerID, childLayerID, selectedValue) {
        console.log("getting layer");
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                if (this.responseText.includes('option')) {
                    console.log("got response");
                    document.getElementById(childLayerID).innerHTML = this.responseText;
                }
                else {
                    console.log("got errror response");
                }
            }
            else if (this.readyState == 4 && this.status != 200) {
                alert('failed ' + this.status);
            }
        };
        xhttp.open("POST", "Approval_module_mapServlet?actionType=getGRSLayer&layernum=" + layernum + "&layerID="
            + layerID + "&childLayerID=" + childLayerID + "&selectedValue=" + selectedValue, true);
        xhttp.send();
    }
    function layerselected(layernum, layerID, childLayerID, hiddenInput, hiddenInputForTopLayer, officerElement) {
        var layervalue = document.getElementById(layerID).value;
        console.log("layervalue = " + layervalue);
        document.getElementById(hiddenInput).value = layervalue;
        if (layernum == 0) {
            document.getElementById(hiddenInputForTopLayer).value = layervalue;
        }
        if (layernum == 0 || (layernum == 1 && document.getElementById(hiddenInputForTopLayer).value == 3)) {
            document.getElementById(childLayerID).setAttribute("style", "display: inline;");
            getLayer(layernum, layerID, childLayerID, layervalue);
        }
        if (officerElement !== null) {
            getOfficer(layervalue, officerElement);
        }
    }
    function isNumeric(n) {
        return !isNaN(parseFloat(n)) && isFinite(n);
    }
    function PreprocessBeforeSubmiting(row, validate) {
        if (validate == "report") {
        }
        else {
            var empty_fields = "";
            var i = 0;
            if (!document.getElementById('tableName_text_' + row).checkValidity()) {
                empty_fields += "'tableName'";
                if (i > 0) {
                    empty_fields += ", ";
                }
                i++;
            }
            if (empty_fields != "") {
                if (validate == "inplaceedit") {
                    $('<input type="submit">').hide().appendTo($('#tableForm')).click().remove();
                    return false;
                }
            }
        }
        if (document.getElementById('hasAddApproval_checkbox_' + row).checked) {
            document.getElementById('hasAddApproval_checkbox_' + row).value = "true";
        }
        else {
            document.getElementById('hasAddApproval_checkbox_' + row).value = "false";
        }
        if (document.getElementById('hasEditApproval_checkbox_' + row).checked) {
            document.getElementById('hasEditApproval_checkbox_' + row).value = "true";
        }
        else {
            document.getElementById('hasEditApproval_checkbox_' + row).value = "false";
        }
        if (document.getElementById('hasDeleteApproval_checkbox_' + row).checked) {
            document.getElementById('hasDeleteApproval_checkbox_' + row).value = "true";
        }
        else {
            document.getElementById('hasDeleteApproval_checkbox_' + row).value = "false";
        }
        return true;
    }
    function PostprocessAfterSubmiting(row) {
    }
    function addHTML(id, HTML) {
        document.getElementById(id).innerHTML += HTML;
    }
    function getRequests() {
        var s1 = location.search.substring(1, location.search.length).split('&'),
            r = {}, s2, i;
        for (i = 0; i < s1.length; i += 1) {
            s2 = s1[i].split('=');
            r[decodeURIComponent(s2[0]).toLowerCase()] = decodeURIComponent(s2[1]);
        }
        return r;
    }
    function Request(name) {
        return getRequests()[name.toLowerCase()];
    }
    function ShowExcelParsingResult(suffix) {
        var failureMessage = document.getElementById("failureMessage_" + suffix);
        if (failureMessage == null) {
            console.log("failureMessage_" + suffix + " not found");
        }
        console.log("value = " + failureMessage.value);
        if (failureMessage != null && failureMessage.value != "") {
            alert("Excel uploading result:" + failureMessage.value);
        }
    }
    function init(row) {
    }
    function doEdit(params, i, id, deletedStyle) {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                if (this.responseText != '') {
                    var onclickFunc = "submitAjax(" + i + ",'" + deletedStyle + "')";
                    document.getElementById('tr_' + i).innerHTML = this.responseText;
                    document.getElementById('tr_' + i).innerHTML += "<td id = '" + i + "_Submit'></td>";
                    document.getElementById(i + '_Submit').innerHTML += "<button class=\"btn btn-primary btn-hover-brand btn-square\" onclick=\"" + onclickFunc + "\">Submit</button>";
                    document.getElementById('tr_' + i).innerHTML += "<td>"
                        + "<div class='checker'>"
                        + "<label class='kt-checkbox kt-checkbox--brand' id='chkEdit'><input type='checkbox' class='checkbox' name='ID' value='" + id + "'/><span></span></label>"
                        + "</td>";
                    init(i);
                    select_2_call();
                }
                else {
                    document.getElementById('tr_' + i).innerHTML = 'NULL RESPONSE';
                }
            }
            else if (this.readyState == 4 && this.status != 200) {
                alert('failed ' + this.status);
            }
        };
        xhttp.open("Get", "Approval_module_mapServlet?actionType=getEditPage" + params, true);
        xhttp.send();
    }
    function submitAjax(i, deletedStyle) {
        console.log('submitAjax called');
        var isSubmittable = PreprocessBeforeSubmiting(i, "inplaceedit");
        if (isSubmittable == false) {
            return;
        }
        var formData = new FormData();
        var value;
        value = document.getElementById('iD_hidden_' + i).value;
        console.log('submitAjax i = ' + i + ' id = ' + value);
        formData.append('iD', value);
        formData.append("identity", value);
        formData.append("ID", value);
        formData.append('tableName', document.getElementById('tableName_text_' + i).value);
        formData.append('hasAddApproval', document.getElementById('hasAddApproval_checkbox_' + i).value);
        formData.append('hasEditApproval', document.getElementById('hasEditApproval_checkbox_' + i).value);
        formData.append('hasDeleteApproval', document.getElementById('hasDeleteApproval_checkbox_' + i).value);
        formData.append('isDeleted', document.getElementById('isDeleted_hidden_' + i).value);
        formData.append('lastModificationTime', document.getElementById('lastModificationTime_hidden_' + i).value);
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                if (this.responseText != '') {
                    document.getElementById('tr_' + i).innerHTML = this.responseText;
                    ShowExcelParsingResult(i);
                }
                else {
                    console.log("No Response");
                    document.getElementById('tr_' + i).innerHTML = 'NULL RESPONSE';
                }
            }
            else if (this.readyState == 4 && this.status != 200) {
                alert('failed ' + this.status);
            }
        };
        xhttp.open("POST", 'Approval_module_mapServlet?actionType=edit&inplacesubmit=true&deletedStyle=' + deletedStyle + '&rownum=' + i, true);
        xhttp.send(formData);
    }
    function fixedToEditable(i, deletedStyle, id) {
        console.log('fixedToEditable called');
        var params = '&identity=' + id + '&inplaceedit=true' + '&deletedStyle=' + deletedStyle + '&ID=' + id + '&rownum=' + i
            + '&dummy=dummy';
        console.log('fixedToEditable i = ' + i + ' id = ' + id);
        doEdit(params, i, id, deletedStyle);
    }
    window.onload = function () {
        ShowExcelParsingResult('general');
    }
</script>