package core.dao;

import java.sql.Types;

import org.hibernate.dialect.Oracle10gDialect;
import org.hibernate.type.StandardBasicTypes;

public class MyOracleDialect extends Oracle10gDialect{
	public MyOracleDialect() {  
        super();                
	    registerHibernateType(Types.NVARCHAR, StandardBasicTypes.STRING.getName());        
	    registerHibernateType(Types.NCLOB, StandardBasicTypes.STRING.getName());  
    }  
}
