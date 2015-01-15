package org.iweb.sys;

import java.text.DecimalFormat;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class NumberUtil {
	/**
	 * double保留2位小数(四舍五入)
	 * 
	 * @param val
	 * @param precision
	 * @return
	 */
	public static Double roundDouble(double val, int precision) {
		Double ret = null;
		try {
			double factor = Math.pow(10, precision);
			ret = Math.floor(val * factor + 0.5) / factor;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return ret;
	}

	public static String formatDouble(double d, String patten) {
		patten = patten == null ? "0.00" : "";
		DecimalFormat df = new DecimalFormat(patten);
		return df.format(d);
	}

	/**
	 * 随机取范围内的整数
	 * 
	 * @param min
	 * @param max
	 * @return
	 */
	public static int getRandomInt(int min, int max) {
		return (int) (Math.random() * (max - min + 1) + min);
	}

	/**
	 * 判断str是否是数字(包括浮点数)
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumeric(String str) {
		Pattern pattern = Pattern.compile("^-?([1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*|0?\\.0+|[0-9]*)$");
		Matcher isNum = pattern.matcher(str);
		return isNum.matches();
	}

	/**
	 * 返回大小单位
	 * 
	 * @param filesize
	 * @return
	 */
	public static String convertSize(long filesize) {
		String strUnit = "Bytes";
		String strAfterComma = "";
		int intDivisor = 1;
		if (filesize >= 1024 * 1024) {
			strUnit = "MB";
			intDivisor = 1024 * 1024;
		} else if (filesize >= 1024) {
			strUnit = "KB";
			intDivisor = 1024;
		}
		if (intDivisor == 1) return filesize + " " + strUnit;
		strAfterComma = "" + 100 * (filesize % intDivisor) / intDivisor;
		if (strAfterComma == "") strAfterComma = ".0";
		return filesize / intDivisor + "." + strAfterComma + " " + strUnit;
	}
}
