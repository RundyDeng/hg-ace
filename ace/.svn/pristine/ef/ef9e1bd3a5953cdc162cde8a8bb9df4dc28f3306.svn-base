package game;

import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.Properties;
import java.util.Set;


class ClassDemo17 
{
	
	/*private static Properties prop = new Properties();
	static{
		try {
			prop.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("messages_zh_CN.properties"));
			
			//转码处理
			Set<Object> keyset = prop.keySet();
			Iterator<Object> iter = keyset.iterator();
			while (iter.hasNext()) {
				String key = (String) iter.next();
				String newValue = null;
				try {
					
					String propertiesFileEncode = "ISO-8859-1";
					newValue = new String(prop.getProperty(key).getBytes("gbk"),propertiesFileEncode);
					System.out.println(newValue);
				} catch (UnsupportedEncodingException e) {
					newValue = prop.getProperty(key);
				}
				prop.setProperty(key, newValue);
			}
		} catch (Exception e) {
		}
	}*/
	public static void main(String[] args) 
	{
		
		String teste = "我  051 懂";
		teste = teste.replaceAll("[^x00-xff]*", "");
		System.out.println(teste);
		
		
		String str = "\u64CD\u4F5C\u5931\u8D25\uFF01";  //似乎无法解决？

		try {
			String newstr = new String(str.getBytes("ISO8859-1"),"gbk");
			System.out.println(newstr);
		} catch (UnsupportedEncodingException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
	}
}
