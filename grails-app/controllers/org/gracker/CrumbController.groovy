package org.gracker

import grails.converters.JSON

class CrumbController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def scaffold = Crumb
	def crumbService
	def test = {
			//TODO Entfernen
			render crumbService.ponyMagic(params.urlToParse, params.regEx )
		}

    def create = {
        def crumbInstance = new Crumb(params)
        return [crumbInstance: crumbInstance]
    }
	
	def showResults = {
		if(params.id){
			def jobs = Job.findAllByCrumb(Crumb.get(params.id))
			ArrayList<Object> result = new ArrayList<Object>()

			//Counter for the job Numbers
			int counter = 0

			//Iterate over all the Jobs
			for(Job j: jobs){
				//Get the Result String 
				def mapString = j.result
				
				mapString = mapString.replace(']', '}')
				mapString = mapString.replace('[', '{')
				if(mapString != "{:}"){
					//Parse the String
					def parseResult = (JSON.parse(mapString))
					
					//Make a new Entry in the result List with a new List where we write in all the Components of the Job
					result[counter] = new ArrayList<Object>()
					result[counter][0] = j.dateCreated
					
					for(def k : parseResult.keySet())
						result[counter][new Integer(k)]= parseResult[k].toString()
						
					counter++
				}else{
					result[counter] = new ArrayList<Object>()
					result[counter][0] = j.dateCreated 
				}
			}	
			[jobList: result, crumbName: Crumb.get(params.id).name]
		}else{
			flash.message = "Crumb with id " + params.id + " was not found."
			redirect(action: list)
		}
	}
	

}
