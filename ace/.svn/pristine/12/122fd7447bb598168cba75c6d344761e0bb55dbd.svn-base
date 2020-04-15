package com.jeefw.controller.sys;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;

@Controller
@RequestMapping("/sys/chooseTableContr")
public class ChooseTableController extends IbaseController {
	@Resource
	private IBaseDao baseDao;
	
	@RequestMapping("/getChooseTable")
	public void getChooseTable(HttpServletRequest request,HttpServletResponse response) throws IOException{
		
		writeJSON(response, null);
	}
	@RequestMapping("/updateChooseTable")
	public void updateChooseTable(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String chooseTime = getParm("tab");
		request.getSession().setAttribute(CHOOSE_TABLE_TIME, chooseTime);
		writeJSON(response, 1);
	}
}
