<%@page import="language.LC" %>
<%@page import="login.LoginDTO" %>
<%@page import="sessionmanager.SessionConstants" %>
<%@page import="org.apache.commons.lang3.StringUtils" %>
<%@page import="language.LM" %>
<%@ page language="java" %>
<%@ page import="util.RecordNavigator" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="searchform.SearchForm" %>
<%@ page import="pb.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    System.out.println("Inside nav.jsp");
    String url = request.getParameter("url");
    String navigator = request.getParameter("navigator");
    String pageName = request.getParameter("pageName");
    if (pageName == null)
        pageName = "Search";
    String pageno = "";
    LoginDTO loginDTO = (LoginDTO) request.getSession(true).getAttribute(SessionConstants.USER_LOGIN);
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
    String searchFieldInfo[][] = rn.getSearchFieldInfo();
    String totalPage = "1";
    if (rn != null)
        totalPage = rn.getTotalPages() + "";
    int row = 0;
    String Language = LM.getText(LC.APPROVAL_MODULE_MAP_EDIT_LANGUAGE, loginDTO);
    String Options;
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date date = new Date();
    String datestr = dateFormat.format(date);
    int pagination_number = 0;
%>
<div class="kt-portlet">
    <div class="kt-portlet__head">
        <div class="caption kt-portlet__head-label d-flex flex-column py-3">
            <h3 class="kt-portlet__head-title mr-auto pb-3">
                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px"
                     height="24px" viewBox="0 0 24 24" version="1.1" class="kt-svg-icon">
                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                        <rect x="0" y="0" width="24" height="24"/>
                        <path
                                d="M12.8434797,16 L11.1565203,16 L10.9852159,16.6393167 C10.3352654,19.064965 7.84199997,20.5044524 5.41635172,19.8545019 C2.99070348,19.2045514 1.55121603,16.711286 2.20116652,14.2856378 L3.92086709,7.86762789 C4.57081758,5.44197964 7.06408298,4.00249219 9.48973122,4.65244268 C10.5421727,4.93444352 11.4089671,5.56345262 12,6.38338695 C12.5910329,5.56345262 13.4578273,4.93444352 14.5102688,4.65244268 C16.935917,4.00249219 19.4291824,5.44197964 20.0791329,7.86762789 L21.7988335,14.2856378 C22.448784,16.711286 21.0092965,19.2045514 18.5836483,19.8545019 C16.158,20.5044524 13.6647346,19.064965 13.0147841,16.6393167 L12.8434797,16 Z M17.4563502,18.1051865 C18.9630797,18.1051865 20.1845253,16.8377967 20.1845253,15.2743923 C20.1845253,13.7109878 18.9630797,12.4435981 17.4563502,12.4435981 C15.9496207,12.4435981 14.7281751,13.7109878 14.7281751,15.2743923 C14.7281751,16.8377967 15.9496207,18.1051865 17.4563502,18.1051865 Z M6.54364977,18.1051865 C8.05037928,18.1051865 9.27182488,16.8377967 9.27182488,15.2743923 C9.27182488,13.7109878 8.05037928,12.4435981 6.54364977,12.4435981 C5.03692026,12.4435981 3.81547465,13.7109878 3.81547465,15.2743923 C3.81547465,16.8377967 5.03692026,18.1051865 6.54364977,18.1051865 Z"
                                fill="#000000"/>
                    </g>
                </svg>
                <%=pageName%>
            </h3>
            <div class="w-100">
                <%
                    out.println("<input type='text' class='form-control' onKeyUp='anyfield_changed(\"\")' id='anyfield'  name='" + LM.getText(LC.APPROVAL_MODULE_MAP_SEARCH_ANYFIELD, loginDTO) + "' ");
                    String value = "";
                    if (value != null) {
                        out.println("value = '" + value + "'");
                    }
                    out.println("/><br />");
                %>
            </div>
        </div>
        <div class="kt-portlet__head-toolbar">
            <div class="kt-portlet__head-wrapper">
                <div class="kt-portlet__head-actions" id="accordion">
                    <div id="collapse-button">
                        <a href="#collapse-form" class="btn btn-primary btn-hover-brand btn-square btn-icon-sm"
                           data-toggle="collapse" aria-expanded="false" aria-controls="collapse-form">
                            <i class=""></i> <%=LM.getText(LC.GLOBAL_SEARCH_ADVANCE_SEARCH, loginDTO)%>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="kt-portlet__body px-5">
        <div class="row">
            <div class="col-sm-12 col-md-8 offset-2">
                <form class="collapse kt-form pb-3" id="collapse-form" aria-labelledby="collapse-button"
                      data-parent="#accordion">
                    <div class="form-group row">
                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                            <label><%=LM.getText(LC.APPROVAL_MODULE_MAP_SEARCH_TABLENAME, loginDTO)%></label>
                            <input type="text" class="form-control" id="table_name" placeholder="" name="table_name"
                                   onChange='setSearchChanged()'>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                            <label><%=LM.getText(LC.APPROVAL_MODULE_MAP_SEARCH_HASADDAPPROVAL, loginDTO)%></label>
                            <input type="text" class="form-control" id="has_add_approval" placeholder=""
                                   name="has_add_approval" onChange='setSearchChanged()'>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                            <label><%=LM.getText(LC.APPROVAL_MODULE_MAP_SEARCH_HASEDITAPPROVAL, loginDTO)%></label>
                            <input type="text" class="form-control" id="has_edit_approval" placeholder=""
                                   name="has_edit_approval" onChange='setSearchChanged()'>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                            <label><%=LM.getText(LC.APPROVAL_MODULE_MAP_SEARCH_HASDELETEAPPROVAL, loginDTO)%></label>
                            <input type="text" class="form-control" id="has_delete_approval" placeholder=""
                                   name="has_delete_approval" onChange='setSearchChanged()'>
                        </div>
                    </div>
                    <div class="kt-form__actions pt-3">
                        <input type="hidden" name="search" value="yes"/>
                        <input type="submit" onclick="allfield_changed()" class="btn btn-primary"
                               value="<%=LM.getText(LC.GLOBAL_SEARCH, loginDTO) %>">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <template id="loader">
        <div class="modal-body">
            <img alt="" class="loading" src="<%=context%>/templates/ViewGrievances_files/loading-spinner-grey.gif">
            <span>Loading...</span>
        </div>
    </template>
    <script type="text/javascript">
        var searchChanged = 0;
        function setValues(x, value) {
            for (i = 0; i < x.length; i++) {
                x[i].value = value;
            }
        }
        function setPageNoInAllFields(value) {
            var x = document.getElementsByName("pageno");
            setValues(x, value);
        }
        function setRPPInAllFields(value) {
            var x = document.getElementsByName("RECORDS_PER_PAGE");
            setValues(x, value);
        }
        function setTotalPageInAllFields(value) {
            var x = document.getElementsByName("totalpage");
            setValues(x, value);
        }
        function setPageNo() {
            setPageNoInAllFields(document.getElementById('hidden_pageno').value);
            setTotalPageInAllFields(document.getElementById('hidden_totalpage').value);
            console.log("totalpage now is " + document.getElementById('hidden_totalpage').value);
        }
        function setSearchChanged() {
            searchChanged = 1;
        }
        function dosubmit(params) {
            document.getElementById('tableForm').innerHTML = document.getElementsByTagName("template")[0].innerHTML;
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    document.getElementById('tableForm').innerHTML = this.responseText;
                    setPageNo();
                    searchChanged = 0;
                }
                else if (this.readyState == 4 && this.status != 200) {
                    alert('failed ' + this.status);
                }
            };
            xhttp.open("Get", "<%=action%>&" + params, true);
            xhttp.send();
        }
        function anyfield_changed(go) {
            var lastSearchTime = document.getElementById('hidden_lastSearchTime').value;
            var totalRecords = document.getElementById('hidden_totalrecords').value;
            var params = 'AnyField=' + document.getElementById('anyfield').value
                + '&search=true&ajax=true&RECORDS_PER_PAGE=' + document.getElementsByName('RECORDS_PER_PAGE')[0].value
                + '&pageno=' + document.getElementsByName('pageno')[0].value
            ;
            params += '&TotalRecords=' + totalRecords;
            params += '&lastSearchTime=' + lastSearchTime;
            dosubmit(params);
        }
        function setPageNoAndSubmit(link) {
            var value = -1;
            if (link == 1) //next
            {
                value = parseInt(document.getElementsByName('pageno')[0].value, 10) + 1;
            }
            else if (link == 2) //previous
            {
                value = parseInt(document.getElementsByName('pageno')[0].value, 10) - 1;
            }
            else if (link == 3) //last
            {
                value = document.getElementById('hidden_totalpage').value;
            }
            else // 1st
            {
                value = 1
            }
            setPageNoInAllFields(value);
            console.log('pageno = ' + document.getElementsByName('pageno')[0].value);
            allfield_changed('go', 0);
        }
        function allfield_changed(go, pagination_number) {
            var params = 'AnyField=' + document.getElementById('anyfield').value;
            <%
            for(int i = 0; i < searchFieldInfo.length - 1; i ++)
            {
                out.println("params += '&" +  searchFieldInfo[i][1] + "='+document.getElementById('"
                    + searchFieldInfo[i][1] + "').value");
            }
            %>
            params += '&search=true&ajax=true';
            var pageNo = document.getElementsByName('pageno')[0].value;
            var rpp = document.getElementsByName('RECORDS_PER_PAGE')[0].value;
            var totalRecords = document.getElementById('hidden_totalrecords').value;
            var lastSearchTime = document.getElementById('hidden_lastSearchTime').value;
            if (go !== '' && searchChanged == 0) {
                console.log("go found");
                params += '&go=1';
                pageNo = document.getElementsByName('pageno')[pagination_number].value;
                rpp = document.getElementsByName('RECORDS_PER_PAGE')[pagination_number].value;
                setPageNoInAllFields(pageNo);
                setRPPInAllFields(rpp);
            }
            params += '&pageno=' + pageNo;
            params += '&RECORDS_PER_PAGE=' + rpp;
            params += '&TotalRecords=' + totalRecords;
            params += '&lastSearchTime=' + lastSearchTime;
            dosubmit(params);
        }
    </script>