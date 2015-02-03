package com.aqkj.adm.text;

public class Client {
	public static void main(String[] args) {
		 HanFeiZi hanFeiZi = new HanFeiZi();  
	        LiSi liSi = new LiSi();  
	        DiaoSi diaoSi = new DiaoSi();  
	        HanFeiZiWife hanFeiZiWife = new HanFeiZiWife();  
	        
	        hanFeiZi.addObserver(liSi);  
	        
	        hanFeiZi.addObserver(diaoSi);  
	        hanFeiZi.addObserver(hanFeiZiWife);  
	 
	        hanFeiZi.smd_state();
	        hanFeiZi.sd_state();
	        
	}
}
