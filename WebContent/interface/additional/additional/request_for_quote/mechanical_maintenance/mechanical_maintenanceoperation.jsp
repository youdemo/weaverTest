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
  	String SORT =  Util.fromScreen(request.getParameter("SORT"),user.getLanguage());
  	
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete MD_HANDLER where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  MD_HANDLER set name = '" + name + "',sort = '" + SORT +  "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into MD_HANDLER(id,name,sort) values (SYS_GUID()||'',"+
				"'" + name + "'," +
				"'" + SORT + "'" +
				")";
				
		rs.executeSql(sql);
		sql ="select  * from MD_HANDLER where name ='"+name+"' ";
		rs.executeSql(sql);
		String vid  ="";
		if(rs.next()){
			vid=rs.getString("id");
		}
		
		sql = "insert into MD_SD_HANDLER_COST(id,HANDLER_FK) values (SYS_GUID()||'',"+
				"'" + vid + "'" +
				")";
		rs.executeSql(sql);
		
    }
    response.sendRedirect("mechanical_maintenance.jsp");
   %>
