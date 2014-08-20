package org.iweb.sys;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import jxl.write.NumberFormats;
import jxl.write.WritableCellFormat;

public class Excel {

	private String[] defaultCols;

	public String[] getDefaultCols() {
		return defaultCols;
	}

	/**
	 * 
	 * @param file
	 *            需要写入的xls文件
	 * @param title
	 *            sheet名称
	 * @param resultList
	 *            iBatis得到的resultList List&lt;Bean&gt;
	 * @param cols_name
	 *            上述bean的属性名
	 * @param cols_title
	 *            与属性名对应的名称(作为excel的标题)
	 * @throws Exception
	 */
	public void getExcel(String path, String file_name, String title, List<Object> resultList, String[] cols_name,
			String[] cols_title) throws Exception {
		if (cols_title == null) {
			cols_title = cols_name;
		}

		File p = new File(path);
		if (!p.exists() && p.isDirectory()) {
			p.mkdirs();
		}

		File file = new File(path + file_name);
		if (file.exists()) {
			file.delete();
		}
		jxl.write.WritableWorkbook excel = jxl.Workbook.createWorkbook(file);
		jxl.write.WritableSheet sheet = excel.createSheet(title, 0);
		// 写入excel的标题
		for (int i = 0; i < cols_title.length; i++) {
			jxl.write.Label col_title = new jxl.write.Label(i, 0, cols_title[i]);
			sheet.addCell(col_title);
		}
		// 开始写入数据
		for (int i = 0, d = resultList.size(); i < d; i++) {
			Map<String, Object> t_map = ToolsUtil.getMapByBean(resultList.get(i));
			if (i == 0) { // 记录defaultCols(数据库自带的column_name),只记录一次
				defaultCols = (String[]) t_map.keySet().toArray();
			}
			for (int j = 0; j < cols_name.length; j++) {
				Object tmp = t_map.get(cols_name[j]);
				if (tmp == null) {
					jxl.write.Label col_value = new jxl.write.Label(j, i + 1, "");
					sheet.addCell(col_value);
				} else if ("java.lang.Integer".equals(tmp.getClass().getName())) {
					jxl.write.Number integerCell = new jxl.write.Number(j, i + 1, (Integer) tmp,
							new WritableCellFormat(NumberFormats.INTEGER));
					sheet.addCell(integerCell);
				} else if ("java.lang.Double".equals(tmp.getClass().getName())) {
					jxl.write.Number doubleCell = new jxl.write.Number(j, i + 1, (Double) tmp,
							new WritableCellFormat(new jxl.write.NumberFormat("#.####")));
					sheet.addCell(doubleCell);
				} else if ("java.util.Date".equals(tmp.getClass().getName())) {
					jxl.write.DateTime dateCell = new jxl.write.DateTime(j, i + 1, (java.util.Date) tmp,
							new WritableCellFormat(new jxl.write.DateFormat("yyyy-MM-dd hh:mm:ss")));
					sheet.addCell(dateCell);
				} else {
					jxl.write.Label stringCell = new jxl.write.Label(j, i + 1, (String) tmp);
					sheet.addCell(stringCell);
				}
			}
		}
		excel.write();
		excel.close();
	}

	/**
	 * 
	 * @param title
	 *            sheet名称
	 * @param resultList
	 *            iBatis得到的resultList List&lt;Bean&gt;
	 * @param cols_name
	 *            上述bean的属性名
	 * @param cols_title
	 *            与属性名对应的名称(作为excel的标题)
	 * @throws Exception
	 */
	public InputStream getExcel(String title, List<Object> resultList, String[] cols_name, String[] cols_title) {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		try {
			// jxl.write.WritableWorkbook workbook = jxl.Workbook.createWorkbook(baos);
			// if (cols_title == null) {
			// cols_title = cols_name;
			// }

			jxl.write.WritableWorkbook excel = jxl.Workbook.createWorkbook(baos);
			jxl.write.WritableSheet sheet = excel.createSheet(title, 0);
			// 写入excel的标题

			WritableCellFormat integerFormat = new WritableCellFormat(NumberFormats.INTEGER);
			WritableCellFormat doubleFormat = new WritableCellFormat(new jxl.write.NumberFormat("#.####"));
			WritableCellFormat dataFormat = new WritableCellFormat(new jxl.write.DateFormat("yyyy-MM-dd hh:mm:ss"));
			// 开始写入数据
			for (int i = 0, d = resultList.size(); i < d; i++) {
				Map<String, Object> t_map = ToolsUtil.getMapByBean(resultList.get(i));
				if (i == 0) { // 记录defaultCols(数据库自带的column_name),只记录一次
					Object[] t_o_a = t_map.keySet().toArray();
					defaultCols = new String[t_o_a.length];
					for (int j = 0; j < t_o_a.length; j++) {
						defaultCols[j] = t_o_a[j].toString();
					}
					if (cols_name == null) {
						cols_name = defaultCols;
					}
					if (cols_title == null) {
						cols_title = cols_name;
					}
					for (int j = 0; j < cols_title.length; j++) {
						jxl.write.Label col_title = new jxl.write.Label(j, 0, cols_title[j]);
						sheet.addCell(col_title);
					}
				}
				for (int j = 0; j < cols_name.length; j++) {
					Object tmp = t_map.get(cols_name[j]);
					if (tmp == null) {
						jxl.write.Label col_value = new jxl.write.Label(j, i + 1, "");
						sheet.addCell(col_value);
					} else if ("java.lang.Integer".equals(tmp.getClass().getName())) {
						jxl.write.Number integerCell = new jxl.write.Number(j, i + 1, (Integer) tmp, integerFormat);
						sheet.addCell(integerCell);
					} else if ("java.lang.Double".equals(tmp.getClass().getName())) {
						jxl.write.Number doubleCell = new jxl.write.Number(j, i + 1, (Double) tmp, doubleFormat);
						sheet.addCell(doubleCell);
					} else if ("java.util.Date".equals(tmp.getClass().getName())) {
						jxl.write.DateTime dateCell = new jxl.write.DateTime(j, i + 1, (java.util.Date) tmp,
								dataFormat);
						sheet.addCell(dateCell);
					} else {
						jxl.write.Label stringCell = new jxl.write.Label(j, i + 1, (String) tmp);
						sheet.addCell(stringCell);
					}
				}
			}
			excel.write();
			excel.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ByteArrayInputStream(baos.toByteArray());
	}
}
