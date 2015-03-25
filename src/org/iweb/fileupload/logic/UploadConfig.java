package org.iweb.fileupload.logic;

import java.util.Date;

import org.iweb.sys.DateUtil;
import org.iweb.sys.OSSUtil_IMG;
import org.iweb.sys.ToolsUtil;

public class UploadConfig {

	public String getPermitExtImages() {
		return "jpg,JPG,jpeg,JPEG,gif,GIF,png,PNG,bmp,BMP";
	}

	public String getPermitExtFiles() {
		return "txt,TXT,zip,ZIP,7z,7Z,rar,RAR,doc,DOC,docx,DOCX,xls,XLS,xlsx,XLSX,ppt,PPT,pptx,PPTX";
	}

	public int getPermitImageLength() {
		return 512000;
	}

	public int getPermitFileLength() {
		return 104857600;
	}

	public boolean isAutoRename() {
		return true;
	}

	public boolean isUploadOss() {
		return true;
	}

	public boolean isReName() {
		return true;
	}

	public String getMessage(String filename, String err) {
		if (ToolsUtil.isEmpty(filename)) {
			filename = "";
		} else {
			filename = "!" + OSSUtil_IMG.default_addr + filename;
		}
		return "{\"err\":\"" + err + "\",\"msg\":\"" + filename + "\"}";
	}

	public String getReNameRule(String filename, String ext) {
		String prefix = "qkjebiz/";
		try {
			prefix += DateUtil.getDateString(new Date(), "yyyy-MM") + "/";
		} catch (Exception e) {
		}
		return prefix + ToolsUtil.getTimeTimeMillis() + "_" + ToolsUtil.getRandomCode(10) + '.' + ext;
	}

	public void fileActionBefore(byte[] buffer) {

	}

	public void fileActionAfter(byte[] buffer, String filename, boolean successFlag) {

	}
}
