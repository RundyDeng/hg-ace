package core.util.timer;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.web.context.ServletContextAware;

import com.jeefw.core.Constant;
import com.jeefw.service.home.HomePageService;

public class TimerTaskListener implements InitializingBean,ServletContextAware,Constant {
	@Resource
	private HomePageService homePageService;
	@Resource
	private TimerTaskChi timerTaskChi;

	@Override
	public void afterPropertiesSet() throws Exception {
		/**
		 * 这个方法将在所有的属性被初始化后调用。
			但是会在init前调用。
			但是主要的是如果是延迟加载的话，则马上执行。
			所以可以在类上加上注解：
			import org.springframework.context.annotation.Lazy;
			@Lazy(false)
			这样spring容器初始化的时候afterPropertiesSet就会被调用。
			只需要实现InitializingBean接口就行。
			如果代码在这里初始化的话，半天都找不到。。
		 */
		//List listTarea = homePageService.listTarea();
		
		//TimerManager tm = new TimerManager();//不能直接这样new，否则和spring没有半毛关系
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.HOUR_OF_DAY, 3);  //03:00 执行
		Date date=cal.getTime(); 
		if(date.before(new Date())){ 
			cal.add(Calendar.DAY_OF_MONTH, 1); //一天后执行
			date = cal.getTime();
		}
/*
		Timer timerInit  = new Timer();
		timerInit.schedule(timerTaskChi, 1000);//无法2次执行此方法--应该是timerTaskChi无法被调用2次吧- -
*/		
		new Timer().schedule(timerTaskChi, date, 6*60* 1000);
	}
	
	@Override
	//在Spring中，凡是实现ServletContextAware接口的类，都可以取得ServletContext。  这个方法比上面那个方法先执行
	public void setServletContext(ServletContext servletContext) {
		System.out.println("---------初始化统计！  开始！taskListener2018");
		
		
		List listAreaUseEnergy = homePageService.listAreaUseEnergy();
		servletContext.setAttribute(YEAR_AREA_USE_ENERGY, listAreaUseEnergy);
	//	System.out.println("各小区季度耗热量统计完毕！");
		List areaUseEnergyForDay = homePageService.areaUseEnergyForDay();
		servletContext.setAttribute(STATIC_USE_ENERGY_FOR_DAY, areaUseEnergyForDay);
	//	System.out.println("各小区当日耗热量完毕！");
		List inOutWarterByDay = homePageService.inOutWarterByDay();
		servletContext.setAttribute(STATIC_INOUT_WATER, inOutWarterByDay);
	//	System.out.println("最新统计各小区的进回水温度完毕!");
		
		System.out.println("---------初始化统计！ 结束！");
		
	}

}
