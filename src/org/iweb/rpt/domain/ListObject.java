package org.iweb.rpt.domain;

/**
 * 专门给HTML List(select radio checkbox)写的domain
 * 
 */
public class ListObject {
	private String key;
	private String value;

	public ListObject() {
	}

	public ListObject(String key, String value) {
		this.key = key;
		this.value = value;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}
