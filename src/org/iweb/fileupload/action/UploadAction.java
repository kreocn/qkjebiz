package org.iweb.fileupload.action;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
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

	public String put() throws Exception {
		// {"err":"","msg":{"url":"200906030521128703.jpg","localfile":"test.jpg","id":"1"}}
		// {"err":"","msg":"200906030521128703.gif"}
		err = "";
		msg = "";
		InputStream in = new ByteArrayInputStream(new byte[0]);
		Long contentLength = 0l;

		// 获得上传文件的文件流InputStream
		if (filedata == null && "application/octet-stream".equals(ContextHelper.getRequest().getContentType())) {
			// HTML5上传方式判断处理
			String dispoString = ContextHelper.getRequest().getHeader("Content-Disposition");
			int iFindStart = dispoString.indexOf("filename=") + 10;
			int iFindEnd = dispoString.indexOf("\"", iFindStart);
			this.setFiledataFileName(dispoString.substring(iFindStart, iFindEnd));

			int i = ContextHelper.getRequest().getContentLength();
			byte buffer[] = new byte[i];
			int j = 0;
			while (j < i) {
				int k = ContextHelper.getRequest().getInputStream().read(buffer, j, i - j);
				j += k;
			}
			if (buffer.length > 0) {
				contentLength = (long) buffer.length;
				in = new ByteArrayInputStream(buffer);
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
			in = new FileInputStream(filedata);
		}
		if (contentLength > 0) {
			// 生成随机文件名
			String extensionName = filedataFileName.substring(filedataFileName.lastIndexOf(".") + 1);
			String filename = "qkjebiz/" + ToolsUtil.getTimeTimeMillis() + "_" + ToolsUtil.getRandomCode(10) + '.' + extensionName;
			// 上传到阿里云存储
			OSSUtil_IMG.uploadFile(filename, in, contentLength);
			// 返回图片地址
			msg = "http://images.qkjchina.com/" + filename;

			log.info("上传文件成功:" + msg);
		} else {
			err = "未接收到图片!";
			log.info("上传文件失败:" + err);
		}

		// 关闭文件流
		try {
			in.close();
			in = null;
		} catch (Exception e) {
		}

		this.setMessage("{\"err\":\"" + err + "\",\"msg\":\"" + msg + "\"}");
		return SUCCESS;
	}
}
