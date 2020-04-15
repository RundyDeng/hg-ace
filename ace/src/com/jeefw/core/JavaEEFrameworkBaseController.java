package com.jeefw.core;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.jeefw.model.sys.SysUser;

import core.controller.ExtJSBaseController;
import core.support.ExtJSBaseParameter;

public abstract class JavaEEFrameworkBaseController<E extends ExtJSBaseParameter> extends ExtJSBaseController<E> implements Constant {

	public SysUser getCurrentSysUser() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		return (SysUser) request.getSession().getAttribute(SESSION_SYS_USER);
	}
	
	/**
	 * excel标题样式及显示字段设置
	 * @param strTitles  顺序的string用中文 ， 分割
	 * @param wb		 工作簿
	 * @param sheet		工作表
	 */
	public HSSFRow setExcelTitleStr(String strTitles,HSSFWorkbook wb,HSSFSheet sheet){
		if(StringUtils.isBlank(strTitles))
			return null;
		String[] cellTitles = strTitles.split("，");
		if(cellTitles.length==1){
			cellTitles = strTitles.replace("'", "").split(",");
		}
		HSSFRow headRow = sheet.createRow(0);
		HSSFCell cell;
		
		HSSFCellStyle cellBorder = wb.createCellStyle();
		//设置边框
        cellBorder.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellBorder.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cellBorder.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cellBorder.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        //居中
        cellBorder.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
		HSSFFont font = wb.createFont();
        font.setFontName("仿宋_GB2312");//字体
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//粗体显示
        font.setFontHeightInPoints((short) 13);//字号
		cellBorder.setFont(font);
		headRow.setHeight((short) 380);
		for (int i = 0; i < cellTitles.length; i++) {
			cell = headRow.createCell(i);
			cell.setCellValue(cellTitles[i]);
			cell.setCellStyle(cellBorder);
		}
		return headRow;
	}

	
}
