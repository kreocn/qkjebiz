package org.iweb.fileupload.logic;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

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
	
		ByteArrayInputStream img = new ByteArrayInputStream(in);    //将b作为输入流；
		BufferedImage image;
		try {
			image = ImageIO.read(img);
			
			BufferedImage tempImg = new BufferedImage(383, 276, BufferedImage.TYPE_INT_RGB); // 根据原图的大小生成空白画布
			Graphics2D g = tempImg.createGraphics();
			g.setColor(Color.white);
			g.fillRect(0, 0, 383, 276);
			g.drawImage(image, 0, 0, 383, 276,  Color.white, null);
			g.dispose();

			BufferedImage newImg = new BufferedImage(383, 276,  BufferedImage.TYPE_INT_RGB);
			// 对图片进行缩小
			newImg.getGraphics().drawImage(tempImg.getScaledInstance(383, 276, Image.SCALE_SMOOTH), 0, 0, null);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}     //将in作为输入流，读取图片存入image中，而这里in可以为ByteArrayInputStream();
		
		
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
