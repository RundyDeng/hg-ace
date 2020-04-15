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
import com.jeefw.model.sys.Department;
import com.jeefw.service.sys.DepartmentService;

import core.support.ExtJSBaseParameter;
import core.support.JqGridPageView;
import core.support.QueryResult;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 部门的控制层
 * @框架唯一的升级和技术支持地址：http://shop111863449.taobao.com
 */
@Controller
@RequestMapping("/sys/department")
public class DepartmentController extends JavaEEFrameworkBaseController<Department> implements Constant {
	@Resource
	private IBaseDao baseDao;
	
	@Resource
	private DepartmentService departmentService;

	// 查询部门的表格，包括分页、搜索和排序
	@RequestMapping(value = "/getDepartment", method = { RequestMethod.POST, RequestMethod.GET })
	public void getDepartment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("page"));
		Integer maxResults = Integer.valueOf(request.getParameter("rows"));
		String sortedObject = request.getParameter("sidx");
		String sortedValue = request.getParameter("sord");
		String filters = request.getParameter("filters");
		Department department = new Department();
		if (StringUtils.isNotBlank(filters)) {
			JSONObject jsonObject = JSONObject.fromObject(filters);
			JSONArray jsonArray = (JSONArray) jsonObject.get("rules");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject result = (JSONObject) jsonArray.get(i);
				if (result.getString("field").equals("departmentKey") && result.getString("op").equals("eq")) {
					department.set$eq_departmentKey(result.getString("data"));
				}
				if (result.getString("field").equals("departmentValue") && result.getString("op").equals("cn")) {
					department.set$like_departmentValue(result.getString("data"));
				}
			}
			if (((String) jsonObject.get("groupOp")).equalsIgnoreCase("OR")) {
				department.setFlag("OR");
			} else {
				department.setFlag("AND");
			}
		}
		department.setFirstResult((firstResult - 1) * maxResults);
		department.setMaxResults(maxResults);
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		department.setSortedConditions(sortedCondition);
		QueryResult<Department> queryResult = departmentService.doPaginationQuery(department);
		JqGridPageView<Department> departmentListView = new JqGridPageView<Department>();
		departmentListView.setMaxResults(maxResults);
		List<Department> departmentCnList = departmentService.queryDepartmentCnList(queryResult.getResultList());
		departmentListView.setRows(departmentCnList);
		departmentListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, departmentListView);
	}

	// 保存部门的实体Bean

	@RequestMapping(value = "/saveDepartment", method = { RequestMethod.POST, RequestMethod.GET })
	public void doSave(Department entity, HttpServletRequest request, HttpServletResponse response) throws IOException {
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		if (CMD_EDIT.equals(parameter.getCmd())) {
			departmentService.merge(entity);
		} else if (CMD_NEW.equals(parameter.getCmd())) {
			departmentService.persist(entity);
		}
		parameter.setSuccess(true);
		writeJSON(response, parameter);
	}

	// 操作部门的删除、导出Excel、字段判断和保存
	@RequestMapping(value = "/operateDepartment", method = { RequestMethod.POST, RequestMethod.GET })
	public void operateDepartment(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String oper = request.getParameter("oper");
		String id = request.getParameter("id");
		if (oper.equals("del")) {
			String[] ids = id.split(",");
			deleteDepartment(request, response, (Long[]) ConvertUtils.convert(ids, Long.class));
		} else if (oper.equals("excel")) {
			response.setContentType("application/msexcel;charset=UTF-8");
			String sql = "select d.id,d.department_key,d.department_value,"
					+ "(select department_value from department where department_key = d.parent_departmentkey) as parent "
					+ ",d.description from department d";
			List list = baseDao.findBySqlList(sql, null);
			
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("sheet1");//创建第一个名为sheet1的工作表
			sheet.setDefaultColumnWidth(15);
			HSSFCellStyle cellBorder = wb.createCellStyle();
            cellBorder.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            cellBorder.setBorderRight(HSSFCellStyle.BORDER_THIN);
            cellBorder.setBorderTop(HSSFCellStyle.BORDER_THIN);
            cellBorder.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            cellBorder.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
    		HSSFFont font = wb.createFont();
            font.setFontName("仿宋_GB2312");//字体
            font.setFontHeightInPoints((short) 10);//字号
    		cellBorder.setFont(font);
            cellBorder.setWrapText(true);
            HSSFRow row;
            HSSFCell cell;
            if(list.size()>0){
            	String strTitles = "ID，部门编码，部门名称，上级部门，部门描述";
            	sheet.setColumnWidth(4, 7700);//设置部门描述列宽
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
						+ new String( "部门管理".getBytes("gb2312"), "ISO8859-1" ) + ".xls");
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
			String departmentKey = request.getParameter("departmentKey");
			String departmentValue = request.getParameter("departmentValue");
			String parentDepartmentkey = request.getParameter("parentDepartmentValue");
			String description = request.getParameter("description");
			Department department = null;
			if (oper.equals("edit")) {
				department = departmentService.get(Long.valueOf(id));
			}
			Department departmentKeyDepartment = departmentService.getByProerties("departmentKey", departmentKey);
			Department parentDepartmentkeyDepartment = departmentService.getByProerties("departmentKey", parentDepartmentkey);
			if (StringUtils.isBlank(departmentKey) || StringUtils.isBlank(departmentValue)) {
				response.setStatus(HttpServletResponse.SC_LENGTH_REQUIRED);
				result.put("message", "请填写部门编码和部门名称");
				writeJSON(response, result);
			} else if (null != departmentKeyDepartment && oper.equals("add")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此部门编码已存在，请重新输入");
				writeJSON(response, result);
			} else if (null != departmentKeyDepartment && !department.getDepartmentKey().equalsIgnoreCase(departmentKey) && oper.equals("edit")) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "此部门编码已存在，请重新输入");
				writeJSON(response, result);
			} else if (StringUtils.isNotBlank(parentDepartmentkey) && null == parentDepartmentkeyDepartment) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "上级部门编码输入有误，请重新输入");
				writeJSON(response, result);
			} else if (StringUtils.isNotBlank(parentDepartmentkey) && parentDepartmentkey.equals(departmentKey)) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				result.put("message", "不能选择自己作为上级部门，请重新输入");
				writeJSON(response, result);
			} else {
				Department entity = new Department();
				entity.setDepartmentKey(departmentKey);
				entity.setDepartmentValue(departmentValue);
				entity.setParentDepartmentkey(parentDepartmentkey);
				entity.setDescription(description);
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

	// 删除部门
	@RequestMapping("/deleteDepartment")
	public void deleteDepartment(HttpServletRequest request, HttpServletResponse response, @RequestParam("ids") Long[] ids) throws IOException {
		boolean flag = departmentService.deleteByPK(ids);
		if (flag) {
			writeJSON(response, "{success:true}");
		} else {
			writeJSON(response, "{success:false}");
		}
	}

	// 获取部门的下拉框
	@RequestMapping(value = "/getDepartmentSelectList", method = { RequestMethod.POST, RequestMethod.GET })
	public void getDepartmentSelectList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Department> departmentList = departmentService.doQueryAll();
		StringBuilder builder = new StringBuilder();
		builder.append("<select>");
		for (int i = 0; i < departmentList.size(); i++) {
			builder.append("<option value='" + departmentList.get(i).getDepartmentKey() + "'>" + departmentList.get(i).getDepartmentValue() + "</option>");
		}
		builder.append("</select>");
		writeJSON(response, builder.toString());
	}

	// 获取部门的下拉框(不包括自身)
	@RequestMapping(value = "/getDepartmentSelectNoSelfList", method = { RequestMethod.POST, RequestMethod.GET })
	public void getDepartmentSelectNoSelfList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String departmentKey = request.getParameter("departmentKey") == null ? "" : request.getParameter("departmentKey");
		List<Department> departmentList = departmentService.doQueryAll();
		StringBuilder builder = new StringBuilder();
		builder.append("<select><option value=''></option>");
		for (int i = 0; i < departmentList.size(); i++) {
			if (!departmentKey.equals(departmentList.get(i).getDepartmentKey())) {
				builder.append("<option value='" + departmentList.get(i).getDepartmentKey() + "'>" + departmentList.get(i).getDepartmentValue() + "</option>");
			}
		}
		builder.append("</select>");
		writeJSON(response, builder.toString());
	}

}