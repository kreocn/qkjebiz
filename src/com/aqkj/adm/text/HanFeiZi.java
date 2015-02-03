package com.aqkj.adm.text;

import java.util.ArrayList;

public class HanFeiZi implements IHanFeiZi, Observerable{
	private ArrayList<Observer> observerList = new ArrayList<Observer>();  
	@Override
	public void addObserver(Observer observer) {
		// TODO Auto-generated method stub
		observerList.add(observer);  
		
	}

	@Override
	public void deleteObserver(Observer observer) {
		// TODO Auto-generated method stub
		observerList.remove(observer);  
	}

	@Override
	public void notifyObservers(String context) {
		// TODO Auto-generated method stub
		for(Observer observer : observerList){  
            observer.update(context);  
        } 
	}



	@Override
	public void smd_state() {
		// TODO Auto-generated method stub
		System.out.println("经理审核");
	}

	@Override
	public void sd_state() {
		// TODO Auto-generated method stub
		System.out.println("副总审核");
	}

	@Override
	public void state() {
		// TODO Auto-generated method stub
		System.out.println("审核中");
	}

}
