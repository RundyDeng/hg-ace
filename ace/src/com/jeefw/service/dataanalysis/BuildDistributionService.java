package com.jeefw.service.dataanalysis;

import java.util.List;
import java.util.Map;

public interface BuildDistributionService {
	
	public List<Map> getBuildDistribution(String areaguid,String buildno);
}
