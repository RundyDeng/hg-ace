package com.jeefw.controller.priceManage;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.service.pub.PubService;

//计量单价设置
@Controller
@RequestMapping("/priceMange/setUnitPriceContr")
public class SetUnitPriceController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService pubSvr;
	
	@RequestMapping("/getSetUnitPrice")
	public void getSetUnitPrice(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String sql = "select PRICE,CGPRICE from TCLIENTCAT where clientcatid= "+getParm("CLIENTCATID");
	 	List list = baseDao.listSqlAndChangeToMap(sql, null);
	 	writeJSON(response, list.get(0));
	}
	
	@RequestMapping("/updateSetUnitPrice")
	public void updateSetUnitPrice(HttpServletRequest request,HttpServletResponse response) throws DocumentException, IOException{
		String updateSql_TCLIENTCAT = "update TCLIENTCAT set ";
		String updateSql_TSHOUFEI_JLPRICE = "update TSHOUFEI set ";
		String updateSql_TSHOUFEI_RFPRICE = "update TSHOUFEI set ";
		String updateSql_TSYSPARAMS = "update TSYSPARAMS set ";
		String id = getParm("CLIENTCATID");
		//update TSYSPARAMS set ITEMVALUE='" + sFl + "' where TYPEID=1
		Map<String, Object> map = (Map<String, Object>)baseDao.listSqlAndChangeToMap("select price,cgprice from tclientcat where clientcatid="+id, null).get(0);
		if(StringUtils.isNotBlank(getParm("CGPRICE"))){
			updateSql_TCLIENTCAT += " cgprice = "+getParm("CGPRICE")+",";
			updateSql_TSHOUFEI_RFPRICE += " RFPRICE=" + getParm("CGPRICE") + " where RFPRICE=" + map.get("CGPRICE").toString();
		}
		if(StringUtils.isNotBlank(getParm("PRICE"))){
			updateSql_TCLIENTCAT += " price =" + getParm("PRICE") + ",";
			updateSql_TSHOUFEI_JLPRICE += " JLPRICE=" + getParm("PRICE") + " where JLPRICE =" + map.get("PRICE").toString();
		}
		if(StringUtils.isNotBlank(getParm("Auto"))){
			updateSql_TSYSPARAMS += " ITEMVALUE =" + getParm("Auto") + " where typeid=1";

			//修改xml
			SAXReader reader = new SAXReader();
			String xmlPath = this.getClass().getResource("/").getPath() + "prop/DBConfig.xml";
		 	Document document = reader.read(xmlPath);
		 	Element root = document.getRootElement();
		 	List selNodes = root.selectNodes("Item/Auto");
		 	Node node = (Node)selNodes.get(0);
		 	node.setText(getParm("Auto"));
		 	try {
					XMLWriter output = new XMLWriter(new FileWriter(
							new File(xmlPath))); //file换成你自己的xml文件
					output.write(document);
					output.flush();
					output.close();
				} catch (Exception e) {
					// TODO: handle exception
			}
		}
		updateSql_TCLIENTCAT = updateSql_TCLIENTCAT.substring(0,updateSql_TCLIENTCAT.length()-1) + " where clientcatid ="+getParm("CLIENTCATID");
		
		boolean flag = pubSvr.executeBatchSql(updateSql_TCLIENTCAT,updateSql_TSHOUFEI_JLPRICE,updateSql_TSHOUFEI_RFPRICE,updateSql_TSYSPARAMS);
		
		writeJSON(response, flag);
	}
}
