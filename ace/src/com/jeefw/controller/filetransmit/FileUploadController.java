package com.jeefw.controller.filetransmit;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.support.RequestContext;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.haskey.FileLists;
import com.jeefw.model.sys.Attachment;
import com.jeefw.model.sys.SysUser;
import com.jeefw.service.filetransmit.FileUploadService;
import com.jeefw.service.sys.AttachmentService;

import core.util.JavaEEFrameworkUtils;
@Controller
@RequestMapping("/filetransmit/fileuploadcontr")
public class FileUploadController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	private Date date;
	private SimpleDateFormat sdf = new SimpleDateFormat();
	@Resource
	private FileUploadService fileUploadSvr;
	
	@RequestMapping("/updateFileUpload")
	public void updateFileUpload(/*@RequestParam(value = "attachment[]", required = false) MultipartFile file,*/ 
			HttpServletRequest request, HttpServletResponse response,FileLists fileListsModel) throws Exception {
		 //printRequestParam();//noy
		 /*Map<String, String[]> map = request.getParameterMap();
		Enumeration<String> paraN = request.getParameterNames();
		while(paraN.hasMoreElements()){
			Object obj = (Object)paraN.nextElement();
		}*/
		 MultipartHttpServletRequest multipartReq = (MultipartHttpServletRequest) request;
		 MultipartFile file = multipartReq.getFile("attachment[]");
/*		 Map<String, MultipartFile> fileMap = multipartReq.getFileMap();
		 Set<String> fileSets = fileMap.keySet();
		 System.out.println("fileSets==="+fileSets.size());
		 for (String string : fileSets) {
			System.out.println(string+":"+fileMap.get(string));
		}
		 
		 Map<String, String[]> paraMap = multipartReq.getParameterMap();
		 Set<String> sets = paraMap.keySet();
		 System.out.println("paraslength==="+sets.size());
		 for (String string : sets) {
			System.out.println(string+":"+paraMap.get(string)[0]);
		}*/
				
		 if (!file.isEmpty()) {
				RequestContext requestContext = new RequestContext(request);
				Map<String, Object> result = new HashMap<String, Object>();
				if (file.getSize() > 20971520) {
					result.put("status", requestContext.getMessage("g_fileTooLarge"));
				} else {
					
					//file
					double size = file.getSize()*100/1024;
					String originalFilename = file.getOriginalFilename();
					/*FileLists obj = fileUploadSvr.getByProerties("up_file_name", originalFilename);
					if(obj!=null){//存在相同文件
						
					}*/
					String fileName = sdf.format(new Date()) + JavaEEFrameworkUtils.getRandomString(3) + originalFilename.substring(originalFilename.lastIndexOf("."));
					//File filePath = new File(getClass().getClassLoader().getResource("/").getPath().replace("/WEB-INF/classes/", "/static/upload/attachment/" + DateFormatUtils.format(new Date(), "yyyyMM")));
					File filePath = new File(UPLOAD_PATH+DateFormatUtils.format(new Date(), "yyyyMM"));
					System.out.println(getClass().getClassLoader().getResource("/").getPath());
					if (!filePath.exists()) {
						filePath.mkdirs();
					}
					file.transferTo(new File(filePath.getAbsolutePath() + "\\" + fileName));
					String destinationFilePath = UPLOAD_PATH + DateFormatUtils.format(new Date(), "yyyyMM") + "/" + fileName;
					String userName = ((SysUser) request.getSession().getAttribute(SESSION_SYS_USER)).getUserName();
					
					//otherPara
					fileListsModel.setFileSize(String.valueOf(size/100)+"K");
					fileListsModel.setFilePath(destinationFilePath);
					fileListsModel.setAddTime(new Date());
					fileListsModel.setUserAccount(userName);
					fileUploadSvr.persist(fileListsModel);
					result.put("status", "OK");
					result.put("originalFilename", originalFilename);
					result.put("url", filePath.getAbsolutePath() + "\\" + fileName);
				}
				writeJSON(response, result);
			}
	}
}
