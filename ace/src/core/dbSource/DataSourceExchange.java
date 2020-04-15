package core.dbSource;

import java.lang.reflect.Method;

import org.springframework.aop.AfterReturningAdvice;
import org.springframework.aop.MethodBeforeAdvice;


/*public class DataSourceExchange implements MethodInterceptor {

	@Override
	public Object invoke(MethodInvocation invocation) throws Throwable {
		DataSource dataSource = invocation.getMethod().getAnnotation(DataSource.class); 
		DatabaseContextHolder.setCustomerType(dataSource.value());
		try {
			invocation.proceed();
		} catch (Exception e) {
			System.out.println("++++++++++++++切换数据库异常+++++++++++++++++++++");
		}
		return null;
	}
	
}
*/





public class DataSourceExchange implements MethodBeforeAdvice,AfterReturningAdvice     
{    
    
    @Override    
    public void afterReturning(Object returnValue, Method method,    
            Object[] args, Object target) throws Throwable {    
        DataSourceContextHolder.clearDataSource();    
    }    
    
    @Override    
    public void before(Method method, Object[] args, Object target)    
            throws Throwable {    

        if (method.isAnnotationPresent(DataSource.class))     
        {    
            DataSource datasource = method.getAnnotation(DataSource.class);    
            DataSourceContextHolder.setDataSource(datasource.name());    
        }    
            
    }    
}    