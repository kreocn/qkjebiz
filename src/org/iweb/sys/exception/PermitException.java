package org.iweb.sys.exception;

public class PermitException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3245479188398387184L;

	public PermitException() {
	}

	public PermitException(String s) {
		super(s);
	}

	public PermitException(String s, Throwable throwable) {
		super(s, throwable);
	}

	public PermitException(Throwable throwable) {
		super(throwable);
	}
}
