package com.aqkj.adm.text;

public class DiaoSi implements Observer{

	@Override
	public void update(String context) {
		// TODO Auto-generated method stub
		 System.out.println("屌丝:发现韩非子有活动" + "<--->" + context);  
	     System.out.println("屌丝非常伤心");  
	}

}
