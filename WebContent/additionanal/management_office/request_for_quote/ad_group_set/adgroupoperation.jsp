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
   	int userID = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	String date = sdf.format(d); 
    String groupname =  Util.fromScreen(request.getParameter("groupname"),user.getLanguage());
    String id = request.getParameter("id");
    String type = request.getParameter("type");
    String sql = "";
    RecordSet rs = new RecordSet();
    if(type.equals("del")){
	    sql = "delete ADGROUPINFO where id  = '"+id+"'";
	    rs.executeSql(sql);
    }
    else if(type.equals("modi")){
    	sql = "update  ADGROUPINFO set groupname = '" + groupname + "',updater = '" + userID + "',updatetime = '" + date + "' where id = '"+id+"'";
		rs.executeSql(sql);
    }
    else if(type.equals("add")){
    	sql = "insert into ADGROUPINFO(groupname,creater,createtime) values ("+
				"'" + groupname + "'," +
				"'" + userID + "'," +
				"'" + date + "'" +	
				")";
		rs.executeSql(sql);
    }
    response.sendRedirect("adgroup.jsp");
   %>
