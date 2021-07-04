package org.iweb.sys;

import java.security.MessageDigest;

/**
 * 
 * @author 骏宇
 * @deprecated replace By org.iweb.sys.encrypt.EncryptMD5
 */
@Deprecated
public class MD5Plus {
	public static String encrypt(String enteredPassword) {
		String encryptString = "";
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(enteredPassword.getBytes());
			byte b[] = md.digest();

			int i;

			StringBuffer buf = new StringBuffer("");
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0) i += 256;
				if (i < 16) buf.append("0");
				buf.append(Integer.toHexString(i));
			}
			encryptString = buf.toString();
			// System.out.println("result: " + buf.toString());// 32位的加密
			// System.out.println("result: " + buf.toString().substring(8, 24));// 16位的加密
		} catch (Exception e) {
			e.printStackTrace();

		}
		return encryptString;
	}

	public static boolean compare(String enteredPassword, String encryptedPassword) {
		boolean flag = false;
		try {
			flag = encryptedPassword.equals(MD5Plus.encrypt(enteredPassword));
		} catch (Exception e) {
			e.printStackTrace();

		}
		return flag;
	}
}
