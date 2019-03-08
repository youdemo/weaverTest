package weaver.interfaces.workflow.action;

import org.json.JSONObject;
import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.interfaces.schedule.CCMEMES83SCH;
import weaver.soa.workflow.request.RequestInfo;

public class CCMEMES6605 implements Action {
	 private static final String url = "http://172.16.60.96:8090/MesWebService/req";
	 public  static final String token ="AWK18VSE25SDNKLS3AET@EWL#LDG*!F";
	
	public String execute(RequestInfo request) {
		try {
			BaseBean baseBean = new BaseBean();
			RecordSet rs = new RecordSet();
			int formId = request.getRequestManager().getFormid();
			
			String sql = "select TIGGERID,cz1,sfqcqr from formtable_main_" + formId + " where requestid = " + request.getRequestid();
			baseBean.writeLog(sql);
			rs.executeSql(sql);
			rs.next();
			String id = rs.getString("TIGGERID");
            String qc = rs.getString("sfqcqr");
			String cz1 = rs.getString("cz1");
			
			sql = "select selectname from workflow_selectitem where fieldid = 6742 and selectvalue = " + cz1;
			baseBean.writeLog(sql);
			rs.executeSql(sql);
			rs.next();
			cz1 = rs.getString("selectname");
			if(cz1.length() > 15){
				cz1 = cz1.substring(0, 15);	
			}
			
			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 
			String udpatetime = sdf.format(date);

	
            JSONObject req = new JSONObject();
			req.put("fromSystem", "OA");
			req.put("functionName", "MES_UPDATEOATESTYIELDINFO");
			req.put("token", token);
			
	        JSONObject message = new JSONObject();
			message.put("id", id);
			sql = "update LLYC_MIDDLE set flag = '200'";
			/* 
			if(!cz1.equals("")){
				sql += ",resv_field4 = '" + cz1 + "'";	
			}*/
			
			JSONObject[] updateInfos = new JSONObject[3];
			updateInfos[0] = new JSONObject();
			updateInfos[0].put("updateField", "FLAG");
			updateInfos[0].put("updateValue", "200");
			updateInfos[1] = new JSONObject();
			updateInfos[1].put("updateField", "UPDATE_TIME");
			updateInfos[1].put("updateValue", udpatetime);
			if(!cz1.equals("")){
				sql += ",resv_field4 = '" + cz1 + "'";
				updateInfos[2] = new JSONObject();
				updateInfos[2].put("updateField", "RESV_FIELD4");
				updateInfos[2].put("updateValue", cz1);
			}else{
	        	updateInfos[2] = new JSONObject(); 
				updateInfos[2].put("updateField", "RESV_FIELD4");
				updateInfos[2].put("updateValue", " ");
	        }
			sql += ",UPDATE_TIME = '" + udpatetime + "' where id = " + id;
			message.put("updateInfoList", updateInfos);
			req.put("message", message);
			
			String retSrcs = CCMEMES83SCH.readInterfacePost(url,req.toString());
			
			JSONObject results = new JSONObject(retSrcs);
			
			String statusValue = results.get("statusValue").toString();
			if(statusValue.equals("0")){
			baseBean.writeLog(sql);
			rs.execute(sql);
			}
			
		}
		catch(java.lang.Exception e){
			BaseBean baseBean = new BaseBean();
			baseBean.writeLog("start log");
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("NFMEMES12251 error:" + e.getMessage());
			baseBean.writeLog("------------------------------------------------------------------------");
			baseBean.writeLog("end log");
		}
		return Action.SUCCESS;
	}
}
