package org.gracker

import grails.plugins.springsecurity.SpringSecurityService;
import java.text.SimpleDateFormat
import org.grails.plugins.csv.CSVWriter

class CrumbController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", importIt: "POST"]
	
	def springSecurityService
	def schedulerService
	def scaffold = Crumb
	def crumbService
	
    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
		if (springSecurityService.isLoggedIn()) {
			[crumbInstanceList: Crumb.findAllByUser(springSecurityService.currentUser, params), crumbInstanceTotal: Crumb.count()]
		} else {
			redirect(action: "listPublic",params: params)
		}
	}
	
	def listPublic = {
		[crumbInstanceList: Crumb.findAllByIsPublic(true, params),  crumbInstanceTotal: Crumb.count()]
		
	}
	
    def show = {
        def crumbInstance = Crumb.get(params.id)
        if (!crumbInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'crumb.label', default: 'Crumb'), params.id])}"
            redirect(action: "list")
        }
        else {
            [crumbInstance: crumbInstance,
				jobList: crumbService.getDataArray(params.id),
				attNames: crumbService.getAttributNames(params.id),
				attTypes: crumbService.getAttributTypes(params.id),
				sec: springSecurityService]
        }
    }


    def delete = {
        def crumbInstance = Crumb.get(params.id)
        if (crumbInstance) {
            try {
                crumbInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'crumb.label', default: 'Crumb'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'crumb.label', default: 'Crumb'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'crumb.label', default: 'Crumb'), params.id])}"
            redirect(action: "list")
        }
    }
	

	def test = {
			//TODO Entfernen
			render crumbService.ponyMagic(params.urlToParse, params.regEx )
		}

	def create = {
		if (springSecurityService.isLoggedIn()) {
			System.out.println(params);
			def crumbInstance = new Crumb(params)
			return [crumbInstance: crumbInstance]
		} else {
			redirect(action: "listPublic",params: params)
		}
	}
	
	def save = {
		def crumbInstance = new Crumb(params)
		crumbInstance.user = springSecurityService.currentUser;
		crumbInstance.validThrough = new Date() +10;
		crumbInstance.save()
		redirect(action: "list");
	}
	
	def showResults = {
		if(params.id){
			try{
				[
					jobList: crumbService.getDataArray(params.id),
					attNames: crumbService.getAttributNames(params.id),
					attTypes: crumbService.getAttributTypes(params.id),
					crumbName: Crumb.get(params.id).name,
					crumbId : Crumb.get(params.id).id
				]
			}catch(Exception e){
				flash.message = e.message
			}
		}else{
			flash.message = "Crumb with id " + params.id + " was not found."
			redirect(action: list)
		}
	}
	
	def startJob = {
		if(servletContext.st == null){
			flash.message = "Could not start Crumb because there's no Thread running"
		}else if(params.id){
			if(Crumb.get(params.id).user.equals(springSecurityService.currentUser))
			{
				schedulerService.start(params.id)
			} else {
				flash.message = "Could not start Crumb because it's not your crumb"
			}
		}
		redirect(action:list)
	}
	

	def stopJob = {
		if(servletContext.st == null){
			flash.message = "Could not stop Crumb because there's no Thread running"
		}else if(params.id){
			if(Crumb.get(params.id).user.equals(springSecurityService.currentUser))
			{
				schedulerService.stop(params.id)
			} else {
				flash.message = "Could not stop Crumb because it's not your crumb"
			}
		}
		redirect(action:list)
	}
	
	def analyse = {
		if(params.id){
			try{
				[
					jobList: crumbService.getDataArray(params.id),
					attNames: crumbService.getAttributNames(params.id),
					attTypes: crumbService.getAttributTypes(params.id),
					crumbName: Crumb.get(params.id).name
				]
			}catch(Exception e){
				flash.message = e.message
			}
		}else{
			flash.message = "Crumb with id " + params.id + " was not found."
			redirect(action: list)
		}
	}
	
	def exportCsv = {
		if(params.id){
			
			[currentID: params.id, crumbName: Crumb.get(params.id).name, exportString: crumbService.getExportString(params.id)]//, downFile: file]
		}else{
			flash.message = "Crumb with id " + params.id + " was not found."
			redirect(action: list)
		}
	}
	
	def downloadFile = {
		def filename = Crumb.get(params.id).name.replace(' ', '_') + "_export.csv"

		response.setContentType("application/octet-stream")
		response.setHeader("Content-disposition", "filename=${filename}")
		response.outputStream << crumbService.getExportString(params.id)
		return
	}
	
	def importCsv = {
		if(params.id){
			//Id übergeben
			[crumbName: Crumb.get(params.id).name, thisId : params.id, importString : params.importString]
		}else{
			flash.message = "Crumb with id " + params.id + " was not found."
			//redirect(action: list)
		}
	}
	
	def importIt = {
		def csvString = params.importString
		
		def lines = csvString.tokenize('\n')
		def tokens
		def attCount = crumbService.getAttributCount(params.id)+1
		def attNames = crumbService.getAttributNames(params.id)
		def attTypes = crumbService.getAttributTypes(params.id)
		def map = [:]
		def date
		def job = null
		def jC = 0
		def counter
		def tmpCrumb = Crumb.get(params.id)
		def jobList = []
		boolean rightFormat = true
		
		for(int lc =0; lc < lines.size() && rightFormat; lc++){
			counter = 0
			tokens = lines[lc].tokenize(',')
			for(int tc=0; tc < tokens.size() && rightFormat; tc ++){

				//Do a little replace Stuff
				tokens[tc] = tokens[tc].replace('"', '').replace('\r', '')
				
				if(tokens.size() != attCount){
					rightFormat = false;
				}else if(lc == 0){
					//First Line with the names
					//Just check if the names are right
					if(tokens[tc].replace(' ', '') != attNames[tc])
						rightFormat = false;
											
				}else if(lc == 1){
					//Second Line with the types
					//Just check if the types are right
					if(tokens[tc].replace(' ', '') != attTypes[tc])
						rightFormat = false;
				
				}else{
					//Set the date
					if(tc == 0)
						try{
							SimpleDateFormat df = new SimpleDateFormat("dd.MM.yyyy hh:mm:ss");
							date = df.parse(tokens[tc])
						}catch(Exception e){
							System.out.println(e);
						}
					else
						map.putAt(counter, tokens[tc])
						
					counter++
				}
			}
			
			if(!rightFormat){
				switch(lc){
					case 0: flash.message = "Your Names are incorrect formatted, therefore we could not import your CSV "
						break;
					case 1: flash.message = "Your Types are incorrect formatted, therefore we could not import your CSV "
						break;
					default: flash.message = "Your Line " + lines[lc] + "are incorrect formatted, therefore we could not import your CSV "
						break;
				}
			}

			// If not Type or Name Line create the Job 
			if(lc != 0 && lc != 1){
				job = new Job(dateCreated: date, result: map.toMapString(), crumb: tmpCrumb).save()
				if(job){
					jC++
					jobList.add(job)
				}
			}
		}
		
		if(rightFormat)
			flash.message = "Succesfully imported " + jC + " Jobs"
			
		redirect(action: "importCsv", params: [id:params.id, importString: params.importString, jobsDone: jobList])
	}

}