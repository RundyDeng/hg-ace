package com.jeefw.controller.priceManage;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.sys.SysUser;
import com.jeefw.service.pub.PubService;
@Controller
@RequestMapping("/priceMange/setChargeDate")
public class SetChargeDateController extends IbaseController{
	@Resource
	private IBaseDao baseDao;  //
	@Resource
	private PubService pubSvr;
	/**
	 * 设置小区收费时间
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/setchargedate")
	public void setchargedate(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String areaguids=request.getParameter("areaguid");
		String years=request.getParameter("years");
		String bdate=request.getParameter("bdate");
		String adate=request.getParameter("adate");
		areaguids=areaguids.substring(0, areaguids.length()-1);
		String sqlwhere="update tarea set years='"+years+"',bdate=to_date('"+bdate+"','yyyy/MM/dd'),"
				+ "adate=to_date('"+adate+"','yyyy/MM/dd') where areaguid in("+areaguids+")";
         boolean flag = pubSvr.executeBatchSql(sqlwhere);
        SysUser sysUser = (SysUser) request.getSession().getAttribute(SESSION_SYS_USER);
 		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
 		String bz="";
 		if(flag==true){
			bz="成功";
		}
		else{
			bz="失败";
		}
 		flag=pubSvr.adduserlog(sysUser.getUserName(),"设置小区收费时间", bz);
		writeJSON(response, flag);
	}
}
