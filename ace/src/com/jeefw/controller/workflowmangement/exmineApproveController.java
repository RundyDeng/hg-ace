package com.jeefw.controller.workflowmangement;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.google.gson.Gson;
import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.service.sys.ExamineapproveService;

import core.support.JqGridPageView;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/workflowmanagement/exmineApprove")
public class exmineApproveController extends IbaseController {
	@Resource
	private IBaseDao baseDao ;
//	@Resource
//	private ExamineapproveService exmineapproveService;
	
	@RequestMapping("/getApprove")
	public void getApprove(HttpServletRequest request ,HttpServletResponse response) throws IOException{
		
			Map<String, Object> map = new HashMap<String, Object>();
			//String username = getParm("username");
			boolean flag = false;
			String sqlwhere = "select fid,title,applicator,applictetime,state,url from texmineapprove";
			
			int page = 0;
			int pagesize = Integer.valueOf(getParm("pagesize"));
			if (StringUtils.isBlank(getParm("page")))
				page = 1;
			else
				page = Integer.valueOf(getParm("page"));
			List approve = baseDao.listSqlPageAndChangeToMap(sqlwhere, page, pagesize, null);
			System.out.println("list:"+approve);
			long total = baseDao.countSql(sqlwhere);
			long pageNumber = (total + pagesize - 1) /pagesize;
			map.put("data", approve);
			map.put("pageCount", pageNumber);
			System.out.println("map:"+map);
			writeJSON(response, map);
		}

}
