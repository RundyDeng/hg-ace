package com.jeefw.controller.baseinfomanage;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;

@RequestMapping("/baseinfomanage/areaPointContr")
@Controller
public class AreaPointController extends IbaseController{
	@Resource
	private IBaseDao baseDao;

	@RequestMapping(value = "/setAreaPoint", method = {RequestMethod.POST})
	public void setAreaPoint(HttpServletRequest request , HttpServletResponse response) throws IOException{
		//b_point_lng number,b_point_lat number
		String sql = "update tarea set  b_point_lng = "+getParm("point[lng]")+",b_point_lat="+getParm("point[lat]")
				+ " where areaguid = "+getParm("areaGuid");
		writeJSON(response, baseDao.execuSql(sql, null));
	}
	

}
