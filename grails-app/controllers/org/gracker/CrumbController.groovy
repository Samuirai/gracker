package org.gracker

import grails.plugins.springsecurity.SpringSecurityService;

class CrumbController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
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
					crumbName: Crumb.get(params.id).name,
					crumbId : params.id
				]
			}catch(Exception e){
				flash.message = e.message
			}
		}else{
			flash.message = "Crumb with id " + params.id + " was not found."
			redirect(action: list)
		}
	}
	
	def updateAnalyse = {
		if(params.id1 && params.id2){
			try{
				[
					jobList: crumbService.getDataArray(params.id1)[(new Integer(params.id2))..-1],
					attNames: crumbService.getAttributNames(params.id1),
					attTypes: crumbService.getAttributTypes(params.id1),
					crumbName: Crumb.get(params.id1).name,
					crumbId : Crumb.get(params.id1).id,
					id1: params.id1,
					id2: (new Integer(params.id2))
				]
			}catch(Exception e){
			flash.message = "error"
				//flash.message = e.message+" params: " + params.id1 + ","+ params.id2 + "<br>liste: "+crumbService.getDataArray(params.id1)
			}
		}else{
			flash.message = "Crumb with id " + params.id1 + " was not found."
			redirect(action: list)
		}
	}


}