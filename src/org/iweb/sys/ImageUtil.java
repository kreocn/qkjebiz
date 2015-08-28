package org.iweb.sys;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import com.sun.image.codec.jpeg.ImageFormatException;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class ImageUtil {

	/** 允许最大宽度 */
	public static int MAX_WIDTH = 230;

	/** 允许最大高度 */
	public static int MAX_HEIGHT = 240;

	/**
	 * 对图片进行缩小处理
	 * 
	 * @param srcImage
	 * @param outImgFile
	 * @param new_w
	 * @param new_h
	 * @param per
	 */
	private static void disposeImage(BufferedImage srcImage, File outImgFile, int new_w, int new_h, float per) {

		// BufferedImage src = getImage(srcImgPath); // 得到图片

		int old_w = srcImage.getWidth(); // 得到源图宽
		int old_h = srcImage.getHeight(); // 得到源图长

		/* 在新的画布上生成原图的缩略图 */
		BufferedImage tempImg = new BufferedImage(old_w, old_h, BufferedImage.TYPE_INT_RGB); // 根据原图的大小生成空白画布
		Graphics2D g = tempImg.createGraphics();
		g.setColor(Color.white);
		g.fillRect(0, 0, old_w, old_h);
		g.drawImage(srcImage, 0, 0, old_w, old_h, Color.white, null);
		g.dispose();

		BufferedImage newImg = new BufferedImage(new_w, new_h, BufferedImage.TYPE_INT_RGB);
		// 对图片进行缩小
		newImg.getGraphics().drawImage(tempImg.getScaledInstance(new_w, new_h, Image.SCALE_SMOOTH), 0, 0, null);
		// 输出图片文件
		outputImage(newImg, outImgFile, per);
	}

	/**
	 * 图片压缩，通过指定的长度、宽度以及质量比进行压缩
	 * 
	 * @param srcImgFile
	 *            原图片文件
	 * @param outImgFile
	 *            目标图片文件
	 * @param new_w
	 *            新的图片长度
	 * @param new_h
	 *            新的图片宽度
	 * @param per
	 *            质量比（取值为0-1）
	 */
	public static void compress(File srcImgFile, File outImgFile, int new_w, int new_h, float per) {
		BufferedImage src = getImage(srcImgFile); // 得到图片
		disposeImage(src, outImgFile, new_w, new_h, per);
	}

	/**
	 * 图片压缩，通过指定的与原图的比例以及质量比进行压缩
	 * 
	 * @param srcImgFile
	 *            原图片文件
	 * @param outImgFile
	 *            目标图片文件
	 * @param ratio
	 *            与原来图片的尺寸比
	 * @param per
	 *            质量比（取值为0-1）
	 */
	public static void compress(File srcImgFile, File outImgFile, float ratio, float per) {
		BufferedImage src = getImage(srcImgFile); // 得到图片
		int old_w = src.getWidth(); // 得到源图宽
		int old_h = src.getHeight(); // 得到源图长
		// 根据图片尺寸压缩比得到新图的尺寸
		int new_w = (int) Math.round(old_w * ratio);
		int new_h = (int) Math.round(old_h * ratio);
		disposeImage(src, outImgFile, new_w, new_h, per);
	}

	/**
	 * 图片压缩，通过指定的最大长度以及质量比进行压缩，生成的图片的长度和宽度中的大者等于该最大长度
	 * 
	 * @param srcImgFile
	 *            原图片文件
	 * @param outImgFile
	 *            目标图片文件
	 * @param maxLength
	 *            最大边长
	 * @param per
	 *            质量比（取值为0-1）
	 */
	public static void compress(File srcImgFile, File outImgFile, int maxLength, float per) {
		BufferedImage src = getImage(srcImgFile); // 得到图片
		int old_w = src.getWidth(); // 得到源图宽
		int old_h = src.getHeight(); // 得到源图长

		int new_w = 0; // 得到源图长
		int new_h = 0; // 新图的宽

		if (old_w > old_h) {
			// 图片要缩放的比例
			new_w = maxLength;
			new_h = (int) Math.round(old_h * ((float) maxLength / old_w));
		} else {
			new_w = (int) Math.round(old_w * ((float) maxLength / old_h));
			new_h = maxLength;
		}
		disposeImage(src, outImgFile, new_w, new_h, per);
	}

	/**
	 * 将指定图片读取到BufferedImage
	 * 
	 * @param srcImgPath
	 *            图片路径
	 * @return
	 */
	public static BufferedImage getImage(String srcImgPath) {
		return getImage(new File(srcImgPath));
	}

	/**
	 * 将指定图片读取到BufferedImage
	 * 
	 * @param srcImgFile
	 *            图片文件
	 * @return
	 */
	public static BufferedImage getImage(File srcImgFile) {
		BufferedImage srcImage = null;
		try {
			FileInputStream in = new FileInputStream(srcImgFile);
			srcImage = javax.imageio.ImageIO.read(in);
		} catch (IOException e) {
			System.out.println("读取图片文件出错！" + e.getMessage());
			e.printStackTrace();
		}
		return srcImage;
	}

	/**
	 * 将图片按指定质量比输出到指定位置，
	 * 
	 * @param newImg
	 *            源图片
	 * @param outputPath
	 *            目标路径
	 * @param quality
	 *            质量比
	 */
	public static void outputImage(BufferedImage newImg, String outputPath, float quality) {
		outputImage(newImg, new File(outputPath), quality);
	}

	/**
	 * 将图片按指定质量比输出到指定文件，
	 * 
	 * @param newImg
	 *            源图片
	 * @param outputFile
	 *            目标文件
	 * @param quality
	 *            质量比
	 */
	public static void outputImage(BufferedImage newImg, File outputFile, float quality) {
		FileOutputStream newimage = null;
		// 判断输出的文件夹路径是否存在，不存在则创建
		if (!outputFile.getParentFile().exists()) {
			outputFile.getParentFile().mkdirs();
		}
		// 输出到文件流
		try {
			newimage = new FileOutputStream(outputFile);
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(newimage);
			JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(newImg);
			// 对图片进行质量压缩
			jep.setQuality(quality, true);
			encoder.encode(newImg, jep);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (ImageFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (newimage != null) {
					newimage.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	public static int getMaxLength(File srcImgFile) {
		BufferedImage image = getImage(srcImgFile);
		int old_w = image.getWidth(); // 得到源图宽
		int old_h = image.getHeight(); // 得到源图长
		int lower_len = MAX_WIDTH;
		if (MAX_WIDTH > MAX_HEIGHT) {
			lower_len = MAX_HEIGHT;
		}
		if (old_w == old_h) {
			if (old_w >= lower_len) { return lower_len; }
			return old_w;
		} else if (old_w > old_h) {
			if (old_w >= MAX_WIDTH) { return MAX_WIDTH; }
			return old_w;
		} else {
			if (old_h >= MAX_HEIGHT) { return MAX_HEIGHT; }
			return old_h;
		}
	}

	public static void main(String[] args) {
		File src = new File("d:\\sunshanshan.jpg");
		File dest = new File("d:\\sunshanshan2.jpg");
		ImageUtil.compress(src, dest, 1F, 1F);
	}

}
