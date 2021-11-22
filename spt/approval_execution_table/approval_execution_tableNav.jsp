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

	String Language = LM.getText(LC.APPROVAL_EXECUTION_TABLE_EDIT_LANGUAGE, loginDTO);
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
			
			out.println("<input type='text' class='form-control' onKeyUp='allfield_changed(\"\",0)' id='anyfield'  name='"+  LM.getText(LC.APPROVAL_EXECUTION_TABLE_SEARCH_ANYFIELD, loginDTO) +"' ");
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
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_SEARCH_TABLENAME, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="table_name" placeholder="" name="table_name" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_SEARCH_PREVIOUSROWID, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="previous_row_id" placeholder="" name="previous_row_id" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_SEARCH_UPDATEDROWID, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="updated_row_id" placeholder="" name="updated_row_id" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_SEARCH_OPERATION, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="operation" placeholder="" name="operation" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_SEARCH_ACTION, loginDTO)%></label>
					</div>
					
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="action" placeholder="" name="action" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_SEARCH_APPROVALSTATUSCAT, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<select class='form-control'  name='approval_status_cat' id = 'approval_status_cat' onSelect='setSearchChanged()'>
<%
			
			Options = CatDAO.getOptions(Language, "approval_status", -2);
			out.print(Options);
%>
</select>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_SEARCH_USERID, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="user_id" placeholder="" name="user_id" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_SEARCH_USERIP, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="user_ip" placeholder="" name="user_ip" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_SEARCH_APPROVALPATHID, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="approval_path_id" placeholder="" name="approval_path_id" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_SEARCH_APPROVALPATHORDER, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="approval_path_order" placeholder="" name="approval_path_order" onChange='setSearchChanged()'>
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" style="margin-top: 5px;">
					<div class="col-xs-2 col-sm-4 col-md-4">
						<label for="" class="control-label pull-right"><%=LM.getText(LC.APPROVAL_EXECUTION_TABLE_SEARCH_REMARKS, loginDTO)%></label>
					</div>
					<div class="col-xs-10 col-sm-8 col-md-8">
						<input type="text" class="form-control" id="remarks" placeholder="" name="remarks" onChange='setSearchChanged()'>
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
									class="btn  btn-sm btn btn-circle btn-sm green-meadow btn-outline sbold uppercase advanceseach"
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
		
		var extraParams = document.getElementsByName('extraParam');
		extraParams.forEach((param) => {
			params += "&" + param.getAttribute("tag") + "=" + param.value;
        })
		
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

