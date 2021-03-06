<%@ page contentType="text/html; charset=UTF-8" %>
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
		
		String c2 = Util.null2String( excelFile.getValue("1", ""+recordercount , "2" ) ).trim() ;
		
        if( c2.equals("") ) break ;   //表示已经是最后一行，处理结束
		
        String c3 = Util.null2String( excelFile.getValue("1", ""+recordercount , "3" ) ).trim() ;
        String c4 = Util.null2String( excelFile.getValue("1", ""+recordercount , "4" ) ).trim() ;
        String c5 = Util.null2String( excelFile.getValue("1", ""+recordercount , "5" ) ).trim() ;
        String c6 = Util.null2String( excelFile.getValue("1", ""+recordercount , "6" ) ).trim() ;
        String c7 = Util.null2String( excelFile.getValue("1", ""+recordercount , "7" ) ).trim() ;
        String c8 = Util.null2String( excelFile.getValue("1", ""+recordercount , "8" ) ).trim() ;
        String c9 = Util.null2String( excelFile.getValue("1", ""+recordercount , "9" ) ).trim() ;
        String c10 = Util.null2String( excelFile.getValue("1", ""+recordercount , "10" ) ).trim() ;
        //sql = "select * from tb_llyc where khm = '" + c2 + "' and xh = '" + c3 + "' and tester = '" + c4 + "' and pkid = '" + c5 + "'";
        //rs.executeSql(sql);
        //if(!rs.next()){
        String COST_DIE_CAT_FK ="";
        
	if (c3.equals("磨片")){
		COST_DIE_CAT_FK = "15F70EF9474B2889E0531D3C10ACD851";
	}else if (c3.equals("划片")){
		COST_DIE_CAT_FK = "15F70EF9474C2889E0531D3C10ACD851";
	}else if (c3.equals("装片")){
		COST_DIE_CAT_FK = "15F70EF9474D2889E0531D3C10ACD851";
	}
	
	if(!c4.equals("")){
		sql = "select id from MD_SD_MOUNTING_MTRL_SPEC where name='" +c4+"'";
		rs.executeSql(sql);
		if(rs.getCounts()>0){
			while(rs.next()){
			String MTRL_SPEC = rs.getString("id");
					sql ="insert into MD_SD_COST_DIE (id,QTTN_PKG_FK,COST_DIE_CAT_FK,MTRL_SPEC,MATERIAL,LABOUR,POWER,DEPR,OTHER,MAINTENANCE_COST) values (SYS_GUID()||'',"+
    				"'" + c2 + "'," +
    				"'" + COST_DIE_CAT_FK + "'," +
    				"'" + MTRL_SPEC + "'," +
    				"'" + c5 + "'," +
    				"'" + c6 + "'," +
    				"'" + c7 + "'," +
    				"'" + c8 + "'," +
    				"'" + c9 + "'," +
    				"'" + c10 + "'" +
    				")";
		  rs.executeSql(sql)
			  bb.writeLog("MD_SD_COST_DIE:" + sql);
			  }
		}else{
		String  MTRL_SPEC =UUID.randomUUID().toString().replace("-","");

		sql ="insert into MD_SD_COST_DIE (id,QTTN_PKG_FK,COST_DIE_CAT_FK,MTRL_SPEC,MATERIAL,LABOUR,POWER,DEPR,OTHER,MAINTENANCE_COST) values (SYS_GUID()||'',"+
    				"'" + c2 + "'," +
    				"'" + COST_DIE_CAT_FK + "'," +
    				"'" + MTRL_SPEC + "'," +
    				"'" + c5 + "'," +
    				"'" + c6 + "'," +
    				"'" + c7 + "'," +
    				"'" + c8 + "'," +
    				"'" + c9 + "'," +
    				"'" + c10 + "'" +
    				")";
		  rs.executeSql(sql);  
		  bb.writeLog("MD_SD_COST_DIE:" + sql);
		  sql = "insert into MD_SD_MOUNTING_MTRL_SPEC (id,NAME) values ("+
    				"'" + MTRL_SPEC + "'," +
    				"'" + c4 + "'" +
    				")";
		  rs.executeSql(sql);  
		  bb.writeLog("MD_SD_MOUNTING_MTRL_SPEC:" + sql);				
		}
	}else{
		sql ="insert into MD_SD_COST_DIE (id,QTTN_PKG_FK,COST_DIE_CAT_FK,MATERIAL,LABOUR,POWER,DEPR,OTHER,MAINTENANCE_COST) values (SYS_GUID()||'',"+
    				"'" + c2 + "'," +
    				"'" + COST_DIE_CAT_FK + "'," +
    				"'" + c5 + "'," +
    				"'" + c6 + "'," +
    				"'" + c7 + "'," +
    				"'" + c8 + "'," +
    				"'" + c9 + "'," +
    				"'" + c10 + "'" +
    				")";
		  rs.executeSql(sql); 
		  
		  bb.writeLog("MD_SD_COST_DIE:" + sql);
	}

        //}
        //else{
        //	sql = "update tb_llyc set workcode ='" + c6 + "' where khm = '" + c2 + "' and xh = '" + c3 + "' and tester = '" + c4 + "' and pkid = '" + c5 + "'";
    	//    rs.executeSql(sql); 
        //    bb.writeLog("llycdetailsql:" + sql);
        //}
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