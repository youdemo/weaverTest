<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/systeminfo/init_wev8.jsp"%>
<%@ page import="weaver.general.Util,java.util.List,java.util.ArrayList"%>
<%@ page import="weaver.general.Util,java.text.*,weaver.conn.*,weaver.soa.workflow.request.*" %>
<%@ page import="java.util.*" %>
<%@ page import="weaver.file.*" %>
<%@ page import="java.text.*" %>
<%@ taglib uri="/WEB-INF/tld/browser.tld" prefix="brow"%>
<HTML>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver_wev8.css>
</HEAD>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<script language=javascript src="/js/jquery/jquery-1.4.2.min_wev8.js"></script>
<%
	String imagefilename = "/images/hdMaintenance.gif";
	String titlename = "包装成本";
	String needfav = "1";
	String needhelp = "";
%>
<%
	int userId = user.getUID();
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(d);
	String id =  Util.fromScreen(request.getParameter("id"),user.getLanguage());
	String QTTN_PKG_FK = "",MAT = "",GRADE = "",MATERIAL = "",MAINTENANCE_COST= "";
    String LABOUR = "",POWER = "",DEPR = "",OTHER = "",PACKING_FK= "",PACKING_GRADE_FK= "";
	RecordSet rs = new RecordSet();
	if(!id.equals("")){
		rs.executeSql("select a.PACKING_FK,a.PACKING_GRADE_FK,A.QTTN_PKG_FK,b.name as MAT ,c.name as  GRADE,MATERIAL,MAINTENANCE_COST,LABOUR,POWER,DEPR,OTHER from MD_SD_COST_PACKING a left join MD_SD_PACKING b on A.PACKING_FK =b.id left join MD_SD_PACKING_GRADE c on A.PACKING_GRADE_FK =c.id where a.id ='"+id+"'");
		if(rs.next()){
			QTTN_PKG_FK = rs.getString("QTTN_PKG_FK");
			MAT = rs.getString("MAT");
			GRADE = rs.getString("GRADE");
			MATERIAL = rs.getString("MATERIAL");
			MAINTENANCE_COST = rs.getString("MAINTENANCE_COST");
			LABOUR = rs.getString("LABOUR");
			POWER = rs.getString("POWER");
			DEPR = rs.getString("DEPR");
			OTHER = rs.getString("OTHER");
			PACKING_FK = rs.getString("PACKING_FK");
			PACKING_GRADE_FK = rs.getString("PACKING_GRADE_FK");
		}
	}
	String type = "";
	if (id.equals("")) {
		type = "add";
	} else {
		type = "modi";
	}
%>
<BODY>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp"%>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp"%>
	<%
		//保存
		RCMenu += "{" + SystemEnv.getHtmlLabelName(86, user.getLanguage()) + ",javascript:doSave(this),_self} ";
		RCMenuHeight += RCMenuHeightStep;
		//返回
		RCMenu += "{" + SystemEnv.getHtmlLabelName(1290, user.getLanguage()) + ",javascript:location.href='pack_cost.jsp',_self} ";
		RCMenuHeight += RCMenuHeightStep;
	%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp"%>
	<table width=100% height=100% border="0" cellspacing="0"
		cellpadding="0">
		<colgroup>
			<col width="10">
			<col width="">
			<col width="10">
		</colgroup>
		<tr>
			<td height="10" colspan="3"></td>
		</tr>
		<tr>
			<td></td>
			<td valign="top">
				<FORM id=weaver NAME=frmmain STYLE="margin-bottom: 0" action="pack_costoperation.jsp" method=post>
				<input type=hidden name=type value='<%=type %>'>
				<input type=hidden name='id' value='<%=id%>'>
					<table style="width: 80%" class=ListStyle>
						<TBODY>
							<TR>
								<td align="right">外形：</td>
								<td align="left">
								<p>
									<brow:browser name="QTTN_PKG_FK" viewType="0" hasBrowser="true" hasAdd="false"
										  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.cont_config'
						 				  isMustInput="1"
						  				  isSingle="false"
						 				  hasInput="true"
										  completeUrl=""  width="200px"
										  browserValue='<%=QTTN_PKG_FK %>'
										  browserSpanValue='<%=QTTN_PKG_FK %>'
										/>									
								</p>										
								</td>
							</TR>
							<TR>
								<td align="right">包装材料：</td>
								<td align="left">
								<p>
									<brow:browser name="MAT" viewType="0" hasBrowser="true" hasAdd="false"
										  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.MD_SD_PACKING'
						 				  isMustInput="1"
						  				  isSingle="false"
						 				  hasInput="true"
										  completeUrl=""  width="200px"
										  browserValue='<%=PACKING_FK %>'
										  browserSpanValue='<%=MAT %>'
										/>									
								</p>										
								</td>
							</TR>
							<TR>
								<td align="right">包装档次：</td>
								<td align="left">
								<p>
									<brow:browser name="GRADE" viewType="0" hasBrowser="true" hasAdd="false"
										  browserUrl='/systeminfo/BrowserMain.jsp?url=/interface/CommonBrowser.jsp?type=browser.MD_SD_PACKING_GRADE'
						 				  isMustInput="1"
						  				  isSingle="false"
						 				  hasInput="true"
										  completeUrl=""  width="200px"
										  browserValue='<%=PACKING_GRADE_FK %>'
										  browserSpanValue='<%=GRADE %>'
										/>									
								</p>										
								</td>
							</TR>
							<TR>
								<td align="right">材料费用：</td>
								<td align="left">
									<input type='text' id='MATERIAL' name='MATERIAL' value='<%=MATERIAL %>' />
								</td>
							</TR>
							<TR>
								<td align="right">维修费用：</td>
								<td align="left">
									<input type='text' id='MAINTENANCE_COST' name='MAINTENANCE_COST' value='<%=MAINTENANCE_COST %>' />
								</td>
							</TR>
							<TR>
								<td align="right">人工费用：</td>
								<td align="left">
									<input type='text' id='LABOUR' name='LABOUR' value='<%=LABOUR %>' />
								</td>
							</TR>
							<TR>
								<td align="right">动力费用：</td>
								<td align="left">
									<input type='text' id='POWER' name='POWER' value='<%=POWER %>' />
								</td>
							</TR>
							<TR>
								<td align="right">折旧费用：</td>
								<td align="left">
									<input type='text' id='DEPR' name='DEPR' value='<%=DEPR %>' />
								</td>
							</TR>
							<TR>
								<td align="right">其他费用：</td>
								<td align="left">
									<input type='text' id='OTHER' name='OTHER' value='<%=OTHER %>' />
								</td>
							</TR>
					</TABLE>
				</FORM>
			</td>
		</tr>
		<tr>
			<td height="10" colspan="3"></td>
		</tr>
	</table>
	<script language=javascript>
		function doSave(obj) {
			document.frmmain.submit();
		}
	</script>
</body>
<SCRIPT language="javascript" defer="defer"
	src="/js/JSDateTime/WdatePicker_wev8.js"></script>
<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
</html>