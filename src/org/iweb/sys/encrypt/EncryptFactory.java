package org.iweb.sys.encrypt;

public class EncryptFactory {
	public static AbstractEncrypt getEncrypt(String type) {
		if ("AES".equals(type)) return EncryptFactory.getAESInstance();
		if ("MD5".equals(type)) return EncryptFactory.getMD5Instance();
		else return null;
	}

	private static EncryptAES encryptAES;

	private static EncryptAES getAESInstance() {
		if (encryptAES == null) {
			encryptAES = new EncryptAES();
		}
		return encryptAES;
	}

	private static EncryptMD5 encryptMD5;

	private static EncryptMD5 getMD5Instance() {
		if (encryptMD5 == null) {
			encryptMD5 = new EncryptMD5();
		}
		return encryptMD5;
	}
}
