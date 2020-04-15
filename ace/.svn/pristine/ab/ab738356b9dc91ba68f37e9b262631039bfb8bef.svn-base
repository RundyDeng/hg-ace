package core.dbSource;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

public class SwitchDataSource extends AbstractRoutingDataSource {

	@Override
	protected Object determineCurrentLookupKey() {
		return DatabaseContextHolder.getCustomerType();
	}

}
