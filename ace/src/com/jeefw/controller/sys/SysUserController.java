package com.jeefw.controller.sys;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.SimpleEmail;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFCellUtil;
import org.apache.poi.hssf.util.Region;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContext;

import com.google.gson.Gson;
import com.jeefw.controller.IbaseController;
import com.jeefw.core.Constant;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.sys.Attachment;
import com.jeefw.model.sys.Authority;
import com.jeefw.model.sys.Role;
import com.jeefw.model.sys.SysUser;
import com.jeefw.service.memoryinit.InitDataService;
import com.jeefw.service.memoryinit.InitDataServiceImpl;
import com.jeefw.service.pub.PubService;
import com.jeefw.service.pub.impl.PubServiceImpl;
import com.jeefw.service.sys.AttachmentService;
import com.jeefw.service.sys.AuthorityService;
import com.jeefw.service.sys.RoleService;
import com.jeefw.service.sys.SysUserService;

import core.dbSource.DatabaseContextHolder;
import core.support.ExtJSBaseParameter;
import core.support.JqGridPageView;
import core.support.QueryResult;
import core.util.JavaEEFrameworkUtils;
import core.util.RequestObj;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/sys/sysuser")
public class SysUserController extends IbaseController implements Constant {
	@Resource
	private InitDataService dataInitSvr;
	private static final Log log = LogFactory.getLog(SysUserController.class);
	@Resource
	private SysUserService sysUserService;
	@Resource
	private AttachmentService attachmentService;
	@Resource
	private AuthorityService authorityService;
	@Resource
	private RoleService roleService;
	@Resource
	private IBaseDao baseDao;

	private static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	
	

	// 登录
	@RequestMapping("/login")
	public void login(SysUser sysUserModel, HttpServletRequest request, HttpServletResponse response) throws IOException {
		getSessionAreaGuids();
		
		dataInitSvr.initData();
		Map<String, Object> result = new HashMap<String, Object>();
		SysUser sysUser = sysUserService.getByProerties("userName", sysUserModel.getUserName()); //email  getEmail()
		if (sysUser == null || sysUser.getStatus() == true) { // 用户名有误或已被禁用
			result.put("result", -1);
			writeJSON(response, result);
			return;
		}
		if (!sysUser.getPassword().equals(new Sha256Hash(sysUserModel.getPassword()).toHex())) { // 密码错误
			result.put("result", -2);
			writeJSON(response, result);
			return;
		}
		sysUser.setLastLoginTime(new Date());
		sysUserService.merge(sysUser);
		Subject subject = SecurityUtils.getSubject();       //getEmail()
		subject.login(new UsernamePasswordToken(sysUserModel.getUserName(), sysUserModel.getPassword(), sysUserModel.isRememberMe()));
		Session session = subject.getSession();
		session.setAttribute(SESSION_SYS_USER, sysUser);
		session.setAttribute("ROLE_KEY", sysUser.getRoles().iterator().next().getRoleKey());
		result.put("result", 1);
		writeJSON(response, result);
		
		
		//。。。。。
	/*	dataInitSvr.initData();
		Map<String, Object> result = new HashMap<String, Object>();
		SysUser sysUser = sysUserService.getByProerties("email", "zq@qq.com");
		sysUser.setLastLoginTime(new Date());
		sysUserService.merge(sysUser);
		Subject subject = SecurityUtils.getSubject();
		subject.login(new UsernamePasswordToken("zq@qq.com", "123456", true));
		Session session = subject.getSession();
		session.setAttribute(SESSION_SYS_USER, sysUser);
		session.setAttribute("ROLE_KEY", sysUser.getRoles().iterator().next().getRoleKey());
		result.put("result", 1);
		writeJSON(response, result);
		*/
	/*	dataInitSvr.initData();  //测试用户登录名使用
		Map<String, Object> result = new HashMap<String, Object>();
		SysUser sysUser = sysUserService.getByProerties("userName", "hg");
		sysUser.setLastLoginTime(new Date());
		sysUserService.merge(sysUser);
		Subject subject = SecurityUtils.getSubject();
		subject.login(new UsernamePasswordToken("hg", "123456", true));
		Session session = subject.getSession();
		session.setAttribute(SESSION_SYS_USER, sysUser);
		session.setAttribute("ROLE_KEY", sysUser.getRoles().iterator().next().getRoleKey());
		result.put("result", 1);
		writeJSON(response, result);*/
		
		//com.jeefw.security.ShiroSecurityRealm
	}

	// 跳转到主页，获取菜单并授权
	@RequestMapping("/home")
	public ModelAndView home(HttpServletRequest request, HttpServletResponse response) {
		
		Subject subject = SecurityUtils.getSubject();
		Session session = subject.getSession();
		if (session.getAttribute(SESSION_SYS_USER) == null) {
			return new ModelAndView();
		} else {
			SysUser sysUser = (SysUser) session.getAttribute(SESSION_SYS_USER);
			String globalRoleKey = sysUser.getRoles().iterator().next().getRoleKey();
			try {
				List<Authority> allMenuList = authorityService.queryAllMenuList(globalRoleKey);
				return new ModelAndView("back/index", "authorityList", allMenuList);
			} catch (Exception e) { 
				log.error(e.toString());
				return new ModelAndView();
			}
		}
	}

	// 注册
	@RequestMapping("/register")
	public void register(SysUser sysUserModel, HttpServletRequest request, HttpServletResponse response) throws IOException {
		Map<String, Object> result = new HashMap<String, Object>();
		SysUser emailSysUser = sysUserService.getByProerties("userName", sysUserModel.getUserName());  //email getEmail()
		if (emailSysUser != null) {
			result.put("result", -1);
			writeJSON(response, result);
			return;
		}
		SysUser sysUser = new SysUser();
		sysUser.setUserName(sysUserModel.getUserName());
		sysUser.setSex(sysUserModel.getSex());
		sysUser.setEmail(sysUserModel.getEmail());
		sysUser.setPhone(sysUserModel.getPhone());
		sysUser.setBirthday(sysUserModel.getBirthday());
		// sysUser.setPassword(MD5.crypt(sysUserModel.getPassword()));
		sysUser.setPassword(new Sha256Hash(sysUserModel.getPassword()).toHex());
		sysUser.setStatus(false);
		sysUser.setLastLoginTime(new Date());

		Set<Role> roles = new HashSet<Role>();
		Role role = roleService.getByProerties("roleKey", "ROLE_USER");
		roles.add(role);
		sysUser.setRoles(roles);

		sysUserService.persist(sysUser);
		// sysUserService.saveSysuserAndRole(sysUser.getId(), 3);

		Subject subject = SecurityUtils.getSubject();       // getEmail()
		subject.login(new UsernamePasswordToken(sysUserModel.getUserName(), sysUserModel.getPassword()));
		Session session = subject.getSession();
		session.setAttribute(SESSION_SYS_USER, sysUser);
		session.setAttribute("ROLE_KEY", sysUser.getRoles().iterator().next().getRoleKey());
		result.put("result", 1);
		writeJSON(response, result);
	}

	// 获取个人资料信息
	@RequestMapping("/sysuserprofile")
	public ModelAndView sysuserprofile(HttpServletRequest request, HttpServletResponse response) throws IOException {
		SysUser sysuser = sysUserService.get(((SysUser) request.getSession().getAttribute(SESSION_SYS_USER)).getId());
		SysUser sysUserWithAvatar = sysUserService.getSysUserWithAvatar(sysuser);
		return new ModelAndView("back/sysuserprofile", "sysuser", sysUserWithAvatar);
	}

	// 登出
	@RequestMapping("/logout")
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		SecurityUtils.getSubject().logout();
		response.sendRedirect("/jeefw/login.jsp");
	}
	
	// 发送邮件找回密码
	@RequestMapping("/retrievePassword")
	public void retrievePassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Map<String, Object> result = new HashMap<String, Object>();
		String email = request.getParameter("userName");  //email 9/18
		SysUser sysUser = sysUserService.getByProerties("email", email);
		if (sysUser == null || sysUser.getStatus() == true) { // 用户名有误或已被禁用
			result.put("result", -1);
			writeJSON(response, result);
			return;
		}
		SimpleEmail emailUtil = new SimpleEmail();
		emailUtil.setCharset("utf-8");
		emailUtil.setHostName("smtp.163.com");
		try {
			emailUtil.addTo(email, sysUser.getUserName());
			emailUtil.setAuthenticator(new DefaultAuthenticator("javaeeframework@163.com", "abcd123456"));// 参数是您的真实邮箱和密码
			emailUtil.setFrom("javaeeframework@163.com", "研发中心");
			emailUtil.setSubject("研发中心密码找回");
			emailUtil.setMsg("本邮件发送仅提供例子，需要您二次开发。" + sysUser.getUserName() + "，您的登录密码是：" + sysUser.getPassword());
			emailUtil.send();
		} catch (Exception e) {
			e.printStackTrace();
		}
		result.put("result", 1);
		writeJSON(response, result);
	}

	// 更改密码
	@RequestMapping("/resetPassword")
	public void resetPassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String password = request.getParameter("password");
		Long id = ((SysUser) request.getSession().getAttribute(SESSION_SYS_USER)).getId();
		// sysUserService.updateByProperties("id", id, "password", MD5.crypt(password));
		sysUserService.updateByProperties("id", id, "password", new Sha256Hash(password).toHex());
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", true);
		writeJSON(response, result);
	}

	// 查询用户的表格，包括分页、搜索和排序
	@RequestMapping(value = "/getSysUser", method = { RequestMethod.POST, RequestMethod.GET })
	public void getSysUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		SysUser sysUser = new SysUser();
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("email") && result.getString("op").equals("eq")) {
					sysUser.set$eq_email(result.getString("data"));
				}
				if (result.getString("field").equals("userName") && result.getString("op").equals("cn")) {
					sysUser.set$like_userName(result.getString("data"));
				}
			}
			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
				sysUser.setFlag("OR");
			} else {
				sysUser.setFlag("AND");
			}
		}
		sysUser.setFirstResult((firstResult - 1) * maxResults);
		sysUser.setMaxResults(maxResults);
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		sysUser.setSortedConditions(sortedCondition);
		QueryResult<SysUser> queryResult = sysUserService.doPaginationQuery(sysUser);
		JqGridPageView<SysUser> sysUserListView = new JqGridPageView<SysUser>();
		sysUserListView.setMaxResults(maxResults);
		List<SysUser> sysUserCnList = sysUserService.querySysUserCnList(queryResult.getResultList());
		sysUserListView.setRows(sysUserCnList);
		sysUserListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, sysUserListView);
	}

	// 保存用户的实体Bean
	@RequestMapping(value = "/saveSysUser", method = { RequestMethod.POST, RequestMethod.GET })
	public void doSave(SysUser entity, HttpServletRequest request, HttpServletResponse response) throws IOException {
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		if (CMD_EDIT.equals(parameter.getCmd())) {
			SysUser sysUser = sysUserService.get(entity.getId());
			entity.setPassword(sysUser.getPassword());
			entity.setLastLoginTime(sysUser.getLastLoginTime());
			sysUserService.merge(entity);
		} else if (CMD_NEW.equals(parameter.getCmd())) {
			// entity.setPassword(MD5.crypt("123456")); // 初始化密码为123456
			entity.setPassword(new Sha256Hash("123456").toHex()); // 初始化密码为123456
			sysUserService.persist(entity);
		}
		parameter.setSuccess(true);
		writeJSON(response, parameter);
	}

	// 操作用户的删除、导出Excel、字段判断和保存
	@RequestMapping(value = "/operateSysUser", method = { RequestMethod.POST, RequestMethod.GET })
	public void operateSysUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String oper = request.getParameter("oper");
		String id = request.getParameter("id");
		if (oper.equals("del")) {
			String[] ids = id.split(",");
			deleteSysUser(request, response, (Long[]) ConvertUtils.convert(ids, Long.class));
		} else if (oper.equals("excel")) {	
			try {
				//创建工作簿
				HSSFWorkbook wb = new HSSFWorkbook();
				
				HSSFSheet sheet = wb.createSheet("sheet1");//创建第一个名为sheet1的工作表
				
				sheet.setDefaultColumnWidth(15);
				//sheet.setDefaultRowHeight((short) 3);
				HSSFCellStyle cellBorder = wb.createCellStyle();
				//设置边框
	            cellBorder.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	            cellBorder.setBorderRight(HSSFCellStyle.BORDER_THIN);
	            cellBorder.setBorderTop(HSSFCellStyle.BORDER_THIN);
	            cellBorder.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	            
	            //居中
	            cellBorder.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
	            
	            cellBorder.setWrapText(true);//自动换行

	            //合并单元格
	            //Region region1 = new Region(0, (short) 0, 0, (short) 6);            
	            //sheet.addMergedRegion(region1);

	           /* HSSFRow title = sheet.createRow(0);//创建第一行
	            HSSFCell tcell = title.createCell(0);//第一个单元格
	            tcell.setCellValue("泥煤你妹你妹的");
	            //setRegionStyle(sheet,  region1 , cellBorder);//设置合并单元格的样式
	            sheet.setColumnWidth(0, 2500); //第一个参数代表列id(从0开始),第2个参数代表宽度值  参考 ："2012-08-10"的宽度为2500
*/	            
	           
	            String sql = "select su.id,su.user_name,case su.sex when 1 then '男' else '女' end as sex,su.email,su.phone,to_char(su.birthday,'yyyy-mm-dd') as birthday, "
							+" d.department_value,r.role_value,case su.status when 0 then '否' else '是' end as status,to_char(su.last_logintime,'yyyy-mm-dd  hh24:mi') as last_logintime "
							+" from sys_user su "
							+" left join sysuser_role sr "
							+" on sr.sysuser_id = su.id "
							+" left join role r "
							+" on r.id = sr.role_id "
							+" left join department d "
							+" on d.department_key = su.department_key";
	            //List<Map> list2 = baseDao.listSqlAndChangeToMap(sql, null);//map不能按照列出的字段排序
	            List list = baseDao.findBySqlList(sql, null);
	            HSSFRow row;
	            HSSFCell cell;
	            if(list.size()>0){
	            	String strTitles = "ID，姓名，性别，邮箱，联系电话，生日，所属部门，角色，是否禁用，最后登录时间";
	            	setExcelTitleStr(strTitles, wb , sheet);
	            	
	            	
	            	for (int i = 0; i < list.size(); i++) {
		            	row = sheet.createRow(i+1);
		            	row.setHeight((short)360);
		            	Object[] os =  (Object[])list.get(i);
						for (int j = 0; j < os.length; j++) {
							cell = row.createCell(j);
							if(os[j] == null){
								cell.setCellValue("");
							}else{
								cell.setCellValue(os[j].toString());
							}
							cell.setCellStyle(cellBorder);
						}
					}
	            }
	            
	            /*Map map = new HashMap();
	            for (int i = 0; i < list.size(); i++) {
	            	row = sheet.createRow(i+1);
	            	row.setHeight((short)330);
	            	map = list.get(i);
	            	Iterator iter = map.entrySet().iterator();
	            	int j = 0;
	            	while (iter.hasNext()) {
	            		Map.Entry entry = (Map.Entry) iter.next();
	            		cell = row.createCell(j);
	            		if(entry.getValue()==null){
	            			cell.setCellValue("");
	            		}else{
	            			//System.out.println(entry.getValue().toString());
		            		cell.setCellValue(entry.getValue().toString());
		            		//cell.setCellStyle(cellBorder);
	            		}
	            		cell.setCellStyle(cellBorder);
	            		j++;
					}
				}*/
	 
	           /* HSSFRow row2 = sheet.createRow(2);
	            HSSFCell row2cell0 = row2.createCell(0);
	            row2cell0.setCellValue("测试自动换行，自动换行，自动换行");
	            row2cell0.setCellStyle(cellBorder);*/
	            
	            // 输出数据流
	            try
	            {                   
	                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
	                    wb.write(baos);
	                    response.addHeader("Content-Disposition", "attachment;filename="
	    						+ new String( "用户管理".getBytes("gb2312"), "ISO8859-1" ) + ".xls");
	                    response.setContentType("application/vnd.ms-excel");
	                    response.setContentLength(baos.size());
	                    
	                    ServletOutputStream out1 = response.getOutputStream();
	                    baos.writeTo(out1);
	                    out1.flush();
	                    out1.close();

	            } catch (Exception e)
	            {
	                   
	            }
      

/*	            
	            //仅导出页面显示部分的 数据
	            response.addHeader("Content-Disposition", "attachment;filename="
						+ new String( "用户管理".getBytes("gb2312"), "ISO8859-1" ) + ".xls");
				OutputStream out = response.getOutputStream();
	            response.setContentType("application/msexcel;charset=UTF-8");

	            byte[] data = URLDecoder.decode(request.getParameter("csvBuffer"), "UTF-8").getBytes();
				out.write(URLDecoder.decode(request.getParameter("csvBuffer"), "UTF-8").getBytes());
				out.flush();
				out.close();*/
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			Map<String, Object> result = new HashMap<String, Object>();
			String userName = request.getParameter("userName");
			String email = request.getParameter("email");
			SysUser sysUser = null;
			if (oper.equals("edit")) {
				sysUser = sysUserService.get(Long.valueOf(id));
			}
			SysUser emailSysUser = sysUserService.getByProerties("email", email);
			if (StringUtils.isBlank(userName) || StringUtils.isBlank(email)) {
				response.setStatus(HttpServletResponse.SC_LENGTH_REQUIRED);
				result.put("message", "请填写姓名和邮箱");
				writeJSON(response, result);
			} else if (null != emailSysUser && oper.equals("add")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此邮箱已存在，请重新输入");
				writeJSON(response, result);
			} else if (null != emailSysUser && !sysUser.getEmail().equalsIgnoreCase(email) && oper.equals("edit")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此邮箱已存在，请重新输入");
				writeJSON(response, result);
			} else {
				SysUser entity = new SysUser();
				entity.setUserName(userName);
				entity.setSex(Short.valueOf(request.getParameter("sexCn")));
				entity.setEmail(email);
				entity.setPhone(request.getParameter("phone"));
				if (StringUtils.isNotBlank(request.getParameter("birthday"))) {
					entity.setBirthday(dateFormat.parse(request.getParameter("birthday")));
				}
				entity.setDepartmentKey(request.getParameter("departmentValue"));
				entity.setStatusCn(request.getParameter("statusCn"));
				if (entity.getStatusCn().equals("是")) {
					entity.setStatus(true);
				} else {
					entity.setStatus(false);
				}

				Set<Role> roles = new HashSet<Role>();
				Role role = roleService.getByProerties("roleKey", request.getParameter("roleCn"));
				roles.add(role);
				entity.setRoles(roles);

				if (oper.equals("edit")) {
					entity.setId(Long.valueOf(id));
					entity.setCmd("edit");
					doSave(entity, request, response);
				} else if (oper.equals("add")) {
					entity.setCmd("new");
					doSave(entity, request, response);
				}
			}
		}
	}
	
	/**设置合并后单元格样式
     * 
     * @param sheet
     * @param region
     * @param cs
     */
     private void setRegionStyle(HSSFSheet sheet, Region region , HSSFCellStyle cs) {
            int toprowNum = region.getRowFrom();
            for (int i = region.getRowFrom(); i <= region.getRowTo(); i ++) {
                HSSFRow row = HSSFCellUtil.getRow(i, sheet);
                for (int j = region.getColumnFrom(); j <= region.getColumnTo(); j++) {
                    HSSFCell cell = HSSFCellUtil.getCell(row, (short)j);
                    cell.setCellStyle(cs);
                }
            }
     }

	// 保存个人资料
	@RequestMapping(value = "/saveSysUserProfile", method = { RequestMethod.POST, RequestMethod.GET })
	public void saveSysUserProfile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long sysUserId = ((SysUser) request.getSession().getAttribute(SESSION_SYS_USER)).getId();
		SysUser sysUser = sysUserService.get(sysUserId);
		SysUser entity = new SysUser();
		entity.setId(sysUserId);
		entity.setUserName(request.getParameter("userName"));
		entity.setSex(Short.valueOf(request.getParameter("sex")));
		entity.setEmail(request.getParameter("email"));
		entity.setPhone(request.getParameter("phone"));
		if (null != request.getParameter("birthday")) {
			entity.setBirthday(dateFormat.parse(request.getParameter("birthday")));
		}
		entity.setStatus(sysUser.getStatus());
		entity.setPassword(sysUser.getPassword());
		entity.setLastLoginTime(sysUser.getLastLoginTime());
		entity.setDepartmentKey(sysUser.getDepartmentKey());
		entity.setRoles(sysUser.getRoles());
		sysUserService.merge(entity);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("success", true);
		writeJSON(response, result);
	}

	// 删除用户
	@RequestMapping("/deleteSysUser")
	public void deleteSysUser(HttpServletRequest request, HttpServletResponse response, @RequestParam("ids") Long[] ids) throws IOException {
		if (Arrays.asList(ids).contains(Long.valueOf("1"))) {
			writeJSON(response, "{success:false,message:'删除项包含超级管理员，超级管理员不能删除！'}");
		} else {
			boolean flag = sysUserService.deleteByPK(ids);
			if (flag) {
				writeJSON(response, "{success:true}");
			} else {
				writeJSON(response, "{success:false}");
			}
		}
	}

	// 即时更新个人资料的字段
	@RequestMapping(value = "/updateSysUserField", method = { RequestMethod.POST, RequestMethod.GET })
	public void updateSysUserField(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Long id = Long.valueOf(request.getParameter("pk"));
		String name = request.getParameter("name");
		String value = request.getParameter("value");
		if (name.equals("userName")) {
			sysUserService.updateByProperties("id", id, "userName", value);
		} else if (name.equals("sex")) {
			sysUserService.updateByProperties("id", id, "sex", Short.valueOf(value));
		} else if (name.equals("email")) {
			sysUserService.updateByProperties("id", id, "email", value);
		} else if (name.equals("phone")) {
			sysUserService.updateByProperties("id", id, "phone", value);
		} else if (name.equals("birthday")) {
			if (null != value) {
				sysUserService.updateByProperties("id", id, "birthday", dateFormat.parse(value));
			}
		}
	}

	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");

	// 上传个人资料的头像
	@RequestMapping(value = "/uploadAttachement", method = RequestMethod.POST)
	public void uploadAttachement(@RequestParam(value = "avatar", required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RequestContext requestContext = new RequestContext(request);
		JSONObject json = new JSONObject();
		if (!file.isEmpty()) {
			if (file.getSize() > 2097152) {
				json.put("message", requestContext.getMessage("g_fileTooLarge"));
			} else {
				try {
					String originalFilename = file.getOriginalFilename();
					String fileName = sdf.format(new Date()) + JavaEEFrameworkUtils.getRandomString(3) + originalFilename.substring(originalFilename.lastIndexOf("."));
					File filePath = new File(getClass().getClassLoader().getResource("/").getPath().replace("/WEB-INF/classes/", "/static/upload/img/" + DateFormatUtils.format(new Date(), "yyyyMM")));
					if (!filePath.exists()) {
						filePath.mkdirs();
					}
					file.transferTo(new File(filePath.getAbsolutePath() + "\\" + fileName));
					String destinationFilePath = "/static/upload/img/" + DateFormatUtils.format(new Date(), "yyyyMM") + "/" + fileName;
					Long sysUserId = ((SysUser) request.getSession().getAttribute(SESSION_SYS_USER)).getId();
					attachmentService.deleteByProperties(new String[] { "type", "typeId" }, new Object[] { (short) 1, sysUserId });
					Attachment attachment = new Attachment();
					attachment.setFileName(originalFilename);
					attachment.setFilePath(destinationFilePath);
					attachment.setType((short) 1);
					attachment.setTypeId(sysUserId);
					attachmentService.persist(attachment);
					json.put("status", "OK");
					json.put("url", request.getContextPath() + destinationFilePath);
					json.put("message", requestContext.getMessage("g_uploadSuccess"));
				} catch (Exception e) {
					e.printStackTrace();
					json.put("message", requestContext.getMessage("g_uploadFailure"));
				}
			}
		} else {
			json.put("message", requestContext.getMessage("g_uploadNotExists"));
		}
		writeJSON(response, json.toString());
	}

	/** 以下方法是根据路径跳转到页面 **/

	@RequestMapping("/sysuser")
	public String sysuser(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/systemmanage/sysuser";
	}

	@RequestMapping("/homepage")
	public String homepage(HttpServletRequest request, HttpServletResponse response) throws IOException {
	 	/*//最近一次的统计时间
		String statisticsDate = baseDao.findBySqlList("select to_char(max(ddate),'yyyy-MM-dd') as statisticsdate from tgztj", null).get(0).toString();
		String sql = "select distinct  AREAGUID,TOTZHSUM,TOTCBSUM,ZCSUM,GZSUM,WFYSUM,WCBSUM,DDATE from tgztj "
				+ " where ddate>to_date('" + statisticsDate + "','yyyy-mm-dd hh24:mi:ss')";
		
		//统计信息
		String sql = "select sum(totzhsum) as totzhsum,sum(totcbsum) as totcbsum,sum(zcsum) as zcsum,sum(gzsum) as gzsum,"
				+ " sum(wfysum) as wfysum,sum(wcbsum) as wcsum,count(1) as areaSum from tgztj"
				+ " where ddate>to_date('" + statisticsDate + "','yyyy-mm-dd hh24:mi:ss')";
		Map<String, Object> map = (Map<String, Object>) baseDao.listSqlAndChangeToMap(sql, null).get(0);	
		
		//每日用量统计
		String everyDayUserEnergySql ="with t1 as "
									+" ( "
									+" select sysdate-level+1 d from dual connect by level<=7 order by d "
									+" ) "
									+" select to_char(t1.d,'yyyy-mm-dd') as day, nvl(Round(sum(t2.meternllj),1),0) as userEnergy "
									+" "
									+" from t1 "
									+" left join tmeter t2 "
									+" on t2.meternllj !=null and to_char(t1.d,'yyyy-Mm-dd')=to_char(t2.ddate,'yyyy-MM-dd') "
									+" group by t1.d order by t1.d ";
		List everyDayUserEnergyList = baseDao.listSqlAndChangeToMap(everyDayUserEnergySql,null);
		
		//各小区表信息统计
		String eachAreaMeterInfoSql = "select t.*,a.areaname,b.SECTIONID,b.SECTIONNAME,c.FACTORYID,c.FACTORYNAME "
									+" from Tarea a "
									+" left join FACTORYSECTIONINFO b "
									+" on a.FACTORYNO=b.SECTIONID "
									+" left join ENERGYFACTORY c "
									+" on c.FACTORYID=b.FACTORYID "
									+" inner join TGZTJ t "
									+" on t.areaguid=a.areaguid "
									+" where t.ddate>to_date('" + statisticsDate + "','yyyy-mm-dd hh24:mi:ss') ";
										
		List eachAreaMeterInfo = baseDao.listSqlAndChangeToMap(eachAreaMeterInfoSql, null);
		
		request.setAttribute("eachAreaMeterInfo", eachAreaMeterInfo);
		request.setAttribute("dayEnergyList", everyDayUserEnergyList);
		request.setAttribute("headStatisticsDate", statisticsDate);
		request.setAttribute("headMap", map);*/
		//request.getSession().setAttribute(AREA_GUIDS, DEFAULT_AREAGUID);
		
		request.setAttribute("eachAreaMeterInfo", InitDataServiceImpl.getObjectByKey(STATISTIC_EACH_AREA_METER_INFO));
		request.setAttribute("dayEnergyList", InitDataServiceImpl.getObjectByKey(EVERYDAY_USE_ENERGY));
		request.setAttribute("headStatisticsDate", InitDataServiceImpl.getObjectByKey(LAST_STATISTIC_DATE));
		request.setAttribute("headMap", InitDataServiceImpl.getObjectByKey(HEAD_STATISTIC));
		
		return "back/homepage";
	}

	@RequestMapping("/dict")
	public String dict(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/systemmanage/dict";
	}

	@RequestMapping("/role")
	public String role(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/systemmanage/role";
	}

	@RequestMapping("/department")
	public String department(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/systemmanage/department";
	}

	@RequestMapping("/mail")
	public String mail(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/systemmanage/mail";
	}

	@RequestMapping("/information")
	public String information(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/infomanage/information";
	}

	@RequestMapping("/authority")
	public String authority(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/systemmanage/authority";
	}

	@RequestMapping("/typography")
	public String typography(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/typography";
	}

	@RequestMapping("/uielements")
	public String uielements(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/uielements";
	}

	@RequestMapping("/buttonsicon")
	public String buttonsicon(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/buttonsicon";
	}

	@RequestMapping("/contentslider")
	public String contentslider(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/contentslider";
	}

	@RequestMapping("/nestablelist")
	public String nestablelist(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/nestablelist";
	}

	@RequestMapping("/jquerydatatables")
	public String jquerydatatables(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/jquerydatatables";
	}

	@RequestMapping("/formelements")
	public String formelements(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/formelements";
	}

	@RequestMapping("/formelements2")
	public String formelements2(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/formelements2";
	}

	@RequestMapping("/wizardvalidation")
	public String wizardvalidation(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/wizardvalidation";
	}

	@RequestMapping("/uiwidgets")
	public String uiwidgets(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/uiwidgets";
	}

	@RequestMapping("/calendar")
	public String calendar(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/calendar";
	}

	@RequestMapping("/gallery")
	public String gallery(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/gallery";
	}

	@RequestMapping("/pricingtables")
	public String pricingtables(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/pricingtables";
	}

	@RequestMapping("/invoice")
	public String invoice(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/invoice";
	}

	@RequestMapping("/timeline")
	public String timeline(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/timeline";
	}

	@RequestMapping("/faq")
	public String faq(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/faq";
	}

	@RequestMapping("/grid")
	public String grid(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/bootstrapexample/grid";
	}

	@RequestMapping("/charts")
	public String charts(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/chartandreport/charts";
	}

	@RequestMapping("/callError404")
	public String callError404(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "redirect:/sys/sysuser/error404";
	}

	@RequestMapping("/error404")
	public String error404(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/error404";
	}

	@RequestMapping("/callError500")
	public String callError500(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "redirect:/sys/sysuser/error500";
	}

	@RequestMapping("/error500")
	public String error500(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/error500";
	}

	@RequestMapping("/callUnauthorized")
	public String callUnauthorized(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "redirect:/sys/sysuser/unauthorized";
	}

	@RequestMapping("/unauthorized")
	public String unauthorized(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/unauthorized";
	}

	@RequestMapping("/druid")
	public String druid(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/druid";
	}
	
	@RequestMapping("/todaydata")
	public String todaydata(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		return "back/monitordata/todaydata";
	}
	
	@RequestMapping("/hisdata")
	public String hisdata(HttpServletRequest request, HttpServletResponse response) throws IOException {
		return "back/searchdata/hisdata";
	}
	
	@RequestMapping("/setarea")
	public String setarea(HttpServletRequest request,HttpServletResponse response){
		return "back/baseinfomanage/setarea";  //"redirect:/sys/sysuser/todaydata";
	}
	
	@RequestMapping("/areainfo")
	public String areainfo(HttpServletRequest request,HttpServletResponse response){
		String areaids = (String) request.getSession().getAttribute(AREA_GUIDS);
		String sql = "select distinct areaguid,areaname,AREACODE,AREAPLACE,LINKMAN,TELEPHONE, SMEMO,IMAGEMAP,IMAGEMAP2,  "  //SMEMO
				+ " SECTIONNAME,FACTORYNAME "
				+ " from ("+ PubServiceImpl.headsql + ") ";
		if(StringUtils.isBlank(areaids)){
			sql += " where areaguid = 1841";
		}else{
			sql += " where areaguid in ("+areaids+")";
		}
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		System.out.println("小区信息："+list.get(0));
		request.setAttribute("result", list.get(0));
		return "back/baseinfomanage/areainfo";
	}
	
	@RequestMapping("/clientinfo")
	public String clientinfo(HttpServletRequest request,HttpServletResponse response){
		return "back/baseinfomanage/clientinfo";
	}
	
	@RequestMapping("/clientedit")
	public String clientedit(HttpServletRequest request,HttpServletResponse response){
		return "back/baseinfomanage/clientedit";
	}
	
	@RequestMapping("/setmeterfailure")
	public String setmeterfailure(HttpServletRequest request,HttpServletResponse response){
		return "back/baseinfomanage/setmeterfailure";
	}
	
	@RequestMapping("/deviceinfomanage")
	public String deviceinfomanage(HttpServletRequest request,HttpServletResponse response){
		return "back/baseinfomanage/deviceinfomanage";
	}
	
	@RequestMapping("/changemeter")
	public String changemeter(HttpServletRequest request,HttpServletResponse response){
		return "back/baseinfomanage/changemeter";
	}
	
	@RequestMapping("/statisticInfo")
	public String statisticInfo(HttpServletRequest request,HttpServletResponse response){
		Object info = InitDataServiceImpl.getObjectByKey(HEAD_STATISTIC);
		Object date = InitDataServiceImpl.getObjectByKey(LAST_STATISTIC_DATE);
		request.setAttribute("statisticInfo", info);
		request.setAttribute("date", date);
		return "back/statisticInfo";
	}
	
	@RequestMapping("/hisFault")
	public String hisFault(HttpServletRequest request,HttpServletResponse response){
		return "back/searchdata/hisFault";
	}
	@RequestMapping("/hisMeter")
	public String hisMeter(HttpServletRequest request,HttpServletResponse response){
		return "back/searchdata/hisMeter";
	}
	@RequestMapping("/meterFaultInfo")
	public String meterFaultInfo(HttpServletRequest request,HttpServletResponse response){
		return "back/baseinfomanage/meterFaultInfo";
	}
	
	@RequestMapping("/todayFaultData")
	public String todayFaultData(HttpServletRequest request,HttpServletResponse response){
		return "back/monitordata/todayFaultData";
	}
	
	@RequestMapping("/baseInfoSearch")
	public String baseInfoSearch(){
		return "back/baseinfomanage/baseInfoSearch";
	}
	
	@RequestMapping("/betweenMeterChange")
	public String betweenMeterChange(){
		return "back/baseinfomanage/betweenMeterChange";
	}
	
	@RequestMapping("/statisticForAnalysis")
	public String statisticForAnalysis(HttpServletRequest request,HttpServletResponse response){
		Object info = InitDataServiceImpl.getObjectByKey(HEAD_STATISTIC);
		Object date = InitDataServiceImpl.getObjectByKey(LAST_STATISTIC_DATE);
		String statusFlag = request.getParameter("statusflag");
		
		request.setAttribute("statisticInfo", info);
		request.setAttribute("date", date);
		if(StringUtils.isNotBlank(statusFlag)){
			request.setAttribute("statusflag", statusFlag);
			return "back/statisticForAnalysis";
		}else	
			return "back/dataAnalysis/statisticForAnalysis";
	}
	@RequestMapping("/clientCharge")
	public String clientCharge(){
		return "back/priceManage/clientCharge";
	}
	
	@RequestMapping("/setUnitPrice")
	public String setUnitPrice(HttpServletRequest request, HttpServletResponse response) throws DocumentException{
		String classPathUrl = this.getClass().getResource("/").getPath();
		
		String sql = "select * from TCLIENTCAT";
	 	List list = baseDao.listSqlAndChangeToMap(sql, null);
	 	SAXReader reader = new SAXReader();
	 	Document document = reader.read(classPathUrl+"/prop/DBConfig.xml");
	 	String xmlStr = document.asXML();//得到包括头申明
	 	Element root = document.getRootElement();//得到根以及根下所有node
	 	Element node = root.element("Item");//element只能获得当前节点的子节点
	 	List selNodes = root.selectNodes("Item/Auto");//里面是使用xpath来解析的
	 	Node autoNode = (Node)selNodes.get(0);
	 	request.setAttribute("list", list);
	    request.setAttribute("Auto", autoNode.getText());
		return "back/priceManage/setUnitPrice";
	}
	@RequestMapping("/energyConsumingStatis")
	public String energyConsumingStatis(){
		return "back/dataAnalysis/energyConsumingStatis";
	}
	
	@RequestMapping("/noReadMeter")
	public String noReadMeter(){
		return "back/monitordata/noReadMeter";
	}
	
	@RequestMapping("/clientCharts")
	public String clientCharts(HttpServletRequest request, HttpServletResponse response){
		request.setAttribute("date", getParm("date"));
		request.setAttribute("btn", getParm("btn"));
		request.setAttribute("meterid", getParm("meterid"));
		request.setAttribute("clientno",getParm("customerid"));
		return "back/monitordata/clientCharts";
	}
	@RequestMapping("/clientCharts2")
	public String clientCharts2(HttpServletRequest request, HttpServletResponse response){
		request.setAttribute("date", getParm("date"));
		request.setAttribute("btn", getParm("btn"));
		request.setAttribute("meterid", getParm("meterid"));
		request.setAttribute("clientno",getParm("customerid"));
		return "back/monitordata/clientCharts2";
	}
	
	@RequestMapping("/fileUpload")
	public String fileUpload(){
		return "back/filetransmit/fileupload";
	}
	
	@RequestMapping("/areachart")
	public String areaChart(HttpServletResponse response , HttpServletRequest request){
		return "back/monitordata/areachart";
	}
	
	@RequestMapping("/areaedit")
	public String areaedit(){
		return "back/systemmanage/areaedit";
	}
	@RequestMapping("/systemoperlog")
	public String systemoperlog(){
		return "back/systemmanage/systemoperlog";
	}
	@RequestMapping("/energyfactory")
	public String energyfactory(){
		return "back/systemmanage/energyfactory";
	}
	@RequestMapping("/factorysectioninfo")
	public String factorysectioninfo(){
		return "back/systemmanage/factorysectioninfo";
	}
	@RequestMapping("/webupdatelog")
	public String webupdatelog(){
		return "back/systemmanage/webupdatelog";
	}
	@RequestMapping("/metercondition")
	public String metercondition(){
		return "back/monitordata/metercondition";
	}
	
	@RequestMapping("/fileManage")
	public String fileManage(){
		return "back/filetransmit/filemanage";
	}
	
	@RequestMapping("/builddatastatis")
	public String builddatastatis(){
		return "back/dataAnalysis/builddatastatis";
	}
	@RequestMapping("/builddistribution")
	public String builddistribution(){
		return "back/dataAnalysis/builddistribution";
	}
	@RequestMapping("/buildtemperature")
	public String buildtemperature(){
		return "back/dataAnalysis/buildtemperature";
	}
	@RequestMapping("/buildcomparison")
	public String buildcomparison(){
		return "back/dataAnalysis/buildcomparison";
	}
	@RequestMapping("/manual")
	public String manual(){
		return "back/dataAnalysis/buildcomparison";
	}
	@RequestMapping("/warningsetting")
	public String warningsetting(){
		return "back/warningmanage/warningsetting";
	}
	@RequestMapping("/expexcel")
	public String expexcel(){
		return "back/baseinfomanage/expexcel";
	}
	//历史数据一键导出
	@RequestMapping("/hisdataexpexcel")
	public String hisdataexpexcel(){
		return "back/searchdata/hisdataexpexcel";
	}
	//住户耗热一键导出
		@RequestMapping("/energyexpexcel")
		public String energyexpexcel(){
			return "back/dataAnalysis/energyexpexcel";
		}
	@RequestMapping("/setChargeDate")
	public String setChargeDate(){
		return "back/priceManage/setChargeDate";
	}
	@RequestMapping("/warningsearch")
	public String warningSearch(){
		return "back/warningmanage/warningsearch";
	}
	//故障统计2018312
	@RequestMapping("/FaultStatistics")
	public String FaultStatistics(){
		return "back/warningmanage/FaultStatistics";
	}
	
	@RequestMapping("/setfaultparamforwarn")
	public String setfaultparamforwarn(){
		return "back/warningmanage/setfaultparamforwarn";
	}
	@RequestMapping("/billPrint")
	public String billPrint(){
		
		return "back/priceManage/billPrint";
	}
	@RequestMapping("/searchfaultparamwarn")
	public String searchfaultparamwarn(){
		return "back/warningmanage/searchfaultparamwarn";
	}
	@RequestMapping("/zlcharts")
	public String zlcharts(HttpServletRequest request){
		if(org.apache.commons.lang3.StringUtils.isNotBlank(request.getParameter("customerid")))
			return "back/zlcharts";
		return "back/monitordata/zlcharts";
	}
	@RequestMapping("/importdata")
	public String importdata(){
		return "back/ReadMeter/ImportData";
	}
	@RequestMapping("/importview")
	public String importview(){
		return "back/ReadMeter/ImportView";
	}
	
	@RequestMapping("/housingmap")
	public ModelAndView housingMap(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
		Map<String,Object> veryMap = new HashMap<String,Object>();
		if(request.getServletContext().getAttribute(STATIC_USE_ENERGY_FOR_DAY)!=null){
			dataList = (List<Map<String,Object>>)request.getServletContext().getAttribute(STATIC_USE_ENERGY_FOR_DAY);
		}
		List verifyAreaList = baseDao.findBySql("select areaname,b_point_lng lng,b_point_lat lat from tarea where b_point_lng is not null and b_point_lat is not null");
		
		HashMap<String, Map<String, Object>> result = new HashMap<String,Map<String,Object>>();
		for (Object obj : verifyAreaList) {
			veryMap.put((((Object[])obj)[0]).toString(),(((Object[])obj)[1]).toString() + ":" + (((Object[])obj)[2]).toString());
		}
		for (Map map : dataList) {
			result.put((String) map.get("AREANAME"), map);
		}
		Gson gson = new Gson();
		request.setAttribute("verify", gson.toJson(veryMap));
		return new ModelAndView("back/BMap/housing", "result", gson.toJson(result));
	}
	
	@RequestMapping("/areagif")
	public String areaGif(){
		return "back/areagif";
	}
	
	@RequestMapping("/chooseTable")
	public String chooseTable(){
		return "back/systemmanage/chooseTable";
	}
	
	@RequestMapping("/areaPoint")
	public String areaPoint(){
		return "back/baseinfomanage/areaPoint";
	}
	
	@RequestMapping("/baseframe")
	public String baseFrame(){
		return "back/baseframe";
	}
	
	@RequestMapping("/setAreaPic")
	public String setAreaPic(){
		return "back/mapMenu/setAreaPic";
	}
	

	@RequestMapping("/useHeatmap")
	public ModelAndView useHeatmap(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<Map> useHeatForDay = (List<Map>)request.getServletContext().getAttribute(STATIC_USE_ENERGY_FOR_DAY);
		Map<String,Object> veryMap = new HashMap<String,Object>();
		List verifyAreaList = baseDao.findBySql("select areaname,b_point_lng lng,b_point_lat lat from tarea where b_point_lng is not null and b_point_lat is not null");
		
		for (Object obj : verifyAreaList) {
			for (Map map : useHeatForDay) {
				if((((Object[])obj)[0]).toString().equals(map.get("AREANAME").toString())){
					veryMap.put((((Object[])obj)[0]).toString(),
							(((Object[])obj)[1]).toString() 
							+ ":" + (((Object[])obj)[2]).toString() 
							+ ":" + map.get("AREA_ENERGY"));
				}
			}
		}
		Gson gson = new Gson();
		return new ModelAndView("back/dataAnalysis/useHeatmap", "verify", gson.toJson(veryMap));
	}
	
	//住户耗热分布图
	@RequestMapping("useHeatDistribution")
	public String useHeatMap(){
		return "back/dataAnalysis/useHeatDistribution";
	}
	
	//管网数据监测
	@RequestMapping("pipeDataMoni")
	public String pipeDataMoni(){
		return "back/pipeMonitor/pipeDataMoni";
	}
	//管网损耗分析
	@RequestMapping("/pipeNetworkLossAnalysis")
	public String pipeNetworkLossAnalysis(){
		return "back/pipeMonitor/pipeNetworkLossAnalysis";
	}
	//供，换热站运行监测
	@RequestMapping("/huanreStationMonit")
	public String huanreStationMomit(){
		return "back/pipeMonitor/huanreStationMonit";
	}
	//退补费分析
	@RequestMapping("/feeAnalysis")
	public String feeAnalysis(){
		return "back/priceManage/feeAnalysis";
	}
	
	//采暖季日数分析
	@RequestMapping("/cainuanAnalysis")
	public String cainuanAnalysis(){
		return "back/dataAnalysis/cainuanAnalysis";
	}
	//供热季耗热分析
	@RequestMapping("/heatSeasonAnalysis")
	public String heatSeasonAnalysis(){
		return "back/dataAnalysis/heatSeasonAnalysis";
	}
	//耗热指标分析
	@RequestMapping("/useHeatIndexAnalysis")
	public String useHeatIndexAnalysis(){
		return "back/dataAnalysis/useHeatIndexAnalysis";
	}
	
		
		@RequestMapping("/heatCons")
		public String heatCons(HttpServletRequest request, HttpServletResponse response){						
			request.setAttribute("btn", getParm("btn"));
			request.setAttribute("date", getParm("date"));
			return "back/HB/heatCons";
		}
		
		@RequestMapping("/flowCons")
		public String flowCons(HttpServletRequest request, HttpServletResponse response){						
			request.setAttribute("btn", getParm("btn"));
			request.setAttribute("date", getParm("date"));
			return "back/HB/flowCons";
		}
		
		@RequestMapping("/aggregateAnalysis")
		public String aggregateAnalysis(HttpServletRequest request, HttpServletResponse response){						
			request.setAttribute("btn", getParm("btn"));
			request.setAttribute("date", getParm("date"));
			return "back/HB/aggregateAnalysis";
		}

		
		@RequestMapping("/meterinfo")
		public String meterinfo(){
			return "back/baseinfomanage/meterinfo";
		}
		

		//热源监测
		@RequestMapping("/heatSourceMonitor")
		public String heatSourceMonitor(HttpServletRequest request, HttpServletResponse response){						
			return "back/PlanningManagement/heatSourceMonitor";
		}
		//调度
		@RequestMapping("/productDispatch")
	    public String productDispatch(HttpServletRequest request, HttpServletResponse response){						
			DatabaseContextHolder.setCustomerType("DS2");//更换数据源  
			String sqlstr = " select areaguid,areaname from tarea order by areacode";
			List list = baseDao.listSqlAndChangeToMap(sqlstr, null);
			request.setAttribute("result", list);
			return "back/PlanningManagement/productDispatch";
		}
		//换热站历史数据查询
		@RequestMapping("/historyData")
		public String historyData(HttpServletRequest request, HttpServletResponse response){						
			return "back/PlanningManagement/historyData";
		}

		
		
    //小区耗热分析
	@RequestMapping("/areaUseHeatAnalysis")
    public String areaUseHeatAnalysis(HttpServletRequest request, HttpServletResponse response){						
		return "back/dataAnalysis/areaUseHeatAnalysis";
	}
	 //首页地图
		@RequestMapping("/nationalMap")
	    public String nationalMap(HttpServletRequest request, HttpServletResponse response){						
			return "back/nationalMap";

		}
		//地图
				@RequestMapping("/map")
			    public String map(HttpServletRequest request, HttpServletResponse response){						
					return "back/mapMenu/map";

				}

		
		//换热站运行监控图
		@RequestMapping("/huanreStation")
		public String huanreStation(HttpServletRequest request, HttpServletResponse response)throws IOException{						
			return "back/dataAnalysis/huanreStation";
		}
		
		
		//热耗指标对比分析
		@RequestMapping("/heatIndex")
		public String heatIndex(HttpServletRequest request, HttpServletResponse response)throws IOException{						
			return "back/dataAnalysis/heatIndex";
		}		
		//单位热耗指标对比分析
		@RequestMapping("/unitHeatIndex")
		public String unitHeatIndex(HttpServletRequest request, HttpServletResponse response)throws IOException{						
			return "back/dataAnalysis/unitHeatIndex";
		}	
		//大数据应用和节能减排
		@RequestMapping("/dataAppliAndEmRedu")
		public String dataAppliAndEmRedu(HttpServletRequest request, HttpServletResponse response)throws IOException{						
			return "back/dataAnalysis/dataAppliAndEmRedu";
		}	

		 //智慧运行
		@RequestMapping("/wisdomRun")
	    public String wisdomRun(HttpServletRequest request, HttpServletResponse response){						
			return "back/dataAnalysis/wisdomRun";
		}
		 //流程管理 换表流程
		@RequestMapping("/changetable")
	    public String changetable(HttpServletRequest request, HttpServletResponse response){						
			return "back/workflowmangement/changetable";
		}
		 //流程管理 发起申请
		@RequestMapping("/applicator")
	    public String datachange(HttpServletRequest request, HttpServletResponse response){						
			return "back/workflowmangement/applicator";
		}
		 //流程管理 审批处理
		@RequestMapping("/examineApprove")
	    public String flowedit(HttpServletRequest request, HttpServletResponse response){						
			return "back/workflowmangement/examineApprove";
		}
		
		 //采集器报警  离线报警
		@RequestMapping("/offLineAlarm")
	    public String offLineAlarm(HttpServletRequest request, HttpServletResponse response){						
			return "back/collectorAlarm/offLineAlarm";
		}
		 //采集器报警  采集率分析
		@RequestMapping("/collectRateAnlysis")
	    public String collectRateAnlysis(HttpServletRequest request, HttpServletResponse response){						
			return "back/collectorAlarm/collectRateAnlysis";
		}
		 //采集器报警  设置采集周期
		@RequestMapping("/setCollectCycle")
	    public String setCollectCycle(HttpServletRequest request, HttpServletResponse response){						
			return "back/collectorAlarm/setCollectCycle";
		}
		 //采集器报警  设置采集周期
		@RequestMapping("/changeInfo")
	    public String changeInfo(HttpServletRequest request, HttpServletResponse response){						
			return "back/changeTableManagement/changeInfo";
		}
		 //抄表管理  实时单抄表
		@RequestMapping("/readingMeter")
	    public String readingMeter(HttpServletRequest request, HttpServletResponse response){	
			request.setAttribute("clientno",getParm("clientno"));
			request.setAttribute("date", getParm("date"));
			request.setAttribute("btn", getParm("btn"));
			request.setAttribute("meterid", getParm("meterid"));
			return "back/ReadMeter/readingMeter";
		}
		 //抄表管理  集抄表
		@RequestMapping("/collectingMeter")
	    public String collectingMeter(HttpServletRequest request, HttpServletResponse response){	
			request.setAttribute("clientno",getParm("clientno"));
			request.setAttribute("date", getParm("date"));
			request.setAttribute("btn", getParm("btn"));
			request.setAttribute("meterid", getParm("meterid"));
			return "back/ReadMeter/collectingMeter";
		}
		
		
		//数据查询  信息
		@RequestMapping("/searchInformation")
		public String searchInformation(){
			return "back/searchdata/searchInformation";
		}
		//基础信息 区域查询
		@RequestMapping("/areaSearch")
		public String areaSearch(HttpServletRequest request,HttpServletResponse response){
			return "back/baseinfomanage/areaSearch"; 
		}
		//审核管理
		@RequestMapping("/approval")
		public String approval(HttpServletRequest request,HttpServletResponse response){
			return "back/systemmanage/approval"; 
		}
		//统计分析 基本信息统计
		@RequestMapping("/baseInfoCount")
		public String baseInfoCount(HttpServletRequest request,HttpServletResponse response){
			return "back/dataAnalysis/baseInfoCount"; 
		}
		//统计分析 单元位置分析
		@RequestMapping("/buildPosition")
		public String buildPosition(HttpServletRequest request,HttpServletResponse response){
			return "back/dataAnalysis/buildPosition"; 
		}
		//房屋位置耗热分析
		@RequestMapping("/roomSiteConsumeCount")
		public String roomSiteConsumeCount(HttpServletRequest request,HttpServletResponse response){
			return "back/dataAnalysis/roomSiteConsumeCount"; 
		}
}