package org.iweb.sys.encrypt;

import java.security.MessageDigest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * MD5 加密类
 * 
 * @author 骏宇
 * @see
 *      {@code EncryptMD5 md5 = (EncryptMD5) EncryptFactory.getEncrypt("MD5");}
 */
public final class EncryptMD5 extends AbstractEncrypt {
	private static Log log = LogFactory.getLog(EncryptMD5.class);

	/**
	 * MD5不用密匙加密
	 */
	@Override
	public String encrypt(String content, String password) {
		return encrypt(content);
	}

	public String encrypt(String content) {
		String encryptString = "";
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(content.getBytes());
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
		} catch (Exception e) {
			log.error("MD5加密错误:", e);
		}
		return encryptString;
	}

	/**
	 * MD5无法解密
	 */
	@Override
	public String decrypt(String encryptResultStr, String password) {
		return null;
	}

	@Override
	public boolean equal(String content, String enContent, String password) {
		return equal(content, enContent);
	}

	public boolean equal(String content, String enContent) {
		return encrypt(content).equals(enContent);
	}
}
