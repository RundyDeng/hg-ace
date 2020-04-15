package com.jeefw.controller.readmeter;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.Socket;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.service.pub.PubService;

import core.support.JqGridPageView;
import core.util.RequestObj;
import core.util.LibDSCServer.CReadFromGprs;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/readmeter/collectingMeter")
public class collectingMeterController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService pubSer;
	private String sIP="192.168.10.162";//通讯DSCIP
	private int sPort=10005;//通讯端口
	public static String ljrldw="KWH";
	private static final char[] HEX_CHAR = {'0', '1', '2', '3', '4', '5', 
            '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
	
	// 集抄可按小区，楼栋进行抄-->unitno,floorno
	@RequestMapping("/getUserInfo")
	public void getUserInfo(HttpServletRequest request ,HttpServletResponse response) throws IOException{
		String areaguid=request.getParameter("areaguid");
		String buildno=request.getParameter("buildno");
		String sqlstr = "select meterno from tdoor_meter where areaguid="+areaguid+" and buildno="+buildno;
		System.out.println("++"+sqlstr);
		List list = baseDao.findBySql(sqlstr);//获取住户对应表号
		List tgprs=getGprsInfo(list.get(0).toString());//获取表号的GPRS号
		Object[] os =  (Object[])tgprs.get(0);
		String remark="";
		if(os[4] != null && !os[4].equals("")){
			remark=os[4].toString();
		}
		
		//3/9
		
		String sendbyte=DataFrame(list.get(0).toString(),os[0].toString() , Integer.parseInt(os[1].toString()));
	    String message=sendCmd(sendbyte,Integer.parseInt(areaguid),Float.parseFloat(os[2].toString()),Integer.parseInt(os[3].toString()),remark);
	   
	    
	    List listdata=null;
	    if("抄表成功".equals(message)){
	    	sqlstr="select * from(select (bname || unitno || '单元' || doorname) as menpai,sftr,clientno,hotarea,meterid,msname,round(metergl,2) as metergl,round(meternllj,2) as meternllj,round(meterls,2) as meterls,round(metertj,2) as metertj,round(meterjswd,2) as meterjswd ,"
                    +" round(meterhswd,2) as meterhswd,round(meterwc,2) as meterwc,counthour,to_char(ddate,'yyyy-MM-dd HH24:mi:ss') as ddate,autoid from vallareainfofailure where areaguid="+areaguid+" and meterid="+list.get(0).toString()+"   order by ddate desc ) where rownum=1";
	        listdata=baseDao.listSqlAndChangeToMap(sqlstr, null);
	    }
	    
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("message", message);
	    map.put("data", listdata);
	    writeJSON(response, map);
	}
	private List getGprsInfo(String meterno)
	{
		List list=null;
		String sqlwhere="select gprsid,to_char(DEVICEADDRESS) as DEVICEADDRESS,to_char(cdata) as cdata,to_char(devicetypechildno) as devicetypechildno,remark from tgprs a,tdevice b where a.gprsno=b.gprsno and b.meterno="+meterno;
	    list = baseDao.findBySql(sqlwhere);
		return list;
	}
	public  String DataFrame(String meterno, String gprsid, int lx)
    {
	  int cInt1=0,cInt2=0,cInt3=0,cInt4=0;
	  int cs=0;
   	  String sendData = "request 2 1 ";
   	  sendData+=gprsid+",0x89,";
   	  byte[] by=new byte[15];
   	  by[0]=(byte)0x68;
   	  by[1]=(byte)0x9;
   	  by[2]=(byte)0x9;
   	  by[3]=(byte)0x68;
   	  by[4]=(byte)0xbb;
   	  by[5]=(byte)0x52;
   	  by[6]=(byte)lx;
   	  if(meterno.length()>8){
   		  meterno=meterno.substring(1, meterno.length()-1);
   	  }
   	  cInt1 = Integer.parseInt(meterno) / 1000000;
         int l11 = Integer.parseInt(meterno) % 1000000;
         cInt2 = l11 / 10000;
         int l22 = l11 % 10000;
         cInt3 = l22 / 100;
         int l33 = l22 % 100;
         cInt4 = l33;
         by[7]=ToBCDC(cInt1);
         by[8]=ToBCDC(cInt2);
         by[9]=ToBCDC(cInt3);
         by[10]=ToBCDC(cInt4);
         by[11]=(byte)0x24;
         by[12]=(byte)0x23;
         for (int j = 4; j <= 12; j++)
         {
             cs = (cs + by[j]) % 256;//控制码+地址域+数据域（字节累加），不计超出0xFF的溢出值
         }    
         by[13]=(byte)cs;
         by[14]=0x16;
         
         String str=bytesToHexFun1(by);
         sendData=sendData+str+"\r\n";
   	  return sendData;
    }
	public  String sendCmd(String cmd,int areaguid,float cdata,int iMetertype,String remark) throws UnknownHostException, IOException
    {
		String message="抄表失败";
		try{
    	  Socket socket = new Socket(sIP, sPort);        
          OutputStream os = socket.getOutputStream(); 
          os.write(cmd.getBytes());
          InputStream is = socket.getInputStream();
          byte[] buffer = new byte[200];
          int length = is.read(buffer);
          String str = new String(buffer, 0, length);
          String[] s=str.split(",");
          if(s.length<3){
        	 int i=s[0].indexOf("offline设备不在线"); 
        	 if(i>0){
        		message="offline设备不在线";
        	 }
          }else{
          String ss=s[2].substring(0, s[2].lastIndexOf("#")); 
          byte[] by=hexStringToBytes(ss);
          boolean flag= DealWithByteCycTY(by,areaguid,cdata,iMetertype,remark); 
          if(flag=true){
        	  message="抄表成功";
            }
          }
          is.close();
          os.close();
          socket.close();
		}catch(Exception e){
			return message;
		}finally{
			return message;
		}
		
    }
	public static String bytesToHexFun1(byte[] bytes) {
        // 一个byte为8位，可用两个十六进制位标识
        char[] buf = new char[bytes.length * 2];
        int a = 0;
        int index = 0;
        for(byte b : bytes) { // 使用除与取余进行转换
            if(b < 0) {
                a = 256 + b;
            } else {
                a = b;
            }

            buf[index++] = HEX_CHAR[a / 16];
            buf[index++] = HEX_CHAR[a % 16];
        }

        return new String(buf);
    }
	  /**
     * 将16进制字符串转换为byte[]
     * 
     * @param str
     * @return
     */
    public static byte[] toBytes(String str) {
        if(str == null || str.trim().equals("")) {
            return new byte[0];
        }

        byte[] bytes = new byte[str.length() / 2];
        for(int i = 0; i < str.length() / 2; i++) {
            String subStr = str.substring(i * 2, i * 2 + 2);
            bytes[i] = (byte) Integer.parseInt(subStr, 16);
        }

        return bytes;
    }
    public static byte[] hexStringToBytes(String hexString) {   
        if (hexString == null || hexString.equals("")) {   
            return null;   
        }   
        hexString = hexString.toUpperCase();   
        int length = hexString.length() / 2;   
        char[] hexChars = hexString.toCharArray();   
        byte[] d = new byte[length];   
        for (int i = 0; i < length; i++) {   
            int pos = i * 2;   
            d[i] = (byte) (charToByte(hexChars[pos]) << 4 | charToByte(hexChars[pos + 1]));   
        }   
        return d;   
    }   
    public static byte charToByte(char c) {   
        return (byte) "0123456789ABCDEF".indexOf(c);   
    }  
    public static byte ToBCDC(int val) 
	{
			byte res = 0;
			int bit = 0;
			while (val >= 10) 
		{
				res |= (byte)(val % 10 << bit);
				val /= 10;
				bit += 4;
			}
			res |= (byte)(val << bit);
			return res;
		}

public static int FromBCDC(byte vals) 
	{
			int c = 1;
			int b = 0;
			int s=0;
			if(vals<0){
				s=(int)vals & 0xFF;
				String ss=String.valueOf(HEX_CHAR[s / 16])+String.valueOf(HEX_CHAR[s % 16]);
				b=Integer.parseInt(ss);
				return b;
			}
			while (vals > 0) 
			{
				b += (byte) ((vals & 0xf) * c);
				c *= 10;
				vals >>= 4;
			}
			return b;
		}
public boolean DealWithByteCycTY(byte[] bReply,int areaguid,float cdata,int iMeterType,String remark)
{
    try
    {
        if (bReply != null)
        {
            if (bReply.length > 0)
            {
                long lPoolAddress = 0, lMeterAddress = 0;
                //float iCData = 0;//设置校正因子-针对申舒斯大水表

               
                lPoolAddress += FromBCDC(bReply[7]);
                int iPool = (int)bReply[7];//通道号
                int iCount = (int)bReply[13];//个数
             
               // int iMeterType = 0;
                String sStatus = "";
                String sStatus1 = "";
                String sStatusM = "";

                int i18 = 0, i17 = 0, i16 = 0;
                int i25 = 0, i35 = 0, i45 = 0, kwh = 0, m3 = 0, kw = 0, lh = 0;
                int i30 = 0, i31 = 0, i32 = 0, i33 = 0;
                int i34 = 0, ik35 = 0, i36 = 0;
                

                float fMeterNLLJ = 0, iMeterNLLJZ = 0, fMeterNLLJGJ = 0;//累积能量
                float fMeterTJ = 0, iMeterTJZ = 0, iMeterTJX = 0; ;//体积
                float fMeterGL = 0, iMeterGLZ = 0, iMeterGLX = 0; ;//功率
                float fMeterLS = 0, iMeterLSZ = 0, iMeterLSX = 0;//流速
                String sMeterLSZ = "";
                float fMeterJSWD = 0, iMeterJSWDZ = 0;//进水温度
                float fMeterHSWD = 0, iMeterHSWDZ = 0;//回水温度
                float fMeterWC = 0, iMeterWCZ = 0;//温差
                String sMeterWCZ = "";
                boolean flag=false;
                int iCountHour = 0;//运行小时数
                int iMeterStatus = 0, iSysStatusT = 0;
                String sSysStatus = "0";//软件判断表状态和表自带状态
                int iFM = 0;
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
                String sTime =df.format(new Date()) ;//日期和时间
                int autoid=0;
                Calendar now = Calendar.getInstance();  
                int hour=now.get(Calendar.HOUR_OF_DAY);
                if(hour<14 && hour>2){
                	autoid=1;
                }else{
                	autoid=2;
                }
                	
                int iAddress = 0;//表的逻辑地址
                int iMeterFS = 0, iMeterFS1 = 0;
                String stemp = "", stemp1 = "", sH = "";
                //DataSet dsCom = m_cl.GetDBXML();
                String isf = "N";

                //开始循环
                for (int i = 0; i < iCount; i++)
                {
                    iFM = 1;//临时用METERFM代表抄表状态，开始抄表插入时默认0表示未抄表，此处改1表示成功抄表，999表示无反应
                    //重新赋值0，避免取到旧数据
                    iMeterStatus = 0;

                    int k = i * 43;
                    //2011-6-1
                    sH = Integer.toBinaryString((int)bReply[k + 14]);
                    while (sH.length() < 8)
                        sH = "0" + sH;
                    iAddress = Integer.parseInt(sH.substring(0, 4),2);//表的逻辑地址
                    byte b1 = (byte)Integer.parseInt(sH.substring(4, 8),2);

                    lMeterAddress = 0;
                    lMeterAddress += FromBCDC(bReply[k + 18]) * 1000000;//表序号
                    lMeterAddress += FromBCDC(bReply[k + 17]) * 10000;
                    lMeterAddress += FromBCDC(bReply[k + 16]) * 100;
                    lMeterAddress += FromBCDC(bReply[k + 15]);
                   
                    if (b1 == 0 || b1 == 3)
                    {

                        i25 = (int)(bReply[k + 22]);
                        i35 = (int)(bReply[k + 27]);
                        i45 = (int)(bReply[k + 32]);


                        //短路 0xDD 
                        if ((i25 == 221) && (i35 == 221) && (i45 == 221))
                        {
                            fMeterNLLJ = 0; fMeterNLLJGJ = 0; fMeterTJ = 0; fMeterLS = 0; fMeterGL = 0; fMeterJSWD = 0; fMeterHSWD = 0; fMeterWC = 0; iCountHour = 0; iMeterStatus = 1; sSysStatus = "999"; iFM = 999;
                            flag=EXQuery(areaguid,lPoolAddress,iPool,lMeterAddress,0,iMeterStatus,fMeterNLLJ,fMeterTJ,fMeterLS,fMeterGL,fMeterJSWD,fMeterHSWD,fMeterWC,iCountHour,sTime,sTime,autoid,remark,sSysStatus,fMeterNLLJGJ);
                            return flag;
                        }
                        //没有响应和回复出错 0xFF 
                        //if ((i45 == 255) && (i45 == 255) && (i45 == 255))
                        if ((i25 == 255) && (i35 == 255) && (i45 == 255))
                        {
                            fMeterNLLJ = 0; fMeterNLLJGJ = 0; fMeterTJ = 0; fMeterLS = 0; fMeterGL = 0; fMeterJSWD = 0; fMeterHSWD = 0; fMeterWC = 0; iCountHour = 0; iMeterStatus = 2; sSysStatus = "999"; iFM = 999;
                            flag=EXQuery(areaguid,lPoolAddress,iPool,lMeterAddress,0,iMeterStatus,fMeterNLLJ,fMeterTJ,fMeterLS,fMeterGL,fMeterJSWD,fMeterHSWD,fMeterWC,iCountHour,sTime,sTime,autoid,remark,sSysStatus,fMeterNLLJGJ);
                            return flag;
                        }

                        if ((i25 == 0) && (i35 == 0) && (i45 == 0))
                        {
                            fMeterNLLJ = 0; fMeterNLLJGJ = 0; fMeterTJ = 0; fMeterLS = 0; fMeterGL = 0; fMeterJSWD = 0; fMeterHSWD = 0; fMeterWC = 0; iCountHour = 0; iMeterStatus = 2; sSysStatus = "999"; iFM = 999;
                            flag=EXQuery(areaguid,lPoolAddress,iPool,lMeterAddress,0,iMeterStatus,fMeterNLLJ,fMeterTJ,fMeterLS,fMeterGL,fMeterJSWD,fMeterHSWD,fMeterWC,iCountHour,sTime,sTime,autoid,remark,sSysStatus,fMeterNLLJGJ);
                            return flag;
                        }
                        //累积能量,补抄，临时去掉  
                        i18 = (int)(bReply[k + 22]);
                        i17 = (int)(bReply[k + 21]);
                        i16 = (int)(bReply[k + 20]);
                        if ((i16 == 238) && (i17 == 238) && (i18 == 238))
                        {
                            fMeterNLLJ = 0; fMeterNLLJGJ = 0; fMeterTJ = 0; fMeterLS = 0; fMeterGL = 0; fMeterJSWD = 0; fMeterHSWD = 0; fMeterWC = 0; iCountHour = 0; iMeterStatus = 5; sSysStatus = "999"; iFM = 999;
                            flag=EXQuery(areaguid,lPoolAddress,iPool,lMeterAddress,0,iMeterStatus,fMeterNLLJ,fMeterTJ,fMeterLS,fMeterGL,fMeterJSWD,fMeterHSWD,fMeterWC,iCountHour,sTime,sTime,autoid,remark,sSysStatus,fMeterNLLJGJ);
                            return flag;
                        }

                        iMeterNLLJZ = FromBCDC(bReply[k + 22]) * 100000;//整数3.5个byte,0.5个byte 14-17 
                        iMeterNLLJZ += FromBCDC(bReply[k + 21]) * 1000;
                        iMeterNLLJZ += FromBCDC(bReply[k + 20]) * 10;
                        //半个byte,要分解 1111,1111                                    
                        int a = 0;
                        float h = 0, l = 0;
                        a = FromBCDC(bReply[k + 19]);

                        h = a / 10;
                        l = a % 10;
                        fMeterNLLJ = ((iMeterNLLJZ + h) * 10 + l) / 100;
                       // iCData = Float.parseFloat(GetDeviceCData(Long.toString(lMeterAddress), areaguid, "CData"));
                        fMeterNLLJ += cdata;
                        double f=fMeterNLLJ / 277.78;
                    	BigDecimal b = new BigDecimal(f);
                    	double f1 = b.setScale(4, BigDecimal.ROUND_HALF_UP).doubleValue();
                        if (ljrldw == "gj")
                        {
                        	
                            fMeterNLLJ = (float)f1;

                        }
                        switch (Byte.toString(bReply[k + 23]))
                        {
                            case "2":
                                fMeterNLLJ = 1000 * fMeterNLLJ;
                                break;
                            case "5":
                                fMeterNLLJ = fMeterNLLJ / 1;
                                break;
                            case "8":
                                fMeterNLLJ = fMeterNLLJ / 1000;
                                break;
                            case "10":
                                fMeterNLLJ = fMeterNLLJ / 100000;
                                break;
                            case "01":
                                fMeterNLLJ = fMeterNLLJ / 36000000;
                                break;
                            case "11":
                                fMeterNLLJ = fMeterNLLJ / 36000;
                                break;
                            case "14":
                                fMeterNLLJ = fMeterNLLJ / 36;
                                break;
                            case "17":
                                fMeterNLLJ = (float)f1;
                                break;
                            case "19":
                                fMeterNLLJ = (float)f1*100;
                                break;
                            default:
                                fMeterNLLJ = fMeterNLLJ / 1;
                                break;
                        }

                   

                        fMeterNLLJGJ = (float)f1;

                        //体积（累计流量
                        iMeterTJZ = FromBCDC(bReply[k + 37]) * 10000;//整数3个byte,小数1个byte 18-19 
                        iMeterTJZ += FromBCDC(bReply[k + 36]) * 100;
                        iMeterTJZ += FromBCDC(bReply[k + 35]);
                        iMeterTJX = FromBCDC(bReply[k + 34]) * 100;
                        fMeterTJ = ((iMeterTJZ * 10000) + iMeterTJX) / 10000;
                        switch (Byte.toString(bReply[k + 38]))
                        {
                            case "41"://29
                                fMeterTJ = fMeterTJ / 1000;
                                break;
                            case "44"://2C
                                fMeterTJ = fMeterTJ / 1;
                                break;
                            default:
                                break;
                        }

                        //功率
                        iMeterGLZ = FromBCDC(bReply[k + 27]) * 100;//整数2个byte,小数2个byte 25-28  
                        iMeterGLZ += FromBCDC(bReply[k + 26]);
                        iMeterGLX = FromBCDC(bReply[k + 25]) * 100;
                        iMeterGLX += FromBCDC(bReply[k + 24]);
                        fMeterGL = (iMeterGLZ * 10000 + iMeterGLX) / 10000;
                        stemp = Float.toString(fMeterGL);
                        stemp1 = "";
                        if (stemp.length() > 5)
                        {
                            stemp1 = stemp.substring(0, 6);
                        }
                        //爱拓利热能表Actaris读数为9999.0000、HYDROMETER热能表返回值是特定字节：DD221 BD189 EB237 DD221
                        if (stemp == "14452.24" || stemp1 == "9999.9")
                        {
                            fMeterGL = 0;
                            iMeterStatus = 4;//功率出错
                        }
                        i30 = (int)(bReply[k + 30]);
                        i31 = (int)(bReply[k + 31]);
                        i32 = (int)(bReply[k + 32]);
                        i33 = (int)(bReply[k + 33]);
                        if ((i30 == 221) && (i31 == 189) && (i32 == 237) && (i33 == 221))
                        {
                            fMeterGL = 0;
                            iMeterStatus = 4;//功率出错
                        }



                        switch (Byte.toString(bReply[k + 28]))
                        {
                            case "23":
                                fMeterTJ = fMeterTJ / 1;//17
                                break;
                            case "20":
                                fMeterTJ = fMeterTJ / 1000;//14
                                break;
                            case "26":
                                fMeterTJ = fMeterTJ * 1000;//1A
                                break;
                            default:
                                fMeterTJ = fMeterTJ / 1;
                                break;
                        }


                        //流速 
                        iMeterLSZ =FromBCDC(bReply[k + 32]) * 100;
                        iMeterLSZ += FromBCDC(bReply[k + 31]);//整数1个byte,小数2个byte 22-24 
                        iMeterLSX = FromBCDC(bReply[k + 30]) * 100;
                        iMeterLSX += FromBCDC(bReply[k + 29]);
                        //负数判断F

                        sMeterLSZ =  String.valueOf(iMeterLSZ).substring(0, String.valueOf(iMeterLSZ).indexOf("."));
                                                
                        while (sMeterLSZ.length() < 4)
                        {
                            sMeterLSZ += "0";
                        }
                        iMeterFS = Integer.parseInt(sMeterLSZ.substring(0, 2));
                        iMeterFS1 = Integer.parseInt(sMeterLSZ.substring(2, 4));

                        if (iMeterFS == 15)
                        {
                            fMeterLS = -((iMeterFS1 * 10000) + iMeterLSX) / 10000;
                        }
                        else
                        {
                            fMeterLS = ((iMeterLSZ * 10000) + iMeterLSX) / 10000;
                        }

                        //爱拓利热能表Actaris读数为99.9999、HYDROMETER热能表返回值是特定字节：DD221 BD189 EB237
                        stemp = Float.toString(fMeterLS);
                        if (stemp.length() > 3)
                        {
                            stemp1 = stemp.substring(0, 4);
                        }
                        if (stemp == "152.2443" || stemp1 == "99.9")
                        {
                            fMeterLS = 0;
                            iMeterStatus = 5;
                        }
                        i34 = (int)(bReply[k + 34]);
                        ik35 = (int)(bReply[k + 35]);
                        i36 = (int)(bReply[k + 36]);
                        if ((i34 == 221) && (ik35 == 189) && (i36 == 237))
                        {
                            fMeterLS = 0;
                            iMeterStatus = 5;//流速出错
                        }
                        if (fMeterLS < 0)
                        {
                            iMeterStatus = 5;//流速出错
                        }

                        switch (Byte.toString(bReply[33]))
                        {
                            case "50"://32
                                fMeterLS = fMeterLS / 1000;
                                break;
                            case "53"://35
                                fMeterLS = fMeterLS / 1;
                                break;
                            default:
                                fMeterLS = fMeterLS / 1;
                                break;

                        }

                        //进水温度
                        iMeterJSWDZ = FromBCDC(bReply[k + 40]) * 10;//整数1.5个byte,小数0.5个byte 29-30 
                        int a1 = 0;
                        float h1 = 0, l1 = 0;
                        a1 = FromBCDC(bReply[k + 39]);
                        h1 = a1 / 10;
                        l1 = a1 % 10;
                        fMeterJSWD = (((iMeterJSWDZ + h1) * 10) + l1) / 100;
                        //爱拓利热能表Actaris读数为999.9、Kamstrup 热能表200
                        stemp = Float.toString(fMeterJSWD);
                        if (stemp == "999.9" || stemp == "200")
                        {
                            fMeterJSWD = 0;
                            iMeterStatus = 6;//温度出错
                        }

                        //回水温度
                        iMeterHSWDZ = FromBCDC(bReply[k + 43]) * 10;//整数1.5个byte,小数0.5个byte 31-32 
                        int a2 = 0;
                        float h2 = 0, l2 = 0;
                        a2 = FromBCDC(bReply[k + 42]);
                        h2 = a2 / 10;
                        l2 = a2 % 10;
                        fMeterHSWD = (((iMeterHSWDZ + h2) * 10) + l2) / 100;
                        //爱拓利热能表Actaris读数为999.9、Kamstrup 热能表200
                        stemp = Float.toString(fMeterHSWD);
                        if (stemp == "999.9" || stemp == "200")
                        {
                            fMeterHSWD = 0;
                            iMeterStatus = 6;//温度出错
                        }


                        fMeterWC = fMeterJSWD - fMeterHSWD;


                        //流速是否显示负数
                        if (isf == "n" || isf == "N")
                        {
                            if (fMeterLS < 0)
                            {
                                fMeterLS = 0;
                            }
                        }
                        int aa=(int)FromBCDC(bReply[k + 46]);
                        //运行小时数
                        iCountHour = FromBCDC(bReply[k + 47]) * 10000;
                        iCountHour += FromBCDC(bReply[k + 46]) * 100;
                        iCountHour +=FromBCDC(bReply[k + 45]);


                        //39-40故障代码                            
                       // iMeterType = Integer.parseInt(GetDeviceCData(Long.toString(lMeterAddress), areaguid, "DeviceTypeChildNo"));
                        switch (iMeterType)
                        {
                            case 5://爱拓利                        
                            case 3://兰吉尔                        
                              /*  sStatus = Integer.toBinaryString(bReply[k + 46]);
                                while (sStatus.length() < 8)
                                {
                                    sStatus = "0" + sStatus;
                                }
                                sStatus1 = Integer.toBinaryString(bReply[k + 47]);
                                while (sStatus1.length() < 8)
                                {
                                    sStatus1 = "0" + sStatus1;
                                }
                                sStatusM = sStatus + sStatus1;
                                sSysStatus = sStatusM;*/
                            	iSysStatusT = (int)(bReply[k + 47]) * 100;
                                iSysStatusT += (int)(bReply[k + 46]);
                                sSysStatus = Integer.toString(iSysStatusT);
                                break;
                            case 6:
                                String syStatus = Integer.toHexString(bReply[k + 46]);
                                while (syStatus.length() < 2)
                                {
                                    syStatus = "0" + syStatus;
                                }
                                String syStatus1 = Integer.toHexString(bReply[k + 47]);
                                while (syStatus1.length() < 2)
                                {
                                    syStatus1 = "0" + syStatus1;
                                }

                                String sStatusM1 = syStatus + syStatus1;

                                sSysStatus = sStatusM1;
                                break;
                            case 80:
                                iSysStatusT = (int)(bReply[k + 56]) * 100;
                                iSysStatusT += (int)(bReply[k + 55]);
                                sSysStatus = Integer.toString(iSysStatusT);
                                break;
                            default://其它
                                iSysStatusT = (int)(bReply[k + 47]) * 100;
                                iSysStatusT += (int)(bReply[k + 46]);
                                sSysStatus = Integer.toString(iSysStatusT);
                                break;
                        }
                    }
                    else
                    {
                        //  k = k + 1;
                        i25 = (int)(bReply[k + 22]);
                        i35 = (int)(bReply[k + 27]);
                        i45 = (int)(bReply[k + 32]);


                        //短路 0xDD 
                        if ((i25 == 221) && (i35 == 221) && (i45 == 221))
                        {
                            fMeterNLLJ = 0; fMeterNLLJGJ = 0; fMeterTJ = 0; fMeterLS = 0; fMeterGL = 0; fMeterJSWD = 0; fMeterHSWD = 0; fMeterWC = 0; iCountHour = 0; iMeterStatus = 1; sSysStatus = "999"; iFM = 999;
                            flag=EXQuery(areaguid,lPoolAddress,iPool,lMeterAddress,0,iMeterStatus,fMeterNLLJ,fMeterTJ,fMeterLS,fMeterGL,fMeterJSWD,fMeterHSWD,fMeterWC,iCountHour,sTime,sTime,autoid,remark,sSysStatus,fMeterNLLJGJ);
                            return flag;
                        }
                        //没有响应和回复出错 0xFF 
                        //if ((i45 == 255) && (i45 == 255) && (i45 == 255))
                        if ((i25 == 255) && (i35 == 255) && (i45 == 255))
                        {
                            fMeterNLLJ = 0; fMeterNLLJGJ = 0; fMeterTJ = 0; fMeterLS = 0; fMeterGL = 0; fMeterJSWD = 0; fMeterHSWD = 0; fMeterWC = 0; iCountHour = 0; iMeterStatus = 2; sSysStatus = "999"; iFM = 999;
                            flag=EXQuery(areaguid,lPoolAddress,iPool,lMeterAddress,0,iMeterStatus,fMeterNLLJ,fMeterTJ,fMeterLS,fMeterGL,fMeterJSWD,fMeterHSWD,fMeterWC,iCountHour,sTime,sTime,autoid,remark,sSysStatus,fMeterNLLJGJ);
                            return flag;
                        }
                        if ((i25 == 0) && (i35 == 0) && (i45 == 0))
                        {
                            fMeterNLLJ = 0; fMeterNLLJGJ = 0; fMeterTJ = 0; fMeterLS = 0; fMeterGL = 0; fMeterJSWD = 0; fMeterHSWD = 0; fMeterWC = 0; iCountHour = 0; iMeterStatus = 2; sSysStatus = "999"; iFM = 999;
                            flag=EXQuery(areaguid,lPoolAddress,iPool,lMeterAddress,0,iMeterStatus,fMeterNLLJ,fMeterTJ,fMeterLS,fMeterGL,fMeterJSWD,fMeterHSWD,fMeterWC,iCountHour,sTime,sTime,autoid,remark,sSysStatus,fMeterNLLJGJ);
                            return flag;
                        }
                        //累积能量,补抄，临时去掉  
                        i18 = (int)(bReply[k + 22]);
                        i17 = (int)(bReply[k + 21]);
                        i16 = (int)(bReply[k + 20]);
                        if ((i16 == 238) && (i17 == 238) && (i18 == 238))
                        {
                            fMeterNLLJ = 0; fMeterNLLJGJ = 0; fMeterTJ = 0; fMeterLS = 0; fMeterGL = 0; fMeterJSWD = 0; fMeterHSWD = 0; fMeterWC = 0; iCountHour = 0; iMeterStatus = 5; sSysStatus = "999"; iFM = 999;
                            flag=EXQuery(areaguid,lPoolAddress,iPool,lMeterAddress,0,iMeterStatus,fMeterNLLJ,fMeterTJ,fMeterLS,fMeterGL,fMeterJSWD,fMeterHSWD,fMeterWC,iCountHour,sTime,sTime,autoid,remark,sSysStatus,fMeterNLLJGJ);
                            return flag;
                        }

                        iMeterNLLJZ = FromBCDC(bReply[k + 24]) * 100000;//整数3.5个byte,0.5个byte 14-17 
                        iMeterNLLJZ += FromBCDC(bReply[k + 23]) * 1000;
                        iMeterNLLJZ += FromBCDC(bReply[k + 22]) * 10;
                        //半个byte,要分解 1111,1111                                    
                        int a = 0;
                        float h = 0, l = 0;
                        a = FromBCDC(bReply[k + 21]);

                        h = a / 10;
                        l = a % 10;
                        fMeterNLLJ = ((iMeterNLLJZ + h) * 10 + l) / 1;
                       // iCData = Float.parseFloat(GetDeviceCData(Long.toString(lMeterAddress), areaguid, "CData"));
                        fMeterNLLJ += cdata;
                        double f=fMeterNLLJ / 277.78;
                    	BigDecimal b = new BigDecimal(f);
                    	double f1 = b.setScale(4, BigDecimal.ROUND_HALF_UP).doubleValue();
                        if (ljrldw == "gj")
                        {
                            fMeterNLLJ =(float)f1;

                        }
                     
                        fMeterNLLJGJ = (float)f1;

                        //体积（累计流量
                        iMeterTJZ = FromBCDC(bReply[k + 30]) * 10000;//整数3个byte,小数1个byte 18-19 
                        iMeterTJZ += FromBCDC(bReply[k + 29]) * 100;
                        iMeterTJZ += FromBCDC(bReply[k + 28]);
                        iMeterTJX = FromBCDC(bReply[k + 27]) * 100;
                        fMeterTJ = ((iMeterTJZ * 10000) + iMeterTJX) / 1000;

                        if (Byte.toString(bReply[k + 30]) == "")
                        {
                            fMeterTJ = fMeterTJ * 10;
                        }
                        //功率
                        //  iMeterGLZ = CPubilcFunction.FromBCDC(bReply[k + 27]) * 100;//整数2个byte,小数2个byte 25-28  
                        iMeterGLZ = FromBCDC(bReply[k + 35]);
                        iMeterGLX = FromBCDC(bReply[k + 34]) * 100;
                        iMeterGLX += FromBCDC(bReply[k + 33]);
                        fMeterGL = (iMeterGLZ * 10000 + iMeterGLX) / 10;
                        stemp = Float.toString(fMeterGL);
                        stemp1 = "";
                        if (stemp.length() > 5)
                        {
                            stemp1 = stemp.substring(0, 6);
                        }
                        //爱拓利热能表Actaris读数为9999.0000、HYDROMETER热能表返回值是特定字节：DD221 BD189 EB237 DD221
                        if (stemp == "14452.24" || stemp1 == "9999.9")
                        {
                            fMeterGL = 0;
                            iMeterStatus = 4;//功率出错
                        }
                        i30 = (int)(bReply[k + 30]);
                        i31 = (int)(bReply[k + 31]);
                        i32 = (int)(bReply[k + 32]);
                        i33 = (int)(bReply[k + 33]);
                        if ((i30 == 221) && (i31 == 189) && (i32 == 237) && (i33 == 221))
                        {
                            fMeterGL = 0;
                            iMeterStatus = 4;//功率出错
                        }

                        //流速 
                        iMeterLSZ = FromBCDC(bReply[k + 40]);//整数1个byte,小数2个byte 22-24 
                        iMeterLSX = FromBCDC(bReply[k + 39]) * 100;
                        iMeterLSX += FromBCDC(bReply[k + 38]);
                        //负数判断F
                        sMeterLSZ =  String.valueOf(iMeterLSZ).substring(0, String.valueOf(iMeterLSZ).indexOf("."));
                        //sMeterLSZ = Float.toString(iMeterLSZ);
                        while (sMeterLSZ.length() < 4)
                        {
                            sMeterLSZ += "0";
                        }
                        iMeterFS = Integer.parseInt(sMeterLSZ.substring(0, 2));
                        iMeterFS1 = Integer.parseInt(sMeterLSZ.substring(2, 4));

                        if (iMeterFS == 15)
                        {
                            fMeterLS = -((iMeterFS1 * 10000) + iMeterLSX) / 10000;
                        }
                        else
                        {
                            fMeterLS = ((iMeterLSZ * 10000) + iMeterLSX) / 10000;
                        }

                        //爱拓利热能表Actaris读数为99.9999、HYDROMETER热能表返回值是特定字节：DD221 BD189 EB237
                        stemp = Float.toString(fMeterLS);
                        if (stemp.length() > 3)
                        {
                            stemp1 = stemp.substring(0, 4);
                        }
                        if (stemp == "152.2443" || stemp1 == "99.9")
                        {
                            fMeterLS = 0;
                            iMeterStatus = 5;
                        }
                        i34 = (int)(bReply[k + 34]);
                        ik35 = (int)(bReply[k + 35]);
                        i36 = (int)(bReply[k + 36]);
                        if ((i34 == 221) && (ik35 == 189) && (i36 == 237))
                        {
                            fMeterLS = 0;
                            iMeterStatus = 5;//流速出错
                        }
                        if (fMeterLS < 0)
                        {
                            iMeterStatus = 5;//流速出错
                        }

                        //进水温度
                        iMeterJSWDZ = FromBCDC(bReply[k + 44]) * 10;//整数1.5个byte,小数0.5个byte 29-30 
                        int a1 = 0;
                        float h1 = 0, l1 = 0;
                        a1 = FromBCDC(bReply[k + 43]);
                        h1 = a1 / 10;
                        l1 = a1 % 10;
                        fMeterJSWD = (((iMeterJSWDZ + h1) * 10) + l1);
                        //爱拓利热能表Actaris读数为999.9、Kamstrup 热能表200
                        stemp = Float.toString(fMeterJSWD);
                        
                        String str=Integer.toString(bReply[k + 42]);
                        if (stemp == "999.9" || stemp == "200")
                        {
                            fMeterJSWD = 0;
                            iMeterStatus = 6;//温度出错
                        }
                        if ("91".equals(Integer.toString(bReply[k + 42])))
                        {
                            fMeterJSWD = fMeterJSWD / 1;
                        }
                        else
                        {
                            fMeterJSWD = fMeterJSWD / 10;
                        }
                        //回水温度
                        iMeterHSWDZ = FromBCDC(bReply[k + 48]) * 10;//整数1.5个byte,小数0.5个byte 31-32 
                        int a2 = 0;
                        float h2 = 0, l2 = 0;
                        a2 = FromBCDC(bReply[k + 47]);
                        h2 = a2 / 10;
                        l2 = a2 % 10;
                        fMeterHSWD = (((iMeterHSWDZ + h2) * 10) + l2);
                        //爱拓利热能表Actaris读数为999.9、Kamstrup 热能表200
                        stemp = Float.toString(fMeterHSWD);
                        if (stemp == "999.9" || stemp == "200")
                        {
                            fMeterHSWD = 0;
                            iMeterStatus = 6;//温度出错
                        }

                        if ("95".equals(Integer.toString(bReply[k + 46])))
                        {
                            fMeterHSWD = fMeterHSWD / 1;
                        }
                        else
                        {
                            fMeterHSWD = fMeterHSWD / 10;
                        }
                        //温差
                        iMeterWCZ = FromBCDC(bReply[k + 52]) * 10;//整数1.5个byte,小数0.5个byte 33-34 
                        int a3 = 0;
                        float h3 = 0, l3 = 0;
                        a3 = FromBCDC(bReply[k + 51]);
                        h3 = a3 / 10;
                        l3 = a3 % 10;
                     
                        sMeterWCZ = String.valueOf(iMeterWCZ).substring(0, String.valueOf(iMeterWCZ).indexOf("."));
                        while (sMeterWCZ.length() < 4)
                        {
                            sMeterWCZ += "0";
                        }
                        iMeterFS = Integer.parseInt(sMeterWCZ.substring(0, 2));
                        iMeterFS1 = Integer.parseInt(sMeterWCZ.substring(2, 4));

                        //2010-12-8
                        fMeterWC = (((iMeterWCZ + h3) * 10) + l3) / 10;
                        stemp = Float.toString(fMeterWC);
                        if (stemp == "999.9")
                        {
                            fMeterWC = 0;
                            iMeterStatus = 7;//温差出错
                        }
                        else
                        {
                            if ((fMeterJSWD - fMeterHSWD) < 0 || (iMeterFS == 15))
                            {
                                fMeterWC = -(((iMeterFS1 + h3) * 10) + l3) / 10;
                            }
                            else
                            {
                                fMeterWC = (((iMeterWCZ + h3) * 10) + l3) / 10;
                            }

                        }

                        //9位数表流速大100倍 2011-12-2//20161213取消
                        //if (lMeterAddress.ToString().Length == 9)
                        //{
                        //    fMeterLS = fMeterLS / 100;
                        //}


                        //流速是否显示负数
                        if (isf == "n" || isf == "N")
                        {
                            if (fMeterLS < 0)
                            {
                                fMeterLS = 0;
                            }
                        }


                        //运行小时数
                        //iCountHour = CPubilcFunction.FromBCDC(bReply[k + 47]) * 10000;
                        //iCountHour += CPubilcFunction.FromBCDC(bReply[k + 46]) * 100;
                        //iCountHour += CPubilcFunction.FromBCDC(bReply[k + 45]);

                        iCountHour = 0;
                        //39-40故障代码                            
                        //iMeterType = Integer.parseInt(GetDeviceCData(Long.toString(lMeterAddress), areaguid, "DeviceTypeChildNo"));
                        switch (iMeterType)
                        {
                            case 5://爱拓利                        
                            case 3://兰吉尔                        
                               /* sStatus = Integer.toBinaryString(bReply[k + 46]);
                                while (sStatus.length() < 8)
                                {
                                    sStatus = "0" + sStatus;
                                }
                                sStatus1 = Integer.toBinaryString(bReply[k + 47]);
                                while (sStatus1.length() < 8)
                                {
                                    sStatus1 = "0" + sStatus1;
                                }
                                sStatusM = sStatus + sStatus1;
                                sSysStatus = sStatusM;*/
                            	iSysStatusT = (int)(bReply[k + 47]) * 100;
                                iSysStatusT += (int)(bReply[k + 46]);
                                sSysStatus = Integer.toString(iSysStatusT);
                                break;
                            case 6:
                                String syStatus = Integer.toHexString(bReply[k + 46]);
                                while (syStatus.length() < 2)
                                {
                                    syStatus = "0" + syStatus;
                                }
                                String syStatus1 = Integer.toHexString(bReply[k + 47]);
                                while (syStatus1.length() < 2)
                                {
                                    syStatus1 = "0" + syStatus1;
                                }

                                String sStatusM1 = syStatus + syStatus1;

                                sSysStatus = sStatusM1;
                                break;
                            default://其它
                                iSysStatusT = (int)(bReply[k + 47]) * 100;
                                iSysStatusT += (int)(bReply[k + 46]);
                                sSysStatus = Integer.toString(iSysStatusT);
                                break;
                        }
                    }
                  flag=EXQuery(areaguid,lPoolAddress,iPool,lMeterAddress,0,iMeterStatus,fMeterNLLJ,fMeterTJ,fMeterLS,fMeterGL,fMeterJSWD,fMeterHSWD,fMeterWC,iCountHour,sTime,sTime,autoid,remark,sSysStatus,fMeterNLLJGJ);
                  return flag;
              
                }
            }
        }
    }
    catch (Exception ex)
    {
        //继续循环
        return false;
    }
    return true;
}
	public boolean EXQuery(int areaguid,long pooladdr,int mbusid,long meterid,int devicetype,int mstatus,float meternllj,float metertj,float meterls,float metergl,float meterjswd,float meterhswd,float meterwc,int icounthour,String stime,String ddate,int autoid,String remark,String sysstatus,float meternlljgj){
		String sqlwhere="select  to_char(count(*)) as coun from  tmeter where AreaGuid =  "+areaguid+" and PoolAddr="+pooladdr+" and MbusID = "+mbusid+" and MeterID="+meterid+" and AutoID="+autoid
		                +" AND  to_char(DDate,'yyyy-MM-dd') ='"+ddate.substring(0,10)+"'";
		List list=baseDao.findBySql(sqlwhere,null);
			if("0".equals(list.get(0).toString())){
				sqlwhere="insert into TMeter (MeterNLLJGJ,AreaGuid, PoolAddr,MbusID,MeterID,DeviceType,DeviceStatus,MeterNLLJ,MeterTJ,MeterLS,MeterGL,MeterJSWD,MeterHSWD,MeterWC,MeterSJ,DDate,AutoID,CountHour,remark,MeterFM,SysStatus)"
			              +" values ("+meternlljgj+","+areaguid+","+pooladdr+","+mbusid+","+meterid+",0,"+mstatus+","+meternllj+","+metertj+","+meterls+","+metergl+","+meterjswd+","+meterhswd+","+meterwc+",'"+stime+"',to_date('"+ddate+"','yyyy-MM-dd HH24:mi:ss'),"+autoid+","+icounthour+",'"+remark+"',0,'"+sysstatus+"')";
			
			}else{
				sqlwhere="update TMeter set MeterNLLJGJ="+meternlljgj+",DeviceStatus="+mstatus+",MeterNLLJ="+meternllj+",MeterTJ="+metertj+",MeterLS="+meterls+",MeterGL="+metergl+",MeterJSWD="+meterjswd+",MeterHSWD="+meterhswd+",MeterWC="+meterwc+",MeterSJ='"+stime+"',DDate=to_date('"+ddate+"','yyyy-MM-dd HH24:mi:ss'),AutoID="+autoid+",CountHour="+icounthour+",MeterFM = 0,SysStatus='"+sysstatus+"'"
			              +"  where AreaGuid =  "+areaguid+" and PoolAddr="+pooladdr+" and MbusID = "+mbusid+" and MeterID="+meterid+" and AutoID="+autoid+" and to_char(ddate,'yyyy-MM-dd')='"+ddate.substring(0,10)+"'";
			}
		boolean flag=baseDao.execuSql(sqlwhere,null);
		return flag;
	}
}




