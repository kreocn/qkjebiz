package com.aqkj.adm.text;

public class LiSi implements Observer{

	@Override
	public void update(String context) {
		// TODO Auto-generated method stub
	
        System.out.println("总经理审核");  
		
	}
	 private void reportToQinShiHuang(String context) {  
	        System.out.println("11" + "<--->" + context);  
	    }  
}
