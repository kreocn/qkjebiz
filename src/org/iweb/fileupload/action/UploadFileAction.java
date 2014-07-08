package org.iweb.fileupload.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.iweb.fileupload.dao.UploadClassDAO;
import org.iweb.fileupload.dao.UploadFileDAO;
import org.iweb.fileupload.domain.ClassFileType;
import org.iweb.fileupload.domain.FileType;
import org.iweb.fileupload.domain.UploadClass;
import org.iweb.fileupload.domain.UploadFile;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;

public class UploadFileAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 406322051193774706L;
	private static Log log = LogFactory.getLog(UploadFileAction.class);

	private Map<String, Object> map = new HashMap<String, Object>();
	private UploadFileDAO dao = new UploadFileDAO();
	private UploadClassDAO dao2 = new UploadClassDAO();

	private UploadFile file;
	private UploadClass uclass;
	private List<UploadFile> files;
	private List<UploadClass> uclasses;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	// 文件上传字段
	private List<String> allowedTypes;
	private Integer maximumSize;

	private List<File> ufiles;
	private List<String> ufilesFileName;
	private List<String> ufilesContentType;

	private String defaultUnionCode;
	private String saveDir;

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

	public UploadFile getFile() {
		return file;
	}

	public void setFile(UploadFile file) {
		this.file = file;
	}

	public UploadClass getUclass() {
		return uclass;
	}

	public void setUclass(UploadClass uclass) {
		this.uclass = uclass;
	}

	public List<UploadFile> getFiles() {
		return files;
	}

	public void setFiles(List<UploadFile> files) {
		this.files = files;
	}

	public List<UploadClass> getUclasses() {
		return uclasses;
	}

	public void setUclasses(List<UploadClass> uclasses) {
		this.uclasses = uclasses;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getViewFlag() {
		return viewFlag;
	}

	public void setViewFlag(String viewFlag) {
		this.viewFlag = viewFlag;
	}

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

	public Integer getMaximumSize() {
		return maximumSize;
	}

	public void setMaximumSize(Integer maximumSize) {
		this.maximumSize = maximumSize;
	}

	public List<File> getUfiles() {
		return ufiles;
	}

	public void setUfiles(List<File> ufiles) {
		this.ufiles = ufiles;
	}

	public List<String> getUfilesFileName() {
		return ufilesFileName;
	}

	public void setUfilesFileName(List<String> ufilesFileName) {
		this.ufilesFileName = ufilesFileName;
	}

	public List<String> getUfilesContentType() {
		return ufilesContentType;
	}

	public void setUfilesContentType(List<String> ufilesContentType) {
		this.ufilesContentType = ufilesContentType;
	}

	public List<String> getAllowedTypes() {
		return allowedTypes;
	}

	public void setAllowedTypes(List<String> allowedTypes) {
		this.allowedTypes = allowedTypes;
	}

	public String getDefaultUnionCode() {
		return defaultUnionCode;
	}

	public void setDefaultUnionCode(String defaultUnionCode) {
		this.defaultUnionCode = defaultUnionCode;
	}

	public String getSaveDir() {
		return saveDir;
	}

	public void setSaveDir(String saveDir) {
		this.saveDir = saveDir;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("UPLOADFILE_CLASS_LIST");
		try {
			map.clear();
			map = ContextHelper.getDefaultRequestMap4Page();
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			if (file != null) {
				map.putAll(ToolsUtil.getMapByBean(file));
			}
			this.setFiles(dao.list(map));
			this.setUclasses(dao2.list(map));
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
				this.setFile(null);
				map.clear();
				this.setUclasses(dao2.list(map));
			} else if ("mdy".equals(viewFlag)) {
				if (file == null || file.getUuid() == null) {
					setMessage("错误操作!");
					throw new Exception("参数丢失,操作失败!");
				} else {
					map.clear();
					map.put("uuid", file.getUuid());
					this.setFile((UploadFile) dao.list(map).get(0));

					map.clear();
					this.setUclasses(dao2.list(map));
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
		ContextHelper.isPermit("UPLOADFILE_CLASS_MDY");
		try {
			this.configUpload();
			System.out.println("允许的类型为:" + allowedTypes);
			// System.out.println("================================");
			// System.out.println(ufiles);
			if (null == ufiles || ufiles.size() == 0) {

			} else {
				int union_num = uclass.getUnion_num(); // 限制数量
				// System.out.println("得到限制数量为:" + union_num);
				int ufiles_num = ufiles.size(); // 需上传文件数量
				// System.out.println("得到需上传文件数量为:" + ufiles_num);
				// 得到当前已有的文件,并统计数量
				map.clear();
				map.put("class_id", uclass.getUuid());
				map.put("union_code", this.getDefaultUnionCode());
				this.setFiles(dao.list(map));
				int exist_files_num = this.getFiles().size(); // 已有文件数量
				// System.out.println("得到已有文件数量为:" + exist_files_num);

				int need_del_num = 0; // 需删除数量
				int need_insert_num = 0; // 需插入数量
				if (union_num == 0) {
					need_del_num = 0;
					need_insert_num = ufiles_num;
				} else if (ufiles_num > union_num) { // 上传文件数量大于限制,则只有部分插入,丢弃其他多余文件(按上传顺序)
					need_del_num = exist_files_num;
					need_insert_num = union_num;
				} else if (ufiles_num + exist_files_num <= union_num) { // 上传文件可以全部插入,不超过限制
					need_del_num = 0;
					need_insert_num = ufiles_num;
				} else { // 可以插入,但是要丢弃数据库中本身存在的一部分数据
					need_del_num = exist_files_num - (union_num - ufiles_num);
					need_insert_num = ufiles_num;
				}

				// 启用事务
				dao.startTransaction();
				// 开始上传并保存文件
				for (int i = 0; i < need_insert_num; i++) {
					File f = ufiles.get(i);
					// System.out.println("File Name:" + f.getName());
					// System.out.println("File Size:" + f.length());
					// System.out.println("File ufilesFileName:" + ufilesFileName.get(i));
					// System.out.println("File ufilesContentType:" +
					// ufilesContentType.get(i));
					// 如果类型允许,则上传
					if (!(allowedTypes.contains(ufilesContentType.get(i)))) {
						// 上传失败则可以少删除原本一个文件
						this.setMessage(this.getMessage() + ufilesFileName.get(0) + " 上传类型[" + ufilesContentType.get(0)
								+ "]不允许,已被丢弃");
						need_del_num--;
					} else if (f.length() > this.getMaximumSize()) {
						this.setMessage(this.getMessage() + "\n" + ufilesFileName.get(i) + " 超出最大限制,已被丢弃");
						need_del_num--;
					} else {
						UploadFile uf = new UploadFile();
						uf.setUuid(ToolsUtil.getUUID());
						uf.setClass_id(uclass.getUuid());
						uf.setTitle(ufilesFileName.get(i));
						// 是否自动重命名
						if ("true".equals(Parameters.getConfig().get("isAutoRename"))) {
							// 重命名规则
							// uf.setFile_name(uclass.getC_id() + ToolsUtil.getUUID()+
							// getFileExtention(ufilesFileName.get(i)));
							uf.setFile_name(ToolsUtil.getUUID() + getFileExtention(ufilesFileName.get(i)));
						} else {
							uf.setFile_name(ufilesFileName.get(i));
						}
						uf.setFile_size(new StringBuffer().append(f.length()).toString());
						uf.setFile_type(ufilesContentType.get(i));
						uf.setLm_time(new Date());
						uf.setLm_user(ContextHelper.getUserLoginTitle());
						uf.setUnion_code(this.getDefaultUnionCode());
						dao.add(uf);

						InputStream is = new FileInputStream(f);
						File destFile = new File(saveDir, uf.getFile_name());
						OutputStream os = new FileOutputStream(destFile);
						byte[] buffer = new byte[400];
						int length = 0;
						while ((length = is.read(buffer)) > 0) {
							os.write(buffer, 0, length);
						}
						is.close();
						os.close();
					}
				}

				// 删除文件
				if (need_del_num > 0) {
					for (int i = 0; i < need_del_num; i++) {
						UploadFile uf = files.get(exist_files_num - i - 1);
						dao.delete(uf);
						File df = new File(saveDir, uf.getFile_name());
						df.delete();
						uf = null;
					}
				}
				dao.commitTransaction();
			}
			// System.out.println("================================");
			// file.setLm_user(ContextHelper.getUserLoginTitle());
			// file.setLm_time(new Date());
			// dao.save(file);
			// setMessage("保存成功!ID=" + file.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTraceHTML(e));
		} finally {
			dao.endTransaction();
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("UPLOADFILE_CLASS_ADD");
		try {
			this.setMessage("");
			this.configUpload();
			System.out.println("允许的类型为:" + allowedTypes);
			if (!(ufiles == null || ufiles.size() == 0)) {
				File f = ufiles.get(0);
				if (!(allowedTypes.contains(ufilesContentType.get(0)))) {
					// 上传失败则可以少删除原本一个文件
					this.setMessage(this.getMessage() + ufilesFileName.get(0) + " 上传类型[" + ufilesContentType.get(0)
							+ "]不允许,已被丢弃");
				} else if (f.length() > this.getMaximumSize()) {
					this.setMessage(this.getMessage() + ufilesFileName.get(0) + " 超出最大限制,已被丢弃");
				} else {
					UploadFile uf = new UploadFile();
					uf.setUuid(file.getUuid());
					uf.setClass_id(uclass.getUuid());
					uf.setTitle(ufilesFileName.get(0));
					// 是否自动重命名
					if ("true".equals(Parameters.getConfig().get("isAutoRename"))) {
						uf.setFile_name(ToolsUtil.getUUID() + getFileExtention(ufilesFileName.get(0)));
					} else {
						uf.setFile_name(ufilesFileName.get(0));
					}
					uf.setFile_size(new StringBuffer().append(f.length()).toString());
					uf.setFile_type(ufilesContentType.get(0));
					uf.setLm_time(new Date());
					uf.setLm_user(ContextHelper.getUserLoginTitle());
					uf.setUnion_code(this.getDefaultUnionCode());
					dao.save(uf);

					InputStream is = new FileInputStream(f);
					File destFile = new File(saveDir, uf.getFile_name());
					OutputStream os = new FileOutputStream(destFile);
					byte[] buffer = new byte[400];
					int length = 0;
					while ((length = is.read(buffer)) > 0) {
						os.write(buffer, 0, length);
					}
					is.close();
					os.close();
				}
			}
			this.setMessage(this.getMessage() + "\n [成功完成修改]");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 写入失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!add 写入失败:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("UPLOADFILE_CLASS_DEL");
		try {
			if (!ToolsUtil.isEmpty(file.getUuid())) {
				map.clear();
				map.put("uuid", file.getUuid());
				file = (UploadFile) dao.list(map).get(0);
				// BeanDebugger.dump(file);
				uclass = new UploadClass();
				uclass.setUuid(file.getClass_id());
				this.configUpload();
				dao.delete(file);
				File df = new File(saveDir, file.getFile_name());
				df.delete();
				setMessage("删除成功!ID=" + file.getUuid());
			} else {
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!del 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public InputStream getDownloadFile() throws Exception {
		InputStream is = null;
		try {
			if (!ToolsUtil.isEmpty(file.getUuid())) {
				map.clear();
				map.put("uuid", file.getUuid());
				file = (UploadFile) dao.list(map).get(0);
				uclass = new UploadClass();
				uclass.setUuid(file.getClass_id());
				this.configUpload();
				is = new FileInputStream(this.getSaveDir() + File.separator + file.getFile_name());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return is;
	}

	public String download() throws Exception {
		return SUCCESS;
	}

	/**
	 * 清除临时文件夹中的文件
	 * 
	 * @return
	 * @throws Exception
	 */
	public String cleanTempDir() throws Exception {
		return SUCCESS;
	}

	/**
	 * 清除无关联的文件
	 * 
	 * @return
	 * @throws Exception
	 */
	public String cleanRedundantFile() throws Exception {
		return SUCCESS;
	}

	private void configUpload() throws Exception {
		try {
			if (uclass == null || uclass.getUuid() == null) {
				setMessage("错误操作!");
				throw new Exception("参数丢失,操作失败!");
			} else {
				if (file == null) {
					file = new UploadFile();
				}
				file.setClass_id(uclass.getUuid());
				map.clear();
				map.put("uuid", uclass.getUuid());
				this.setUclass((UploadClass) dao2.list(map).get(0));
				// 得到最大容量限制
				this.setMaximumSize(this.getUclass().getMax_size());
				// 得到外键类型从而得到外键
				if ("USER".equals(uclass.getUnion_type())) {
					this.setDefaultUnionCode(ContextHelper.getUserLoginTitle());
				} else {
					this.setDefaultUnionCode(ServletActionContext.getRequest().getParameter("default_union_code"));
				}
				// 设置文件保存的目录
				this.setSaveDir(Parameters.getConfig().get("fileUploadRoot") + File.separator + uclass.getC_dir());
				File f = new File(Parameters.getConfig().get("fileUploadRoot"));
				if (f.exists()) {
					new File(this.getSaveDir()).mkdirs();
				} else {
					throw new Exception(this.getClass().getName() + "!默认上传文件目录不存在,上传失败!");
				}
				// 得到此分类允许上传的文件类型
				map.clear();
				map.put("class_id", uclass.getUuid());
				List<ClassFileType> ftlist = dao2.listClassFileType(map);
				allowedTypes = new ArrayList<String>();
				for (ClassFileType ft : ftlist) {
					allowedTypes.add(ft.getFiletype_mime_type());
				}
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!configUpload 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!configUpload 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
	}

	/**
	 * 从文件名中得到扩展名
	 * 
	 * @return
	 */
	private String getFileExtention(String file_name) {
		return file_name.substring(file_name.lastIndexOf("."));
	}
}
