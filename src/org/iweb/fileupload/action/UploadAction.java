package org.iweb.fileupload.action;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.fileupload.logic.UploadConfig;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.NumberUtil;
import org.iweb.sys.OSSUtil_IMG;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;

public class UploadAction extends ActionSupport {
	private static final long serialVersionUID = 406322051193774706L;
	private static Log log = LogFactory.getLog(UploadAction.class);

	private File filedata;
	private String filedataContentType;
	private String filedataFileName;
	private String err;
	private String msg;
	private String message;

	private byte[] buffer;

	private UploadConfig config;
	private String initConfig = "";
	private boolean successflag = false;

	public String getInitConfig() {
		return initConfig;
	}

	public void setInitConfig(String initConfig) {
		this.initConfig = initConfig;
	}

	public void setConfig(UploadConfig config) {
		this.config = config;
	}

	public String getErr() {
		return err;
	}

	public void setErr(String err) {
		this.err = err;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getFiledataFileName() {
		return filedataFileName;
	}

	public void setFiledataFileName(String filedataFileName) {
		this.filedataFileName = filedataFileName;
	}

	public String getFiledataContentType() {
		return filedataContentType;
	}

	public void setFiledataContentType(String filedataContentType) {
		this.filedataContentType = filedataContentType;
	}

	public File getFiledata() {
		return filedata;
	}

	public void setFiledata(File filedata) {
		this.filedata = filedata;
	}

	@Override
	public void validate() {
		UploadConfig uc = null;
		if (!ToolsUtil.isEmpty(initConfig)) {
			try {
				uc = (UploadConfig) Class.forName("org.iweb.fileupload.logic." + initConfig + "UploadConfig").newInstance();
			} catch (Exception e) {
			}
		}
		if (uc == null) {
			uc = new UploadConfig();
		}
		this.setConfig(uc);
		log.info("初始化UploadConfig成功,初始化类:" + uc.getClass().getName());
	}

	public String put() throws Exception {
		// {"err":"","msg":{"url":"200906030521128703.jpg","localfile":"test.jpg","id":"1"}}
		// {"err":"","msg":"200906030521128703.gif"}
		err = "";
		msg = "";
		Long contentLength = 0l;
		String filename = "";

		// 获得上传文件的文件流InputStream
		if (filedata == null && "application/octet-stream".equals(ContextHelper.getRequest().getContentType())) {
			// HTML5上传方式判断处理
			String dispoString = ContextHelper.getRequest().getHeader("Content-Disposition");
			int iFindStart = dispoString.indexOf("filename=") + 10;
			int iFindEnd = dispoString.indexOf("\"", iFindStart);
			this.setFiledataFileName(dispoString.substring(iFindStart, iFindEnd));

			int i = ContextHelper.getRequest().getContentLength();
			// byte buffer[] = new byte[i];
			buffer = new byte[i];
			int j = 0;
			while (j < i) {
				int k = ContextHelper.getRequest().getInputStream().read(buffer, j, i - j);
				j += k;
			}
			if (buffer.length > 0) {
				contentLength = (long) buffer.length;
				// in = new ByteArrayInputStream(buffer);
				// FileUtil.writeFileBinary("D:/aa.jpg", buffer);
				// msg = "file:///D:/aa.jpg";
			}
		} else if (filedata != null) {
			/*
			 * System.out.println("服务器接收成功!");
			 * System.out.println(filedata.getName());
			 * System.out.println(filedata.length());
			 * System.out.println(filedata.lastModified());
			 * System.out.println("filedataFileName:" + filedataFileName);
			 * System.out.println("filedataContentType:" + filedataContentType);
			 */
			// msg = filedata.getName();
			contentLength = filedata.length();
			// in = new FileInputStream(filedata);
			buffer = ToolsUtil.File2byte(filedata);
		}
		if (contentLength > 0 && buffer.length > 0) {
			// 生成随机文件名
			String extensionName = filedataFileName.substring(filedataFileName.lastIndexOf(".") + 1);
			// 限制图片大小为500K
			if (!ToolsUtil.isIn(extensionName, config.getPermitExtImages(), ",") && !ToolsUtil.isIn(extensionName, config.getPermitExtFiles(), ",")) {
				err = "此文件类型[" + extensionName + "]不允许上传";
			} else if (ToolsUtil.isIn(extensionName, config.getPermitExtImages(), ",") && contentLength > config.getPermitImageLength()) {
				err = "图片超过最大限制,不能超过" + NumberUtil.convertSize(config.getPermitImageLength());
			} else if (ToolsUtil.isIn(extensionName, config.getPermitExtFiles(), ",") && contentLength > config.getPermitFileLength()) {
				err = "文件超过最大限制,不能超过" + NumberUtil.convertSize(config.getPermitFileLength());
			} else {

				config.fileActionBefore(buffer);

				filename = filedataFileName;
				if (config.isAutoRename()) {
					filename = config.getReNameRule(filedataFileName, extensionName);
				}
				if (config.isUploadOss()) {
					// 上传到阿里云存储
					// ByteArrayInputStream
					InputStream bin = new ByteArrayInputStream(buffer);
					if (OSSUtil_IMG.uploadFile(filename, bin, contentLength)) {
						msg = "!" + OSSUtil_IMG.default_addr + filename;
						log.info("上传文件->OSS成功:" + msg);
						successflag = true;
					} else {
						err = "上传文件失败,无法连接OSS服务器.";
						log.info(err);
					}
					// 返回图片地址
					try {
						bin.close();
						bin = null;
					} catch (Exception e) {
						// TODO: handle exception
						log.warn("inupload close error", e);
					}

				} else {
					log.info("文件不上传到OSS");
				}
				config.fileActionAfter(buffer, filename, successflag);
			}
		} else {
			err = "未接收到图片!";
			log.info("上传文件失败:" + err);
		}

		// 关闭文件流
		/*
		 * try {
		 * in.close();
		 * in = null;
		 * } catch (Exception e) {
		 * }
		 */

		this.setMessage(config.getMessage(filename, err));
		return SUCCESS;
	}

}
