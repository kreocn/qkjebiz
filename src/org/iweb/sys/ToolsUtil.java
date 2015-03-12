package org.iweb.sys;

import java.beans.PropertyDescriptor;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.lang.annotation.Annotation;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.TreeMap;
import java.util.UUID;
import java.util.Vector;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

public class ToolsUtil {

	private final static String[] simpleClass = { "java.lang.String", "java.lang.Double", "java.lang.Integer", "java.lang.Float", "java.lang.Lang", "java.lang.Number",
			"java.lang.Short" };

	/**
	 * 创建16位ID
	 * 
	 * @return
	 */
	public static String getUUID() {
		return getUUIDByDateRandom(2, "yyyyMMddHHmmss");
	}

	/**
	 * 创建ID, 前缀+15位时间数字
	 * 
	 * @return
	 */
	public static String getUUID(String prefix) {
		String s = "";
		try {
			s = DateUtil.getDateString(new Date(), "yyMMddHHmmssSSS");
		} catch (Exception e) {
			s = getTimeTimeMillis(15);
		}
		return prefix + s;
	}

	/**
	 * 使用日期加6位随机数编码
	 * 
	 * @return
	 * @date 2014-1-1 下午9:00:20
	 */
	public static String getUUIDByDateRandom() {
		return getUUIDByDateRandom(6, "yyyyMMdd");
	}

	/**
	 * 使用简写日期加5位随机数编码
	 * 
	 * @return
	 * @date 2014-1-1 下午9:00:20
	 */
	public static String getCommonUUID() {
		return getCommonUUID("", 5, "yyMMdd");
	}

	/**
	 * 加一个前缀
	 * 
	 * @param prefix
	 * @return
	 * @date 2014-4-23 下午9:35:24
	 */
	public static String getCommonUUID(String prefix) {
		return getCommonUUID(prefix, 5, "yyMMdd");
	}

	/**
	 * 加一个前缀
	 * 
	 * @param prefix
	 * @return
	 * @date 2014-4-23 下午9:35:24
	 */
	public static String getCommonUUID(String prefix, int pos, String patten) {
		return prefix + getUUIDByDateRandom(pos, patten);
	}

	/**
	 * 时间+随机数的编码方式生成随机码
	 * 
	 * @param pos
	 *            随机码位数
	 * @param patten
	 *            时间格式 yyyyMMdd
	 * @return
	 * @date 2014-1-27 下午2:43:29
	 */
	public static String getUUIDByDateRandom(int pos, String patten) {
		try {
			StringBuffer sb = new StringBuffer();
			try {
				sb.append(DateUtil.getDateString(new Date(), patten)).toString();
			} catch (Exception e) {
				patten = "yyyyMMdd";
				sb.append(DateUtil.getDateString(new Date(), patten)).toString();
			}
			Random r = new Random();
			sb.append(String.format("%0" + pos + "d", r.nextInt((int) Math.pow(10, pos) - 1)));
			return sb.toString();
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * @return 得到16位的唯一性ID
	 */
	public static String getUUIDByTimeMillis() {
		return ((Long) (System.currentTimeMillis() * 1000 + (long) (Math.random() * 900) + 100)).toString();
	}

	/**
	 * JAVA自带UUID生成器,推荐使用
	 * 
	 * @return
	 */
	public static String getUUID32() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

	/**
	 * 使用System.currentTimeMillis(13位)得到ID
	 * 
	 * @param pos
	 *            总长度(如果总长度小于13,则会截取字符串;如果大于,则会在后面补随机数)
	 * @return
	 */
	public static String getTimeTimeMillis(int pos) {
		String s = ((Long) System.currentTimeMillis()).toString();
		int len = s.length();
		if (len < pos) {
			s += String.format("%0" + (pos - len) + "d", getRandomInt(pos - len));
		} else if (len > pos) {
			s = s.substring(0, pos);
		}
		return s;
	}

	/**
	 * 使用System.currentTimeMillis(13位)得到ID
	 * 
	 * @return
	 */
	public static String getTimeTimeMillis() {
		return getTimeTimeMillis(13);
	}

	/**
	 * 生成固定长度整数
	 * 
	 * @param int len 长度
	 * @return 固定长度整数
	 */
	public static int getRandomInt(int len) {
		Random r = new Random();
		return r.nextInt((int) Math.pow(10, len) - 1);
	}

	/**
	 * 生成固定长度随机密码,把L大写以免混淆
	 * 
	 * @param pwd_len
	 *            生成的密码的总长度
	 * @return 密码的字符串
	 */
	public static String getRandomCode(int pwd_len) {
		// 35是因为数组是从0开始的，26个字母+10个数字
		final int maxNum = 36;
		int i; // 生成的随机数
		int count = 0; // 生成的密码的长度
		char[] str = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'L', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4',
				'5', '6', '7', '8', '9' };
		StringBuffer pwd = new StringBuffer("");
		Random r = new Random();
		while (count < pwd_len) {
			// 生成随机数，取绝对值，防止生成负数，
			i = Math.abs(r.nextInt(maxNum)); // 生成的数最大为36-1
			if (i >= 0 && i < str.length) {
				pwd.append(str[i]);
				count++;
			}
		}
		return pwd.toString();
	}

	/**
	 * 根据传入的参数,计算出下一个ID
	 * 
	 * @param current_id
	 *            当前ID
	 * @param prefix
	 *            前缀
	 * @return NextID
	 * 
	 * 比如传入(q000155,q)则返回q000156
	 */
	public static String getNextID(String current_id, String prefix) {
		Long l = Long.parseLong(current_id.substring(prefix.length()));
		return prefix + String.format("%0" + (current_id.length() - prefix.length()) + "d", ++l);
	}

	/**
	 * 检查obj是否为空(包括""和null)
	 * 
	 * @param obj
	 * @return 空返回true
	 */
	public static boolean isEmpty(Object obj) {
		return obj == null || "".equals(obj.toString());
	}

	public static String getEmpty(Object obj) {
		return obj == null ? "" : (obj + "");
	}

	/**
	 * 把一个bean对象转换成Map
	 * 
	 * @param bean
	 * @return
	 */
	public static Map<String, Object> getMapByBean(Object bean) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			java.beans.BeanInfo info = java.beans.Introspector.getBeanInfo(bean.getClass());
			if (info != null) {
				java.beans.PropertyDescriptor pds[] = info.getPropertyDescriptors();
				for (java.beans.PropertyDescriptor pd : pds) {
					String fieldName = pd.getName();
					if (fieldName != null && !fieldName.equals("class")) {
						java.lang.reflect.Method method = pd.getReadMethod();
						try {
							Object value = method.invoke(bean);
							// System.out.println("[" +
							// bean.getClass().getName() + "]." +
							// pd.getName() + "("
							// + pd.getPropertyType().getName() + ") = " +
							// value);
							if (!ToolsUtil.isEmpty(value)) {
								map.put(pd.getName(), value);
								// System.out.println("PUT:" + pd.getName() +
								// "=" + value);
							}
						} catch (Exception e) {
							System.out.println("读取[" + pd.getName() + "]参数值异常!");
							e.printStackTrace();
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	/**
	 * 和上述相反,把map转换成bean
	 * 
	 * @param bean
	 * @param request
	 * @return
	 */
	public static Object getBeanByMap(Object bean, Map<String, Object> map) {
		try {
			java.beans.BeanInfo info = java.beans.Introspector.getBeanInfo(bean.getClass());
			if (info != null) {
				java.beans.PropertyDescriptor pds[] = info.getPropertyDescriptors();
				for (java.beans.PropertyDescriptor pd : pds) {
					String fieldName = pd.getName();
					if (fieldName != null && !fieldName.equals("class")) {
						try {
							for (Iterator<Map.Entry<String, Object>> iterator = map.entrySet().iterator(); iterator.hasNext();) {
								Map.Entry<String, Object> m = iterator.next();
								if ((fieldName.toUpperCase()).equals(m.getKey().toString().toUpperCase())) {
									java.lang.reflect.Method method = pd.getWriteMethod();
									Object[] args = new Object[1];
									args[0] = m.getValue();
									method.invoke(bean, args);
								}

							}
						} catch (Exception e) {
							System.out.println("写入[" + pd.getName() + "]参数值异常!");
							e.printStackTrace();
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}

	/**
	 * 从原有的list(存在树型结构)中,根据指定的mode返回id相关的节点,如中途出现异常,则直接返回原list
	 * 
	 * @param list
	 *            原list
	 * @param clas
	 *            list内的Bean Class
	 * @param id_col
	 *            id在Bean Class的属性名
	 * @param p_id_col
	 *            parent_id在Bean Class的属性名
	 * @param id
	 *            需要查询的id
	 * @param mode
	 *            模式(0:只根据_c参数列出id本身,1:所有父节点,2:所有子节点,3:所有子节点及父节点)
	 * @param _c
	 *            是否包含节点本身
	 */
	public static List getTreeNode(List list, String id_col, String p_id_col, String id, int mode, boolean _c) {
		try {
			List p_list = new ArrayList();
			List c_list = new ArrayList();
			List f_list = new ArrayList();
			Map<String, String> m_map = new HashMap<String, String>();
			Map<String, Object> o_map = new HashMap<String, Object>();
			String tmp_p = null, tmp_ = null;
			if (list == null || id_col == null || p_id_col == null || id == null) {
				return null;
			} else if (!(mode == 0 || mode == 1 || mode == 2 || mode == 3)) {
				mode = 0;
			}
			// 循环得到特定的map: map<id,p_id>
			for (int i = 0, length = list.size(); i < length; i++) {
				Object obj = list.get(i);
				java.beans.BeanInfo info = java.beans.Introspector.getBeanInfo(obj.getClass());
				if (info != null) {
					for (java.beans.PropertyDescriptor pd : info.getPropertyDescriptors()) {
						String fieldName = pd.getName();
						if (fieldName != null && !fieldName.equals("class")) {
							java.lang.reflect.Method method = pd.getReadMethod();
							if (id_col.equals(fieldName)) {
								tmp_ = (String) method.invoke(obj);
							} else if (p_id_col.equals(fieldName)) {
								tmp_p = (String) method.invoke(obj);
							}
						}
					}
					if (!isEmpty(tmp_) || !isEmpty(tmp_p)) {
						m_map.put(tmp_, tmp_p);
						o_map.put(tmp_, obj);
					}
				}
			}
			if (m_map.containsKey(id)) {
				if (mode != 0) { // 如mode是0,则不用遍历
					for (Map.Entry<String, String> m : m_map.entrySet()) {
						tmp_ = m.getKey();
						// tmp_p = m.getValue();
						if (mode == 1 || mode == 3) {
							if (checkParent(m_map, id, tmp_)) {
								c_list.add(o_map.get(tmp_));
							}
						}
						if (mode == 2 || mode == 3) {
							if (checkParent(m_map, tmp_, id)) {
								p_list.add(o_map.get(tmp_));
							}
						}
					}
				}
				if (_c) {
					f_list.add(o_map.get(id));
				}
				f_list.addAll(c_list);
				f_list.addAll(p_list);
			}
			return f_list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 在特定的map&lt;id:p_id&gt;中,用来判定是否存在从属关系,即判断id是否从属于p_id(可能包含多层),
	 * id和p_id相同将返回false
	 * 
	 * @param map
	 *            特定格式的map,格式为&lt;id,p_id&gt;
	 * @param id
	 * @param p_id
	 * @return
	 */
	public static boolean checkParent(Map<String, String> map, String id, String p_id) {
		while (true) {
			if (map.containsKey(id)) {
				return p_id.equals(map.get(id)) || checkParent(map, map.get(id), p_id);
			} else {
				break;
			}
		}
		return false;
	}

	private static String getStackTrace(Exception e, String type) {
		String n = "", t = "";
		if ("HTML".equals(type)) {
			n = "<br />";
			t = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		} else if ("Text".equals(type)) {
			n = "\n";
			t = "\t";
		}
		StackTraceElement[] sts = e.getStackTrace();
		StringBuffer sb = new StringBuffer();
		sb.append(e.toString()).append(n);
		for (StackTraceElement st : sts) {
			sb.append(t).append("at ").append(st.toString()).append(n);
		}
		return sb.toString();
	}

	public static void removeNullElement(List list) {
		List nuList = new ArrayList();
		nuList.add(null);
		list.removeAll(nuList);
		nuList = null;
	}

	/**
	 * 得到Exception抛出的错误字符串文本
	 * 
	 * @param e
	 * @return
	 */
	public static String getStackTrace(Exception e) {
		return getStackTrace(e, "Text");
	}

	/**
	 * 得到Exception抛出的错误字符串HTML(页面显示时用)
	 * 
	 * @param e
	 * @return
	 */
	public static String getStackTraceHTML(Exception e) {
		return getStackTrace(e, "HTML");
	}

	/**
	 * 得到正在运行的方法名
	 * 
	 * @return
	 */
	public static String getRuntimeMethodName() {
		return new Exception().getStackTrace()[1].getMethodName();
	}

	/**
	 * 把List<String>转换成分隔符隔开的字符串
	 * 
	 * @param list
	 * @param sep
	 *            分隔符
	 * @return
	 */
	public static String List2StringBySep(List<String> list, String sep) {
		if (list == null || list.size() == 0) { return ""; }
		StringBuffer sb = new StringBuffer();
		for (int i = 0, n = list.size(); i < n; i++) {
			sb.append(list.get(i)).append(sep);
		}
		sb.delete(sb.length() - sep.length(), sb.length());
		return sb.toString();
	}

	/**
	 * 调试, 返回当前所有属性的值
	 * 
	 * @date 2005-07-31
	 * @author BeanSoft
	 * @param bean
	 */
	public static String dumpObject(Object bean) {
		if (bean == null) {
			return null;
		} else {
			// instanceof
			if (ToolsUtil.isIn(bean.getClass().getName(), ToolsUtil.simpleClass) || bean instanceof Map || bean instanceof Collections || bean instanceof Collection) {
				return bean.toString();
			} else {
				StringBuffer sb = new StringBuffer();
				java.beans.PropertyDescriptor[] descriptors = ToolsUtil.getAvailablePropertyDescriptors(bean);
				sb.append(bean.getClass().getName()).append(":{");
				for (int i = 0; descriptors != null && i < descriptors.length; i++) {
					java.lang.reflect.Method readMethod = descriptors[i].getReadMethod();

					try {
						Object value = readMethod.invoke(bean, null);
						// System.out.println("[" + bean.getClass().getName() +
						// "]." + descriptors[i].getName()+ "("+
						// descriptors[i].getPropertyType().getName() + ") = " +
						// value);
						if (value != null) sb.append(descriptors[i].getName()).append(":").append(value).append(",");
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				sb.append("}");
				return sb.toString();
			}
		}
	}

	// JavaBean 中遍历解析属性信息并查找相关的read/write 方法
	private static java.beans.PropertyDescriptor[] getAvailablePropertyDescriptors(Object bean) {
		try {
			java.beans.BeanInfo info = java.beans.Introspector.getBeanInfo(bean.getClass());
			if (info != null) {
				java.beans.PropertyDescriptor pd[] = info.getPropertyDescriptors();
				Vector columns = new Vector();

				for (int i = 0; i < pd.length; i++) {
					String fieldName = pd[i].getName();
					if (fieldName != null && !fieldName.equals("class")) {
						columns.add(pd[i]);
					}
				}

				java.beans.PropertyDescriptor[] arrays = new java.beans.PropertyDescriptor[columns.size()];

				for (int j = 0; j < columns.size(); j++) {
					arrays[j] = (PropertyDescriptor) columns.get(j);
				}

				return arrays;
			}
		} catch (Exception ex) {
			System.out.println(ex);
			return null;
		}
		return null;
	}

	/**
	 * 竖转横 注意,*参数都不能为null,如无参数,也需要new一个对象,比如 new String[0]
	 * 
	 * @param oTable
	 *            原数据
	 * @param p_key
	 *            元数据中,作为primary key的列表
	 * @param v_key
	 *            横转竖的key列表
	 * @param v_key_name
	 *            横转竖的key需要转换的名字(横列变成竖列后的显示名称)
	 * @param v_key_title
	 *            竖列名称(横列变成竖列后的key name)
	 * @param value_key
	 *            竖转横的key(竖列需变成横列的key列)
	 * @return
	 */
	public static List<Map<String, Object>> conventTable(List<Map<String, Object>> oTable, String[] p_key, String[] v_key, String[] v_key_name, String v_key_title, String value_key) {
		// 定义返回的变量
		Map<String, HashMap<String, Object>> nTable1 = new HashMap<String, HashMap<String, Object>>();
		Map<String, HashMap<String, Object>> nTable2 = new HashMap<String, HashMap<String, Object>>();
		HashMap<String, Object> nMap; // 返回变量nTable的元素赋予变量

		String tmpKey;
		// 竖转横后,横列的列表
		HashSet<String> value_key_set = new HashSet<String>();

		// 第一次遍历oTable,得到新的Map Key和提取的value_key列表
		for (Iterator<Map<String, Object>> iterator = oTable.iterator(); iterator.hasNext();) {
			Map<String, Object> oMap = iterator.next();
			tmpKey = "";
			nMap = new HashMap<String, Object>();
			nMap.clear();
			for (int i = 0; i < p_key.length; i++) {
				Object to = oMap.get(p_key[i]);
				nMap.put(p_key[i], to);
				if (to instanceof java.lang.Number) {
					java.lang.Number tn = (java.lang.Number) to;
					tmpKey += frontCompWithZore(tn.doubleValue(), 20);
				} else {
					tmpKey += to;
				}
			}
			nTable1.put(tmpKey, nMap);
			value_key_set.add(oMap.get(value_key).toString());
		}
		// 判断变量,判断是否对号
		boolean tmp_flag = true;

		// 第二次循环,开始填入数据
		for (Iterator<Map.Entry<String, HashMap<String, Object>>> iterator = nTable1.entrySet().iterator(); iterator.hasNext();) {
			Map.Entry<String, HashMap<String, Object>> m = iterator.next();
			String oTableKey = m.getKey();
			HashMap<String, Object> oTableValue = m.getValue();
			HashMap<String, Object> tmpValue;
			for (Iterator<Map<String, Object>> iterator2 = oTable.iterator(); iterator2.hasNext();) {
				Map<String, Object> oMap = iterator2.next();

				// System.out.println(oTableValue.toString() + oMap.toString());
				// 首先检查p_key是否对应
				tmp_flag = true;
				for (int i = 0; i < p_key.length; i++) {
					tmp_flag = tmp_flag && oTableValue.get(p_key[i]).equals(oMap.get(p_key[i]));
				}
				if (tmp_flag) {
					// 如果p_key对应,则去查value_key的对应情况
					for (Iterator<String> iterator3 = value_key_set.iterator(); iterator3.hasNext();) {
						String tmp_value_key = iterator3.next();

						if (tmp_value_key.equals(oMap.get(value_key))) {
							// 找到对应的列,则根据v_key自动填写数据(拆分成多列)
							for (int i = 0; i < v_key.length; i++) {
								if (nTable2.containsKey(oTableKey + v_key[i])) {
									tmpValue = nTable2.get(oTableKey + v_key[i]);
								} else {
									tmpValue = new HashMap<String, Object>();
								}
								tmpValue.putAll(oTableValue);
								tmpValue.put(v_key_title, v_key_name[i]);
								tmpValue.put(tmp_value_key, oMap.get(v_key[i]));
								nTable2.put(oTableKey + v_key[i], tmpValue);
							}
						}
					}
				}
			}
		}
		// 清空数据,以免内存溢出
		value_key_set.clear();
		value_key_set = null;
		nTable1.clear();
		nTable1 = null;
		// 排序需要
		TreeMap<String, HashMap<String, Object>> tmp = new TreeMap<String, HashMap<String, Object>>();
		tmp.putAll(nTable2);

		// for (Iterator<Map.Entry<String, HashMap<String, Object>>> iterator =
		// tmp.entrySet().iterator(); iterator
		// .hasNext();) {
		// Map.Entry<String, HashMap<String, Object>> tm = iterator.next();
		// System.out.println(tm.getKey() + ":" + tm.getValue().toString());
		// }

		List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
		l.addAll(tmp.values());
		return l;
	}

	/**
	 * 将元数据前补零，补后的总长度为指定的长度，以字符串的形式返回 (将有2位小数的形式)
	 * 
	 * @param sourceDate
	 * @param formatLength
	 * @return 重组后的数据
	 */
	public static String frontCompWithZore(double sourceDate, int formatLength) {
		String format = String.format("%0" + formatLength + ".3g", 0.0);
		DecimalFormat df = new DecimalFormat(format);
		return df.format(sourceDate);
	}

	/**
	 * JAVA判断字符串数组中是否包含某字符串元素
	 * 
	 * @param substring
	 *            某字符串
	 * @param source
	 *            源字符串数组
	 * @return 包含则返回true，否则返回false
	 */
	public static boolean isIn(String substring, String[] source) {
		if (source == null || source.length == 0) { return false; }
		for (int i = 0; i < source.length; i++) {
			String aSource = source[i];
			if (aSource.equals(substring)) { return true; }
		}
		return false;
	}

	/**
	 * JAVA判断字符串数组中是否包含某字符串元素
	 * 
	 * @param substring
	 *            某字符串
	 * @param source
	 *            源字符串
	 * @return 包含则返回true，否则返回false
	 */
	public static boolean isIn(String substring, String source, String split) {
		if (source == null) { return false; }
		split = isEmpty(split) ? "," : split;
		return isIn(substring, source.split(split));
	}

	/**
	 * 传入2个参数,输出一个非空字符串,如2个都为null,则输出null,优先级 str1>str2
	 * 
	 * @param str1
	 * @param str2
	 * @return
	 * @date 2014-1-28 下午3:37:08
	 */
	public static String getNotNull(String str1, String str2) {
		return str1 != null ? str1 : str2;
	}

	/**
	 * 防止分隔符中间还有空格的情况
	 * 
	 * @param uuid_str
	 * @param split
	 * @return
	 */
	public static String[] spliten(String str, String split) {
		if (ToolsUtil.isEmpty(str)) {
			return new String[0];
		} else {
			return str.split("[ ]*" + split + "[ ]*");
		}
	}

	public static String[] spliten(String str) {
		return spliten(str, ",");
	}

	/**
	 * 把传入对象转换成JSON格式
	 * 
	 * @param obj
	 * @return
	 */
	public static Object Object2JSON(Object obj) {
		// 使类可以序列化java.sql.Date
		// JsDateJsonBeanProcessor jd = new JsDateJsonBeanProcessor();
		// JsonConfig config = new JsonConfig();
		// config.registerJsonBeanProcessor(java.sql.Date.class, jd);
		if (obj == null || obj instanceof String || obj instanceof Number) {
			JSONObject json = new JSONObject();
			json.put("value", obj);
			return json;
		} else if (obj instanceof Enum || JSONUtils.isArray(obj)) {
			return JSONArray.fromObject(obj);
		} else if (obj instanceof Annotation) {
			JSONObject json = new JSONObject();
			json.put("value", "Object is an Annotation");
			return json;
		} else {
			return JSONObject.fromObject(obj);
		}
	}

	/**
	 * 数组转换成字符串,用split隔开
	 * 
	 * @param array
	 *            数组,可以是简单类型的数组String[],Integer[],Double[]等
	 * @param split
	 *            分隔字符
	 * @return
	 */
	public static String Array2String(Object[] array, String split) {
		if (!(array == null || array.length == 0)) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < array.length; i++)
				sb.append(array[i]).append(split);
			sb.delete(sb.length() - split.length(), sb.length());
			return sb.toString();
		} else {
			return null;
		}
	}

	/**
	 * 字符串数组转换成字符串,用split隔开
	 * 
	 * @param array
	 *            字符串数组
	 * @param split
	 *            分隔字符
	 * @return
	 */
	public static String List2String(List<String> list, String split) {
		if (!(list == null || list.size() == 0)) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0, n = list.size(); i < n; i++) {
				sb.append(list.get(i)).append(split);
			}

			sb.delete(sb.length() - split.length(), sb.length());
			return sb.toString();
		} else {
			return null;
		}
	}

	/**
	 * 首字母大写
	 * 
	 * @param str
	 * @date 2013-12-29 下午6:36:33
	 */
	public static String UpperFirst(String str) {
		char[] array = str.toCharArray();
		if (Character.isLowerCase(array[0])) array[0] -= 32;
		return String.valueOf(array);
	}

	/**
	 * 首字母小写
	 * 
	 * @param str
	 * @date 2013-12-29 下午6:36:33
	 */
	public static String LowerFirst(String str) {
		char[] array = str.toCharArray();
		if (Character.isUpperCase(array[0])) array[0] += 32;
		return String.valueOf(array);
	}

	/**
	 * 去除下划线,下划线后首字母大写
	 * 
	 * @param s
	 * @return
	 * @date 2013-12-29 下午7:26:51
	 */
	public static String UpperFirst2(String s) {
		StringBuffer sb = new StringBuffer(s);
		int n;
		while ((n = sb.indexOf("_")) >= 0) {
			if (Character.isLowerCase(sb.charAt(n + 1))) sb.replace(n, n + 2, (char) (sb.charAt(n + 1) - 32) + "");
			else sb.deleteCharAt(n);
		}
		return sb.toString();
	}

	/**
	 * 去除下划线,下划线后首字母小写
	 * 
	 * @param s
	 * @return
	 * @date 2013-12-29 下午7:26:51
	 */
	public static String LowerFirst2(String s) {
		StringBuffer sb = new StringBuffer(s);
		int n;
		while ((n = sb.indexOf("_")) >= 0) {
			if (Character.isUpperCase(sb.charAt(n + 1))) sb.replace(n, n + 2, (char) (sb.charAt(n + 1) + 32) + "");
			else sb.deleteCharAt(n);
		}
		return sb.toString();
	}

	/**
	 * 截取字符串,截取前n位
	 * 
	 * @param s
	 * @return
	 * @date 2013-12-29 下午7:26:51
	 */
	public static String subString(String s, Integer n) {
		if (s.length() <= n) {
			return s;
		} else {
			return s.substring(0, n) + "...";
		}
	}

	public static byte[] File2byte(String filePath) {
		byte[] buffer = null;
		try {
			File file = new File(filePath);
			FileInputStream fis = new FileInputStream(file);
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			byte[] b = new byte[1024];
			int n;
			while ((n = fis.read(b)) != -1) {
				bos.write(b, 0, n);
			}
			fis.close();
			bos.close();
			buffer = bos.toByteArray();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return buffer;
	}

	public static byte[] File2byte(File file) {
		byte[] buffer = null;
		try {
			FileInputStream fis = new FileInputStream(file);
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			byte[] b = new byte[1024];
			int n;
			while ((n = fis.read(b)) != -1) {
				bos.write(b, 0, n);
			}
			fis.close();
			bos.close();
			buffer = bos.toByteArray();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return buffer;
	}

	public static String formatNum(Double d, Integer digit) {
		return String.format("%." + digit + "f", d);
	}

	/**
	 * 把字符串转成整形数组
	 * 
	 * @param str
	 * @return
	 */
	public static Integer[] split2Integer(String str, String split) {
		if (isEmpty(str)) return new Integer[0];
		String[] strs = spliten(str, split);
		Integer[] ints = new Integer[strs.length];
		for (int i = 0; i < ints.length; i++) {
			try {
				ints[i] = Integer.parseInt(strs[i]);
			} catch (Exception e) {
				ints[i] = -1;
			}
		}
		return ints;
	}

	public static Integer[] split2Integer(String str) {
		return split2Integer(str, ",");
	}

	/**
	 * 序列化对象
	 */
	public static byte[] serialize(Object object) {
		ObjectOutputStream oos = null;
		ByteArrayOutputStream baos = null;
		try {
			// 序列化
			baos = new ByteArrayOutputStream();
			oos = new ObjectOutputStream(baos);
			oos.writeObject(object);
			byte[] bytes = baos.toByteArray();
			return bytes;
		} catch (Exception e) {

		}
		return null;
	}

	/**
	 * 反序列化对象
	 */
	public static Object unserialize(byte[] bytes) {
		ByteArrayInputStream bais = null;
		try {
			// 反序列化
			bais = new ByteArrayInputStream(bytes);
			ObjectInputStream ois = new ObjectInputStream(bais);
			return ois.readObject();
		} catch (Exception e) {

		}
		return null;
	}

	public Object[] mergeArray(Object[] al, Object[] bl) {
		if ((bl == null || bl.length == 0) && (al == null || al.length == 0)) return null;
		else if (bl == null || bl.length == 0) return al;
		else if (al == null || al.length == 0) return bl;
		else {
			Object[] a = al;
			Object[] b = bl;
			Object[] c = new Object[a.length + b.length];
			System.arraycopy(a, 0, c, 0, a.length);
			System.arraycopy(b, 0, c, a.length, b.length);
			return c;
		}
	}
}
