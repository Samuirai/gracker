package org.gracker

import org.apache.tools.ant.types.CommandlineJava.SysProperties;

class SchedulerController {

	def scaffold = Scheduler
	def schedulerService
	
    def index = { 
		redirect(action:listJobs)
	}
	
	def startThread = {
		servletContext.st = new SchedulerThread(schedulerService)
		servletContext.st.start()
		redirect(action:listJobs)
	}
	
	def stopThread = {
		servletContext.st.stopIt()
		servletContext.st = null
		redirect(action:listJobs)
	}
	
	def listJobs = {
		def mainS = Scheduler.findByName('mainScheduler')
		
		if(servletContext.st == null){
			mainS.crumbsToDo.clear()
			Crumb.getAll()*.nextDate=null
		}
			
		[thread: servletContext.st, name: mainS.name, crumbsToDo: mainS.crumbsToDo.sort(), allCrumbs: Crumb.findAll(), now: new Date()]
	}
	
	def startJob = {
		if(servletContext.st == null){
			flash.message = "Could not start Crumb because there's no Thread running"
		}else if(params.id){
			schedulerService.start(params.id)
		}
		
		redirect(action:listJobs)
	}
	

	def stopJob = {
		if(params.id){
			schedulerService.stop(params.id)
		}
		redirect(action:listJobs)
	}
	
	//TODO Entfernen
	def test = {
		flash.message = schedulerService.updateScheduler()
	}
}
