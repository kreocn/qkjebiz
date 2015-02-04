package org.iweb.sys;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JSONUtil {
	private static ObjectMapper mapper;

	/**
	 * 获取ObjectMapper实例
	 * 
	 * @return
	 */
	public static synchronized ObjectMapper getMapperInstance() {
		if (mapper == null) {
			mapper = new ObjectMapper();
		}
		return mapper;
	}

	/**
	 * 将java对象转换成json字符串
	 * 
	 * @param obj
	 *            准备转换的对象
	 * @param createNew
	 *            ObjectMapper实例方式:true，新实例;false,存在的mapper实例
	 * @return json字符串
	 * @throws Exception
	 */
	public static String toJsonString(Object obj) {
		try {
			ObjectMapper objectMapper = getMapperInstance();
			String json = objectMapper.writeValueAsString(obj);
			return json;
		} catch (Exception e) {
			return "";
		}
	}

	/**
	 * 将json字符串转换成java对象
	 * 
	 * @param json
	 *            准备转换的json字符串
	 * @param cls
	 *            准备转换的类
	 * @param createNew
	 *            ObjectMapper实例方式:true，新实例;false,存在的mapper实例
	 * @return
	 * @throws Exception
	 */
	public static Object toObject(String json, Class<?> cls) {
		try {
			ObjectMapper objectMapper = getMapperInstance();
			Object vo = objectMapper.readValue(json, cls);
			return vo;
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 将json字符串转换为Collection&lt;beanClass&gt;形式
	 * 
	 * @param json
	 * @param collectionClass
	 * @param beanClass
	 * @return
	 */
	public static Collection<?> toList(String json, Class<?> collectionClass, Class<?> beanClass) {
		try {
			JavaType javaType = getCollectionType(collectionClass, beanClass);
			ObjectMapper objectMapper = getMapperInstance();
			return objectMapper.readValue(json, javaType);
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 将json字符串转换为ArrayList&lt;beanClass&gt;形式
	 * 
	 * @param json
	 * @param beanClass
	 * @return
	 */
	public static ArrayList<?> toList(String json, Class<?> beanClass) {
		return (ArrayList<?>) toList(json, ArrayList.class, beanClass);
	}

	/**
	 * 将json字符串转换为HashMap&lt;String,beanClass&gt;形式
	 * 
	 * @param json
	 * @param beanClass
	 * @return
	 */
	public static HashMap<String, ?> toMap(String json, Class<?> beanClass) {
		try {
			JavaType javaType = getCollectionType(HashMap.class, String.class, beanClass);
			ObjectMapper objectMapper = getMapperInstance();
			return objectMapper.readValue(json, javaType);
		} catch (Exception e) {
			return null;
		}
	}

	private static JavaType getCollectionType(Class<?> collectionClass, Class<?>... elementClasses) {
		ObjectMapper objectMapper = getMapperInstance();
		return objectMapper.getTypeFactory().constructParametricType(collectionClass, elementClasses);
	}
}