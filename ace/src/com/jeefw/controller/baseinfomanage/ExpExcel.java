package com.jeefw.controller.baseinfomanage;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.common.Tarea;
import com.jeefw.service.pub.PubService;
import com.jeefw.service.pub.impl.PubServiceImpl;

import core.dao.ExcelUtils;

@Controller
@RequestMapping(value = "/baseinfomanage/ExpExcel")
public class ExpExcel extends IbaseController{
	@Resource
	private IBaseDao<?> baseDao;
	@Resource
	private PubService pubSer;
	/**
	 * 一键式导出今日抄表数据
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "/getAllAreaAllData")
	 public void getAllAreaAllData(HttpServletRequest request , HttpServletResponse response) throws IOException{
		String type=request.getParameter("type");
		String areaguid=request.getParameter("csvBuffer");
		String sql = "select * from tarea";
		if("1".equals(areaguid)){
			sql+=" where 1=1";
		}else{
			areaguid=areaguid.substring(0, areaguid.length()-1);
			sql+=" where areaguid in("+areaguid+")";
		}
		List<Map>list=baseDao.listSqlAndChangeToMap(sql, null);
		String sqlwhere="";
	    Calendar c=Calendar.getInstance(); 
	    SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd"); 
	    List<File> srcfile=new ArrayList<File>(); 
	    String path=f.format(c.getTime());
	    String serverPath = request.getSession().getServletContext().getRealPath("/"); 
        //在服务器端创建文件夹  
        File file = new File(serverPath+path);  
        if(!file.exists()){  
            file.mkdir();  
        }  
	    for(int i=0;i<list.size();i++)
          {
	    	if("0".equals(type))
			{
			sqlwhere="select rownum,BNAME||'-'|| UNITNO||'-'||DOORNAME as menpai,clientno,meterid,SFTR,MSNAME,Round(METERGL,2) as METERGL,"
					+ "Round(METERNLLJ,2) as METERNLLJ,Round(METERLS,2) as METERLS,Round(METERTJ,2) as METERTJ,Round(METERJSWD,2) as METERJSWD,Round(METERHSWD,2) as METERHSWD,Round(METERWC,2) as METERWC, COUNTHOUR,to_char(DDATE,'yyyy-MM-dd') as DDATE,AUTOID,REMARK from vallareainfofailure"
					+ " where areaguid="+list.get(i).get("AREAGUID")+" and to_char(ddate,'yyyy-MM-dd')='"+path+"' order by menpai"; //2018323 order by clientno
			}else{
			sqlwhere="select rownum,BNAME||'-'|| UNITNO||'-'||DOORNAME as menpai,clientno,meterid,SFTR,MSNAME,Round(METERGL,2) as METERGL,"
						+ "Round(METERNLLJ,2) as METERNLLJ,Round(METERLS,2) as METERLS,Round(METERTJ,2) as METERTJ,Round(METERJSWD,2) as METERJSWD,Round(METERHSWD,2) as METERHSWD,Round(METERWC,2) as METERWC, COUNTHOUR,to_char(DDATE,'yyyy-MM-dd') as DDATE,AUTOID,REMARK from vallareainfofailure"
						+ " where areaguid="+list.get(i).get("AREAGUID")+" and to_char(ddate,'yyyy-MM-dd')='"+path+"' and sysstatus!='0' order by menpai"; 
			}
			List<Map> ltodaydata=baseDao.listSqlAndChangeToMap(sqlwhere, null);
			 //生成excel的名字    
            String templateName = list.get(i).get("AREANAME").toString();   
            /** 表头数组 */  
            String[] headArray = new String[]{"序号","  门牌  ","  用户编码  "," 表编号 ","   用热状态   ","   系统状态   ","瞬时热量(KW)","累计热量(KWH)","瞬时流量(M3/H)","累计流量(M3)","进水温度(℃)","回水温度(℃)","温差(℃)","时数","抄表时间","抄表批次","备注"};  
            
            /** 字段名数组 */  
            String[] fieldArray = new String[]{"ROWNUM","MENPAI","CLIENTNO","METERID","SFTR","MSNAME","METERGL","METERNLLJ","METERLS","METERTJ","METERJSWD","METERHSWD","METERWC","COUNTHOUR","DDATE","AUTOID","REMARK"};  
             
            String filename = templateName + "_" + path;  
            try {    
            String encodedfileName = new String(filename.getBytes("utf-8"), "UTF-8");  
            //将生成的多个excel放到服务器的指定的文件夹中  
            FileOutputStream out = new FileOutputStream(serverPath+path+"\\"+encodedfileName+".xls");  
            String fi=encodedfileName;
             
            ExcelUtils.exportExcel(response, headArray, fieldArray, ltodaydata,out,fi);
            srcfile.add(new File(serverPath+path+"\\"+encodedfileName+".xls"));
            } catch (Exception e) {  
                e.printStackTrace();  
            }   
		}
	    //将服务器上存放Excel的文件夹打成zip包  
	    File  zipfile = new File(serverPath+path+".zip");  
        this.zipFiles(srcfile, zipfile); 
        deleteFile(file);
        //弹出下载框供用户下载  
        this.downFile(response,serverPath, path+".zip");
        deleteFile(zipfile);
		
	 }

	/**
	 * 下载文件方法
	 * @param response
	 * @param serverPath
	 * @param str
	 */
	public void downFile(HttpServletResponse response,String serverPath, String str) {    
        try {    
            String path = serverPath + str;    
            File file = new File(path);    
            if (file.exists()) {    
                InputStream ins = new FileInputStream(path);    
                BufferedInputStream bins = new BufferedInputStream(ins);// 放到缓冲流里面    
                OutputStream outs = response.getOutputStream();// 获取文件输出IO流    
                BufferedOutputStream bouts = new BufferedOutputStream(outs);    
                response.setContentType("application/x-download");// 设置response内容的类型    
                response.addHeader("Content-Disposition",    
                        "attachment;filename=\""+URLEncoder.encode(str, "UTF-8"));// 设置头部信息    
                int bytesRead = 0;   
                //response.reset(); 
                byte[] buffer = new byte[8192];    
                 //开始向网络传输文件流    
                while ((bytesRead = bins.read(buffer, 0, buffer.length)) != -1) {    
                   bouts.write(buffer, 0, bytesRead);    
               }    
                
                bouts.flush();// 这里一定要调用flush()方法    
                ins.close();    
                bins.close();    
                outs.close();    
                bouts.close();    
            } else {    
                 
            }    
        } catch (IOException e) {    
            e.printStackTrace();  
        }    
    }  
	
	 /** 
     * 将多个Excel打包成zip文件 
     * @param srcfile 
     * @param zipfile 
     */  
    public void zipFiles(List<File> srcfile, File zipfile) {    
        byte[] buf = new byte[1024];    
        try {    
            // 生成压缩文件   
            ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipfile));    
            // Compress the files    
            for (int i = 0; i < srcfile.size(); i++) {    
                File file = srcfile.get(i);    
                FileInputStream in = new FileInputStream(file);    
                // 添加压缩文件到输出流    
                out.putNextEntry(new ZipEntry(file.getName()));    
                // 从文件传输到压缩文件的字节数
                int len;    
                while ((len = in.read(buf)) > 0) {    
                    out.write(buf, 0, len);    
                }    
                // Complete the entry    
                out.closeEntry();    
                in.close();    
            }    
            // 完成压缩    
            out.close();   
        } catch (IOException e) {    
           e.printStackTrace();  
        }    
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
