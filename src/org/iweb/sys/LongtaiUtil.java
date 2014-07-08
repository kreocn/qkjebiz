package org.iweb.sys;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class LongtaiUtil {

	/**
	 * 从乳剂号中得出有效期
	 * 
	 * @param lot
	 *            乳剂号,如36951012
	 * @return
	 */
	public static Date getValidDateByLotInfo(String lot) {
		Calendar cal = new GregorianCalendar(1705, 0, 1, 0, 0, 0);
		int i = 0;
		try {
			i = Integer.parseInt(lot.substring(0, 4));
		} catch (Exception e) {
			i = 0;
		}
		cal.add(Calendar.MONTH, i);
		return cal.getTime();
	}

	public static void main(String[] args) {
	}
}
