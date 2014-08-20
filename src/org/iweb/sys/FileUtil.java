/**
 * 
 */
package org.iweb.sys;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.math.BigInteger;
import java.security.MessageDigest;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2013-12-30 上午11:09:42
 */

public class FileUtil {
	/**
	 * 
	 * The buffer.
	 */
	protected static byte buf[] = new byte[1024];

	/**
	 * 
	 * 
	 * @param fileName
	 *            local file name to read
	 * @return
	 * @throws Exception
	 */
	public static String readFileAsString(String fileName) throws Exception {
		String content = new String(readFileBinary(fileName));
		return content;
	}

	/**
	 * 
	 * 读取文件并返回为给定字符集的字符串.
	 * 
	 * @param fileName
	 * @param encoding
	 * @return
	 * @throws Exception
	 */
	public static String readFileAsString(String fileName, String encoding) throws Exception {
		String content = new String(readFileBinary(fileName), encoding);
		return content;
	}

	/**
	 * 读取文件并返回为给定字符集的字符串.
	 * 
	 * @param fileName
	 * @param encoding
	 * @return
	 * @throws Exception
	 */
	public static String readFileAsString(InputStream in) throws Exception {
		String content = new String(readFileBinary(in));
		return content;
	}

	/**
	 * 
	 * Read content from local file to binary byte array.
	 * 
	 * @param fileName
	 *            local file name to read
	 * @return
	 * @throws Exception
	 */
	public static byte[] readFileBinary(String fileName) throws Exception {
		FileInputStream fin = new FileInputStream(fileName);
		return readFileBinary(fin);
	}

	/**
	 * 从输入流读取数据为二进制字节数组.
	 * 
	 * @param streamIn
	 * @return
	 * @throws IOException
	 */
	public static byte[] readFileBinary(InputStream streamIn) throws IOException {
		BufferedInputStream in = new BufferedInputStream(streamIn);
		ByteArrayOutputStream out = new ByteArrayOutputStream(10240);
		int len;
		while ((len = in.read(buf)) >= 0)
			out.write(buf, 0, len);
		in.close();
		return out.toByteArray();
	}

	/**
	 * 
	 * Write string content to local file.
	 * 
	 * @param fileName
	 *            local file name will write to
	 * @param content
	 *            String text
	 * @return true if success
	 * @throws IOException
	 */
	public static boolean writeFileString(String fileName, String content) throws IOException {
		FileWriter fout = new FileWriter(fileName);
		fout.write(content);
		fout.close();
		return true;
	}

	/**
	 * 
	 * Write string content to local file using given character encoding.
	 * 
	 * @param fileName
	 *            local file name will write to
	 * @param content
	 *            String text
	 * @param encoding
	 *            the encoding
	 * @return true if success
	 * @throws IOException
	 */
	public static boolean writeFileString(String fileName, String content, String encoding) throws IOException {
		OutputStreamWriter fout = new OutputStreamWriter(new FileOutputStream(fileName), encoding);
		fout.write(content);
		fout.close();
		return true;
	}

	/**
	 * 
	 * Write binary byte array to local file.
	 * 
	 * @param fileName
	 *            local file name will write to
	 * @param content
	 *            binary byte array
	 * @return true if success
	 * @throws IOException
	 */
	public static boolean writeFileBinary(String fileName, byte[] content) throws IOException {
		FileOutputStream fout = new FileOutputStream(fileName);
		fout.write(content);
		fout.close();
		return true;
	}

	/**
	 * 
	 * 检查文件名是否合法.文件名字不能包含字符\/:*?"<>|
	 * 
	 * @param fileName文件名
	 *            ,不包含路径
	 * 
	 * @return boolean is valid file name
	 */
	public static boolean isValidFileName(String fileName) {
		boolean isValid = true;
		String errChar = "\\/:*?\"<>|"; //
		if (fileName == null || fileName.length() == 0) {
			isValid = false;
		} else {
			for (int i = 0; i < errChar.length(); i++) {
				if (fileName.indexOf(errChar.charAt(i)) != -1) {
					isValid = false;
					break;
				}
			}
		}
		return isValid;
	}

	/**
	 * 
	 * 把非法文件名转换为合法文件名.
	 * 
	 * @param fileName
	 * 
	 * @return
	 */
	public static String replaceInvalidFileChars(String fileName) {
		StringBuffer out = new StringBuffer();
		for (int i = 0; i < fileName.length(); i++) {
			char ch = fileName.charAt(i);
			// Replace invlid chars: \\/:*?\"<>|
			switch (ch) {
			case '\\':
			case '/':
			case ':':
			case '*':
			case '?':
			case '\"':
			case '<':
			case '>':
			case '|':
				out.append('_');
				break;
			default:
				out.append(ch);
			}
		}
		return out.toString();
	}

	/**
	 * 
	 * Convert a given file name to a URL(URI) string.
	 * 
	 * @param fileName
	 *            the file to parse
	 * 
	 * @return - URL string
	 */
	public static String filePathToURL(String fileName) {
		String fileUrl = new File(fileName).toURI().toString();
		return fileUrl;
	}

	/**
	 * 
	 * Write string content to local file.
	 * 
	 * @param fileName
	 *            local file name will write to
	 * @param content
	 *            String text
	 * @return true if success
	 * @throws IOException
	 */
	public static boolean appendFileString(String fileName, String content) throws IOException {
		OutputStreamWriter fout = new OutputStreamWriter(new FileOutputStream(fileName, true), "GBK");
		fout.write(content);
		fout.close();
		return true;
	}

	/**
	 * 获取单个文件的MD5值！
	 * 
	 * @param file
	 * @return
	 */
	public static String getFileMD5(File file) {
		try {
			if (!file.exists() || !file.isFile()) {
				return null;
			} else {
				return getFileMD5(new FileInputStream(file));
			}
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 获取单个文件的MD5值！
	 * 
	 * @param in
	 * @return
	 */
	public static String getFileMD5(InputStream in) {
		if (in == null) { return null; }
		MessageDigest digest = null;
		byte buffer[] = new byte[1024];
		int len;
		try {
			digest = MessageDigest.getInstance("MD5");
			while ((len = in.read(buffer, 0, 1024)) != -1) {
				digest.update(buffer, 0, len);
			}
			in.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		BigInteger bigInt = new BigInteger(1, digest.digest());
		return bigInt.toString(16);
	}

	public static void main(String[] args) {
		System.out.println(replaceInvalidFileChars("http://www.abc.com/"));
	}
}
