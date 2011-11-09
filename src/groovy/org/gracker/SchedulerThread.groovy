package org.gracker;

public class SchedulerThread extends Thread{

	public boolean running
	public boolean stopped
	public Integer timeInt
	def schedulerService
	
	public SchedulerThread(def ss){
		schedulerService = ss	
	}
	
	public void setTimeInt(int pTI){
		timeInt = pTI
	}
	
	public void stopIt(){
		running = false
	}
	
	public void run() {
		running = true
		stopped = false
		
		if(timeInt == null)
			timeInt = 100;
			
		while(running){
			schedulerService.updateScheduler()
			Thread.sleep(timeInt)
		}
	}
}
