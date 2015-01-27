package org.iweb.sys.encrypt;

import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

/**
 * 未完成
 * 
 * @author 骏宇
 * 
 */
public class EncryptMD5 extends AbstractEncrypt {

	private static MessageDigest md;

	static {
		try {
			md = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			md = null;
		}
	}

	private static EncryptMD5 encrypt;

	private EncryptMD5() {

	}

	public static EncryptMD5 getInstance() {
		if (encrypt == null) encrypt = new EncryptMD5();
		return encrypt;
	}

	/**
	 * 加密
	 * 
	 * @param content
	 *            需要加密的内容
	 * @return
	 */
	public byte[] encrypt(String content) throws Exception {
		md.update(content.getBytes("UTF-8"));
		return md.digest();
	}

	/**
	 * 加密
	 * 
	 * @param content
	 *            需要加密的内容
	 * @return
	 */
	public byte[] encrypt(byte[] content) throws Exception {
		md.update(content);
		return md.digest();
	}

	/**
	 * 解密(MD5无法解密)
	 * 
	 * @param content
	 *            待解密内容
	 * @return
	 */
	public byte[] decrypt(byte[] content) throws Exception {
		return null;
	}

	/**
	 * 比较内容
	 * 
	 * @param content
	 * @param enContent
	 * @return
	 * @throws Exception
	 */
	public boolean equal(String content, String enContent) throws Exception {
		return equal(content.getBytes("UTF-8"), enContent.getBytes("UTF-8"));
	}

	/**
	 * 比较内容
	 * 
	 * @param content
	 * @param enContent
	 * @return
	 * @throws Exception
	 */
	public boolean equal(String content, byte[] enContent) throws Exception {
		return equal(content.getBytes("UTF-8"), enContent);
	}

	/**
	 * 比较内容
	 * 
	 * @param content
	 * @param enContent
	 * @return
	 * @throws Exception
	 */
	public boolean equal(byte[] content, byte[] enContent) throws Exception {
		if (content == null || content.length == 0 || enContent == null || enContent.length == 0) {
			return false;
		} else {
			return java.util.Arrays.equals(this.encrypt(content), enContent);
		}
	}

	/**
	 * @param args
	 * @throws NoSuchPaddingException
	 * @throws NoSuchAlgorithmException
	 * @throws BadPaddingException
	 * @throws IllegalBlockSizeException
	 * @throws InvalidKeyException
	 */
	public static void main(String[] args) throws Exception {
		// String pwd = "123456";
		String msg = "郭XX-搞笑相声全集";
		String en = "&���emY�ͻ�,6";
		AbstractEncrypt encrypt = EncryptMD5.getInstance();
		byte[] encontent = encrypt.encrypt(msg);
		System.out.println("加密后的字符串为:" + new String(encontent));
		System.out.println("比较结果为:" + encrypt.equal(msg, en.getBytes("UTF-8")));
	}
}
