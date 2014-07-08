package org.iweb.fileupload.dao;

import java.util.List;
import java.util.Map;

import org.iweb.fileupload.domain.ClassFileType;
import org.iweb.sys.AbstractDAO;

public class UploadClassDAO extends AbstractDAO {
	public List list(Map<String, Object> map) {
		return super.list("upload_getClass", map);
	}

	public void add(Object parameters) {
		super.add("upload_addClass", parameters);
	}

	public void save(Object parameters) {
		super.save("upload_mdyClass", parameters);
	}

	public void delete(Object parameters) {
		super.delete("upload_delClass", parameters);
	}

	public List listClassFileType(Map<String, Object> map) {
		return super.list("upload_getClassFileType", map);
	}

	public void addBatchClassFileType(List<Object> parameters) {
		super.batchStatment("upload_addClassFileType", parameters, true);
	}

	public void delClassFileType(Object parameters) {
		super.delete("upload_delClassFileType", parameters);
	}

	public List listFileType(Map<String, Object> map) {
		return super.list("upload_getFileType", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
