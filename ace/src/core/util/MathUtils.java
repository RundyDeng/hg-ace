package core.util;

import java.math.BigDecimal;
import java.math.BigInteger;

public class MathUtils {
	/**
	 * 若对象属于BigDecimal则返回BigDeciaml类型实例
	 */
    public static BigDecimal getBigDecimal( Object value ) {
        BigDecimal ret = null;
        if( value != null ) {
            if( value instanceof BigDecimal ) {
                ret = (BigDecimal) value;
            } else if( value instanceof String ) {
                ret = new BigDecimal( (String) value );
            } else if( value instanceof BigInteger ) {
                ret = new BigDecimal( (BigInteger) value );
            } else if( value instanceof Number ) {
                ret = new BigDecimal( ((Number)value).doubleValue() );
            } else {
                throw new ClassCastException("Not possible to coerce ["+value+"] from class "+value.getClass()+" into a BigDecimal.");
            }
        }
        return ret;
    }
    
    /**
     * 
     * @param dividend  被除数
     * @param divisor	除数
     * @return 两数相除后的截取小数点后2位部分
     */
    public static int getNoRound(Object dividend,Object divisor){
    	double a = getBigDecimal(dividend).doubleValue();
    	double b = getBigDecimal(divisor).doubleValue();
    	double no = a/b*100;
    	String str = String.valueOf(no);
        int index = str.indexOf('.');
        str = str.substring(0, index);
        
        return Integer.valueOf(str);
    }
}
