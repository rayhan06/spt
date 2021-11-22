<%@page import="language.LC"%>
<%@page import="login.LoginDTO"%>
<%@page import="sessionmanager.SessionConstants"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="language.LM"%>
<%@ page language="java" %>
<%@ page import="util.RecordNavigator"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="searchform.SearchForm"%>
<%@ page import="pb.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>


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

	String Language = LM.getText(LC.APPLICANT_PROFILE_EDIT_LANGUAGE, loginDTO);
	String Options;
	SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
	Date date = new Date();
	String datestr = dateFormat.format(date);
	int pagination_number = 0;
	boolean isPermanentTable = rn.m_isPermanentTable;
	System.out.println("In nav::: isPermanentTable = " + isPermanentTable);
%>






<!-- search control -->
<div class="portlet box portlet-btcl">
	<div class="portlet-title">
		<div class="caption" style="margin-top: 5px;"><i class="fa fa-search-plus"  style="margin-top:-3px"></i><%=pageName%></div>
		<p class="desktop-only" style="float:right; margin:10px 5px !important;">Advanced Search</p>
		<div class="tools">
			<a class="expand" href="javascript:;" data-original-title="" title=""></a>	
		</div>
		
		<div class="col-xs-12 col-sm-5 col-md-4" style="margin-top:10px">
		<%
			
			out.println("<input type='text' class='form-control' onKeyUp='allfield_changed(\"\",0)' id='anyfield'  name='"+  LM.getText(LC.APPLICANT_PROFILE_SEARCH_ANYFIELD, loginDTO) +"' ");
			String value = (String)session.getAttribute(searchFieldInfo[searchFieldInfo.length - 1][1]);
			
			if( value != null)
			{
				out.println("value = '" + value + "'");
			}
			
			out.println ("/><br />");
		%> 
		</div>
		
		
		
	</div>
	<div 
	class="portlet-body form collapse"
	>
		<!-- BEGIN FORM-->
		<div class="container-fluid">
			<div class="row col-lg-offset-1">
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_APPLICANTTYPE, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<select class='form-control'  name='applicant_type' id = 'applicant_type' onSelect='setSearchChanged()'>
<%
			
			Options = CommonDAO.getOptions(Language, "select", "applicant", "applicantType_select_" + row, "form-control", "applicantType", "any" );			
			out.print(Options);
%>
</select>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_SERVICEID, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="service_id" placeholder="" name="service_id" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_SERVICETYPE, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<select class='form-control'  name='service_type' id = 'service_type' onSelect='setSearchChanged()'>
<%
			
			Options = CommonDAO.getOptions(Language, "select", "service", "serviceType_select_" + row, "form-control", "serviceType", "any" );			
			out.print(Options);
%>
</select>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_CHIEFSHAREHOLDERINFO, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="chief_shareholder_info" placeholder="" name="chief_shareholder_info" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_NAME, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="name" placeholder="" name="name" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_FATHERNAME, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="father_name" placeholder="" name="father_name" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_HUSBANDNAME, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="husband_name" placeholder="" name="husband_name" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_ADDRESSPRESENT, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="address_present" placeholder="" name="address_present" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_ADDRESSPERMANENT, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="address_permanent" placeholder="" name="address_permanent" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_NAMEBN, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="name_bn" placeholder="" name="name_bn" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_FATHERNAMEBN, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="father_name_bn" placeholder="" name="father_name_bn" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_HUSBANDNAMEBN, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="husband_name_bn" placeholder="" name="husband_name_bn" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_ADDRESSPRESENTBN, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="address_present_bn" placeholder="" name="address_present_bn" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_ADDRESSPERMANENTBN, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="address_permanent_bn" placeholder="" name="address_permanent_bn" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_NATIONALITY, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="nationality" placeholder="" name="nationality" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_AGE, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="age" placeholder="" name="age" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_GENDER, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="gender" placeholder="" name="gender" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_NID, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="nid" placeholder="" name="nid" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_CAPITAL, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="capital" placeholder="" name="capital" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_PREVIOUS, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="previous" placeholder="" name="previous" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_BANKSOLVENCY, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="bank_solvency" placeholder="" name="bank_solvency" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPLICANT_PROFILE_SEARCH_PICTURE, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="picture" placeholder="" name="picture" onChange='setSearchChanged()'>
					</div>
				</div>

			</div>	


			<div class=clearfix></div>

			<div class="form-actions fluid" style="margin-top:10px">
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-offset-3 col-xs-12 col-md-12  col-md-12 col-lg-9">							
							<div class="col-xs-4  col-sm-4  col-md-6">
								<input type="hidden" name="search" value="yes" />
								<!-- 				          	<input type="reset" class="btn  btn-sm btn btn-circle  grey-mint btn-outline sbold uppercase" value="Reset" > -->
								<input type="submit" onclick="allfield_changed('',0)"
									class="btn  btn-sm btn btn-circle btn-sm green-meadow btn-outline sbold uppercase"
									value="<%=LM.getText(LC.GLOBAL_SEARCH, loginDTO) %>">
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		<!-- END FORM-->
	</div>


<%@include file="../common/pagination_with_go2.jsp"%>


<template id = "loader">
<div class="modal-body">
        <img alt="" class="loading" src="<%=context%>/templates/ViewGrievances_files/loading-spinner-grey.gif">
        <span>Loading...</span>
</div>
</template>


<script type="text/javascript">

	var searchChanged = 0;

	function setValues(x, value)
	{
		for (i = 0; i < x.length; i++)
		{
			 x[i].value = value;
		}
	}
	
	function setInnerHTML(x, value)
	{
		for (i = 0; i < x.length; i++)
		{
			 x[i].innerHTML = value;
		}
	}

	function setPageNoInAllFields(value)
	{
		var x = document.getElementsByName("pageno");
		setValues(x, value);
	}
	
	function setRPPInAllFields(value)
	{
		var x = document.getElementsByName("RECORDS_PER_PAGE");
		setValues(x, value);
	}
	
	function setTotalPageInAllFields(value)
	{
		var x = document.getElementsByName("totalpage");
		setInnerHTML(x, value);
	}

	function setPageNo()
	{
		
		setPageNoInAllFields(document.getElementById('hidden_pageno').value);
		setTotalPageInAllFields(document.getElementById('hidden_totalpage').value);
		console.log("totalpage now is " + document.getElementById('hidden_totalpage').value);
		//document.getElementById('totalpage').innerHTML= document.getElementById('hidden_totalpage').value;
	}
	
	function setSearchChanged()
	{
		searchChanged = 1;
	}
	
	function dosubmit(params)
	{
		document.getElementById('tableForm').innerHTML = document.getElementsByTagName("template")[0].innerHTML;
		//alert(params);
		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) 
		    {
		    	document.getElementById('tableForm').innerHTML = this.responseText ;
				setPageNo();
				searchChanged = 0;
			}
		    else if(this.readyState == 4 && this.status != 200)
			{
				alert('failed ' + this.status);
			}
		  };
		  
		  xhttp.open("Get", "<%=action%>&isPermanentTable=<%=isPermanentTable%>&" + params, true);
		  xhttp.send();
		
	}
	
	function setPageNoAndSubmit(link)
	{
		var value = -1;
		if(link == 1) //next
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
	function allfield_changed(go, pagination_number)
	{
		var params = 'AnyField=' + document.getElementById('anyfield').value;
		<%
			for(int i = 0; i < searchFieldInfo.length - 1; i ++)
			{
				out.println("params += '&" +  searchFieldInfo[i][1] + "='+document.getElementById('" 
					+ searchFieldInfo[i][1] + "').value");
			}
		%>
		params +=  '&search=true&ajax=true';

		var pageNo = document.getElementsByName('pageno')[0].value;
		var rpp = document.getElementsByName('RECORDS_PER_PAGE')[0].value;

		var totalRecords = 0;
		var lastSearchTime = 0;
		if(document.getElementById('hidden_totalrecords'))
		{
			totalRecords = document.getElementById('hidden_totalrecords').value;
			lastSearchTime = document.getElementById('hidden_lastSearchTime').value;
		}


		if(go !== '' && searchChanged == 0)
		{
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

