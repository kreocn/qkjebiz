package org.iweb.ajax.data;

import java.util.Map;

public abstract class Ajax {
	protected Map<String, Object> parameter;

	public abstract Object getResult();

	protected Map<String, Object> getParameter() {
		return parameter;
	}

	public void setParameter(Map<String, Object> parameter) {
		this.parameter = parameter;
	}

	protected final static String NOLOGIN = "NOLOGIN";
	protected final static String NODATA = "NODATA";
	protected final static String NOPERMIT = "NOPERMIT";
}
