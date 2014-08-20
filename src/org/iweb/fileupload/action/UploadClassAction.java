package org.iweb.fileupload.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.fileupload.dao.UploadClassDAO;
import org.iweb.fileupload.domain.ClassFileType;
import org.iweb.fileupload.domain.FileType;
import org.iweb.fileupload.domain.UploadClass;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.test.BeanDebugger;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * @author Kreo
 * 
 */
public class UploadClassAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6933875222440644692L;
	// maximumSize
	private static Log log = LogFactory.getLog(UploadClassAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private UploadClassDAO dao = new UploadClassDAO();

	private UploadClass uclass;
	private List<UploadClass> uclasses;
	private List<FileType> fileTypes;

	private ClassFileType cfileType;
	private List<ClassFileType> classFileType;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public int getRecCount() {
		return recCount;
	}

	public void setRecCount(int recCount) {
		this.recCount = recCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

	public UploadClass getUclass() {
		return uclass;
	}

	public void setUclass(UploadClass uclass) {
		this.uclass = uclass;
	}

	public List<UploadClass> getUclasses() {
		return uclasses;
	}

	public void setUclasses(List<UploadClass> uclasses) {
		this.uclasses = uclasses;
	}

	public ClassFileType getCfileType() {
		return cfileType;
	}

	public void setCfileType(ClassFileType cfileType) {
		this.cfileType = cfileType;
	}

	public List<FileType> getFileTypes() {
		return fileTypes;
	}

	public void setFileTypes(List<FileType> fileTypes) {
		this.fileTypes = fileTypes;
	}

	public List<ClassFileType> getClassFileType() {
		return classFileType;
	}

	public void setClassFileType(List<ClassFileType> classFileType) {
		this.classFileType = classFileType;
	}

	public String getViewFlag() {
		return viewFlag;
	}

	public void setViewFlag(String viewFlag) {
		this.viewFlag = viewFlag;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("UPLOADFILE_CLASS_LIST");
		try {
			map.clear();
			map = ContextHelper.getDefaultRequestMap4Page();
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setUclasses(dao.list(map));
			this.setRecCount(dao.getResultCount());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if ("add".equals(viewFlag)) {
				this.setUclass(null);

				map.clear();
				this.setFileTypes(dao.listFileType(null));
			} else if ("mdy".equals(viewFlag)) {
				if (uclass == null || uclass.getUuid() == null) {
					setMessage("错误操作!");
					throw new Exception("参数丢失,操作失败!");
				} else {
					map.clear();
					map.put("uuid", uclass.getUuid());
					this.setUclass((UploadClass) dao.list(map).get(0));

					map.clear();
					map.put("class_id", this.getUclass().getUuid());
					this.setClassFileType(dao.listClassFileType(map));

					map.clear();
					this.setFileTypes(dao.listFileType(null));
				}
			} else {
				setMessage("错误操作!");
				throw new Exception("参数丢失,操作失败!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("UPLOADFILE_CLASS_ADD");
		try {
			uclass.setUuid(ToolsUtil.getUUID());
			uclass.setLm_user(ContextHelper.getUserLoginTitle());
			uclass.setLm_time(new Date());
			dao.add(uclass);
			setMessage("添加成功!");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 写入失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!add 写入失败:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("UPLOADFILE_CLASS_MDY");
		try {
			uclass.setLm_user(ContextHelper.getUserLoginTitle());
			uclass.setLm_time(new Date());
			dao.save(uclass);
			setMessage("保存成功!ID=" + uclass.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("UPLOADFILE_CLASS_DEL");
		try {
			if (!ToolsUtil.isEmpty(uclass.getUuid())) {
				dao.delete(uclass);
				setMessage("删除成功!ID=" + uclass.getUuid());
			} else {
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!del 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String addRelation() throws Exception {
		ContextHelper.isPermit("UPLOADFILE_CLASS_ADD_RELATION");
		try {
			if (null == classFileType) {
				setMessage("你没有添加任何类型!");
			} else {
				checkRelationList();
				// for (Object obj : classFileType) {
				// System.out.println("=======================================");
				// BeanDebugger.dump(obj);
				// System.out.println("=======================================");
				// }
				dao.addBatchClassFileType((List) classFileType);
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!addRelation 数据添加失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!addRelation 数据添加失败:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String removeRelation() throws Exception {
		ContextHelper.isPermit("UPLOADFILE_CLASS_REMOVE_RELATION");
		try {
			if (ToolsUtil.isEmpty(cfileType.getClass_id()) || ToolsUtil.isEmpty(cfileType.getFiletype_id())) {
				setMessage("错误操作!");
				throw new Exception("参数丢失,操作失败!");
			} else {
				dao.delClassFileType(cfileType);
				uclass = new UploadClass();
				uclass.setUuid(cfileType.getClass_id());
				setMessage("删除成功!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!removeRelation 数据删除失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!removeRelation 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	private void checkRelationList() {
		// 先移除为空的元素
		ToolsUtil.removeNullElement(classFileType);

		// 出现不可预知的BUG,平时正常,有时获取对象时,某几个class_id会丢失,而导致无法插入数据库的错误
		// 所以只能写个过滤器把class_id为空的对象去除
		// 很奇怪的是filetype_id却都能很好的获取
		for (ClassFileType cf : classFileType) {
			if (cf.getClass_id() == null) {
				// 移除class_id为空的元素
				// 很奇怪的一点是为什么会丢失class_id,而且这个BUG经常会发生,所以需要增加一个判断,跳过class_id为空的元素
				classFileType.remove(cf);
			}
		}
	}
}
