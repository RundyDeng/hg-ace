package com.jeefw.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jeefw.dao.IBaseDao;
import com.jeefw.model.haskey.CustomerHomeBtn;
import com.jeefw.model.sys.SysUser;
import com.jeefw.model.vo.MenuTree;
import com.jeefw.model.vo.TMenu;
import com.jeefw.service.home.CustomerHomeBtnService;
import com.jeefw.service.home.HomePageService;
import com.jeefw.service.sys.AuthorityService;
import com.jeefw.service.sys.RoleService;
import com.jeefw.service.sys.SysUserService;
import com.sun.corba.se.spi.orbutil.fsm.FSM;
import com.sun.corba.se.spi.orbutil.fsm.State;

import core.support.JqGridPageView;
import core.util.MathUtils;

@Controller
@RequestMapping("/homePage")
public class HomePageController extends IbaseController {
	@Resource
	private IBaseDao baseDao;
	private int pagesize = 12;
	@Resource
	private CustomerHomeBtnService btnService;
	@Resource
	private SysUserService sysUserService;
	@Resource
	private AuthorityService authorityService;
	@Resource
	private RoleService roleService;
	@Resource
	private HomePageService homePageService;
	
	private List<TMenu> menuList;
	
	@RequestMapping("/getStatisticsInfo")
	public void getStatisticsInfo(HttpServletRequest request, HttpServletResponse response) {
		// 最近一次的统计时间 max data :
		String statisticsDate = baseDao.findBySqlList("select to_char(max(ddate),'yyyy-MM-dd') as statisticsdate from tgztj", null).get(0).toString();
//		String statisticsDate = baseDao.findBySql("select to_char(max(ddate),'yyyy-MM-dd') as day from tmeter_tmp").get(0).toString();
		
		/*
		 * String sql =
		 * "select distinct  AREAGUID,TOTZHSUM,TOTCBSUM,ZCSUM,GZSUM,WFYSUM,WCBSUM,DDATE from tgztj "
		 * + " where ddate>to_date('" + statisticsDate +
		 * "','yyyy-mm-dd hh24:mi:ss')";
		 */

		// 统计信息 ()  20180316  ddate>to_date---->ddate<to_date 最新日期
		String sql = "select sum(totzhsum) as totzhsum,sum(totcbsum) as totcbsum,sum(zcsum) as zcsum,sum(gzsum) as gzsum,"
				+ " sum(wfysum) as wfysum,sum(wcbsum) as wcsum from tgztj" + " where ddate>to_date('" + statisticsDate
				+ "','yyyy-mm-dd hh24:mi:ss')";
		Map<String, Object> map = (Map<String, Object>) baseDao.listSqlAndChangeToMap(sql, null).get(0);

	}

	@RequestMapping("/getTemperature")
	public void getTemperature(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 正式的时候用这个
		String sql = "select  replace(ddate,'/','-') ddate ,areaname,swwendu " + " from twendu "
				+ " where ddate >= to_char(sysdate-2,'yyyy-mm-dd hh24:mi:ss') "
				+ " and ddate <= to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') "
				+ " order by to_date(ddate,'yyyy-mm-dd hh24:mi:ss')";
		String rsql = "select  replace(ddate,'/','-') ddate ,areaname,swwendu " + " from twendu "
				+ " where to_date(ddate,'yyyy-mm-dd hh24:mi:ss') >= to_date('2017/10/20','yyyy-mm-dd') "
				+ " and to_date(ddate,'yyyy-mm-dd hh24:mi:ss') <= to_date('2017/10/30','yyyy-mm-dd')"
				+ " order by to_date(ddate,'yyyy-mm-dd hh24:mi:ss')";
		List list = baseDao.listSqlAndChangeToMap(rsql, null);

		writeJSON(response, list);
	}

//	@RequestMapping("/getTemperatureByHighCharts")
	//@ResponseBody
//	public void getTemperatureByHighCharts(HttpServletRequest request,HttpServletResponse response) throws IOException{
		/*String rsql = "select  replace(ddate,'/','-') ddate ,areaname,swwendu " + " from twendu "
				+ " where to_date(ddate,'yyyy-mm-dd hh24:mi:ss') >= to_date('2016/3/7','yyyy-mm-dd') "
				+ " and to_date(ddate,'yyyy-mm-dd hh24:mi:ss') <= to_date('2016/3/10','yyyy-mm-dd')"
				+ " order by to_date(ddate,'yyyy-mm-dd hh24:mi:ss')";
		List list = baseDao.findBySqlList(rsql, null);
		String str = new String( "日期,温度" );
		for (int i = 0; i < list.size(); i++) {
			str += "\n";
			Object[] obj = (Object[])list.get(i);
			str += obj[0].toString()+","+obj[2].toString();
		}
		response.setContentType("text/plain;charset=utf-8");
		response.getWriter().write(str);*/
//	}
	
	@RequestMapping("/getStatisticInfo")
	public void getStatisticInfo(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Map<String, Object> map = new HashMap<String, Object>() ;
		String date = getParm("date");
		String areaName = getParm("areaname");
		boolean flag = false;
		// 各小区表信息统计
		String eachAreaMeterInfoSql = "select t.*,a.areaname,b.SECTIONID,b.SECTIONNAME,c.FACTORYID,c.FACTORYNAME "
									+" from Tarea a "
									+" left join FACTORYSECTIONINFO b "
									+" on a.FACTORYNO=b.SECTIONID "
									+" left join ENERGYFACTORY c "
									+" on c.FACTORYID=b.FACTORYID "
									+" inner join TGZTJ t "
									+" on t.areaguid=a.areaguid "
									+" where 1=1 ";
		if(StringUtils.isNotBlank(date)){
			eachAreaMeterInfoSql += " and t.ddate>to_date('" + date + "','yyyy-mm-dd hh24:mi:ss') and t.ddate<to_date('" + date + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
			flag = true;
		}
		if(StringUtils.isNotBlank(areaName)){
			eachAreaMeterInfoSql += " and a.areaname like '%" + areaName + "%' ";
			flag = true;
		}
		if(flag!=true){
		}
		int page = 0;
		if(StringUtils.isBlank(getParm("page")))
			page = 1;
		else
			page = Integer.valueOf(getParm("page"));
		List eachAreaMeterInfo = baseDao.listSqlPageAndChangeToMap(eachAreaMeterInfoSql, page, pagesize, null);
		long total = baseDao.countSql(eachAreaMeterInfoSql);
		long pageNumber = (total + pagesize - 1)/pagesize;
		map.put("data", eachAreaMeterInfo);
		map.put("pageCount", pageNumber);
		writeJSON(response, map);
	}

	
	@RequestMapping("/getStatisticnew")
	public void getStatistic(HttpServletRequest request,HttpServletResponse response) throws IOException{
		Map<String, Object> map = new HashMap<String, Object>() ;
		String date = getParm("date");
		String areaName = getParm("areaname");
		String statusFlag = getParm("statusflag");
		boolean flag = false;
		// 各小区表信息统计
		String eachAreaMeterInfoSql = "select t.*,a.areaname,b.SECTIONID,b.SECTIONNAME,c.FACTORYID,c.FACTORYNAME "
									+" from Tarea a "
									+" left join FACTORYSECTIONINFO b "
									+" on a.FACTORYNO=b.SECTIONID "
									+" left join ENERGYFACTORY c "
									+" on c.FACTORYID=b.FACTORYID "
									+" inner join TGZTJ t "
									+" on t.areaguid=a.areaguid "
									+" where 1=1 ";
		
		if(StringUtils.isNotBlank(statusFlag)){
			eachAreaMeterInfoSql += " and t." + statusFlag + " <> 0";
		}
		if(StringUtils.isNotBlank(date)){
			eachAreaMeterInfoSql += " and t.ddate>to_date('" + date + "','yyyy-mm-dd hh24:mi:ss') and t.ddate<to_date('" + date + " 23:59:59','yyyy-mm-dd hh24:mi:ss')";
			flag = true;
		}
		if(StringUtils.isNotBlank(areaName)&&!"null".equals(areaName)){
			eachAreaMeterInfoSql += " and a.areaname like '%" + areaName + "%' ";
			flag = true;
		}
		if(flag!=true){
		}
		List eachAreaMeterInfo = baseDao.listSqlAndChangeToMap(eachAreaMeterInfoSql, null);
		map.put("data", eachAreaMeterInfo);
		writeJSON(response, map);

	}
	@RequestMapping("/getMeterDetail")
	public void getMeterDetail(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String sql = "select * from VALLAREAINFOFAILURE " + getSqlWhereByRequestParaMap()+"order by customid";
		List list = baseDao.listSqlAndChangeToMap(sql, null);
		writeJSON(response, list);
	}
	//导出excel
	@RequestMapping("/excelTodayStatus")
	public void excelTodayStatus(HttpServletRequest request,HttpServletResponse response) throws Exception{
		byte[] data = URLDecoder.decode(request.getParameter("csvBuffer"), "UTF-8").getBytes();
		String dataStr = new String(data);
		String[] rows = dataStr.split("\n");
		if(rows.length<2){//至少有2行，第一行是标题，第二行是数据，否则不用导出表格数据
			
		}
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
        
		String titles = rows[0].replaceAll("\t", "，");  //标题串，逗号分隔
		setExcelTitleStr(titles, wb , sheet);//设置标题样式
		sheet.setColumnWidth(1, 7700);
		
		for (int i = 1; i < rows.length; i++) {
			String[] obj = rows[i].split("\t");//内容部分
			row = sheet.createRow(i);
        	row.setHeight((short)360);
			for (int j = 0; j < obj.length; j++) {
				String val = obj[j];
				cell = row.createCell(j);
				cell.setCellValue(val);
				cell.setCellStyle(cellBorder);
			}
			
		}
		 String fileTitle = URLDecoder.decode(getParm("title"), "UTF-8").replaceAll(" ", "");
		/*
		String aa = URLDecoder.decode(request.getQueryString(),"UTF-8");
		String url = request.getParameter("fname").replaceAll("%(?![0-9a-fA-F]{2})", "%25"); 
		byte[] fileData = URLDecoder.decode(url, "UTF-8").getBytes();
		String ff = new String(fileData,"UTF-8");*/
			try {
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
                wb.write(baos);
                response.addHeader("Content-Disposition", "attachment;filename="
						+ new String( fileTitle.getBytes("gb2312"), "ISO8859-1" ) + ".xls");
                response.setContentType("application/vnd.ms-excel");//文件下载
                response.setContentLength(baos.size());
                ServletOutputStream out1 = response.getOutputStream();
                baos.writeTo(out1);
                out1.flush();
                out1.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
	}
	
	
	
/* homepage.js从以下获取数据 */	
	
	//各小区平均进回水温度温差
	@RequestMapping("/getstatisticeacharea")
	public void getStatisticEachArea(HttpServletRequest request,HttpServletResponse response) throws IOException{
		ServletContext servletContext = request.getServletContext();
		if(servletContext.getAttribute(STATIC_INOUT_WATER) != null){
			writeJSON(response, servletContext.getAttribute(STATIC_INOUT_WATER));
			return;
		}
		List list = homePageService.inOutWarterByDay();
		servletContext.setAttribute(STATIC_INOUT_WATER, list);
		writeJSON(response, list);
	}
	
	//耗热量统计，小区，住户数，面积，日期，耗热量      统计当天的
	@RequestMapping("/getareauseenergy")
	public void getAreaUseEnergy(HttpServletRequest request,HttpServletResponse response) throws IOException{
		if(request.getServletContext().getAttribute(STATIC_USE_ENERGY_FOR_DAY)!=null){
			writeJSON(response, request.getServletContext().getAttribute(STATIC_USE_ENERGY_FOR_DAY));
			return ;
		}
		List list = homePageService.areaUseEnergyForDay();
		request.getServletContext().setAttribute(STATIC_USE_ENERGY_FOR_DAY, list);
		writeJSON(response, list);
	}
	
	/**
	 * 各小区本季度耗热总量
	 */
	@RequestMapping("/getareaenergy")
	public void getAreaEnergy(HttpServletRequest request,HttpServletResponse response) throws IOException{
		Object attribute = request.getServletContext().getAttribute(YEAR_AREA_USE_ENERGY);
		if(attribute != null){
			writeJSON(response, attribute);
			return;
		}
		List list = homePageService.listAreaUseEnergy();
		request.getServletContext().setAttribute(YEAR_AREA_USE_ENERGY, list);
		writeJSON(response, list);
	}
	
	//首页的故障统计部分
/*	@RequestMapping("/getwarninginfo")
	public void getWarningInfo(HttpServletRequest resquest,HttpServletResponse response) throws IOException{
		
		String sql = "select b.areaname as 小区名称,concat(concat(concat(b.Buildname,'-'),concat(b.unitno,'-')),b.doorname) as 门牌 ,b.CLIENTNO,a.meterid, "
					+" case when a.METERGL>c.METERSSLLMAX then '瞬时流量过高,' when a.METERGL<c.meterssllmin then '瞬时流量过低,' end"
					+ " || "
					+" case when a.MeterJSWD>c.JSWDMAX then '供水温度过高,' when a.MeterJSWD<c.jswdmin then '供水温度过低,' end"
					+ " || "
					+" case when a.MeterHSWD>c.HSWDMAX then '回水温度过高,' when a.MeterHSWD<c.hswdmin then '回水温度过低,' end"
					+ " || "
					+" case when a.MeterWC>c.WCMAX then '温差过高,' when a.MeterWC<c.wcmin then '温差过低,' end as 异常情况,"
					+" Round(a.meternllj,2) as 累计热量, Round(a.METERTJ,2) as 累计流量,Round(a.METERGL,2) as 瞬时流量, "
					+" Round(a.METERJSWD,2) as 供水温度， Round(a.METERHSWD,2) as 回水温度,Round(a.MeterWC,2) as 温差,to_char(a.Ddate,'YYYY-MM-DD') as 抄表时间 "
					+" from tmeter a ,vareainfo b,warringsparmset c "
					+" where (to_char(DDate,'YYYY-MM-DD')='"+stoday+"' and a.meterid=b.meterno and a.areaguid=b.areaguid ) "
					+" and  (a. METERGL>c.METERSSLLMAX or a. METERGL<c.meterssllmin"
					+ " or  a.MeterJSWD>c.JSWDMAX or a.MeterJSWD<c.jswdmin"
					+ " or  a.MeterHSWD>c.HSWDMAX or a.MeterHSWD<c.hswdmin"
					+ " or  a.MeterWC>c.WCMAX or a.MeterWC<c.wcmin )"
					+ " order by b.CLIENTNO";
		String day= baseDao.findBySql("select to_char(max(ddate),'yyyy-MM-dd') as day from tmeter_tmp").get(0).toString();
		String sql = "select b.areaname as 小区名称,concat(concat(concat(b.Buildname,'-'),concat(b.unitno,'-')),b.doorname) as 门牌 ,b.CLIENTNO,a.meterid, "
				+" case when a.METERGL>c.METERSSLLMAX then '瞬时流量过高,' when a.METERGL<c.meterssllmin then '瞬时流量过低,' end"
				+ " || "
				+" case when a.MeterJSWD>c.JSWDMAX then '供水温度过高,' when a.MeterJSWD<c.jswdmin then '供水温度过低,' end"
				+ " || "
				+" case when a.MeterHSWD>c.HSWDMAX then '回水温度过高,' when a.MeterHSWD<c.hswdmin then '回水温度过低,' end"
				+ " || "
				+" case when a.MeterWC>c.WCMAX then '温差过高,' when a.MeterWC<c.wcmin then '温差过低,' end as 异常情况,"
				+" Round(a.meternllj,2) as 累计热量, Round(a.METERTJ,2) as 累计流量,Round(a.METERGL,2) as 瞬时流量, "
				+" Round(a.METERJSWD,2) as 供水温度， Round(a.METERHSWD,2) as 回水温度,Round(a.MeterWC,2) as 温差,to_char(a.Ddate,'YYYY-MM-DD') as 抄表时间 "
				+" from tmeter a ,vareainfo b,warringsparmset c ,tclient d"
				+" where (to_char(a.DDate,'YYYY-MM-DD')='"+day+"' and a.meterid=b.meterno and a.areaguid=b.areaguid ) "
				+" and  (a. METERGL>c.METERSSLLMAX or a. METERGL<c.meterssllmin"
				+ " or  a.MeterJSWD>c.JSWDMAX or a.MeterJSWD<c.jswdmin"
				+ " or  a.MeterHSWD>c.HSWDMAX or a.MeterHSWD<c.hswdmin"
				+ " or  a.MeterWC>c.WCMAX or a.MeterWC<c.wcmin ) and ( a.areaguid =d.areaguid and d.clientno=b.clientno and d.isyestr=0)"
				+ " order by b.CLIENTNO";

		List list = baseDao.listSqlPageAndChangeToMap(sql, getCurrentPage(), getShowRows(), null);
		JqGridPageView view = new JqGridPageView();
		view.setCurrentPage(getCurrentPage());
		view.setRows(list);
		view.setMaxResults(getShowRows());
		view.setRecords(baseDao.countSql(sql));
		writeJSON(response, view);
	}*/
	//设置自定义按钮
	@RequestMapping("/setCustomerBtn")
	public void setCustomerBtn(HttpServletRequest request,HttpServletResponse response,CustomerHomeBtn customerBtnModel) throws IOException{
		Long id = ((SysUser) request.getSession().getAttribute(SESSION_SYS_USER)).getId();
		customerBtnModel.setUserId(id);
		if(customerBtnModel.getId() == 0){//新增
			long userMaxSeq = btnService.userMaxSeq(id) + 1;
			customerBtnModel.setSeq((int)userMaxSeq);
		}
		btnService.merge(customerBtnModel);
		writeJSON(response, "ok");
	}
	
	//删除自定义按钮
	@RequestMapping("/delCustBtn")
	@ResponseBody
	public boolean delCustomerBtn(HttpServletRequest request,HttpServletResponse response){
		boolean deleteByPK = btnService.deleteByPK(Long.valueOf(getParm("id")));
		return deleteByPK;
	}
	
	//获取自定义按钮
	@RequestMapping("/getCustomerBtn")
	public void getCustomerBtn(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String sql = "select c_h_b.id,c_h_b.seq,a.menu_code,a.menu_name,"
					//+ "replace(a.menu_class,'menu-icon ','') as menu_class"//设置好子菜单样式再使用这句
					+ "replace((select menu_class from authority where menu_code=a.parent_menucode),'menu-icon ','') as menu_class"//使用父节点图标
					+ ",a.data_url,c_h_b.bg_class "
					+" ,(select menu_name from authority where menu_code=a.parent_menucode) as parent_name "
					+" from customer_home_btn c_h_b "
					+" inner join authority a "
					+" on c_h_b.menu_code = a.menu_code "
					+" where c_h_b.user_id = "+ ((SysUser) request.getSession().getAttribute(SESSION_SYS_USER)).getId() + " "
					+" order by c_h_b.seq";
		 List list = baseDao.listSqlAndChangeToMap(sql, null);
		writeJSON(response, list);
	}
	
	
	
	
	//小区图片
//	@RequestMapping("/getAreaGif")
//	public void getAreaGif(HttpServletRequest request, HttpServletResponse response) throws IOException{
//		writeJSON(response, null);
//	}
	
	//得到小区树
	@RequestMapping("/getAreaTree")
	public void getAreaTree(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String getAllSql = "select c.FACTORYID as \"id\",0 as \"parent_id\",c.FACTORYNAME as \"menu_name\",1 as \"menu_level\"  from EnergyFactory c   "
						+"union  "
						+"select b.SECTIONID as \"id\",b.FACTORYID as \"parent_id\",b.SECTIONNAME as \"menu_name\", 2 as \"menu_level\" from FACTORYSECTIONINFO b  "
						+"union  "
						+"select a.areaguid as \"id\",a.factoryno as \"parent_id\",a.areaname as \"menu_name\", 3 as \"menu_level\" from tarea a  ";
		//List<TMenu> menus = baseDao.findSql(getAllSql, TMenu.class, null); //似乎是BUG  转换为对象集合时数据出错
		List<Map> list = baseDao.listSqlAndChangeToMap(getAllSql, null);
		List<TMenu> menus = new ArrayList<TMenu>();
		for (Map map : list) {
			TMenu tMenu = new TMenu();
			tMenu.setId(MathUtils.getBigDecimal(map.get("id")).toString());
			tMenu.setParentid(MathUtils.getBigDecimal(map.get("parent_id")).toString());
			tMenu.setMenuName(map.get("menu_name") instanceof String ? 
					(String)map.get("menu_name") : MathUtils.getBigDecimal(map.get("menu_name")).toString());
			tMenu.setLevel(MathUtils.getBigDecimal(map.get("menu_level")).intValue());
			if(map.get("menu_name").equals(getParm("areaName"))){
				tMenu.getState().checked = true;
				tMenu.getState().selected = false;
				tMenu.getState().disable = true;
				tMenu.getState().expanded = true;
			}
			menus.add(tMenu);
		}
		
		List<MenuTree> tree = getTree(menus);
		writeJSON(response, tree);
	}
	
	//得到树形对象
	private List<MenuTree> getTree(List<TMenu> objs){
		menuList = objs;
		String beginParentId = "0";
		List<MenuTree> list = new ArrayList<MenuTree>();
		for (TMenu tMenu : objs) 
			if(tMenu.getParentid().equals(beginParentId) && tMenu.getLevel()==1 ) list.add(menuConvert(tMenu));
		return list;
	}
	
	//递归根节点下的所有节点
	private List<MenuTree> recursionMenu(String parentId,int parentLevel){
		List<MenuTree> list = new ArrayList<MenuTree>();
		for (TMenu tMenu : menuList) 
			if(tMenu.getLevel()==(parentLevel+1) && tMenu.getParentid().equals(parentId)) list.add(menuConvert(tMenu));
		return list;
	};
	
	//对象转换
	private MenuTree menuConvert(TMenu tMenu){
		MenuTree menuTree = new MenuTree();
		menuTree.setMenuId(tMenu.getId());
		menuTree.setText(tMenu.getMenuName());
		menuTree.setMenuLevel(tMenu.getLevel());
		menuTree.setState(tMenu.getState());
		List<MenuTree> recursionMenu = recursionMenu(tMenu.getId(),tMenu.getLevel());
		if(recursionMenu.size() != 0)
			menuTree.setNodes(recursionMenu);
		return menuTree;
	}
}
