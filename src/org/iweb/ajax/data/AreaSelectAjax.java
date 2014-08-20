package org.iweb.ajax.data;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.dom4j.tree.DefaultAttribute;
import org.iweb.sys.Parameters;

public class AreaSelectAjax extends Ajax {

	private static Log log = LogFactory.getLog(AreaSelectAjax.class);

	private static class Area {
		private final static String xmlFile = Parameters.getAbsolutePath() + "WEB-INF/area.xml";
		private static Area area;

		private Document doc;

		public Document getDoc() {
			return doc;
		}

		public void setDoc(Document doc) {
			this.doc = doc;
		}

		private Area() throws Exception {
			SAXReader reader = new SAXReader();
			File f = new File(xmlFile);
			setDoc(reader.read(f));
		}

		private boolean checkFileExists() {
			return new File(xmlFile).exists();
		}

		public Element getSingleProvince(String provincename) {
			return (Element) getRootElement(doc).selectSingleNode("/address/province[@name='" + provincename + "']");
		}

		public ArrayList<String> getProvinces() throws Exception {
			ArrayList<String> list = new ArrayList<String>();
			Element root = getRootElement(doc);
			List provinceNodes = root.selectNodes("/address/province/@name");
			for (int i = 0, n = provinceNodes.size(); i < n; i++) {
				DefaultAttribute d = (DefaultAttribute) provinceNodes.get(i);
				list.add(d.getValue());
			}
			return list;
		}

		public Element getSingleCity(String provincename, String cityname) {
			return (Element) getRootElement(doc).selectSingleNode(
					"/address/province[@name='" + provincename + "']/city[@name='" + cityname + "']");
		}

		public ArrayList<String> getCities(String provincename) throws Exception {
			ArrayList<String> list = new ArrayList<String>();
			Element root = getRootElement(doc);
			List provinceNodes = root.selectNodes("/address/province[@name='" + provincename + "']/city/@name");
			for (int i = 0, n = provinceNodes.size(); i < n; i++) {
				DefaultAttribute d = (DefaultAttribute) provinceNodes.get(i);
				list.add(d.getValue());
			}
			return list;
		}

		public ArrayList<String> getCountries(String provincename, String city) throws Exception {
			ArrayList<String> list = new ArrayList<String>();
			Element root = getRootElement(doc);
			List provinceNodes = root.selectNodes("/address/province[@name='" + provincename + "']/city[@name='" + city
					+ "']/country/@name");
			for (int i = 0, n = provinceNodes.size(); i < n; i++) {
				DefaultAttribute d = (DefaultAttribute) provinceNodes.get(i);
				list.add(d.getValue());
			}
			return list;
		}

		private Element getRootElement(Document doc) {
			return doc.getRootElement();
		}

		public synchronized static Area getInstance() {
			if (area == null) {
				try {
					area = new Area();
				} catch (Exception e) {
					e.printStackTrace();
					return null;
				}
			}
			if (!area.checkFileExists()) {
				System.out.println("File is not exists!");
				area = null;
			} else {
			}
			return area;
		}
	}

	@Override
	public Object getResult() {
		Object result = null;
		try {
			Area area = Area.getInstance();
			if (parameter.containsKey("type") && "country".equals(parameter.get("type"))
					&& parameter.containsKey("province") && parameter.containsKey("city")) {
				result = area.getCountries((String) parameter.get("province"), (String) parameter.get("city"));
			} else if (parameter.containsKey("type") && "city".equals(parameter.get("type"))
					&& parameter.containsKey("province")) {
				result = area.getCities((String) parameter.get("province"));
			} else if (parameter.containsKey("type") && "province".equals(parameter.get("type"))) {
				result = area.getProvinces();
			} else {
				result = "参数错误!";
			}
			log.info("AreaSelectAjax getResult Success!");
		} catch (Exception e) {
			log.error("AreaSelectAjax getResult Error", e);
		}
		return result;
	}
}
