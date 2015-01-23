package org.iweb.sys.encrypt;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class EncryptAES extends AbstractEncrypt {
	private KeyGenerator key;
	private SecretKey secretKey;
	private SecretKeySpec secretKeySpec;
	private Cipher cipher;

	private static EncryptAES encrypt;

	private EncryptAES() {
		try {
			key = KeyGenerator.getInstance("AES");
			key.init(128, new SecureRandom(pwd.getBytes("UTF-8")));
			secretKey = key.generateKey();
			byte[] enCodeFormat = secretKey.getEncoded();
			secretKeySpec = new SecretKeySpec(enCodeFormat, "AES");
			cipher = Cipher.getInstance("AES");// 创建密码器
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private EncryptAES(String pwd) {
		try {
			key = KeyGenerator.getInstance("AES");
			key.init(128, new SecureRandom(pwd.getBytes("UTF-8")));
			secretKey = key.generateKey();
			byte[] enCodeFormat = secretKey.getEncoded();
			secretKeySpec = new SecretKeySpec(enCodeFormat, "AES");
			cipher = Cipher.getInstance("AES");// 创建密码器
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static EncryptAES getInstance() {
		if (encrypt == null) encrypt = new EncryptAES();
		return encrypt;
	}

	public static EncryptAES getInstance(String pwd) {
		if (encrypt == null) {
			encrypt = new EncryptAES(pwd);
		}
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
		byte[] byteContent = content.getBytes("UTF-8");
		cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec);// 初始化
		return cipher.doFinal(byteContent); // 加密
	}

	/**
	 * 加密
	 * 
	 * @param content
	 *            需要加密的内容
	 * @return
	 */
	public byte[] encrypt(byte[] content) throws Exception {
		cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec);// 初始化
		return cipher.doFinal(content); // 加密
	}

	/**
	 * 解密
	 * 
	 * @param content
	 *            待解密内容
	 * @return
	 */
	public byte[] decrypt(byte[] content) throws Exception {
		cipher.init(Cipher.DECRYPT_MODE, secretKeySpec);// 初始化
		return cipher.doFinal(content); // 加密
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
		if (content == null || enContent == null || enContent.length == 0) {
			return false;
		} else {
			return content.equals(new String(this.decrypt(enContent)));
		}
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
			return java.util.Arrays.equals(content, this.decrypt(enContent));
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
		AbstractEncrypt encrypt = EncryptAES.getInstance();
		byte[] encontent = encrypt.encrypt(msg);
		byte[] decontent = encrypt.decrypt(encontent);
		boolean flag1 = encrypt.equal(msg, encontent);
		boolean flag2 = encrypt.equal(msg.getBytes(), encontent);
		System.out.println("明文是:" + msg);
		System.out.println("加密后:" + new String(encontent));
		System.out.println("解密后:" + new String(decontent));
		System.out.println("比较1:" + flag1);
		System.out.println("比较2:" + flag2);
	}
}
