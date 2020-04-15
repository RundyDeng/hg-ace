package core.util.timer;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.jeefw.service.home.HomePageService;

/**
 * 定时任务 --  此类作废
 * @author 
 *
 */
public class TimerManager {
	private static final long TIME_INTERVAL = 24 * 60 * 60 * 1000; 

	public TimerManager(){
		
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.HOUR_OF_DAY, 22);
		Date date=cal.getTime(); 
		if(date.before(new Date())){ 
			cal.add(Calendar.DAY_OF_MONTH, 1);
			date = cal.getTime();
		}
		Timer timer  = new Timer();
		TimerTaskChi ttc = new TimerTaskChi();
		System.out.println("进入得到TimerManager!");
		/*WebApplicationContext wAC = ContextLoader.getCurrentWebApplicationContext();
		ServletContext servletContext = wAC.getServletContext();
		TimerTaskChi ttc2 = (TimerTaskChi)WebApplicationContextUtils.getWebApplicationContext(servletContext).getBean("timerTaskChi");*/
		//timer.schedule(ttc, date,TIME_INTERVAL);
		timer.schedule(ttc, 1000*3,1000*3);
	}

}