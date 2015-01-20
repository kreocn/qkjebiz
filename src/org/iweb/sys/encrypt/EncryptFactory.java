package org.iweb.sys.encrypt;

public class EncryptFactory {
	public static AbstractEncrypt getEncrypt(String type) {
		if ("AES".equals(type)) return EncryptAES.getInstance();
		else return null;
	}
}
