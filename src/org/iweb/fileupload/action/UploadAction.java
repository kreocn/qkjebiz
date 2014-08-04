package org.iweb.fileupload.action;

import java.io.File;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;

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
		if (filedata == null) {
			// HTML5上传方式判断处理
			if ("application/octet-stream".equals(ContextHelper.getRequest().getContentType())) {
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
				if (buffer.length == 0) {
					err = "未接收到图片!";
				} else {
					// FileUtil.writeFileBinary("D:/aa.jpg", buffer);
					// msg = "file:///D:/aa.jpg";
				}
			} else err = "未接收到图片!";
		} else {
			System.out.println("服务器接收成功!");
			System.out.println(filedata.getName());
			System.out.println(filedata.length());
			System.out.println(filedata.lastModified());
			System.out.println("filedataFileName:" + filedataFileName);
			System.out.println("filedataContentType:" + filedataContentType);
			msg = filedata.getName();
		}
		this.setMessage("{\"err\":\"" + err + "\",\"msg\":\"" + msg + "\"}");
		System.out.println(message);
		return SUCCESS;
	}
}
