package com.jeefw.test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.jeefw.app.bean.UpdateUserPwdRequestBean;

import core.util.AppSendUtils;

/**
 * 测试APP接口
 */
public class TestApp {

	public static void main(String[] args) throws ParseException {
		/*UpdateUserPwdRequestBean plrb = new UpdateUserPwdRequestBean();
		plrb.setUsername("杨添");
		plrb.setPassword("skynet168");
		String result = AppSendUtils.SendToUrlByBean(plrb); // 根据用户名修改密码
		System.out.println(result);*/
		
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		System.out.println(cal.getTime().toString());//当前时间
		
		cal.add(Calendar.DAY_OF_MONTH, -3);//当前时间减3天
		Date date = cal.getTime();
		
		String strDate = sdf.format(date);//转换为字符串
		System.out.println(strDate);
		
		Date calDate = sdf.parse(strDate);//字符串转Date
		System.out.println(calDate.toString());
		
		
		Calendar cal2 = Calendar.getInstance();
		cal2.setTime(sdf.parse("2017-06-24"));//设置Claendar的日期为   "2017-06-24"
		System.out.println("设定日期cal："+strDate+"    被比较日期：2017-06-24");
		System.out.println(cal.before(cal2));
		System.out.println(cal.after(cal2));
		
		
	

	}

}
