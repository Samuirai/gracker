package org.gracker

import org.apache.log4j.spi.TriggeringEventEvaluator;
import org.apache.tools.ant.types.CommandlineJava.SysProperties;

class SchedulerService {

    static transactional = true
	def crumbService

	def updateScheduler(){
		def mainS = Scheduler.findByName('mainScheduler')
		def crumbs = mainS.crumbsToDo.sort()
		
		for(int i =0; (crumbs[i]?.nextDate < new Date()) && (crumbs.size()>i); i++){
			def parseResult = crumbService.ponyMagic(crumbs[i].urlToParse, crumbs[i].regEx)
			
			new Job(result: parseResult, crumb: crumbs[i]).save()
			
			crumbs[i].nextDate = triggerTime(crumbs[i].id)
			System.out.println("[" + new Date() + "] " + crumbs[i] + " updatet");
		}
	}
	
	def triggerTime(id){
		def mainS = Scheduler.findByName('mainScheduler')
		def tmpCrumb = Crumb.get(id)
		def intervallTokens = tmpCrumb.refreshInterval.tokenize()
		

	/* Using following Cron job format: 
	   cronExpression: "s m h D M W Y"
		| | | | | | `- Year [optional]
		| | | | | `- Day of Week, 1-7 or SUN-SAT, ?
		| | | | `- Month, 1-12 or JAN-DEC
		| | | `- Day of Month, 1-31, ?
		| | `- Hour, 0-23
		| `- Minute, 0-59
		`- Second, 0-59
	*/
		//handle the Case of a wrong String
		if(intervallTokens.size() != 7){
			return "hallo"
			throw new Exception("Error the String of 'refreshIntervall'("+ tmpCrumb.refreshInterval+" String of " + tmpCrumb + " was not in the right Form")
		}

		def c = Calendar.getInstance()
		
		if(intervallTokens[0] != "*")
			c.add(Calendar.SECOND, new Integer(intervallTokens[0]))
			
		if(intervallTokens[1] != "*")
			c.add(Calendar.MINUTE, new Integer(intervallTokens[1]))
			
		return c.getTime()
	}
	
	def stop(def id){
		if(id){
			def mainS = Scheduler.findByName('mainScheduler')
			def tmpCrumb = Crumb.get(id)
			
			tmpCrumb.nextDate = null
			tmpCrumb.save()
			mainS.crumbsToDo.remove(tmpCrumb)
			mainS.save()
		}
	}
	
}
