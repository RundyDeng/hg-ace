package game;

class Person
{
	//int h=175;//每个人都有自己的身高 初始值都是175
	private int h;
	private int age;
	private String name;
	private static int diqiu;
	
	{
	    h=175;
		System.out.println("aa..");
	}
	
	static {
		diqiu=1;
		System.out.println("bb");
	}
	//static int diqiu =1;//代表所有人公用一个地球
    Person (int ageString, String name)
	{
		this.age=age;
		this.name=name;
		System.out.println("cc..");
	}
}