package org.iweb.sys.encrypt;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public abstract class AbstractEncrypt {
	protected final static String pwd = "ilikeqkjebiz";
	protected final static String encoding = "UTF-8";

	public abstract String encrypt(String content, String password);

	public abstract String decrypt(String enContent, String password);

	public abstract boolean equal(String content, String enContent, String password);

	/**
	 * 加密字符串
	 */
	public static String encryptBase64(String str) throws Exception {
		BASE64Encoder base64encoder = new BASE64Encoder();
		String result = str;
		if (str != null && str.length() > 0) {
			byte[] encodeByte = str.getBytes(encoding);
			result = base64encoder.encode(encodeByte);
		}
		// base64加密超过一定长度会自动换行 需要去除换行符
		return result.replaceAll("\r\n", "").replaceAll("\r", "").replaceAll("\n", "");
	}

	/**
	 * 解密字符串
	 */
	public static String decryptBase64(String str) throws Exception {
		BASE64Decoder base64decoder = new BASE64Decoder();
		byte[] encodeByte = base64decoder.decodeBuffer(str);
		return new String(encodeByte);
	}

	/**
	 * 将二进制转换成16进制
	 * 
	 * @param buf
	 * @return
	 */
	public static String parseByte2HexStr(byte buf[]) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < buf.length; i++) {
			String hex = Integer.toHexString(buf[i] & 0xFF);
			if (hex.length() == 1) {
				hex = '0' + hex;
			}
			sb.append(hex.toUpperCase());
		}
		return sb.toString();
	}

	/**
	 * 将16进制转换为二进制
	 * 
	 * @param hexStr
	 * @return
	 */
	public static byte[] parseHexStr2Byte(String hexStr) {
		if (hexStr.length() < 1) return null;
		byte[] result = new byte[hexStr.length() / 2];
		for (int i = 0; i < hexStr.length() / 2; i++) {
			int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);
			int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2), 16);
			result[i] = (byte) (high * 16 + low);
		}
		return result;
	}

}
