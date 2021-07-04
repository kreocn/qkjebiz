package org.iweb.sys.encrypt;

import java.io.UnsupportedEncodingException;
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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ToolsUtil;

/**
 * AES 加密类
 * 
 * @author 骏宇
 * @see
 *      {@code EncryptAES aes = (EncryptAES) EncryptFactory.getEncrypt("AES");}
 */
public final class EncryptAES extends AbstractEncrypt {
	private static Log log = LogFactory.getLog(EncryptAES.class);

	@Override
	public String encrypt(String content, String password) {
		try {
			byte[] encryptResult = encryptAES(content, password);
			String encryptResultStr = parseByte2HexStr(encryptResult);
			// BASE64位加密
			encryptResultStr = encryptBase64(encryptResultStr);
			return encryptResultStr;
		} catch (Exception e) {
			log.error("AES加密错误:", e);
			return null;
		}
	}

	public String encrypt(String content) {
		return encrypt(content, pwd);
	}

	@Override
	public String decrypt(String enContent, String password) {
		try {
			// BASE64位解密
			String decrpt = decryptBase64(enContent);
			byte[] decryptFrom = parseHexStr2Byte(decrpt);
			byte[] decryptResult = decryptAES(decryptFrom, password);
			return new String(decryptResult);
		} catch (Exception e) {
			log.error("AES解密错误:", e);
			return null;
		}
	}

	public String decrypt(String enContent) {
		return decrypt(enContent, pwd);
	}

	@Override
	public boolean equal(String content, String enContent, String password) {
		if (!ToolsUtil.isEmpty(content)) return content.equals(decrypt(enContent, pwd));
		return false;
	}

	public boolean equal(String content, String enContent) {
		return equal(content, enContent, pwd);
	}

	/**
	 * 加密
	 * 
	 * @param content
	 *            需要加密的内容
	 * @param password
	 *            加密密码
	 * @return
	 */
	private static byte[] encryptAES(String content, String password) {
		try {
			KeyGenerator kgen = KeyGenerator.getInstance("AES");
			// 防止linux下 随机生成key
			SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");
			secureRandom.setSeed(password.getBytes());
			kgen.init(128, secureRandom);
			// kgen.init(128, new SecureRandom(password.getBytes()));
			SecretKey secretKey = kgen.generateKey();
			byte[] enCodeFormat = secretKey.getEncoded();
			SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
			Cipher cipher = Cipher.getInstance("AES");// 创建密码器
			byte[] byteContent = content.getBytes("utf-8");
			cipher.init(Cipher.ENCRYPT_MODE, key);// 初始化
			byte[] result = cipher.doFinal(byteContent);
			return result; // 加密
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 解密
	 * 
	 * @param content
	 *            待解密内容
	 * @param password
	 *            解密密钥
	 * @return
	 */
	private static byte[] decryptAES(byte[] content, String password) {
		try {
			KeyGenerator kgen = KeyGenerator.getInstance("AES");
			// 防止linux下 随机生成key
			SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");
			secureRandom.setSeed(password.getBytes());
			kgen.init(128, secureRandom);
			// kgen.init(128, new SecureRandom(password.getBytes()));
			SecretKey secretKey = kgen.generateKey();
			byte[] enCodeFormat = secretKey.getEncoded();
			SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
			Cipher cipher = Cipher.getInstance("AES");// 创建密码器
			cipher.init(Cipher.DECRYPT_MODE, key);// 初始化
			byte[] result = cipher.doFinal(content);
			return result; // 加密
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		// String pwd = "123456";
		// String msg = "郭XX-搞笑相声全集";
		// AbstractEncrypt encrypt = EncryptAES.getInstance();
		// byte[] encontent = encrypt.encrypt(msg);
		// byte[] decontent = encrypt.decrypt(encontent);
		// boolean flag1 = encrypt.equal(msg, encontent);
		// boolean flag2 = encrypt.equal(msg.getBytes(), encontent);
		// System.out.println("明文是:" + msg);
		// System.out.println("加密后:" + new String(encontent));
		// System.out.println("解密后:" + new String(decontent));
		// System.out.println("比较1:" + flag1);
		// System.out.println("比较2:" + flag2);
	}

}
