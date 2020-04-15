package com.jeefw.controller.dataAnalysis;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.jeefw.controller.IbaseController;
import com.jeefw.service.dataanalysis.BuildDistributionService;
import com.jeefw.service.pub.PubService;

import core.util.MathUtils;

@Controller
@RequestMapping("/dataanalysis/builddistributioncontr")
public class BuildDistributionContr extends IbaseController {
	@Resource
	private BuildDistributionService buildSvr;
	@Resource
	private PubService pubSvr;
	
	@RequestMapping("/getBuildDistribution")
	public void getBuildDistribution(HttpServletRequest request,HttpServletResponse response) throws IOException{
		Map<String, Object> buildinfo = pubSvr.getMaxFloorAndUnitAndMaxDoor(getParm("buildno"));
		List<Map> data = buildSvr.getBuildDistribution(getParm("areaguid"),getParm("buildno"));
		List<Map<String, Object>> array = (ArrayList<Map<String, Object>>)buildinfo.get("unitInfo");

		List finallll = new ArrayList();
		List cellList = new ArrayList();
		for (int i = 0; i < (int)buildinfo.get("maxFloor"); i++) {
			Map map = new HashMap();
			cellList = new ArrayList();
			for (int j = 0; j < array.size(); j++) {
				 String unitno = array.get(j).get("UNITNO").toString();
				 int maxDoor = MathUtils.getBigDecimal(array.get(j).get("MAXDOOR")).intValue();
				 for (int k = 0; k < maxDoor; k++) {
					 int flag = 0;
					 for (int k2 = 0; k2 < data.size(); k2++) {
						 String doorNum = (String)data.get(k2).get("DOORNAME");
						 String doorP = doorNum.replaceAll("[^x00-xff]*", "");
						 String tmpD = doorP.replaceAll("[A-Za-z]+", "");
						 if(!doorP.equals(tmpD)) continue;//楼栋包含字母的楼层时，暂不处理
						 if(Integer.valueOf(unitno)==MathUtils.getBigDecimal(data.get(k2).get("UNITNO")).intValue()
								 &&i==MathUtils.getBigDecimal(data.get(k2).get("FLOORNO")).intValue()-1
								 &&k==Integer.valueOf(doorP.substring(doorP.length()-1))-1){
							 Map oo = data.get(k2);
							 cellList.add(data.get(k2));
							 flag = 1;
							 break;
						 }
					}
					if(flag == 0){
						cellList.add(null);
					}
				}
			}
			finallll.add(cellList);
		}
		Map result = new HashMap();
		result.put("ROWS", finallll);
		result.put("UNITINFO", array);
		writeJSON(response, result);
	}
}
