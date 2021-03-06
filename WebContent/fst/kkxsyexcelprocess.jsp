<%@ page language="java" contentType="text/html; charset=GBK" %>
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

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ExcelParse" class="weaver.file.ExcelParse" scope="page" />
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%
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
		
		String c1 = Util.null2String( excelFile.getValue("1", ""+recordercount , "1" ) ).trim() ;
        if( c1.equals("") ) break ;   //表示已经是最后一行，处理结束
        String c2 = "", c3 = "", c4 = "", c5 = "", c6 = "", c7 = "", c8 = "", c9 = "", c10 = "";
        c2 = Util.null2String( excelFile.getValue("1", ""+recordercount , "2" ) ).trim() ;
        c3 = Util.null2String( excelFile.getValue("1", ""+recordercount , "3" ) ).trim() ;
        c4 = Util.null2String( excelFile.getValue("1", ""+recordercount , "4" ) ).trim() ;
        c5 = Util.null2String( excelFile.getValue("1", ""+recordercount , "5" ) ).trim() ;
        c6 = Util.null2String( excelFile.getValue("1", ""+recordercount , "6" ) ).trim() ;
        c7 = Util.null2String( excelFile.getValue("1", ""+recordercount , "7" ) ).trim() ;
        c8 = Util.null2String( excelFile.getValue("1", ""+recordercount , "8" ) ).trim() ;
        c9 = Util.null2String( excelFile.getValue("1", ""+recordercount , "9" ) ).trim() ;
        c10 = Util.null2String( excelFile.getValue("1", ""+recordercount , "10" ) ).trim() ;
        
        sql = "select * from tb_kkxsy where ph = '" + c1 + "' and lotid = '" + c2 + "'";
        rs.executeSql(sql);
        if(!rs.next()){
        	sql = "insert into tb_kkxsy (ph,lotid,pm,fzlx,jbkj,xpcc,jhs,zhj,sfl,dd) values ("+
        			"'" + c1 + "'," +
        			"'" + c2 + "'," +
    				"'" + c3 + "'," +
    				"'" + c4 + "'," +
    				"'" + c5 + "'," +
    				"'" + c6 + "'," +
    				"'" + c7 + "'," +
    				"'" + c8 + "'," +
    				"'" + c9 + "'," +
    				"'" + c10 + "'" +
    				")";
    	    rs.executeSql(sql); 
            bb.writeLog("kkxsydetailsql:" + sql);
        }
        else{
        	sql = "update tb_kkxsy set pm = '" + c3 + "',fzlx = '" + c4 + "',jbkj = '" + c5 + "', xpcc = '" + c6 + "',jhs = '" +
        	c7 + "',zhj = '" + c8 + "',sfl = '" + c9 + "',dd = '" + c10 + "' where ph = '" + c1 + "' and lotid = '" + c2 + "'";
        	rs.executeSql(sql); 
            bb.writeLog("kkxsydetailsql:" + sql);
        }
    }
	
	if(hasvalid){ 
		out.println("<SCRIPT language=javascript>alert('数据导入成功!')</SCRIPT>");
		out.println("<SCRIPT language=javascript>parent.window.returnValue='1';window.close();</SCRIPT>");
	}
	else{
		out.println("<SCRIPT language=javascript>alert('" + error + "!')</SCRIPT>");
		out.println("<SCRIPT language=javascript>parent.document.getElementById('loading').style.display='none';</SCRIPT>");
	}
%>