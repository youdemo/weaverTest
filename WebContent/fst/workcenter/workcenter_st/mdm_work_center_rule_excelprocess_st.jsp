﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.Util,weaver.file.*,java.util.*,java.io.*" %>
<%@ page import="weaver.join.hrm.in.IHrmImportAdapt"%>
<%@ page import="weaver.file.*"%>
<%@ page import="weaver.general.Util,java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="weaver.general.BaseBean"%>
<%@ page import="weaver.join.hrm.in.IHrmImportProcess"%>
<%@ page import="weaver.join.hrm.in.processImpl.HrmImportProcess"%>
<%@ page import="weaver.general.StaticObj"%>
<%@ page import="weaver.conn.RecordSet"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ExcelParse" class="weaver.file.ExcelParse" scope="page" />
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%
	Date date = new Date();
	SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	BaseBean bb = new BaseBean();
	String sql = "";
    FileUploadToPath fu = new FileUploadToPath(request) ;    // 上传EXCEL文件
	String filename = fu.uploadFiles("excelfile") ;    //获取EXCEL路径
	ExcelParse excelFile = new ExcelParse();
	excelFile.init(filename) ;    //进行EXCEL文件初始化
	
	int recordercount = 0 ;
	String error = "";
	boolean hasvalid = true;
	StringBuilder sb = new StringBuilder();
	while( true ) {
		recordercount ++ ;
		//以下一行一行按列读取EXCEL中的数据getValue方法中的第一个参数不要变化，固定为1，第二个参数是行号，第三个参数是列号
		if( recordercount == 1 ) continue ;  //第一行为标题，一般不处理
		
		String c2 = Util.null2String( excelFile.getValue("1", ""+recordercount , "2" ) ).trim() ;
        if( c2.equals("") ) break ;   //表示已经是最后一行，处理结束
        String c3 = "", c4 = "", c5 = "", c6 = "", c7 = "", c8 = "";
        c3 = Util.null2String( excelFile.getValue("1", ""+recordercount , "3" ) ).trim() ;
        c4 = Util.null2String( excelFile.getValue("1", ""+recordercount , "4" ) ).trim() ;
        c5 = Util.null2String( excelFile.getValue("1", ""+recordercount , "5" ) ).trim() ;
        c6 = Util.null2String( excelFile.getValue("1", ""+recordercount , "6" ) ).trim() ;
        c7 = Util.null2String( excelFile.getDateValue("1", ""+recordercount , "7" ) ).trim() ;
        c8 = Util.null2String( excelFile.getDateValue("1", ""+recordercount , "8" ) ).trim() ;
        	sql = "Insert into MDM_WORK_CENTER_RULE_st (ID,OPER_FK,WORK_CENTER_FK, CUST_FK,PKG_OUTLINE_FK,VEHICLE_FK,DATE_CREATE, DATE_UPDATE, DATE_EFFECT, DATE_EXPIRE) Values ( " +
				"SYS_GUID()||'',"+ 
    				"'" + c2 + "'," +
    				"'" + c3 + "'," +
    				"'" + c4 + "'," +
    				"'" + c5 + "'," +
    				"'" + c6 + "'," +
    				"TO_DATE('" + bartDateFormat.format(date) + "','yyyy-MM-dd HH24:mi:ss')," +
    				"TO_DATE('" + bartDateFormat.format(date) + "','yyyy-MM-dd HH24:mi:ss')," +
    				"TO_DATE('" + c7 + "','yyyy-MM-dd HH24:mi:ss')," +
					"TO_DATE('" + c8 + "','yyyy-MM-dd HH24:mi:ss')" +
    				")";
	bb.writeLog("mdm_work_center_rule_detailsql:" + sql);
    	    rs.executeSql(sql); 
            bb.writeLog("mdm_work_center_rule_detailsql:" + sql);
    }
	
	if(hasvalid){ 
		out.println("<SCRIPT language=javascript>alert('数据导入成功!')</SCRIPT>");
		out.println("<SCRIPT language=javascript>parent.window.returnValue='1';window.open('','_top').close();</SCRIPT>");
	}
	else{
		out.println("<SCRIPT language=javascript>alert('" + error + "!')</SCRIPT>");
		out.println("<SCRIPT language=javascript>parent.document.getElementById('loading').style.display='none';</SCRIPT>");
	}
%>