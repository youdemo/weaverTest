<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.net.URL"%> 
<%@page import="java.net.URLConnection"%> 
<%@page import="java.net.HttpURLConnection"%> 
<%@page import="javax.servlet.http.HttpServletRequest"%> 
<%@page import="javax.servlet.http.HttpServletResponse"%> 
<%@page import="sun.misc.BASE64Decoder"%> 
<%@page import="weaver.system.*"%> 
<%@page import="java.text.SimpleDateFormat"%> 
<%@page import="java.net.InetAddress"%> 
<%@page import="java.net.UnknownHostException"%> 
<%@page import="weaver.conn.RecordSetDataSource"%> 
<%@page import="java.util.*"%> 
<%@page import="java.text.*"%> 
<%@page import="java.math.*"%> 
<%@ page import="weaver.file.*" %>
<%@page import="weaver.conn.*"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*" %>
<%@include file="/systeminfo/init_wev8.jsp" %>
   <%
    String QTTN_PKG_FK =  Util.fromScreen(request.getParameter("QTTN_PKG_FK"),user.getLanguage());
  	String PRDC_TYPE_FK =  Util.fromScreen(request.getParameter("PRDC_TYPE_FK"),user.getLanguage());
  	String GPM =  Util.fromScreen(request.getParameter("GPM"),user.getLanguage());
  	
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete MD_SD_QTTN_PKG_GPM where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MD_SD_QTTN_PKG_GPM set QTTN_PKG_FK = '" + QTTN_PKG_FK +  "', PRDC_TYPE_FK  = '" + PRDC_TYPE_FK + "', GPM  = '" + GPM + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MD_SD_QTTN_PKG_GPM(id,QTTN_PKG_FK,PRDC_TYPE_FK,GPM) values (SYS_GUID()||'',"+
				"'" + QTTN_PKG_FK + "'," +
				"'" + PRDC_TYPE_FK + "'," +
				"'" + GPM + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("gross_margin_appearance_standards.jsp");
   %>
