package com.jeefw.controller.sys;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.service.pub.PubService;
@Controller
@RequestMapping("/sys/approval")
public class ApprovalController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	
	@Resource
	private PubService pubSer;
	@RequestMapping("/getApprovalInfo")
	public void getClientInfo(HttpServletRequest request ,HttpServletResponse response) throws IOException{	
		String sql = "select id,type,content,sql_content,case when status=0 then '未审核' else '已审核' end as status,"
				+ "to_char(ddate,'yyyy-MM-dd HH24:mi:ss') as ddate,username,superior from TAPPROVAL order by ddate desc";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		request.setAttribute("applist", list.get(0));
		
		writeJSON(response, list);
	}
	
	@RequestMapping("/execute")
	public void execute(HttpServletRequest request ,HttpServletResponse response) throws IOException{	
		boolean flag=false;
		String id=request.getParameter("id");
		String sql = "select sql_content,status from TAPPROVAL where id="+id;
		List<Map> list = baseDao.listSqlAndChangeToMap(sql, null);
		
		String sqlwhere=list.get(0).get("SQL_CONTENT").toString();
		String[] sqlw=sqlwhere.split(";");
		String sqlwhere2="update TAPPROVAL set status=1 where id="+id;
		if("0".equals(list.get(0).get("STATUS").toString())){
			if(sqlw.length>1){
				
			    flag=pubSer.executeBatchSql(sqlw[0],sqlw[1],sqlwhere2);
			}else{
			    flag=pubSer.executeBatchSql(sqlw[0],sqlwhere2);
			}
			 	writeJSON(response, "{success:true}");
		}else{
				writeJSON(response, "{success:false}");
		}
		
	}
	
	/**
	 * 消息任务查询
	 * @param request
	 * @param response
	 * @return 
	 * @throws IOException
	 */
	@RequestMapping("/getAppInfo")
	public String getAppInfo(HttpServletRequest request ,HttpServletResponse response) throws IOException{	
		String sql = "select id,content,"
				+ "to_char(ddate,'yyyy-MM-dd HH24:mi:ss') as ddate,username from TAPPROVAL order by ddate desc";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		request.setAttribute("obj", list.get(0));
		System.out.println("@..."+list.get(0).toString());
		return "back/index";
		
	}
	@RequestMapping("/getApproval")
	public String getClient(HttpServletRequest request ,HttpServletResponse response) throws IOException{	
		String sql = "select id,type,content,sql_content,case when status=0 then '未审核' else '已审核' end as status,"
				+ "to_char(ddate,'yyyy-MM-dd HH24:mi:ss') as ddate,username,superior from TAPPROVAL order by ddate desc";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		request.setAttribute("applist", list.get(0));
		System.out.println("applist"+list.get(0));
		return "back/systemmanage/approval";
	}
}
