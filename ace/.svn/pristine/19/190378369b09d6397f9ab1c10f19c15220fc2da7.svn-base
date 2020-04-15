package core.support;

import java.sql.Types;

import org.hibernate.dialect.OracleDialect;
import org.hibernate.type.StringType;

public class OracleDialectSupport extends OracleDialect{
	public OracleDialectSupport(){
		super();
		
		registerHibernateType(Types.NVARCHAR,StringType.INSTANCE.getName());
	}
}
