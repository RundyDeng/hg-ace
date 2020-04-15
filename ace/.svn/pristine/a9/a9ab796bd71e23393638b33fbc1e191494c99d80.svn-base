package com.jeefw.controller.BMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.service.pub.PubService;

@Controller
@RequestMapping("/BMap")
public class Housing extends IbaseController {
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService pubSvr;
	
	@RequestMapping("/housing")
	public ModelAndView getAreaNames(HttpServletRequest request, HttpServletResponse response) {
		List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
		if(request.getServletContext().getAttribute(STATIC_USE_ENERGY_FOR_DAY)!=null){
			dataList = (List<Map<String,Object>>)request.getServletContext().getAttribute(STATIC_USE_ENERGY_FOR_DAY);
		}
		HashMap<String, Map<String, Object>> result = new HashMap<String,Map<String,Object>>();
		for (Map map : dataList) {
			result.put((String) map.get("AREANAME"), map);
		}
		Gson gson = new Gson();
		String json = gson.toJson(result);
		return new ModelAndView("back/BMap/housing", "result", json);
	}
}
