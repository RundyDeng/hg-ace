package timedtask;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.TimerTask;

public class TimerTaskChi extends TimerTask {
	private static SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@Override
	//此计时器任务要执行的操作。
	public void run() {
		try {
			System.out.println("执行当前时间:" + formatter.format(Calendar.getInstance().getTime()));
		} catch (Exception e) {
			System.out.println("-------------解析信息发生异常--------------");
		}
	}

}
