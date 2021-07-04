package org.iweb.sys;

/**
 * Action辅助类
 * 
 * @author kreo
 *
 */
public interface ActionAttr {
	public abstract String getMessage();

	public abstract void setMessage(String message);

	public abstract String getPath();

	public abstract String getViewFlag();

	public abstract void setViewFlag(String viewFlag);
}
