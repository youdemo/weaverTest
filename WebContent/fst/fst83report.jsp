<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp"%>
<%@ page import="weaver.common.xtable.*"%>
<HTML>
	<head>
		<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
		<SCRIPT language="javascript" src="/js/weaver.js"></script>
		<link rel='stylesheet' type='text/css' href='/js/extjs/resources/css/ext-all.css' />
		<link rel='stylesheet' type='text/css' href='/js/extjs/resources/css/xtheme-gray.css'/>
		<link rel='stylesheet' type='text/css' href='/css/weaver-ext.css' />
		<script type='text/javascript' src='/js/extjs/adapter/ext/ext-base.js'></script>
		<script type='text/javascript' src='/js/extjs/ext-all.js'></script>   
		<%if(user.getLanguage()==7) {%>
			<script type='text/javascript' src='/js/extjs/build/locale/ext-lang-zh_CN_gbk.js'></script>
			<script type='text/javascript' src='/js/weaver-lang-cn-gbk.js'></script>
		<%} else if(user.getLanguage()==8) {%>
			<script type='text/javascript' src='/js/extjs/build/locale/ext-lang-en.js'></script>
			<script type='text/javascript' src='/js/weaver-lang-en-gbk.js'></script>
		<%}%>
		<script type="text/javascript" src="/js/WeaverTableExt.js"></script>  
		<link rel="stylesheet" type="text/css" href="/css/weaver-ext-grid.css" />
	</head>
	<%
		String lotid = Util.fromScreen3(request.getParameter("lotid"), user.getLanguage());
		String sqlWhere = " where  ASSYLOT = '" + lotid + "'";
	%>
	<BODY>
		<table width=100% height=100% style="margin: 0px;" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<%
					String tableString = "";
					String backfields = " requestname,t1.requestid ";
					String fromSql = " formtable_main_6 t1 join workflow_requestbase t2 on t1.requestid = t2.requestid ";
					String sqlmei = "";
					String orderby = " id ";
					//out.println("sql:"+ "select "+backfields+" from "+fromSql+ sqlWhere);

					ArrayList xTableColumnList = new ArrayList();

					TableColumn xTableColumn3 = new TableColumn();
					xTableColumn3.setColumn("requestname");
					xTableColumn3.setDataIndex("requestname");
					xTableColumn3.setHeader("�������");
					xTableColumn3.setLinkkey("requestid");
					xTableColumn3.setLinkvaluecolumn("requestid");
					xTableColumn3.setHref("/workflow/request/ViewRequest.jsp");
					xTableColumn3.setTarget("_fullwindow");
					xTableColumn3.setSortable(true);
					xTableColumn3.setWidth(0.016);
					xTableColumnList.add(xTableColumn3);

					TableSql xTableSql = new TableSql();
					xTableSql.setBackfields(backfields);
					xTableSql.setPageSize(5);
					xTableSql.setSqlform(fromSql);
					xTableSql.setSqlwhere(sqlWhere);
					xTableSql.setSqlprimarykey("t2.requestid");
					xTableSql.setSqlisdistinct("false");
					xTableSql.setDir(TableConst.DESC);
					xTableSql.setSort(orderby);

					Table xTable = new Table(request);

					xTable.setTableGridType(TableConst.NONE);
					xTable.setTableNeedRowNumber(true);
					xTable.setTableSql(xTableSql);
					xTable.setTableColumnList(xTableColumnList);
				%>
				<td valign="top" style="padding: 0px !important;margin: 0px !important;">
					<%=xTable.toString()%>
				</td>
			</tr>
		</table>
	</BODY>
</HTML>