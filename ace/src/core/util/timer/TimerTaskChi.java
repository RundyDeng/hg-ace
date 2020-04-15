package core.util.timer;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.TimerTask;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.jeefw.core.Constant;
import com.jeefw.service.home.HomePageService;
public class TimerTaskChi extends TimerTask implements Constant{
	/*@Autowired   //这个算是废了
	private IBaseDao baseDao;*/
	@Autowired
	private HomePageService homePageService;
	
	private static SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@Override
	//此计时器任务要执行的操作。
	public void run() {
		WebApplicationContext wAC = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = wAC.getServletContext();
		try {
			System.out.println("----------定时执行任务！！！开始执行！:" + formatter.format(Calendar.getInstance().getTime()));
			
			
			List listAreaUseEnergy = homePageService.listAreaUseEnergy();
			servletContext.setAttribute(YEAR_AREA_USE_ENERGY, listAreaUseEnergy);
			System.out.println("各小区季度耗热量统计完毕！");
			List areaUseEnergyForDay = homePageService.areaUseEnergyForDay();
			servletContext.setAttribute(STATIC_USE_ENERGY_FOR_DAY, areaUseEnergyForDay);
			System.out.println("各小区当日耗热量完毕！");
			List inOutWarterByDay = homePageService.inOutWarterByDay();
			servletContext.setAttribute(STATIC_INOUT_WATER, inOutWarterByDay);
			System.out.println("最新统计各小区的进回水温度完毕!core.timer2018");
			
			
			
		} catch (Exception e) {
			System.out.println("------------定时任务执行异常--------------");
		}
	}

}