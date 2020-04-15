package core.util;

import org.apache.commons.lang3.StringUtils;

public class StringUtilsForController {
	public static boolean isNotBlank(String str){
		if(StringUtils.isNotBlank(str)&&!"UNDEFINED".equalsIgnoreCase(str)&&!"null".equalsIgnoreCase(str))
			return true;
		return false;
	}
}
