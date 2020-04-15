package com.jeefw.controller;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.jeefw.dao.IBaseDao;
import com.jeefw.service.pub.PubService;
import core.util.ImageUtil;


@Controller
@RequestMapping("/createImg")
public class CreateImgController extends IbaseController{
	@Resource
	private PubService todayDataService;
	@Resource
	private IBaseDao baseDao;
	@RequestMapping(value = "/getImg", method = { RequestMethod.POST, RequestMethod.GET })
	protected void createImg(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		//1.生成随机的验证码及图片
		Object[] objs = ImageUtil.createImage();
		//2.将验证码存入session
		String imgcode = (String)objs[0];
		HttpSession session = req.getSession();
		session.setAttribute("imgcode", imgcode);
		//3.将图片输出给浏览器
		BufferedImage img = (BufferedImage)objs[1];
		res.setContentType("image/png");
		//服务器自动创建输出流，目标指向浏览器
		OutputStream os = res.getOutputStream();
		ImageIO.write(img, "png", os);
		os.close();
		
	}
	/*protected void login(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String adminCode = req.getParameter("adminCode");
		String password = req.getParameter("password");
		String code = req.getParameter("code");
		
		HttpSession session = req.getSession();
		String imgcode = (String)session.getAttribute("imgcode");
		
		//如果没有输入验证码或验证码不对,结束请求执行
		if(code==null || !code.equalsIgnoreCase(imgcode)){
			req.setAttribute("miss", "验证码错误!");
			//req.getRequestDispatcher("http://localhost:8080/ace/login.jsp").forward(req, res);
			res.sendRedirect("/ace/login.jsp");
			return;
		}
	
		
	}*/
}
