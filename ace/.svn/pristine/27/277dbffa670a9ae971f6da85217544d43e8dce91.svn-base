package com.jeefw.controller.sys;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jeefw.core.Constant;
import com.jeefw.core.JavaEEFrameworkBaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.sys.Authority;
import com.jeefw.model.sys.RoleAuthority;
import com.jeefw.model.sys.SysUser;
import com.jeefw.service.sys.AuthorityService;
import com.jeefw.service.sys.RoleAuthorityService;
import com.jeefw.service.sys.RoleService;

import core.support.ExtJSBaseParameter;
import core.support.JqGridPageView;
import core.support.QueryResult;

@Controller
@RequestMapping("/sys/authority")
public class AuthorityController extends JavaEEFrameworkBaseController<Authority> implements Constant {
	@Resource
	private IBaseDao baseDao;
	
	@Resource
	private AuthorityService authorityService;
	@Resource
	private RoleAuthorityService roleAuthorityService;
	@Resource
	private RoleService roleService;

	// 查询菜单的表格，包括分页、搜索和排序
	@RequestMapping(value = "/getAuthority", method = { RequestMethod.POST, RequestMethod.GET })
	public void getAuthority(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		Authority authority = new Authority();
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("menuCode") && result.getString("op").equals("eq")) {
					authority.set$eq_menuCode(result.getString("data"));
				}
				if (result.getString("field").equals("menuName") && result.getString("op").equals("cn")) {
					authority.set$like_menuName(result.getString("data"));
				}
			}
			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
				authority.setFlag("OR");
			} else {
				authority.setFlag("AND");
			}
		}
		authority.setFirstResult((firstResult - 1) * maxResults);
		authority.setMaxResults(maxResults);
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		authority.setSortedConditions(sortedCondition);
		QueryResult<Authority> queryResult = authorityService.doPaginationQuery(authority);
		JqGridPageView<Authority> authorityListView = new JqGridPageView<Authority>();
		authorityListView.setMaxResults(maxResults);
		authorityListView.setRows(queryResult.getResultList());
		authorityListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, authorityListView);
	}

	// 保存菜单的实体Bean
	@RequestMapping(value = "/saveAuthority", method = { RequestMethod.POST, RequestMethod.GET })
	public void doSave(Authority entity, HttpServletRequest request, HttpServletResponse response) throws IOException {
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		if (CMD_EDIT.equals(parameter.getCmd())) {
			authorityService.merge(entity);
		} else if (CMD_NEW.equals(parameter.getCmd())) {
			authorityService.persist(entity);
		}
		parameter.setSuccess(true);
		writeJSON(response, parameter);
	}

	// 操作菜单的删除、导出Excel、字段判断和保存
	@RequestMapping(value = "/operateAuthority", method = { RequestMethod.POST, RequestMethod.GET })
	public void operateAuthority(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String oper = request.getParameter("oper");
		String id = request.getParameter("id");
		if (oper.equals("del")) {
			String[] ids = id.split(",");
			deleteAuthority(request, response, (Long[]) ConvertUtils.convert(ids, Long.class));
		} else if (oper.equals("excel")) {
			response.setContentType("application/msexcel;charset=UTF-8");
			String sql = "select id,menu_code,menu_name,menu_class,data_url,sequence,parent_menucode from authority";
			List list = baseDao.findBySqlList(sql, null);
			
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("sheet1");
			sheet.setDefaultColumnWidth(15);
			HSSFCellStyle cellBorder = wb.createCellStyle();
            cellBorder.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            cellBorder.setBorderRight(HSSFCellStyle.BORDER_THIN);
            cellBorder.setBorderTop(HSSFCellStyle.BORDER_THIN);
            cellBorder.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            cellBorder.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
    		HSSFFont font = wb.createFont();
            font.setFontName("仿宋_GB2312");
            font.setFontHeightInPoints((short) 10);
    		cellBorder.setFont(font);
            cellBorder.setWrapText(true);
            HSSFRow row;
            HSSFCell cell;
            if(list.size()>0){
            	String strTitles = "ID，菜单编码，菜单名称，菜单class属性值，菜单data-url属性值，排序，上级菜单编码";
            	sheet.setColumnWidth(2, 5000);//菜单名称
            	sheet.setColumnWidth(3, 9000);//菜单样式
            	sheet.setColumnWidth(4, 8000);//菜单URL
            	sheet.setColumnWidth(1, 6700);//菜单编号
            	sheet.setColumnWidth(6, 6700);//父菜单编号
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

			try {
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
                wb.write(baos);
                response.addHeader("Content-Disposition", "attachment;filename="
						+ new String( "菜单管理".getBytes("gb2312"), "ISO8859-1" ) + ".xls");
                response.setContentType("application/vnd.ms-excel");
                response.setContentLength(baos.size());
                
                ServletOutputStream out1 = response.getOutputStream();
                baos.writeTo(out1);
                out1.flush();
                out1.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			Map<String, Object> result = new HashMap<String, Object>();
			String menuCode = request.getParameter("menuCode");
			String menuName = request.getParameter("menuName");
			String menuClass = request.getParameter("menuClass");
			String dataUrl = request.getParameter("dataUrl");
			String sequence = request.getParameter("sequence");
			String parentMenuCode = request.getParameter("parentMenuCode");
			if (StringUtils.isBlank(parentMenuCode)) {
				parentMenuCode = "0";
			}
			Authority authority = null;
			if (oper.equals("edit")) {
				authority = authorityService.get(Long.valueOf(id));
			}
			Authority menuCodeAuthority = authorityService.getByProerties("menuCode", menuCode);
			Authority parentMenuCodeAuthority = authorityService.getByProerties("menuCode", parentMenuCode);
			if (StringUtils.isBlank(menuCode) || StringUtils.isBlank(menuName) || StringUtils.isBlank(menuClass) || StringUtils.isBlank(dataUrl)) {
				response.setStatus(HttpServletResponse.SC_LENGTH_REQUIRED);
				result.put("message", "请填写菜单编码、菜单名称、菜单class属性值和菜单data-url属性值");
				writeJSON(response, result);
			} else if (null != menuCodeAuthority && oper.equals("add")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此菜单编码已存在，请重新输入");
				writeJSON(response, result);
			} else if (null != menuCodeAuthority && !authority.getMenuCode().equalsIgnoreCase(menuCode) && oper.equals("edit")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此菜单编码已存在，请重新输入");
				writeJSON(response, result);
			} else if (!parentMenuCode.equals("0") && null == parentMenuCodeAuthority) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "上级菜单编码输入有误，请重新输入");
				writeJSON(response, result);
			} else {
				Authority entity = new Authority();
				entity.setMenuCode(menuCode);
				entity.setMenuName(menuName);
				entity.setMenuClass(menuClass);
				entity.setDataUrl(dataUrl);
				entity.setSequence(sequence == "" ? null : Long.valueOf(sequence));
				entity.setParentMenuCode(parentMenuCode);
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

	// 删除菜单
	@RequestMapping("/deleteAuthority")
	public void deleteAuthority(HttpServletRequest request, HttpServletResponse response, @RequestParam("ids") Long[] ids) throws IOException {
		boolean flag = authorityService.deleteByPK(ids);
		if (flag) {
			writeJSON(response, "{success:true}");
		} else {
			writeJSON(response, "{success:false}");
		}
	}

	// 获取菜单树
	@RequestMapping("/getAuthorityTreeList")
	public void getAuthorityTreeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String roleKey = request.getParameter("roleKey");

		List<RoleAuthority> roleAuthorityList = roleAuthorityService.queryByProerties("roleKey", roleKey);
		List<String> menuCodeList = new ArrayList<String>();
		for (int j = 0; j < roleAuthorityList.size(); j++) {
			menuCodeList.add(roleAuthorityList.get(j).getMenuCode());
		}

		List<Authority> allAuthority = authorityService.doQueryAll();
		Set<String> parentMenuCodeSet = new HashSet<String>();
		for (int i = 0; i < allAuthority.size(); i++) {
			parentMenuCodeSet.add(allAuthority.get(i).getParentMenuCode());
		}

		List<Authority> subMenuList = authorityService.queryByProerties("parentMenuCode", id);

		JSONObject allJSONObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		for (int i = 0; i < subMenuList.size(); i++) {
			JSONObject subJsonObject = new JSONObject();
			subJsonObject.element("id", subMenuList.get(i).getMenuCode());
			subJsonObject.element("name", subMenuList.get(i).getMenuName());

			if (parentMenuCodeSet.contains(id)) {
				subJsonObject.element("type", "folder");
				subJsonObject.element("children", true);
			} else {
				subJsonObject.element("type", "item");
			}

			if (menuCodeList.contains(subMenuList.get(i).getMenuCode())) {
				subJsonObject.element("item-selected", true);
			} else {
				subJsonObject.element("item-selected", false);
			}

			subJsonObject.element("additionalParameters", subJsonObject);
			jsonArray.add(subJsonObject);
		}
		allJSONObject.element("status", "OK");
		allJSONObject.element("data", jsonArray);
		writeJSON(response, allJSONObject);
	}

	// 获取按钮权限
	@RequestMapping("/getAuthorityButtonList")
	public void getAuthorityButtonList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String menuCode = request.getParameter("menuCode");
		JSONObject allJSONObject = new JSONObject();
		String result = authorityService.getAuthorityButtonList(menuCode);
		allJSONObject.element("data", result);
		writeJSON(response, allJSONObject);
	}

	// 保存角色权限
	@RequestMapping(value = "/saveAuthorityButtonList")
	public void saveAuthorityButtonList(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String checkboxList = request.getParameter("checkboxList");
		String menuCode = request.getParameter("menuCode");
		authorityService.saveAuthorityButtonList(checkboxList, menuCode);
		writeJSON(response, "{success:true}");
	}
	
	
	
	@RequestMapping("/getHomeBtnTreeList")
	public void getHomeBtnTreeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		//String roleKey = request.getParameter("roleKey");
		Long userId = ((SysUser) request.getSession().getAttribute(SESSION_SYS_USER)).getId();
		String roleKey = baseDao.findBySql("select r.role_key from role r where r.id = (select role_id from sysuser_role where sysuser_id ="+userId +")").get(0).toString();
		List<RoleAuthority> roleAuthorityList = roleAuthorityService.queryByProerties("roleKey", roleKey);
		List<String> menuCodeList = new ArrayList<String>();
		for (int j = 0; j < roleAuthorityList.size(); j++) {
			menuCodeList.add(roleAuthorityList.get(j).getMenuCode());
		}
		List<Authority> allAuthority = authorityService.doQueryAll();
		Set<String> parentMenuCodeSet = new HashSet<String>();
		for (int i = 0; i < allAuthority.size(); i++) {
			parentMenuCodeSet.add(allAuthority.get(i).getParentMenuCode());
		}
		List<Authority> subMenuListAll = authorityService.queryByProerties("parentMenuCode", id);
		List<Authority> subMenuList = new ArrayList<Authority>();
		for (Authority authority : subMenuListAll) {
			if(menuCodeList.contains(authority.getMenuCode())) subMenuList.add(authority);
		}
		JSONObject allJSONObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		for (int i = 0; i < subMenuList.size(); i++) {
			JSONObject subJsonObject = new JSONObject();
			subJsonObject.element("id", subMenuList.get(i).getMenuCode());
			subJsonObject.element("name", subMenuList.get(i).getMenuName());

			if (parentMenuCodeSet.contains(id)) {
				if(parentMenuCodeSet.contains(subMenuList.get(i).getMenuCode())){
					subJsonObject.element("type", "folder");
					subJsonObject.element("children", true);
				}else{
					subJsonObject.element("type", "item");
					subJsonObject.element("children", false);
				}
			}
			if (menuCodeList.contains(subMenuList.get(i).getMenuCode())) {
				subJsonObject.element("item-selected", false);
			}
			subJsonObject.element("additionalParameters", subJsonObject);
			jsonArray.add(subJsonObject);
		}
		allJSONObject.element("status", "OK");
		allJSONObject.element("data", jsonArray);
		writeJSON(response, allJSONObject);
	}

}
