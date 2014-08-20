package org.iweb.sys;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.aliyun.openservices.oss.OSSClient;
import com.aliyun.openservices.oss.model.Bucket;
import com.aliyun.openservices.oss.model.CannedAccessControlList;
import com.aliyun.openservices.oss.model.ObjectMetadata;
import com.aliyun.openservices.oss.model.PutObjectResult;

/**
 * 对于阿里云OSS所写的公共类
 * 
 * @author 骏宇
 * 
 */
public class OSSUtil {
	private static Log log = LogFactory.getLog(OSSUtil.class);
	private final static String key = "otx1ZFIBfPBRgPEv";
	private final static String secret = "A1PwcIcvavGUhjZ7amtIEJkI4Xg4QO";
	private final static String endpoint = "http://images.qkjchina.com/";
	private static OSSClient client;

	static {
		client = new OSSClient(endpoint, key, secret);
		log.info("初始化阿里OSS成功.");
	}

	/**
	 * 创建Bucket
	 * 
	 * @param bucketName
	 */
	public static void createBucket(String bucketName) {
		client.createBucket(bucketName);
		log.info("成功创建Bucket:" + bucketName);
	}

	/**
	 * 列出用户下所有的Buckets
	 * 
	 * @return
	 */
	public static List<Bucket> listBuckets() {
		log.info("开始列出Bucket列表");
		return client.listBuckets();
	}

	/**
	 * 判断Bucket是否存在
	 * 
	 * @param bucketName
	 * @return
	 */
	public static boolean bucketExist(String bucketName) {
		log.info("开始检测Bucket是否存在:" + bucketName);
		return client.doesBucketExist(bucketName);
	}

	/**
	 * 删除一个Bucket
	 * 
	 * @param bucketName
	 */
	public static void deleteBucket(String bucketName) {
		client.deleteBucket(bucketName);
	}

	/**
	 * 设置一个Bucket的权限
	 * 
	 * @param bucketName
	 * @param acl
	 *            权限方式 0:Private 1:PublicRead 2:PublicReadWrite
	 */
	public static void setBucketAcl(String bucketName, int acl) {
		switch (acl) {
		case 0:
			client.setBucketAcl(bucketName, CannedAccessControlList.Private);
			break;
		case 1:
			client.setBucketAcl(bucketName, CannedAccessControlList.PublicRead);
			break;
		case 2:
			client.setBucketAcl(bucketName, CannedAccessControlList.PublicReadWrite);
			break;
		default:
			break;
		}
	}

	public static boolean uploadFile(String bucketName, String file_name, InputStream in, ObjectMetadata meta) {
		PutObjectResult r = client.putObject(bucketName, file_name, in, meta);
		log.info("上传成功,返回MD5值为:" + r.getETag());
		return true;
	}

	public static boolean uploadFile(String bucketName, String file_name, File uploadFile, ObjectMetadata meta) {
		try {
			log.info("校验的MD5值为:" + FileUtil.getFileMD5(uploadFile));
			return uploadFile(bucketName, file_name, new FileInputStream(uploadFile), meta);
		} catch (Exception e) {
			return false;
		}
	}

	public static InputStream getFile(String bucketName, String file_name) {
		return client.getObject(bucketName, file_name).getObjectContent();
	}

	public static void main(String[] args) {
		try {
			ObjectMetadata meta = new ObjectMetadata();
			File f = new File("D://bcd.jpg");
			// InputStream in = new FileInputStream(f);
			meta.setContentLength(f.length());
			OSSUtil.uploadFile("qkjebiz-images", "123456.jpg", f, meta);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}