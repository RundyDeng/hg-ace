package com.jeefw.controller.baseinfomanage;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
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

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;

@Controller
@RequestMapping("/baseinfomanage/SystemOperLog")
public class SystemOperLogController extends IbaseController {
	@Resource
	private IBaseDao baseDao;

	@RequestMapping("/getsystemoperlog")
	public void getStatistic(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Map<String, Object> map = new HashMap<String, Object>();
		String sdate = getParm("sdate");
		String edate = getParm("edate");
		String username = getParm("username");
		boolean flag = false;
		String sqlwhere = "select USERNAME,OPERATION,to_char(OPERDATE,'yyyy-MM-dd HH24:mi:ss') as OPERDATE,OPERRESULT,LOGTYPE from TLOG where 1=1";
		if (StringUtils.isNotBlank(username) && !"null".equals(username)) {
			sqlwhere += " and username='"+username+"'";
			flag = true;
		}
		if (StringUtils.isNotBlank(sdate) && StringUtils.isNotBlank(edate)) {
			sqlwhere += " and operdate between "
	                  +"  to_date('"+sdate+" 00:00:00','yyyy-MM-dd HH24:mi:ss') and "
	                  +"  to_date('"+edate+" 23:59:59','yyyy-MM-dd HH24:mi:ss')";
			flag = true;
		}
		sqlwhere+=" order by operdate desc";
		if (flag != true) {

		}
		int page = 0;
		int pagesize = Integer.valueOf(getParm("pagesize"));
		if (StringUtils.isBlank(getParm("page")))
			page = 1;
		else
			page = Integer.valueOf(getParm("page"));
		List eachAreaMeterInfo = baseDao.listSqlPageAndChangeToMap(sqlwhere, page, pagesize, null);
		System.out.println("list:"+eachAreaMeterInfo);
		long total = baseDao.countSql(sqlwhere);
		long pageNumber = (total + pagesize - 1) / pagesize;
		map.put("data", eachAreaMeterInfo);
		map.put("pageCount", pageNumber);
		System.out.println("map:"+map);
		writeJSON(response, map);
	}
/**
 * 系统操作日志导出excel
 * @param request
 * @param response
 * @throws Exception
 */
		@RequestMapping("/exportoperlog")
		public void exportoperlog(HttpServletRequest request,HttpServletResponse response) throws Exception{
            String title = getParm("title");
			String sdate=getParm("sdate");
			String edate=getParm("edate");
			String username = getParm("username");
			String sql = "select rownum,a.* from(select username,to_char(operdate,'yyyy-MM-dd HH:mi:ss') as operdate,operation from TLOG"
					+ "  where operdate between to_date('"+sdate+" 00:00:00','yyyy-MM-dd HH24:mi:ss')  and to_date('"+edate+" 23;59:59','yyyy-MM-dd HH24:mi:ss')";
			
			if(StringUtils.isNotBlank(username)){
				sql+=" and username='"+username+"'";
			}
			sql+=" order by operdate desc)a";
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
            	String strTitles = "序号，记录人，日期，备注";
            		
            	sheet.setColumnWidth(2, 7700);
            	sheet.setColumnWidth(3, 9000);
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
						+ title + ".xls");
                response.setContentType("application/vnd.ms-excel");
                response.setContentLength(baos.size());
                
                ServletOutputStream out1 = response.getOutputStream();
                baos.writeTo(out1);
                out1.flush();
                out1.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
				
				
		}
}