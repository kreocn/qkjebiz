package org.iweb.fileupload.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class UploadFileDAO extends AbstractDAO {
	public List list(Map<String, Object> map) {
		return super.list("upload_getFiles", map);
	}

	public void add(Object parameters) {
		super.add("upload_addFile", parameters);
	}

	public void save(Object parameters) {
		super.save("upload_mdyFile", parameters);
	}

	public void delete(Object parameters) {
		super.delete("upload_delFile", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
