package org.iweb.rpt.logic;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.iweb.sys.ToolsUtil;

/**
 * 报表系统所用到的专门的工具函数
 * 
 * @author Kreo
 * 
 */
public class ReportUtils {

	/**
	 * 合计
	 * 
	 * 
	 * @param m
	 *            源数据
	 * @param statKey
	 *            参与合计的key列表
	 * @param isWStat
	 *            是否横向统计
	 * @param WStatKey
	 *            横向统计时,需要增加的Key(总计的key)
	 * @param isVStat
	 *            是否竖状统计
	 * @param VStatKey
	 *            竖状统计时,"合计"所放的列的Key
	 * @param VStatGroupKey
	 *            竖状统计时,需分组统计的Key
	 * @category 关于总计:暂时定义为 竖状统计时计算总计,并且需要定义WStatKey
	 */
	public static void sum(List<Map<String, Object>> m, String[] statKey, boolean isWStat, String WStatKey,
			boolean isVStat, String VStatKey, String VStatGroupKey) {
		double[] vSum;
		Map<String, Object> nm;
		// 竖状统计的值
		HashMap<String, Object> tm = new HashMap<String, Object>();
		// HashMap<String, Double> total_m = new HashMap<String, Double>();
		for (Iterator<Map<String, Object>> iterator = m.iterator(); iterator.hasNext();) {
			Map<String, Object> map = iterator.next();
			if (isWStat || isVStat) {
				// if(isWStat)
				double dtmp = 0;
				double tmp = 0;
				for (int i = 0; i < statKey.length; i++) {
					if (map.containsKey(statKey[i])) {
						tmp = ReportUtils.getDouble(map.get(statKey[i]));
						if (isWStat)
							dtmp += tmp;
						if (isVStat) {
							String tmp_group_key;
							if (ToolsUtil.isEmpty(VStatGroupKey) || !map.containsKey(VStatGroupKey)
									|| ToolsUtil.isEmpty(map.get(VStatGroupKey))) {
								tmp_group_key = " ";
							} else {
								tmp_group_key = map.get(VStatGroupKey).toString();
							}
							if (tm.containsKey(tmp_group_key)) {
								vSum = (double[]) tm.get(tmp_group_key);
							} else {
								vSum = new double[statKey.length];
							}
							vSum[i] += tmp;
							tm.put(tmp_group_key, vSum);

						}
					}
				}
				if (isWStat)
					map.put(WStatKey, dtmp);
			}
			map.remove(null);
		}
		if (isVStat) {
			for (Iterator<Map.Entry<String, Object>> iterator = tm.entrySet().iterator(); iterator.hasNext();) {
				double tmp_total = 0;
				Map.Entry<String, Object> me = iterator.next();
				vSum = (double[]) me.getValue();

				nm = new HashMap<String, Object>();
				nm.put(VStatKey, "<div style='text-align:right;'>合计:</div>");
				if (!ToolsUtil.isEmpty(VStatGroupKey)) {
					nm.put(VStatGroupKey, me.getKey());
				}
				for (int i = 0; i < statKey.length; i++) {
					nm.put(statKey[i], vSum[i]);
					tmp_total += vSum[i];
				}
				if (!ToolsUtil.isEmpty(WStatKey))
					nm.put(WStatKey, tmp_total);
				nm.remove(null);
				m.add(nm);
			}
		}
	}

	private static double getDouble(Object o) {
		double d;
		try {
			d = o == null ? 0.0 : Double.parseDouble(o.toString());
		} catch (Exception e) {
			d = 0.0;
		}
		return d;
	}
}
