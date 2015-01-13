package org.iweb.fileupload.logic;

import java.io.InputStream;

import org.iweb.sys.ToolsUtil;

public class MemberStockUploadConfig extends UploadConfig {
	@Override
	public String getMessage(String filename, String err) {
		return "上传成功";
	}

	@Override
	public String getReNameRule(String filename, String ext) {
		return "memberStock/" + ToolsUtil.getTimeTimeMillis() + "_" + ToolsUtil.getRandomCode(10) + '.' + ext;
	}

	@Override
	public boolean isUploadOss() {
		return false;
	}

	@Override
	public void fileActionBefore(InputStream in) {
		System.out.println("现在要对文件进行操作了!");
	}

	@Override
	public void fileActionAfter(InputStream in) {
		System.out.println("现在又要对文件进行操作了! +10086");
	}
}
