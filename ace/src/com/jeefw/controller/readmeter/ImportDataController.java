package com.jeefw.controller.readmeter;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.service.pub.PubService;
import com.sun.mail.iap.Response;

@Controller
@RequestMapping(value = "/readmeter/importdata")
public class ImportDataController  extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService todayDataService;
	@Resource
	private PubService pubSer;
	/**
	 * 手动录入抄表数据
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/importData")
	
	public void importData(HttpServletRequest request , HttpServletResponse response) throws IOException{
	 boolean flag=false;
	 String areaguid=request.getParameter("areaguid");
	 String pooladdr=request.getParameter("pooladdr");
	 String mbusid=request.getParameter("mbusid");
	 String meterid=request.getParameter("meterid");
	 String devicetype="0";
	 String devicestatus=request.getParameter("devicestatus");
	 String areaname = todayDataService.getAreanameById(areaguid);
		request.getSession().setAttribute(AREA_GUIDS, areaguid);
		request.getSession().setAttribute(AREA_NAME, areaname);
	 if(devicestatus==""){
		 devicestatus="0";
	 }
	 String metergl=request.getParameter("metergl");
	 if(metergl==""){
		 metergl="0";
	 }
	 String meternllj=request.getParameter("meternllj");
	 if(meternllj==""){
		 meternllj="0";
	 }
	 String meterls=request.getParameter("meterls");
	 if(meterls==""){
		 meterls="0";
	 }
	 String metertj=request.getParameter("metertj");
	 if(metertj==""){
		 metertj="0";
	 }
	 String meterjswd=request.getParameter("meterjswd");
	 if(meterjswd==""){
		 meterjswd="0";
	 }
	 String meterhswd=request.getParameter("meterhswd");
	 if(meterhswd==""){
		 meterhswd="0";
	 }
	 String meterwc=request.getParameter("meterwc");
	 if(meterwc==""){
		 meterwc="0";
	 }
	 String counthour=request.getParameter("counthour");
	 if(counthour==""){
		 counthour="0";
	 }
	 String metersj=request.getParameter("metersj");
	 if(metersj==""){
		 metersj="";
	 }
	 String ddate=request.getParameter("ddate");
	 String autoid=request.getParameter("autoid");
	 String remark=request.getParameter("remark");
	 if(remark==""){
		 remark="";
	 }
	 String sysstatus=request.getParameter("sysstatus");
	 if(sysstatus==""){
		 sysstatus="";
	 }
	 String meternlljgj=request.getParameter("meternlljgj");
	 if(meternlljgj==""){
		 meternlljgj="0";
	 }
	 Integer iMeterFM=0;
	 String sqlwhere = String.format("insert into tmeter values(%d,%d,%d,%d,%d,%d,%f,"
	 		+ "%f,%f,%f,%f,%f,%f,%d,'%s',to_date('%s','yyyy-MM-dd HH24:mi;ss'),%d,"
	 		+ "'%s',%d,'%s',%f)", Integer.parseInt(areaguid), Integer.parseInt(pooladdr), Integer.parseInt(mbusid), Integer.parseInt(meterid),
	 		Integer.parseInt(devicetype), Integer.parseInt(devicestatus), Float.parseFloat(meternllj), Float.parseFloat(metertj), Float.parseFloat(meterls), Float.parseFloat(metergl),
	 		Float.parseFloat(meterjswd), Float.parseFloat(meterhswd), Float.parseFloat(meterwc), Integer.parseInt(counthour), metersj, ddate, Integer.parseInt(autoid),
	 		remark, iMeterFM, sysstatus,Float.parseFloat(meternlljgj) );
	 String sqlcount = String.format("select * from tmeter where areaguid=%d and"
	 		+ " pooladdr=%d and mbusid=%d and meterid=%d and devicetype=%d"
	 		+ " and to_char(ddate,'yyyy-MM-dd')='%s' and autoid=%d ",Integer.parseInt(areaguid), Integer.parseInt(pooladdr),Integer.parseInt(mbusid), Integer.parseInt(meterid),Integer.parseInt(devicetype),ddate,Integer.parseInt(autoid));
	 List list= baseDao.listSqlAndChangeToMap(sqlcount, null);	
	 if(list.size()>0){
		 String sqlupdatestr = String.format("update tmeter set "
		 		+ " devicestatus=%d , meternllj=%f , metertj=%f , meterls=%f"
		 		+ " , metergl=%f , meterjswd=%f , meterhswd=%f , meterwc=%f , counthour=%d"
		 		+ " , metersj='%s' , ddate= to_date('%s','yyyy-MM-dd HH24:mi:ss')   ,"
		 		+ " remark='%s' , meterfm=%d , sysstatus='%s' , meternlljgj=%f where areaguid=%d and pooladdr=%d and mbusid=%d and meterid=%d and devicetype=%d and to_char(ddate,'yyyy-MM-dd')='%s' and autoid=%d", 
		 	    Integer.parseInt(devicestatus), Float.parseFloat(meternllj),
		 		Float.parseFloat(metertj), Float.parseFloat(meterls), Float.parseFloat(metergl), 
		 		Float.parseFloat(meterjswd), Float.parseFloat(meterhswd), Float.parseFloat(meterwc), 
		 		Integer.parseInt(counthour), metersj, ddate,remark, iMeterFM, sysstatus,Float.parseFloat(meternlljgj),Integer.parseInt(areaguid), Integer.parseInt(pooladdr),Integer.parseInt(mbusid), Integer.parseInt(meterid),Integer.parseInt(devicetype),ddate,Integer.parseInt(autoid));
		 flag = pubSer.executeBatchSql(sqlupdatestr); 
	 }else{
		 flag = pubSer.executeBatchSql(sqlwhere); 
	 }
	 writeJSON(response, flag);
	}
	  /**
	   * 使用excel批量导入抄表数据
	   * @param myfiles
	   * @param request
	   * @param response
	   * @throws IOException
	   */
	 @RequestMapping(value = "/loanData", method = RequestMethod.POST)
	 public void loanData(@RequestParam MultipartFile[] myfiles,
	            HttpServletRequest request,HttpServletResponse response) throws IOException {
	        // 如果只是上传一个文件，则只需要MultipartFile类型接收文件即可，而且无需显式指定@RequestParam注解
	        // 如果想上传多个文件，那么这里就要用MultipartFile[]类型来接收文件，并且还要指定@RequestParam注解
	        // 并且上传多个文件时，前台表单中的所有<input type="file">的name都应该是myfiles，否则参数里的myfiles无法获取到所有上传的文件
	        File[] files = new File[myfiles.length];
	        String message="";
	        Calendar c=Calendar.getInstance(); 
    	    SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd"); 
    	    String path=f.format(c.getTime());
	        Map<Integer, Map<Integer, String>> map = new HashMap<Integer, Map<Integer, String>>();
	        if(myfiles.length>1){
	        	message="上传文件大于一个，请重新选择！";
	        }else{ 
	        for (MultipartFile myfile : myfiles) {
	            if (myfile.isEmpty()) {
	            	message="未选择上传文件哦！";
	            } else {
	                System.out.println("文件长度: " + myfile.getSize());
	                System.out.println("文件类型: " + myfile.getContentType());
	                System.out.println("文件名称: " + myfile.getName());
	                System.out.println("文件原名: " + myfile.getOriginalFilename());
	                System.out.println(myfile.getOriginalFilename().substring(myfile.getOriginalFilename().lastIndexOf(".")+1));
	                if("xls".equals(myfile.getOriginalFilename().substring(myfile.getOriginalFilename().lastIndexOf(".")+1))
	                  || "xlsx".equals(myfile.getOriginalFilename().substring(myfile.getOriginalFilename().lastIndexOf(".")+1))
	                  || "XLS".equals(myfile.getOriginalFilename().substring(myfile.getOriginalFilename().lastIndexOf(".")+1))
	                  || "XLSX".equals(myfile.getOriginalFilename().substring(myfile.getOriginalFilename().lastIndexOf(".")+1))){
	               
	                String serverPath = request.getSession().getServletContext().getRealPath("/");  
	                //在服务器端创建文件夹  
	                File filename = new File(serverPath+path);  
	                if(!filename.exists()){  
	                	filename.mkdir();  
	                }  
	                String realPath = request.getSession().getServletContext().getRealPath("/"+path);
	                // 这里不必处理IO流关闭的问题，因为FileUtils.copyInputStreamToFile()方法内部会自动把用到的IO流关掉，我是看它的源码才知道的
	                File file = new File(realPath, myfile.getOriginalFilename());
	                FileUtils.copyInputStreamToFile(myfile.getInputStream(), file);
	                
	                if(myfile.getOriginalFilename().toLowerCase().endsWith("xls")){
	                	map=readXls(myfile.getInputStream());
	                
	                }else{
	                 map= readXlsx(file+"");
	                
	                }
	               
	               deleteFile(filename);
	        }else{
	           message="文件不是excel，请选择正确文件上传！";
	          }
	        }
	       }
	       
	    }
	        
	       if("".equals(message)){
	    	   boolean flag=false;
	    		  // System.out.println("key= "+ key + " and value= " + map.get(key));
	    		  if("小区编号".equals(map.get(0).get(0)) && "集中器地址".equals(map.get(0).get(1)) && "通道号".equals(map.get(0).get(2))
	    			  && "表号".equals(map.get(0).get(3)) && "设备类型".equals(map.get(0).get(4)) && "设备状态".equals(map.get(0).get(5))
	    			  && "累计热量".equals(map.get(0).get(6)) && "累计流量".equals(map.get(0).get(7)) && "瞬时流量".equals(map.get(0).get(8)) 
	    			  && "瞬时热量".equals(map.get(0).get(9)) && "进水温度".equals(map.get(0).get(10)) && "回水温度".equals(map.get(0).get(11))
	    			  && "温差".equals(map.get(0).get(12)) && "时数".equals(map.get(0).get(13)) && "热表时间".equals(map.get(0).get(14))
	    			  && "抄表时间".equals(map.get(0).get(15)) && "抄表批次".equals(map.get(0).get(16)) && "备注".equals(map.get(0).get(17))
	    			  && "系统状态".equals(map.get(0).get(18)) && "累计热量(GJ)".equals(map.get(0).get(19))){
	    			   for (Integer key : map.keySet()) {
	    					  if(key>0){
	    						 String areaguid=map.get(key).get(0);
	    						 String pooladdr=map.get(key).get(1);
	    						 String mbusid=map.get(key).get(2);
	    						 String meterid=map.get(key).get(3);
	    						 String devicetype=map.get(key).get(4);
	    						 if (devicetype == null){
	    							  devicetype="0";
	    						  }
	    						 String devicestatus=map.get(key).get(5);
	    						 if (devicestatus == null){
	    							 devicestatus="0";
	    						  }
	    						 String meternllj=map.get(key).get(6);
	    						 if (meternllj == null){
	    							 meternllj="0";
	    						  }
	    						 String metertj=map.get(key).get(7);
	    						 if (metertj == null){
	    							 metertj="0";
	    						  }
	    						 String meterls=map.get(key).get(8);
	    						 if (meterls == null){
	    							 meterls="0";
	    						  }
	    						 String metergl=map.get(key).get(9);
	    						 if (metergl == null){
	    							 metergl="0";
	    						  }
	    						 String meterjswd=map.get(key).get(10);
	    						 if (meterjswd == null){
	    							 meterjswd="0";
	    						  }
	    						 String meterhswd=map.get(key).get(11);
	    						 if (meterhswd == null){
	    							 meterhswd="0";
	    						  }
	    						 String meterwc=map.get(key).get(12);
	    						 if (meterwc == null){
	    							 meterwc="0";
	    						  }
	    						 String counthour=map.get(key).get(13);
	    						 if (counthour == null){
	    							 counthour="0";
	    						  }
	    						 String metersj=map.get(key).get(14);
	    						 if (metersj == null){
	    							 metersj=path;
	    						  }
	    						 String ddate=map.get(key).get(15);
	    						 if (ddate == null){
	    							 ddate=path;
	    						  }
	    						 String autoid=map.get(key).get(16);
	    						 if (autoid == null){
	    							 autoid="1";
	    						  }
	    						 String remark=map.get(key).get(17);
	    						 if (remark == null){
	    							 remark="";
	    						  }
	    						 String sysstatus=map.get(key).get(18);
	    						 if (sysstatus == null){
	    							 sysstatus="0";
	    						  }
	    						 String meternlljgj=map.get(key).get(19);
	    						 if (meternlljgj == null){
	    							 meternlljgj="0";
	    						  }
	    						 Integer iMeterFM=0;
	    						 
	    						 String sqlwhere = String.format("insert into tmeter values(%d,%d,%d,%d,%d,%d,%f,"
	    						 		+ "%f,%f,%f,%f,%f,%f,%d,'%s',to_date('%s','yyyy-MM-dd HH24:mi;ss'),%d,"
	    						 		+ "'%s',%d,'%s',%f)", Integer.parseInt(areaguid), Integer.parseInt(pooladdr), Integer.parseInt(mbusid), Integer.parseInt(meterid),
	    						 		Integer.parseInt(devicetype), Integer.parseInt(devicestatus), Float.parseFloat(meternllj), Float.parseFloat(metertj), Float.parseFloat(meterls), Float.parseFloat(metergl),
	    						 		Float.parseFloat(meterjswd), Float.parseFloat(meterhswd), Float.parseFloat(meterwc), Integer.parseInt(counthour), metersj, ddate, Integer.parseInt(autoid),
	    						 		remark, iMeterFM, sysstatus,Float.parseFloat(meternlljgj) );
	    						 String sqlcount = String.format("select * from tmeter where areaguid=%d and"
	    						 		+ " pooladdr=%d and mbusid=%d and meterid=%d and devicetype=%d"
	    						 		+ " and to_char(ddate,'yyyy-MM-dd')='%s' and autoid=%d ",Integer.parseInt(areaguid), Integer.parseInt(pooladdr),Integer.parseInt(mbusid), Integer.parseInt(meterid),Integer.parseInt(devicetype),ddate,Integer.parseInt(autoid));
	    						 List list= baseDao.listSqlAndChangeToMap(sqlcount, null);	
	    						 if(list.size()>0){
	    							 String sqlupdatestr = String.format("update tmeter set "
	    							 		+ " devicestatus=%d , meternllj=%f , metertj=%f , meterls=%f"
	    							 		+ " , metergl=%f , meterjswd=%f , meterhswd=%f , meterwc=%f , counthour=%d"
	    							 		+ " , metersj='%s' , ddate= to_date('%s','yyyy-MM-dd HH24:mi:ss')   ,"
	    							 		+ " remark='%s' , meterfm=%d , sysstatus='%s' , meternlljgj=%f where areaguid=%d and pooladdr=%d and mbusid=%d and meterid=%d and devicetype=%d and to_char(ddate,'yyyy-MM-dd')='%s' and autoid=%d", 
	    							 	    Integer.parseInt(devicestatus), Float.parseFloat(meternllj),
	    							 		Float.parseFloat(metertj), Float.parseFloat(meterls), Float.parseFloat(metergl), 
	    							 		Float.parseFloat(meterjswd), Float.parseFloat(meterhswd), Float.parseFloat(meterwc), 
	    							 		Integer.parseInt(counthour), metersj, ddate,remark, iMeterFM, sysstatus,Float.parseFloat(meternlljgj),Integer.parseInt(areaguid), Integer.parseInt(pooladdr),Integer.parseInt(mbusid), Integer.parseInt(meterid),Integer.parseInt(devicetype),ddate,Integer.parseInt(autoid));
	    							 flag = pubSer.executeBatchSql(sqlupdatestr); 
	    						 }else{
	    							 flag = pubSer.executeBatchSql(sqlwhere); 
	    						 }
	    					  }
	    				  }
	    			   if(flag==true){
	    				  message="上传成功!";
	    			   }else{
	    				   message="上传失败!";
	    			   }
	    			  }else{
	    				  message="表格格式错误，请检查!";
	    			  }
	    		   
	    		 
	    	  
	    }
	       writeJSON(response, "<script>alert('"+message+"');history.go(-1);</script>");
	  }
	/**
	 * 读取excel文档数据，存入map中(Excel2007以上版本)
	 * @param fileName
	 * @return
	 * @throws IOException
	 */
	 private Map<Integer, Map<Integer, String>> readXlsx(String fileName) throws IOException {
	        
	        XSSFWorkbook xssfWorkbook = new XSSFWorkbook(fileName);
	        Map<Integer, Map<Integer, String>> mapRow = new HashMap<Integer, Map<Integer, String>>();
	        // 循环工作表Sheet
	        for (int numSheet = 0; numSheet < xssfWorkbook.getNumberOfSheets(); numSheet++) {
	            XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(numSheet);
	            if (xssfSheet == null) {
	                continue;
	            }
	 
	            // 循环行Row
	            for (int rowNum = 0; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {
	                XSSFRow xssfRow = xssfSheet.getRow(rowNum);
	                if (xssfRow == null) {
	                    continue;
	                }
	                Map<Integer, String> mapColumn = new HashMap<Integer, String>();
	                // 循环列Cell
	                for (int cellNum = 0; cellNum <= xssfRow.getLastCellNum(); cellNum++) {
	                    XSSFCell xssfCell = xssfRow.getCell(cellNum);
	                    if (xssfCell == null) {
	                        continue;
	                    
	                    }
	                    mapColumn.put(xssfCell.getColumnIndex(), getValue(xssfCell));
	                  
	                    
	                }
	                mapRow.put(xssfRow.getRowNum(), mapColumn);
	             
	            }
	        }
	        xssfWorkbook.close();
	        return mapRow;
	    }
	 /**
	  * 获取单元格的值
	  * @param xssfCell
	  * @return
	  */
	 @SuppressWarnings("static-access")
	 private String getValue(XSSFCell xssfCell) {

		  int type = xssfCell.getCellType();
		  String cellContext = "";
		  switch (type) { // 判断数据类型
			case Cell.CELL_TYPE_BLANK:// 空的
				cellContext = "";
				break;
			case Cell.CELL_TYPE_BOOLEAN:// 布尔
				cellContext = xssfCell.getBooleanCellValue() + "";
				break;
			case Cell.CELL_TYPE_ERROR:// 错误
				cellContext = xssfCell.getErrorCellValue() + "";
				break;
			case Cell.CELL_TYPE_FORMULA:// 公式
				cellContext = xssfCell.getCellFormula();
				break;
			case Cell.CELL_TYPE_NUMERIC:// 数字或日期
				if (HSSFDateUtil.isCellDateFormatted(xssfCell)) {
					cellContext = new DataFormatter().formatRawCellContents(xssfCell.getNumericCellValue(), 0, "yyyy-mm-dd");// 格式化日期
				} else {
					NumberFormat nf = NumberFormat.getInstance();
					nf.setGroupingUsed(false);
					cellContext = nf.format(xssfCell.getNumericCellValue());
				}
				break;
			case Cell.CELL_TYPE_STRING:// 字符串
				cellContext = xssfCell.getStringCellValue();
				break;
			default:
				break;
			}
		  return cellContext;
	    }
	 /**
	  * 读取excel,把数据存入map(excel2003版本) 
	  * @param is
	  * @return
	  * @throws IOException
	  */
	 private Map<Integer, Map<Integer, String>> readXls(InputStream is) throws IOException {
	        HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
	        Map<Integer, Map<Integer, String>> mapRow = new HashMap<Integer, Map<Integer, String>>();
	        // 循环工作表Sheet
	        for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
	            HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
	            if (hssfSheet == null) {
	                continue;
	            }
	 
	            // 循环行Row
	            for (int rowNum = 0; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
	                HSSFRow hssfRow = hssfSheet.getRow(rowNum);
	                if (hssfRow == null) {
	                    continue;
	                }
	                Map<Integer, String> mapColumn = new HashMap<Integer, String>();
	                // 循环列Cell
	                for (int cellNum = 0; cellNum <= hssfRow.getLastCellNum(); cellNum++) {
	                    HSSFCell hssfCell = hssfRow.getCell(cellNum);
	                    if (hssfCell == null) {
	                        continue;
	                    }
	                    mapColumn.put(hssfCell.getColumnIndex(), getValue(hssfCell));
	                    
	                }
	                
	                mapRow.put(hssfRow.getRowNum(), mapColumn);
	            }
	        }
	        hssfWorkbook.close();
	        return mapRow;
	    }
	 
	    @SuppressWarnings("static-access")
	  private String getValue(HSSFCell hssfCell) {
	    	  int type = hssfCell.getCellType();
			  String cellContext = "";
			  switch (type) { // 判断数据类型
				case Cell.CELL_TYPE_BLANK:// 空的
					cellContext = "";
					break;
				case Cell.CELL_TYPE_BOOLEAN:// 布尔
					cellContext = hssfCell.getBooleanCellValue() + "";
					break;
				case Cell.CELL_TYPE_ERROR:// 错误
					cellContext = hssfCell.getErrorCellValue() + "";
					break;
				case Cell.CELL_TYPE_FORMULA:// 公式
					cellContext = hssfCell.getCellFormula();
					break;
				case Cell.CELL_TYPE_NUMERIC:// 数字或日期
					if (HSSFDateUtil.isCellDateFormatted(hssfCell)) {
						cellContext = new DataFormatter().formatRawCellContents(hssfCell.getNumericCellValue(), 0, "yyyy-mm-dd");// 格式化日期
					} else {
						NumberFormat nf = NumberFormat.getInstance();
						nf.setGroupingUsed(false);
						cellContext = nf.format(hssfCell.getNumericCellValue());
					}
					break;
				case Cell.CELL_TYPE_STRING:// 字符串
					cellContext = hssfCell.getStringCellValue();
					break;
				default:
					break;
				}
			  return cellContext;
	    }
	    //递归删除文件夹  
	 private void deleteFile(File file) {  
	     if (file.exists()) {//判断文件是否存在  
	      if (file.isFile()) {//判断是否是文件  
	       file.delete();//删除文件   
	      } else if (file.isDirectory()) {//否则如果它是一个目录  
	       File[] files = file.listFiles();//声明目录下所有的文件 files[];  
	       for (int i = 0;i < files.length;i ++) {//遍历目录下所有的文件  
	        this.deleteFile(files[i]);//把每个文件用这个方法进行迭代  
	       }  
	       file.delete();//删除文件夹  
	      }  
	     } else {  
	      System.out.println("所删除的文件不存在");  
	     }  
	    }  
 
}
