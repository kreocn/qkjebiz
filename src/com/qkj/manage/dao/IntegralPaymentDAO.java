package com.qkj.manage.dao;

import org.iweb.sys.AbstractDAO;

public class IntegralPaymentDAO  extends AbstractDAO{
	public Object add(Object parameters) {
		return super.add("qkjmanage_addIntegralPay", parameters);
	}
}
