<%@page import="sessionmanager.SessionConstants" %>
<%@page import="login.LoginDTO" %>
<%@page import="approval_module_map.*" %>
<%@page import="java.util.*" %>
<%@page pageEncoding="UTF-8" %>
<%@page import="org.apache.log4j.Logger" %>
<%@page import="java.util.UUID" %>
<%@page import="language.LanguageTextDTO" %>
<%@page import="language.LC" %>
<%@page import="language.LM" %>
<%
    Approval_module_mapDTO approval_module_mapDTO;
    approval_module_mapDTO = (Approval_module_mapDTO) request.getAttribute("approval_module_mapDTO");
    LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
    if (approval_module_mapDTO == null) {
        approval_module_mapDTO = new Approval_module_mapDTO();
    }
    System.out.println("approval_module_mapDTO = " + approval_module_mapDTO);
    String actionName;
    System.out.println("actionType = " + request.getParameter("actionType"));
    if (request.getParameter("actionType").equalsIgnoreCase("getAddPage")) {
        actionName = "add";
    } else {
        actionName = "edit";
    }
    String formTitle;
    if (actionName.equals("edit")) {
        formTitle = LM.getText(LC.APPROVAL_MODULE_MAP_EDIT_APPROVAL_MODULE_MAP_EDIT_FORMNAME, loginDTO);
    } else {
        formTitle = LM.getText(LC.APPROVAL_MODULE_MAP_ADD_APPROVAL_MODULE_MAP_ADD_FORMNAME, loginDTO);
    }
    String ID = request.getParameter("ID");
    if (ID == null || ID.isEmpty()) {
        ID = "0";
    }
    System.out.println("ID = " + ID);
    int i = 0;
    String value = "";
    Approval_module_mapDTO row = approval_module_mapDTO;
%>
<div class="row">
    <div class="col-md-6">
        <div class="kt-portlet border my-3">
            <div class="kt-portlet__head">
                <div class="kt-portlet__head-label">
                    <h3 class="kt-portlet__head-title">
                        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px"
                             height="24px" viewBox="0 0 24 24" version="1.1" class="kt-svg-icon">
                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                <rect x="0" y="0" width="24" height="24"/>
                                <path d="M8,17.9148182 L8,5.96685884 C8,5.56391781 8.16211443,5.17792052 8.44982609,4.89581508 L10.965708,2.42895648 C11.5426798,1.86322723 12.4640974,1.85620921 13.0496196,2.41308426 L15.5337377,4.77566479 C15.8314604,5.0588212 16,5.45170806 16,5.86258077 L16,17.9148182 C16,18.7432453 15.3284271,19.4148182 14.5,19.4148182 L9.5,19.4148182 C8.67157288,19.4148182 8,18.7432453 8,17.9148182 Z"
                                      fill="#000000" fill-rule="nonzero"
                                      transform="translate(12.000000, 10.707409) rotate(-135.000000) translate(-12.000000, -10.707409) "/>
                                <rect fill="#000000" opacity="0.3" x="5" y="20" width="15" height="2" rx="1"/>
                            </g>
                        </svg>
                        <%=formTitle%>
                    </h3>
                </div>
            </div>
            <div class="kt-portlet__body">
                <form class="kt-form" action="Approval_module_mapServlet?actionType=<%=actionName%>&identity=<%=ID%>"
                      id="bigform" name="bigform" method="POST" enctype="multipart/form-data"
                      onsubmit="return PreprocessBeforeSubmiting(0,'<%=actionName%>')">
                    <div class="kt-portlet__body">
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
                        <input type='hidden' class='form-control' name='iD' id='iD_hidden_<%=i%>' value='<%=ID%>'/>
                        <div class="form-group ">
                            <label>
                                <%=(actionName.equals("edit")) ? (LM.getText(LC.APPROVAL_MODULE_MAP_EDIT_TABLENAME, loginDTO)) : (LM.getText(LC.APPROVAL_MODULE_MAP_ADD_TABLENAME, loginDTO))%>
                                <span class="required"> * </span>
                            </label>
                            <div id='tableName_div_<%=i%>'>
                                <input type='text' class='form-control' name='tableName' id='tableName_text_<%=i%>'
                                       value=<%=actionName.equals("edit")?("'" + approval_module_mapDTO.tableName + "'"):("''")%> required="required"
                                />
                            </div>
                        </div>
                        <div id='hasAddApproval_div_<%=i%>'>
                            <label class="kt-checkbox kt-checkbox--brand">
                                <%=(actionName.equals("edit")) ? (LM.getText(LC.APPROVAL_MODULE_MAP_EDIT_HASADDAPPROVAL, loginDTO)) : (LM.getText(LC.APPROVAL_MODULE_MAP_ADD_HASADDAPPROVAL, loginDTO))%>
                                <input type='checkbox' name='hasAddApproval' id='hasAddApproval_checkbox_<%=i%>'
                                       value='true' <%=(actionName.equals("edit") && String.valueOf(approval_module_mapDTO.hasAddApproval).equals("true"))?("checked"):""%>  >
                                <span></span>
                            </label>
                        </div>
                        <div id='hasEditApproval_div_<%=i%>'>
                            <label class="kt-checkbox kt-checkbox--brand">
                                <%=(actionName.equals("edit")) ? (LM.getText(LC.APPROVAL_MODULE_MAP_EDIT_HASEDITAPPROVAL, loginDTO)) : (LM.getText(LC.APPROVAL_MODULE_MAP_ADD_HASEDITAPPROVAL, loginDTO))%>
                                <input type='checkbox' name='hasEditApproval' id='hasEditApproval_checkbox_<%=i%>'
                                       value='true' <%=(actionName.equals("edit") && String.valueOf(approval_module_mapDTO.hasEditApproval).equals("true"))?("checked"):""%>  >

                                <span></span>
                            </label>
                        </div>
                        <div id='hasDeleteApproval_div_<%=i%>'>
                            <label class="kt-checkbox kt-checkbox--brand">
                                <%=(actionName.equals("edit")) ? (LM.getText(LC.APPROVAL_MODULE_MAP_EDIT_HASDELETEAPPROVAL, loginDTO)) : (LM.getText(LC.APPROVAL_MODULE_MAP_ADD_HASDELETEAPPROVAL, loginDTO))%>
                                <input type='checkbox' name='hasDeleteApproval' id='hasDeleteApproval_checkbox_<%=i%>'
                                       value='true' <%=(actionName.equals("edit") && String.valueOf(approval_module_mapDTO.hasDeleteApproval).equals("true"))?("checked"):""%>  >
                                <span></span>
                            </label>
                        </div>
                        <input type='hidden' class='form-control' name='isDeleted' id='isDeleted_hidden_<%=i%>'
                               value= <%=actionName.equals("edit") ? ("'" + approval_module_mapDTO.isDeleted + "'") : ("'" + "false" + "'")%>/>
                        <input type='hidden' class='form-control' name='lastModificationTime'
                               id='lastModificationTime_hidden_<%=i%>'
                               value=<%=actionName.equals("edit") ? ("'" + approval_module_mapDTO.lastModificationTime + "'") : ("'" + "0" + "'")%>/>
                    </div>
                    <div class="kt-portlet__foot">
                        <div class="kt-form__actions">
                            <a class="btn btn-primary btn-hover-brand btn-square"
                               href="<%=request.getHeader("referer")%>">
                                <%
                                    if (actionName.equals("edit")) {
                                        out.print(LM.getText(LC.APPROVAL_MODULE_MAP_EDIT_APPROVAL_MODULE_MAP_CANCEL_BUTTON, loginDTO));
                                    } else {
                                        out.print(LM.getText(LC.APPROVAL_MODULE_MAP_ADD_APPROVAL_MODULE_MAP_CANCEL_BUTTON, loginDTO));
                                    }

                                %>
                            </a>
                            <button class="btn btn-outline-brand btn-elevate-hover ml-2" type="submit">
                                <%
                                    if (actionName.equals("edit")) {
                                        out.print(LM.getText(LC.APPROVAL_MODULE_MAP_EDIT_APPROVAL_MODULE_MAP_SUBMIT_BUTTON, loginDTO));
                                    } else {
                                        out.print(LM.getText(LC.APPROVAL_MODULE_MAP_ADD_APPROVAL_MODULE_MAP_SUBMIT_BUTTON, loginDTO));
                                    }
                                %>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="nicEdit.js" type="text/javascript"></script>
<script type="text/javascript">
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
    var row = 0;
    bkLib.onDomLoaded(function () {
    });
    window.onload = function () {
        init(row);
    }
    function SetCheckBoxValues(tablename) {
        var i = 0;
        console.log("document.getElementById(tablename).childNodes.length = " + document.getElementById(tablename).childNodes.length);
        var element = document.getElementById(tablename);
        var j = 0;
        for (i = 0; i < document.getElementById(tablename).childNodes.length; i++) {
            var tr = document.getElementById(tablename).childNodes[i];
            if (tr.nodeType === Node.ELEMENT_NODE) {
                console.log("tr.childNodes.length= " + tr.childNodes.length);
                var checkbox = tr.querySelector('input[type="checkbox"]');
                checkbox.id = tablename + "_cb_" + j;
                j++;
            }
        }
    }
</script>