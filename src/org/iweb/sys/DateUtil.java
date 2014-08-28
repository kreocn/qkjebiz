package org.iweb.sys;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class DateUtil {
	/**
	 * 把指定格式字符串返回日期
	 * 如果报错就返回null
	 * 
	 * @param str
	 *            String
	 * @param patten
	 *            yyyy-MM-dd HH:mm:ss
	 * @return
	 */
	public static Date getDate(String str, String patten) {
		try {
			return new SimpleDateFormat(patten).parse(str);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 把指定格式字符串返回日期
	 * 
	 * @param str
	 *            String
	 * @param patten
	 *            yyyy-MM-dd HH:mm:ss
	 * @return
	 */
	public static Date getDate(Date d, String patten) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(patten);
			return sdf.parse(sdf.format(d));
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 按指定格式返回字符串
	 * 
	 * @param d
	 *            Date
	 * @param patten
	 *            yyyy.MM.dd HH:mm:ss
	 * @return
	 * @throws Exception
	 */
	public static String getDateString(Date d, String patten) throws Exception {
		if (ToolsUtil.isEmpty(d)) return "";
		else return new SimpleDateFormat(patten).format(d);
	}

	/**
	 * 捕获错误版本,如果发生错误,就返回null
	 * 
	 * @param d
	 * @param patten
	 * @return
	 * @date 2014-3-13 下午10:29:52
	 */
	public static String format(Date d, String patten) {
		try {
			return new SimpleDateFormat(patten).format(d);
		} catch (Exception e) {
		}
		return null;
	}

	/**
	 * 给指定日期增加月份
	 * 
	 * @param d
	 *            原时间
	 * @param i
	 *            需增加月份(可为负数)
	 * @return Date
	 */
	public static Date addMonth(Date d, int i) {
		Calendar cal = GregorianCalendar.getInstance();
		cal.setTimeInMillis(d.getTime());
		cal.add(Calendar.MONTH, i);
		return cal.getTime();
	}

	/**
	 * 给指定日期增加天
	 * 
	 * @param d
	 *            原时间
	 * @param i
	 *            需增加天数(可为负数)
	 * @return Date
	 */
	public static Date addDay(Date d, int i) {
		Calendar cal = GregorianCalendar.getInstance();
		cal.setTimeInMillis(d.getTime());
		cal.add(Calendar.DATE, i);
		return cal.getTime();
	}

	/**
	 * 给指定日期增加小时
	 * 
	 * @param d
	 *            原时间
	 * @param i
	 *            需增加小时
	 * @return Date
	 */
	public static Date addHour(Date d, int i) {
		Calendar cal = GregorianCalendar.getInstance();
		cal.setTimeInMillis(d.getTime());
		cal.add(Calendar.HOUR, i);
		return cal.getTime();
	}

	/**
	 * 给指定日期增加分钟
	 * 
	 * @param d
	 *            原时间
	 * @param i
	 *            需增加分钟数 MINUTE
	 * @return Date
	 */
	public static Date addMinute(Date d, int i) {
		Calendar cal = GregorianCalendar.getInstance();
		cal.setTimeInMillis(d.getTime());
		cal.add(Calendar.MINUTE, i);
		return cal.getTime();
	}

	/**
	 * 得到参数时间所在月的第一天，即1号
	 * 
	 * @param d
	 * @return
	 */
	public static Date getFirstDayOfMonth(Date d) {
		Calendar cal = GregorianCalendar.getInstance();
		cal.setTimeInMillis(d.getTime());
		cal.set(Calendar.DATE, 1);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}

	/**
	 * 得到参数时间所在天的最后时刻,即当天的23:59:59:999
	 * 
	 * @param d
	 * @return
	 */
	public static Date getLastSecondOfDay(Date d) {
		Calendar cal = GregorianCalendar.getInstance();
		cal.setTimeInMillis(d.getTime());
		cal.set(Calendar.HOUR_OF_DAY, 23);
		cal.set(Calendar.MINUTE, 59);
		cal.set(Calendar.SECOND, 59);
		cal.set(Calendar.MILLISECOND, 999);
		return cal.getTime();
	}

	/**
	 * 得到参数时间所在月的最后一天
	 * 
	 * @param d
	 * @return
	 */
	public static Date getLastDayOfMonth(Date d) {
		Calendar cal = GregorianCalendar.getInstance();
		cal.setTimeInMillis(d.getTime());
		cal.set(Calendar.DATE, 1);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return DateUtil.addDay(DateUtil.addMonth(cal.getTime(), 1), -1);
	}

	/**
	 * 得到参数日期,即yyyy.MM.dd
	 * 
	 * @param d
	 * @return
	 */
	public static Date getToday(Date d) {
		Calendar cal = GregorianCalendar.getInstance();
		cal.setTimeInMillis(d.getTime());
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}

	private static int getFieldValue(Date d, int field) {
		Calendar cal = GregorianCalendar.getInstance();
		cal.setTimeInMillis(d.getTime());
		return cal.get(field);
	}

	/**
	 * 得到年
	 * 
	 * @param d
	 * @return
	 */
	public static int getYear(Date d) {
		return getFieldValue(d, Calendar.YEAR);
	}

	/**
	 * 得到月
	 * 
	 * @param d
	 * @return
	 */
	public static int getMonth(Date d) {
		return getFieldValue(d, Calendar.MONTH) + 1;
	}

	/**
	 * 得到日
	 * 
	 * @param d
	 * @return
	 */
	public static int getDay(Date d) {
		return getFieldValue(d, Calendar.DAY_OF_MONTH);
	}

	/**
	 * 得到时
	 * 
	 * @param d
	 * @return
	 */
	public static int getHour(Date d) {
		return getFieldValue(d, Calendar.HOUR_OF_DAY);
	}

	/**
	 * 得到分
	 * 
	 * @param d
	 * @return
	 */
	public static int getMinute(Date d) {
		return getFieldValue(d, Calendar.MINUTE);
	}

	/**
	 * 得到秒
	 * 
	 * @param d
	 * @return
	 */
	public static int getSecond(Date d) {
		return getFieldValue(d, Calendar.SECOND);
	}
}
