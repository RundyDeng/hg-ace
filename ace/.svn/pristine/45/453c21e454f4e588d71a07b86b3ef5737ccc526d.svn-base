package com.jeefw.controller.sys;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.jeefw.model.sys.Role;
import com.jeefw.service.sys.RoleService;
import com.jeefw.service.sys.SysUserService;

import core.support.ExtJSBaseParameter;
import core.support.JqGridPageView;
import core.support.QueryResult;

/**
 * 角色的控制层
 */
@Controller
@RequestMapping("/sys/role")
public class RoleController extends JavaEEFrameworkBaseController<Role> implements Constant {
	@Resource
	private IBaseDao baseDao;
	@Resource
	private RoleService roleService;
	@Resource
	private SysUserService sysUserService;

	// 查询角色的表格，包括分页、搜索和排序
	@RequestMapping(value = "/getRole", method = { RequestMethod.POST, RequestMethod.GET })
	public void getRole(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		Role role = new Role();
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("roleKey") && result.getString("op").equals("eq")) {
					role.set$eq_roleKey(result.getString("data").toUpperCase());
				}
				if (result.getString("field").equals("roleValue") && result.getString("op").equals("cn")) {
					role.set$like_roleValue(result.getString("data"));
				}
			}
			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
				role.setFlag("OR");
			} else {
				role.setFlag("AND");
			}
		}
		role.setFirstResult((firstResult - 1) * maxResults);
		role.setMaxResults(maxResults);
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		role.setSortedConditions(sortedCondition);
		QueryResult<Role> queryResult = roleService.doPaginationQuery(role);
		JqGridPageView<Role> roleListView = new JqGridPageView<Role>();
		roleListView.setMaxResults(maxResults);
		roleListView.setRows(queryResult.getResultList());
		roleListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, roleListView);
	}

	// 保存角色的实体Bean
	@RequestMapping(value = "/saveRole", method = { RequestMethod.POST, RequestMethod.GET })
	public void doSave(Role entity, HttpServletRequest request, HttpServletResponse response) throws IOException {
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		if (CMD_EDIT.equals(parameter.getCmd())) {
			roleService.merge(entity);
		} else if (CMD_NEW.equals(parameter.getCmd())) {
			roleService.persist(entity);
		}
		parameter.setSuccess(true);
		writeJSON(response, parameter);
	}

	// 操作角色的删除、导出Excel、字段判断和保存
	@RequestMapping(value = "/operateRole", method = { RequestMethod.POST, RequestMethod.GET })
	public void operateRole(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String oper = request.getParameter("oper");
		String id = request.getParameter("id");
		if (oper.equals("del")) {
			String[] ids = id.split(",");
			deleteRole(request, response, (Long[]) ConvertUtils.convert(ids, Long.class));
		} else if (oper.equals("excel")) {
			response.setContentType("application/msexcel;charset=UTF-8");
			String sql = "select id,role_key,role_value,description from role";
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
            	String strTitles = "角色ID，角色编号，角色名，描述";
            	sheet.setColumnWidth(1, 7700);//角色编码
            	sheet.setColumnWidth(3, 6700);//描述
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
						+ new String( "角色权限".getBytes("gb2312"), "ISO8859-1" ) + ".xls");
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
			String roleKey = request.getParameter("roleKey");
			String roleValue = request.getParameter("roleValue");
			String description = request.getParameter("description");
			Role role = null;
			if (oper.equals("edit")) {
				role = roleService.get(Long.valueOf(id));
			}
			Role roleKeyRole = roleService.getByProerties("roleKey", roleKey);
			if (StringUtils.isBlank(roleKey) || StringUtils.isBlank(roleValue)) {
				response.setStatus(HttpServletResponse.SC_LENGTH_REQUIRED);
				result.put("message", "请填写角色编码和角色名称");
				writeJSON(response, result);
			} else if (null != roleKeyRole && oper.equals("add")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此角色编码已存在，请重新输入");
				writeJSON(response, result);
			} else if (null != roleKeyRole && !role.getRoleKey().equalsIgnoreCase(roleKey) && oper.equals("edit")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此角色编码已存在，请重新输入");
				writeJSON(response, result);
			} else {
				Role entity = new Role();
				entity.setRoleKey(roleKey);
				entity.setRoleValue(roleValue);
				entity.setDescription(description);
				if (oper.equals("edit")) {
					entity.setId(Long.valueOf(id));
					entity.setCmd("edit");
					entity.setPermissions(role.getPermissions());
					doSave(entity, request, response);
				} else if (oper.equals("add")) {
					entity.setCmd("new");
					// Set<String> permissions = new HashSet<String>();
					// permissions.add(roleKey + ":*");
					// entity.setPermissions(permissions);
					doSave(entity, request, response);
				}
			}
		}
	}

	// 删除角色
	@RequestMapping("/deleteRole")
	public void deleteRole(HttpServletRequest request, HttpServletResponse response, @RequestParam("ids") Long[] ids) throws IOException {
		boolean flag = false;
		for (int i = 0; i < ids.length; i++) {
			Long id = ids[i];
			roleService.deleteSysUserAndRoleByRoleId(id);
			flag = roleService.deleteByPK(id);
		}
		if (flag) {
			writeJSON(response, "{success:true}");
		} else {
			writeJSON(response, "{success:false}");
		}
	}

	// 获取角色的下拉框
	@RequestMapping(value = "/getRoleSelectList", method = { RequestMethod.POST, RequestMethod.GET })
	public void getRoleSelectList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Role> roleList = roleService.doQueryAll();
		StringBuilder builder = new StringBuilder();
		builder.append("<select>");
		for (int i = 0; i < roleList.size(); i++) {
			builder.append("<option value='" + roleList.get(i).getRoleKey() + "'>" + roleList.get(i).getRoleValue() + "</option>");
		}
		builder.append("</select>");
		writeJSON(response, builder.toString());
	}

}
