package core.util;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

public class PrintStringPrototype {
	//字符串原样输出
	public static void print(String str1) {
		int specialsymbols = 9;
		byte[] bytes = str1.getBytes();
		List<Integer> indexs = new ArrayList<Integer>();
		List<Byte> list = new LinkedList<Byte>();
		for (int i = 0; i < bytes.length; i++) {
			if (bytes[i] == specialsymbols) {
				indexs.add(i);
			}
			list.add(bytes[i]);
		}

		int indexpos = 0;
		int increate = 0;
		for (Integer index : indexs) {
			indexpos = index + increate;
			list.add(indexpos, (byte) 92);
			list.add(indexpos + 1, (byte) 116);
			increate += 2;
		}

		byte[] newbyte = new byte[list.size()];
		int i = 0;
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Byte byte1 = (Byte) iterator.next();
			if (byte1 == specialsymbols) {
				iterator.remove();
			} else {
				newbyte[i] = byte1;
				i++;
			}
		}
		try {
			System.out.println(new String(newbyte, "utf-8"));
		} catch (UnsupportedEncodingException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}
}
