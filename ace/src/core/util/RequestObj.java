package core.util;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.jeefw.core.Constant;

public class RequestObj {
	public static HttpServletRequest getResq(){
		return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
	}
	
	public static String switchOnTimeTableByName(String tableName){
		String tableTime = "";
		Object ob = getResq().getSession().getAttribute(Constant.CHOOSE_TABLE_TIME);
		if(ob != null && org.apache.commons.lang3.StringUtils.isNotBlank(ob.toString()))
			tableTime = ob.toString();
		String resultName = tableName + tableTime;
		return resultName;
	}
}
