package org.iweb.sys.encrypt;

public abstract class AbstractEncrypt {
	protected String pwd = "ilikeqkjebiz";

	public abstract byte[] encrypt(String content) throws Exception;

	public abstract byte[] encrypt(byte[] content) throws Exception;

	public abstract byte[] decrypt(byte[] content) throws Exception;

	public abstract boolean equal(String content, byte[] enContent) throws Exception;

	public abstract boolean equal(byte[] content, byte[] enContent) throws Exception;

}
