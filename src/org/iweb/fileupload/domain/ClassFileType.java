package org.iweb.fileupload.domain;

public class ClassFileType {
	private String class_id;
	private String filetype_id;

	// 一下为非数据库字段
	private String class_name;
	private String filetype_title;
	private String filetype_extension;
	private String filetype_mime_type;

	public String getClass_id() {
		return class_id;
	}

	public void setClass_id(String class_id) {
		this.class_id = class_id;
	}

	public String getFiletype_id() {
		return filetype_id;
	}

	public void setFiletype_id(String filetype_id) {
		this.filetype_id = filetype_id;
	}

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public String getFiletype_title() {
		return filetype_title;
	}

	public void setFiletype_title(String filetype_title) {
		this.filetype_title = filetype_title;
	}

	public String getFiletype_extension() {
		return filetype_extension;
	}

	public void setFiletype_extension(String filetype_extension) {
		this.filetype_extension = filetype_extension;
	}

	public String getFiletype_mime_type() {
		return filetype_mime_type;
	}

	public void setFiletype_mime_type(String filetype_mime_type) {
		this.filetype_mime_type = filetype_mime_type;
	}

}
