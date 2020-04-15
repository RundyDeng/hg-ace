package com.jeefw.controller.workflowmangement;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.sys.Changetable;
import com.jeefw.service.sys.ChangetableService;


@Controller
@RequestMapping("/workflowmanagement/changetable")
public class changetableController extends IbaseController {
	@Resource
	private IBaseDao baseDao;
	@Resource
	private ChangetableService changetableSevice;
	
	@RequestMapping("/getChar")
	public void getStatistic(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Map<String, Object> map = new HashMap<String, Object>();
		String sdate = getParm("sdate");
		String edate = getParm("edate");
		String username = getParm("username");
		boolean flag = false;
		String sqlwhere = "select Flowname,Flows,Opertor from changetable where 1=1";
		/*if (StringUtils.isNotBlank(username) && !"null".equals(username)) {
			sqlwhere += " and username='"+username+"'";
			flag = true;
		}
		if (StringUtils.isNotBlank(sdate) && StringUtils.isNotBlank(edate)) {
			sqlwhere += " and operdate between "
	                  +"  to_date('"+sdate+" 00:00:00','yyyy-MM-dd HH24:mi:ss') and "
	                  +"  to_date('"+edate+" 23:59:59','yyyy-MM-dd HH24:mi:ss')";
			flag = true;
		}
		sqlwhere+=" order by operdate desc";
		if (flag != true) {

		}*/
		int page = 0;
		int pagesize = Integer.valueOf(getParm("pagesize"));
		if (StringUtils.isBlank(getParm("page")))
			page = 1;
		else
			page = Integer.valueOf(getParm("page"));
		List eachAreaMeterInfo = baseDao.listSqlPageAndChangeToMap(sqlwhere, page, pagesize, null);
		System.out.println("list:"+eachAreaMeterInfo);
		long total = baseDao.countSql(sqlwhere);
		long pageNumber = (total + pagesize - 1) / pagesize;
		map.put("data", eachAreaMeterInfo);
		map.put("pageCount", pageNumber);
		System.out.println("map:"+map);
		writeJSON(response, map);
	}
}
