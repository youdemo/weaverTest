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
    String name =  Util.fromScreen(request.getParameter("name"),user.getLanguage());
  	String FULL_NAME =  Util.fromScreen(request.getParameter("FULL_NAME"),user.getLanguage());
  	String REASON =  Util.fromScreen(request.getParameter("REASON"),user.getLanguage());
  	String RATE =  Util.fromScreen(request.getParameter("RATE"),user.getLanguage());

  	
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete MD_SD_GPM_RANG_AR where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MD_SD_GPM_RANG_AR set name = '" + name + "',FULL_NAME = '" + FULL_NAME +  "', REASON  = '" + REASON + "', RATE  = '" + RATE + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MD_SD_GPM_RANG_AR(id,name,APPROVEL_LEVEL_FK,FPA_REASON ,RATE) values (SYS_GUID()||'',"+
				"'" + name + "'," +
				"'" + APPROVEL_LEVEL_FK + "'," +
				"'" + FPA_REASON + "'," +
				"'" + RATE + "'" +
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("gross_margin_range_nuclear_permissions.jsp");
   %>
