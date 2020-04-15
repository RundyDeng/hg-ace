package com.jeefw.controller.priceManage;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.jeefw.controller.IbaseController;
import com.jeefw.dao.IBaseDao;
import com.jeefw.service.pub.PubService;
@Controller
@RequestMapping("/priceMange/billprint")
public class BillPrintController extends IbaseController{
	@Resource
	private IBaseDao baseDao;
	@Resource
	private PubService todayDataService;
	@Resource
	private PubService pubSvr;
	@RequestMapping(value="/getBuild" ,method = { RequestMethod.POST, RequestMethod.GET })
	public void getBuild(HttpServletRequest request,HttpServletResponse response) throws IOException{
		Map<String, String[]> mapss = request.getParameterMap();
		List list=pubSvr.getBuild(mapss);
		writeJSON(response, list);
	}
	@RequestMapping(value="/getUnit" ,method = { RequestMethod.POST, RequestMethod.GET })
	public void getUnit(HttpServletRequest request,HttpServletResponse response) throws IOException{
		Map<String, String[]> mapss = request.getParameterMap();
		List list=pubSvr.getUnitNO(mapss);
		writeJSON(response, list);
	}
	@RequestMapping(value="/getFloor" ,method = { RequestMethod.POST, RequestMethod.GET })
	public void getFloor(HttpServletRequest request,HttpServletResponse response) throws IOException{
		Map<String, String[]> mapss = request.getParameterMap();
		List list=pubSvr.getFloorNo(mapss);
		writeJSON(response, list);
	}
	@RequestMapping(value="/getDoorName" ,method = { RequestMethod.POST, RequestMethod.GET })
	public void getDoorName(HttpServletRequest request,HttpServletResponse response) throws IOException{
		Map<String, String[]> mapss = request.getParameterMap();
		List list=pubSvr.getDoorNo(mapss);
		writeJSON(response, list);
	}
	@RequestMapping(value="/getBillData",method = { RequestMethod.POST, RequestMethod.GET }) 
	public ModelAndView getBillData(HttpServletRequest request,HttpServletResponse response)throws IOException{
		ModelAndView mv = new ModelAndView("back/priceManage/printView");
		return mv;
	}
	
	/**
	 * 获取退费单的table,返回前台显示
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws ParseException 
	 */
	@RequestMapping("/getTable") 
	public void  getTable(HttpServletRequest request,HttpServletResponse response)throws IOException, ParseException{
		String html="";
		String areaguid=request.getParameter("areaguid").toString();
		String buildno=request.getParameter("buildno").toString();
		String unitno=request.getParameter("unitno").toString();
		String floorno=request.getParameter("floorno").toString();
		String doorno=request.getParameter("doorno").toString();
		String years=request.getParameter("years").toString();
		String areaname = todayDataService.getAreanameById(areaguid);
		request.getSession().setAttribute(AREA_GUIDS, areaguid);
		request.getSession().setAttribute(AREA_NAME, areaname);
		String sql = " areaguid=" + areaguid;
		 if (!"9999".equals(buildno))
         {
             sql += " and  buildno =" + buildno;
         }
         if (!"9999".equals(unitno))
         {
             sql += " and  unitno =" + unitno;
         }
         if (!"9999".equals(floorno))
         {
             sql += " and  floorno =" + floorno;
         }
         if (!"9999".equals(doorno))
         {
             sql += " and doorno =" + doorno;
         }
         List<Map> areainfolist=baseDao.listSqlAndChangeToMap("select * from vareainfo where "+sql, null);
         if(areainfolist.size()>0){
        	 String shtmlc = "";
             for (int j = 0; j < areainfolist.size(); j++)
             {
                 //-------打印收费单数据------
                 String sClientUser = String.valueOf(areainfolist.get(j).get("CLIENTNO"));
                 //日期读数信息
                 //查找所具有的表 
                 String sbdata = "";
                 String sbdate = "";
                 String sedata = "";
                 String sedate = "";
                 String smeterno = "";
                 Calendar c = Calendar.getInstance();
                 int iyear = c.get(Calendar.YEAR);
                 String syears = years;
                 Calendar time1 = Calendar.getInstance();
                 time1.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(areainfolist.get(0).get("BDATE").toString()));
                 Calendar time2 = Calendar.getInstance();
                 time2.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(areainfolist.get(0).get("ADATE").toString()));
                 List<Map> tmd = baseDao.listSqlAndChangeToMap("select * from tdoor_meter where areaguid="+areaguid+" and clientno='"+sClientUser+"'", null);
                 if (tmd.size() > 0){
                	 for (int i = 0; i < tmd.size(); i++){
                    smeterno += tmd.get(i).get("METERNO") + ","; 
                    String sqlw="select a.MeterID,minLjrl,maxLjrl,maxLjrl-minLjrl as hrl from (" +
                            " select min(MeterNLLJ) minLjrl ,MeterID from tmeter where AreaGuid=" + areaguid + " and MeterID='" + tmd.get(i).get("METERNO") + "' and " +
                            " to_char(ddate,'yyyy')=" + time1.get(Calendar.YEAR) + " and to_char(ddate,'mm')=" + (time1.get(Calendar.MONTH)+1) + " and MeterNLLJ>0 " +
                            " group by MeterID)a left join " +
                            "(select max(MeterNLLJ) maxLjrl,MeterID from tmeter where AreaGuid=" + areaguid + " and MeterID='" + tmd.get(i).get("METERNO") + "' and" +
                            " to_char(ddate,'yyyy')=" + time2.get(Calendar.YEAR) + " and to_char(ddate,'mm')=" + (time2.get(Calendar.MONTH)+1) + "  and MeterNLLJ>0 "+
                            " group by MeterID) b on a.MeterID=b.MeterID";

                    List<Map> tsf = baseDao.listSqlAndChangeToMap(sqlw, null);
                    if (tsf != null && tsf.size() > 0) {
                        sbdata += tsf.get(0).get("MINLJRL") + ",";
                        sedata += tsf.get(0).get("MAXLJRL") + ",";
                        sbdate=areainfolist.get(0).get("BDATE").toString().substring(0, 10);
                        sedate =areainfolist.get(0).get("ADATE").toString().substring(0, 10);
                    } else{
                        sbdata = "0,";
                        sedata = "0,";
                        String[] year = years.split("-");
                        sbdate = "" + year[0] + "-10-15";
                        sedate = "" + year[1] + "-04-15";
                    }
                
                 }
                	 smeterno = smeterno.substring(0, smeterno.length()-1);
                     sbdata = sbdata.substring(0, sbdata.length()-1);
                     sedata = sedata.substring(0, sedata.length()-1);
                     if (sbdata == "" || sbdata == null)
                     {
                         sbdata = "0";
                     }
                     if (sedata == "" || sedata == null)
                     {
                         sedata = "0";
                     }
                }
                 List<Map> tad=baseDao.listSqlAndChangeToMap("select * from vclientinfo where areaguid="+areaguid+" and clientno='"+sClientUser+"'", null);
                 String sCLIENTNO = String.valueOf(tad.get(0).get("CLIENTNO"));
                 String sCLIENTNAME =String.valueOf( tad.get(0).get("CLIENTNAME"));
                 if(sCLIENTNAME=="null"){
                	 sCLIENTNAME="";
                 }
                 String sPHONE=String.valueOf(tad.get(0).get("PHONE"));
                 if(sPHONE=="null"){
                	 sPHONE="";
                 }
                 String sMOBPHONE=String.valueOf(tad.get(0).get("MOBPHONE"));
                 if(sMOBPHONE=="null"){
                	 sMOBPHONE="";
                 }
                 String sHOTAREA = String.valueOf(tad.get(0).get("HOTAREA"));
                 if(sHOTAREA=="null"){
                	 sHOTAREA="";
                 }
                 String lxname = String.valueOf(tad.get(0).get("CLIENTCAT"));
                 if(lxname=="null"){
                	 lxname="";
                 }
                 String szhlx = String.valueOf(tad.get(0).get("CLIENTCATID"));
                 if(szhlx=="null"){
                	 szhlx="";
                 }
                 String szhlxname = lxname;
                 String sUAREA = String.valueOf(tad.get(0).get("UAREA"));
                 if(sUAREA=="null"){
                	 sUAREA="";
                 }
                 String sUnit = "元 / KW.H";
                 String hRl = "";
                 hRl = "KWH";
                 if ("".equals(sUAREA))
                 {
                     sUAREA = "0.00";
                 }
                 double jlPrice = 0.00;
                 //除类型为住户外其它按建筑面积算
                 switch (szhlx)
                 {
                     case "1":
                         jlPrice = Double.parseDouble(sHOTAREA); //用户使用面积
                         break;
                     case "2":
                         jlPrice = Double.parseDouble(sUAREA);
                         break;
                     case "3":
                         jlPrice = Double.parseDouble(sUAREA);
                         break;
                     default:
                         jlPrice = Double.parseDouble(sHOTAREA);
                         break;
                 }
                 String sISYESTR = String.valueOf( tad.get(0).get("SFTR"));
                 if(sISYESTR=="null"){
                	 sISYESTR="";
                 }
                 String sISYESTRname = "";
                 String buildname = String.valueOf(areainfolist.get(j).get("BUILDNAME"));
                 if(buildname=="null"){
                	 buildname="";
                 }
                 String nuint = String.valueOf(areainfolist.get(j).get("UNITNO"));
                 if(nuint=="null"){
                	 nuint="";
                 }
                 String doorname = String.valueOf(areainfolist.get(j).get("DOORNAME"));
                 if(doorname=="null"){
                	 doorname="";
                 }
                 String sADDRESS = buildname + "-" + nuint + "-" + doorname;
                 List<Map> farea=baseDao.listSqlAndChangeToMap("select e.factoryid,factoryname,sectionid,sectionname,areaguid,areaname,areacode,f.years,f.bdate,f.adate from energyfactory e,factorysectioninfo f ,tarea t where e.factoryid=f.factoryid and t.factoryno=f.SECTIONID and t.areaguid="+ areaguid,null);
                 String factoryname = String.valueOf(farea.get(0).get("FACTORYNAME"));
                 if(factoryname=="null"){
                	 factoryname="";
                 }
                 String SECTIONNAMEs = String.valueOf(farea.get(0).get("SECTIONNAME"));
                 if(SECTIONNAMEs=="null"){
                	 SECTIONNAMEs="";
                 }
                 String AREANAMEs = String.valueOf(farea.get(0).get("AREANAME"));
                 if(AREANAMEs=="null"){
                	 AREANAMEs="";
                 }
                 String sgrts = String.valueOf(tad.get(0).get("GRTS"));
                 if(sgrts=="null"){
                	 sgrts="";
                 }
                 double dsjfse = 0;
                 try{
                     dsjfse = Double.parseDouble(String.valueOf(tad.get(0).get("SJFSE")));
                 }catch (Exception e){

                     dsjfse = 0;
                 }
                 String sSJFSE = Double.toString(dsjfse);
                 String sPRICE = "0.00";
                 if (String.valueOf(tad.get(0).get("PRICE"))==""||String.valueOf(tad.get(0).get("PRICE"))=="null")
                 {
                     sPRICE = "0.00";
                 }
                 else{
                 sPRICE = String.valueOf(tad.get(0).get("PRICE"));//计量单价
                 }
               //多表读数，合计热量
                 String[] sed = sedata.split(",");
                 String[] sbd = sbdata.split(",");

                 double ijlrl = 0;
                 double sdata = 0.00, edata = 0.00;
                 for (int si = 0; si < sed.length; si++)
                 {
                     double a = 0, b = 0;
                     try
                     {
                         a = (Double.parseDouble(sed[si]));
                     }
                     catch (Exception e)
                     {

                         a = 0;
                     }
                     try
                     {
                         b = Double.parseDouble(sbd[si]);
                     }
                     catch (Exception e)
                     {

                         b = 0;
                     }
                         edata += new BigDecimal(a).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue(); 
                         sdata += new BigDecimal(b).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue();

                         ijlrl += new BigDecimal(a-b).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue();
                    
                 }
               //计量热量*计量单价=计量热费
                 String sJLJE =Double.toString(new BigDecimal(ijlrl*(new BigDecimal(sPRICE).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue())).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
                 double d1 = 0;
                 try
                 {
                     d1=Double.parseDouble(String.valueOf(tad.get(0).get("CGPRICE"))); //基本热价
                 }
                 catch (Exception e)
                 {

                     d1 = 0;
                 }
                 String sYJRF =Double.toString(new BigDecimal(d1*jlPrice).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue()) ;
                 double d2 = 0;
                 try
                 {
                     d2 = Double.parseDouble(sYJRF);
                 }
                 catch (Exception e)
                 {

                     d2 = 0;
                 }
                 //停热， 停热的用户=（0-（(用量 *计量热价+面积 * 基本热价)））
                 //未停热退费=((面积 *面积单价)/供热天数* 用热天数)-(用量 *计量热价+面积 * 基本热价)
                    double dfl = 0.00; double dmjsf = 0; String tfe = "";
                    if ("否".equals(sISYESTR))
                    {
                        sISYESTRname = "否";
                       
                            try
                            {
                                dmjsf = Double.parseDouble(String.valueOf(tad.get(0).get("MJDJ")));
                            }
                            catch (Exception e)
                            {

                                dmjsf = 19;
                            }
                            dfl = dmjsf;
                         
                        //求供热天数  sedate sbdate
                        double qgrts=Double.parseDouble(String.valueOf(tad.get(0).get("GRTS")));
                        //使用天数
                        double day=daysBetween(sbdate,sedate);
                        //未停热 //未停热退费=((面积 *面积单价)/供热天数* 用热天数)-(用量 *计量热价+面积 * 基本热价)
                        double qtfe = ((jlPrice * dmjsf) / qgrts * day) - (Double.parseDouble(sJLJE) + Double.parseDouble(sYJRF));
                        tfe =Double.toString(new BigDecimal(qtfe).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
                    }
                    else
                    {
                        sISYESTRname = "是";
                        dfl = dmjsf;
                        //dfl = 0.3;
                        double qtfey = (0.0 - (Double.parseDouble(sJLJE) + Double.parseDouble(sYJRF)));
                        tfe = Double.toString(new BigDecimal(qtfey).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());

                    }
                    //按面积收费金额=面积*面积收费
                    String sJCJFE =  Double.toString(new BigDecimal(d2 * dfl).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
                    String sYJFSE = sJLJE;
                    double dcg = 0;
                    try
                    {
                        dcg = Double.parseDouble(String.valueOf(tad.get(0).get("CGPRICE")));
                    }
                    catch (Exception e)
                    {

                        dcg = 0;
                    }
                    double pr = 0;
                    try
                    {
                        pr = Double.parseDouble(String.valueOf(tad.get(0).get("PRICE")));
                    }
                    catch (Exception e)
                    {

                        pr = 0;
                    }
                    String sr = "公司留存";
               //     shtmlc += "<P>";
                    shtmlc += "<div  align='center'>";
                    for (int k = 0; k < 2; k++)
                    {
                    	String remark="";
                    	if(String.valueOf(tad.get(0).get("remark"))!="null"){
                    		remark=String.valueOf(tad.get(0).get("remark"));
                    	}
                        shtmlc += "<table style='border:0px'><tr><td  align='center' style='border:0px;height:40px;font-size:20px;font-weight:bold;'>市热计量收费（试行）通知单</td></tr></table>";
                        shtmlc += "<table style='border:0px'><tr><td  align='center' style='border:0px;height:40px;font-size:14px;font-weight:bold;'>（" + syears + "年度）&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + new SimpleDateFormat("yyyy/MM/dd").format(new Date()) + "</td></tr></table>";
                        shtmlc += "<table align='center' cellspacing='0' cellpadding='0'>";
                        shtmlc += "<tr><td class=\"titles\">用户编码：</td><td colspan=\"2\" class=\"con\">" + sClientUser + "</td><td class=\"titles\">姓名：</td><td colspan=\"2\" class=\"con\">";
                        if (k == 0)
                        {
                            sr = "公司留存";
                        }
                        else
                        {
                            sr = "热用户留存";  //dCHJY.ToString("#,##0.00")
                        }
                        shtmlc += sCLIENTNAME + "</td><td class=\"titles\">住户类型：</td><td colspan=\"2\" class=\"con\">" + szhlxname + "</td><td rowspan=\"12\" style=\"width: 20px;border:0px\">" + sr + "</td></tr>";
                        shtmlc += "<tr><td class=\"titles\">固定电话：</td><td colspan=\"2\">" + sPHONE + "<td class=\"titles\">手机：</td><td colspan=\"2\">" + sMOBPHONE + "</td><td class=\"titles\">地址：</td><td colspan=\"2\">" + sADDRESS + "</td></tr>";
                        shtmlc += "<tr><td class=\"titles\">建筑面积：</td><td class=\"con1\">" + sUAREA + "</td><td class=\"unit\">M<sup>2</sup></td><td class=\"titles\">使用面积：</td><td class=\"con1\">" + sHOTAREA + "</td><td class=\"unit\">M<sup>2</sup></td><td class=\"titles\">是否停热：</td><td colspan=\"2\">" + sISYESTRname + "</td></tr>";
                        shtmlc += "<tr><td class=\"titles\">供热分公司：</td><td colspan=\"2\">" + factoryname + "</td><td class=\"titles\">热力站：</td><td colspan=\"2\">" + SECTIONNAMEs + "</td><td class=\"titles\">小区：</td><td colspan=\"2\">" + AREANAMEs + "</td></tr>";
                        shtmlc += "<tr><td class=\"titles\">表号：</td><td colspan=\"8\">" + smeterno + "</td></tr>";

                        shtmlc += "<TR><TD class=titles>始日期：</TD><TD colSpan=2>" + sbdate + "</TD><TD class=titles>始读数：</TD><TD colSpan=2>" + sdata + "</TD> <TD class=titles rowspan=\"2\">耗热量:</TD><TD rowspan=\"2\">" + Double.toString(ijlrl) + "</TD><TD class=unit1 rowspan=\"2\">"+hRl+"</TD></TR>";

                        shtmlc += "<TR><TD class=titles>止日期：</TD><TD colSpan=2>" + sedate + "</TD><TD class=titles>止读数：</TD><TD colSpan=2>" + edata + "</TD></TR>";
                        shtmlc += "<TR><TD class=titles>热费单价：</TD><TD class=con1>" + Double.toString(dcg) + "</TD><TD class=unit>元/月*M<sup>2</sup></TD><TD class=titles>计量单价：</TD><TD class=con1>" + Double.toString(pr) + "</TD><TD class=unit>" + sUnit + "</TD><TD class=titles>面积单价：</TD><TD class=con1>" + Double.toString(dfl) + "</TD><TD class=unit>M<sup>2</sup></TD></TR>";
                        shtmlc += "<TR><TD class=titles>基本热费：</TD><TD class=con1>" + sYJRF + "</TD><TD>元</TD><TD class=titles>计量热费：</TD><TD class=con1>" + sYJFSE + "</TD><TD class=unit>元</TD><TD class=titles rowspan=\"2\">退费额：&nbsp;</TD><TD class=con3 rowspan=\"2\">" + tfe + "</TD><TD class=unit1 rowspan=\"2\">元</TD></TR>";
                        shtmlc += "<TR><TD class=titles>热费合计：</TD><TD class=con1>" + Double.toString(Double.parseDouble(sJLJE) + Double.parseDouble(sYJRF)) + "</TD><TD>元</TD><TD class=titles>按面积收费金额：</TD><TD class=con1>" + Double.toString(jlPrice * dmjsf) + "</TD><TD class=unit>元</TD></TR>";
                        shtmlc += "<tr><td class=\"titles\">备注说明：</td><td colspan=\"8\">1、账户余额结转至下一个采暖期。" +remark + "</td></tr></table>";

                        if (k == 0)
                        {
                            
                            shtmlc += "<div style=\"width:710px\" ><hr style=\"BORDER-BOTTOM: #000 0px dashed; BORDER-LEFT: #000 0px dashed; HEIGHT: 2px; BORDER-TOP: #000 2px dashed; BORDER-RIGHT: #000 2px dashed\"></div>";
                           
                        }
                    }
                    shtmlc += "</div>";
                  //  shtmlc += "</P>";
             }  
             html=shtmlc;
         }
         writeJSON(response, html);
	}
	/** 
	*字符串的日期格式的计算 
	*/  
	    public static double daysBetween(String smdate,String bdate) throws ParseException{  
	        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
	        Calendar cal = Calendar.getInstance();    
	        cal.setTime(sdf.parse(smdate));    
	        long time1 = cal.getTimeInMillis();                 
	        cal.setTime(sdf.parse(bdate));    
	        long time2 = cal.getTimeInMillis();         
	        long between_days=(time2-time1)/(1000*3600*24);  
	        
	       return new BigDecimal(Double.parseDouble(String.valueOf(between_days))).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue();           
	    }  
	  
}