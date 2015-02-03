package com.aqkj.adm.text;

public interface Observerable {
	 public void addObserver(Observer observer);  
     
	    public void deleteObserver(Observer observer);  
	      
	    public void notifyObservers(String context);
}
