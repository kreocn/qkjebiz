package org.iweb.fileupload.logic;

import org.iweb.sys.OSSUtil_IMG;
import org.iweb.sys.ToolsUtil;
import org.iweb.sysvip.action.MemberStockAction;

public class MemberStockUploadConfig extends UploadConfig {
	private String message;

	@Override
	public String getMessage(String filename, String err) {
		if (message != null) {
			err = message;
		}
		if (err == null || err.equals("") || err.equals("null")) {
			return "上传成功";
		} else {
			return err;
		}

	}

	@Override
	public String getReNameRule(String filename, String ext) {
		return "memberStock/" + ToolsUtil.getTimeTimeMillis() + "_" + ToolsUtil.getRandomCode(10) + '.' + ext;
	}

	@Override
	public boolean isUploadOss() {
		return true;
	}

	@Override
	public void fileActionBefore(byte[] in) {
		MemberStockAction msa = new MemberStockAction();
		try {
			message = msa.lead(in);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void fileActionAfter(byte[] in, String filename, boolean successflag) {
		MemberStockAction msa = new MemberStockAction();
		if (successflag == true) {
			try {
				if (message != null) {
					msa.history("!" + OSSUtil_IMG.default_addr + filename, 1);
				} else {
					msa.history("!" + OSSUtil_IMG.default_addr + filename, 0);
				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
