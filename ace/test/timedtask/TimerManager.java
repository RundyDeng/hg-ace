package timedtask;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

/**
 * 定时任务，每天定时执行任务
 * @author ZQ
 *
 */
public class TimerManager {
	private static final long time_interval = 24 * 60 * 60 * 1000; //时间间隔
	
	public TimerManager(){
		Calendar cal = Calendar.getInstance();
		
		/**定制每天2点执行方法**/
		
		//指示一天中的小时。HOUR_OF_DAY 用于 24 小时制时钟。例如 在 10:04:15.250 PM 这一时刻，HOUR_OF_DAY 为 22。 
		cal.set(Calendar.HOUR_OF_DAY, 22);
		
		Date date=cal.getTime(); //第一次执行定时任务的时间
		
		//Timer一种工具，线程用其安排以后在后台线程中执行的任务。可安排任务执行一次，或者定期重复执行。
		Timer timer  = new Timer();
		TimerTaskChi ttc = new TimerTaskChi();
		System.out.println("aaaaaa");
		timer.schedule(ttc, 1000*3,1000);
	}
	/*public static void main(String[] args) {
		new TimerManager();
	}*/
}
