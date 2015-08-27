package org.iweb.fileupload.logic;

import org.iweb.sys.ContextHelper;
import org.iweb.sys.ImageUtil;
import org.iweb.sys.OSSUtil_IMG;
import org.iweb.sys.dao.UserDAO;
import org.iweb.sys.domain.User;

public class IUserUploadConfig extends UploadConfig {
	private String message;
	private boolean isUploadOss = true;

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
		if(!ext.equals("jpg")){
			isUploadOss=false;
			message="文件格式必须为：jpg";
		}else{
			
		}
		return "qkj_sign/" + filename;
	}

	@Override
	public boolean isUploadOss() {
		return isUploadOss;
	}

	@Override
	public void fileActionBefore(byte[] in) {
		/*TravelCustomerAction msa = new TravelCustomerAction();
		try {
			message = msa.addCus(in);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		ImageUtil i=new ImageUtil();
		i.disposeImage(src, in, 383, 276, 1);
	}

	@Override
	public void fileActionAfter(byte[] in, String filename, boolean successflag) {
		UserDAO msa = new UserDAO();
		User u=new User();
		if (successflag == true) {
			try {
				if (message != null) {
				}else{
					String userSign=OSSUtil_IMG.default_addr + filename;
					u.setUuid(ContextHelper.getUserLoginInfo().getUuid());
					u.setUser_sign(userSign);
					msa.isaveSign(u);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
