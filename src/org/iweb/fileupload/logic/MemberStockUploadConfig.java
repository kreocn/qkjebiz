package org.iweb.fileupload.logic;

import java.io.InputStream;

import org.iweb.sys.ToolsUtil;
import org.iweb.sysvip.action.MemberStockAction;

public class MemberStockUploadConfig extends UploadConfig {
	private String message;
	@Override
	public String getMessage(String filename, String err) {
		if(message!=null){
			err=message;
		}
		if(err==null || err.equals("") || err.equals("null")){
			return "上传成功";
		}else{
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
	public void fileActionBefore(InputStream in) {
		System.out.println("现在要对文件进行操作了!");
		MemberStockAction msa=new MemberStockAction();
		try {
			message=msa.lead(in);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void fileActionAfter(InputStream in,String filename,boolean successflag) {
		System.out.println("现在又要对文件进行操作了! +10086");
		MemberStockAction msa=new MemberStockAction();
		if(successflag==true){
			try {
				msa.history("!http://images01.qkjchina.com/"+filename);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
