package com.jeefw.controller.filetransmit;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.model.haskey.FileLists;
import com.jeefw.service.filetransmit.FileManageService;

import core.support.JqGridPageView;
import core.support.QueryResult;
@Controller
@RequestMapping("/filetransmit/filemanagecontr")
public class FileManageController extends IbaseController {
	@Resource
	private IBaseDao baseDao;
	@Resource
	private FileManageService fileManageService;
	
	@RequestMapping("/getfilemanage")
	public void getFileManage(HttpServletRequest request,HttpServletResponse response) throws IOException{
		FileLists fileLists = new FileLists();
		fileLists.setFirstResult((getCurrentPage()-1)*getShowRows());
		fileLists.setMaxResults(getShowRows());
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(getOrderField(), getOrderKind());    
		fileLists.setSortedConditions(sortedCondition);
		QueryResult<FileLists> queryResult = fileManageService.doPaginationQuery(fileLists);
		JqGridPageView<FileLists> fileManageListView = new JqGridPageView<FileLists>();
		fileManageListView.setRows(queryResult.getResultList());
		fileManageListView.setRecords(queryResult.getTotalCount());
		writeJSON(response, fileManageListView);
	}
	
	@RequestMapping("/updatefilemanage")
	public void updateFileManage(HttpServletRequest request,HttpServletResponse response){
		String oper = getParm("oper");
		String id = getParm("id");
		if("del".equals(oper)){
			String[] ids = id.split(",");
			delFile((Long[]) ConvertUtils.convert(ids,Long.class));
		}
	}
	
	@ResponseBody
	private String delFile(Long[] ids){
		boolean flag = fileManageService.deleteByPK(ids);
		if(flag){
			return "{success:true}";
		}
		return "{success:false}";
	}
	
	@RequestMapping("/downloadFile")
	public ResponseEntity<byte[]> downloadFile(HttpServletRequest request,HttpServletResponse response) throws IOException{
		FileLists fileList = fileManageService.get(Long.valueOf(getParm("id")));
		String path = fileList.getFilePath();
		String[] splitStr = path.split("\\.");
		int suffix = splitStr.length-1;
		//String localRealPath = request.getSession().getServletContext().getRealPath("");
		File file = new File(fileList.getFilePath());
		HttpHeaders headers = new HttpHeaders(); 
		String fileName = "";
		try {
			fileName = new String(fileList.getUpFileName().getBytes("UTF-8"),"iso-8859-1");
		} catch (UnsupportedEncodingException e) {
			writeJSON(response, "找不到文件");
			e.printStackTrace();
		}
		headers.setContentDispositionFormData("attachment", fileName + "."+splitStr[suffix]);   
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
                headers, HttpStatus.CREATED);    
	}
}
