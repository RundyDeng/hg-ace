package core.dao;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;
 
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
 


import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Workbook;
 
/**
 * @desc: excel工具
 * @author: fxl
 * @createTime: 2016-07-21 上午11:32:17
 * @version: v1.0
 */
public class ExcelUtils {
	 /**
	    * excel导出工具
	    * @author: fxl
	    * @createTime: 2016-07-21 上午11:32:17
	    * @param <E>
	    * @param response
	    * @param header
	    * @param fileNames
	    * @param list void
	 * @throws IOException 
	    */

	public static <E> void exportExcel(HttpServletResponse response,String[] header,String[] fileNames,List<Map> list,FileOutputStream out,String file) throws IOException {
		  //创建工作簿
        HSSFWorkbook wb=new HSSFWorkbook();
	
        //创建一个sheet
        HSSFSheet sheet=wb.createSheet("抄表数据");
         
        HSSFRow headerRow=sheet.createRow(0);
        HSSFRow contentRow=null;
         
         
        //设置标题
        for(int i=0;i<header.length;i++){
            headerRow.createCell(i).setCellValue(header[i]);
        }
        try {
            for(int i=0;i<list.size();i++){
                contentRow=sheet.createRow(i+1);
                //获取每一个对象
                Map cls=list.get(i);
                for(int j=0;j<fileNames.length;j++){
                    String fieldName = fileNames[j].substring(0, 1).toUpperCase()+ fileNames[j].substring(1);
                    
                    Object value = cls.get(fieldName);
                    if(value!=null){
                        contentRow.createCell(j).setCellValue(value.toString());
                    }
                }
            }
            wb.write(out);
            wb.close();
            out.close();
          
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }  catch (SecurityException e) {
            e.printStackTrace();
        } 
       
       
    }
}
