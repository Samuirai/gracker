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
			
			new Job(result: parseResult, crumb: crumbs[i], dateCreated: new Date()).save()
			
			def tmpDate = triggerTime(crumbs[i].id);
			crumbs[i].nextDate = tmpDate;
			System.out.println("["+ new Date() +"] " + crumbs[i]+ " updated")
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
		if(intervallTokens.size() != 6){
			//TODO Abfangen und Crumb beenden
			return ""
			throw new Exception("Error the String of 'refreshIntervall'("+ tmpCrumb.refreshInterval+" String of " + tmpCrumb + " was not in the right Form")
		}

		def c = null
		if(tmpCrumb.nextDate instanceof java.util.Date){
			c = tmpCrumb.nextDate.toCalendar()
		}else
			c = Calendar.getInstance()
		
		if(intervallTokens[4] == "*" && intervallTokens[5] == "*"){
			// Intervall
			if(intervallTokens[0] != "*")
				c.add(Calendar.SECOND, new Integer(intervallTokens[0]))
			
			if(intervallTokens[1] != "*")
				c.add(Calendar.MINUTE, new Integer(intervallTokens[1]))

			if(intervallTokens[2] != "*")
				c.add(Calendar.HOUR, new Integer(intervallTokens[2]))
				
			if(intervallTokens[3] != "*")
				c.add(Calendar.DAY_OF_MONTH, new Integer(intervallTokens[3]))
				
		}else if(intervallTokens[4] == "1" && intervallTokens[5] == "*"){
			//Daily
			if(intervallTokens[0] != "*")
				c.set(Calendar.SECOND, new Integer(intervallTokens[0]))
	
			if(intervallTokens[1] != "*")
				c.set(Calendar.MINUTE, new Integer(intervallTokens[1]))

			if(intervallTokens[2] != "*")
				c.set(Calendar.HOUR, new Integer(intervallTokens[2]))
			
			c.add(Calendar.DAY_OF_MONTH, 1);
				
				
		}else if(intervallTokens[4] == "*" && intervallTokens[5] == "1"){
			//Monthly
			if(intervallTokens[0] != "*")
				c.set(Calendar.SECOND, new Integer(intervallTokens[0]))

			if(intervallTokens[1] != "*")
				c.set(Calendar.MINUTE, new Integer(intervallTokens[1]))

			if(intervallTokens[2] != "*")
				c.set(Calendar.HOUR, new Integer(intervallTokens[2]))
	
			if(intervallTokens[3] != "*")
				c.set(Calendar.DAY_OF_MONTH, new Integer(intervallTokens[3]))
				
			c.add(Calendar.MONTH, 1);
		
		}	
		return c.getTime()
	}
	
	def start(def id)  {
		if(id){
			def mainS = Scheduler.findByName('mainScheduler')
			
			def tmpCrumb = Crumb.get(id)
			tmpCrumb.nextDate = triggerTime(id)
			tmpCrumb.save()
			
			mainS.crumbsToDo.add(tmpCrumb)
			mainS.save()
		}
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
