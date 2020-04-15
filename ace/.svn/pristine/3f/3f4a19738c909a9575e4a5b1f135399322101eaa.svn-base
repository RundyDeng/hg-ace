package game;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;

public class SS {
	public static void main(String[] args) {
		write();
		read();
	}

	public static void write() {
		try {
			// 把1.txt文件作为字节输出流，并且直接可以写java的数据类型
			/*
			 * DataOutputStream dos = new DataOutputStream( new
			 * FileOutputStream("d:\\1.txt"));
			 */
			// 把1.txt文件作为字节输出流，并且先写入缓冲区，并且可以直接写java的数据类型(txt里面就是java数据类型)
			/*
			 * DataOutputStream dos1 = new DataOutputStream( new
			 * BufferedOutputStream( new FileOutputStream("d:\\1.txt")));
			 */

			// 发现特殊功能的流类都是由基本的流流，嵌套构造而来，其实是装饰模式
			DataOutputStream dos = new DataOutputStream(new FileOutputStream(
					"D:\\appppp\\data.txt"));
		    /*
		     * 如果是FileOutputStream out
		     * out.write(10000); write方法每次只能写一个字节 
		     * 但是10000 是32个字节，所以它只会写后8位
		     * DataOutputStream dos对象的writeInt
		     * 方法一定是利用out对象的write方法写4次每次写8位
		     * writeInt内部一定是
		     * 10000》》1  0011   10001   0000先把这个右移24位把高8位写上去，然后再右移16位把接着8位写上去以此类推
		     * out.write(10000>>24)// 这样写进去的就和之前的值一样了
		     * out.write(10000>>16)             //  X  X  X  X
		     * out.write(10000>>8)
		     * out.write(10000)
		     */

			dos.writeInt(1000);
			dos.writeInt(5);
			dos.writeInt(3000);
			dos.writeBoolean(true);
			dos.writeDouble(10.03);
			dos.writeUTF("helloworld");//保存在本地的txt文件里面是乱码(txt里面就是java数据类型)
			dos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void read() {
		try {
			DataInputStream dis = new DataInputStream(new 
					FileInputStream("D:\\appppp\\data.txt"));
			/*
			 * readInt方法是用
			 * InputStream 的read读4次然后拼接
			 * 看源码
			 */
			System.out.println(dis.readInt());
			System.out.println(dis.readBoolean());
			System.out.println(dis.readDouble());
			System.out.println(dis.readUTF());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
