package org.gracker

class CrumbController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def springSecurityService
	def scaffold = Crumb
	def crumbService
	
    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		//params.fetch = [belongsTo: [user: springSecurityService.currentUser]]
        [crumbInstanceList: Crumb.list(params), crumbInstanceTotal: Crumb.count(), sec: springSecurityService]
    }
	
	def listPublic = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		//params.fetch = [belongsTo: [user: springSecurityService.currentUser]]
		[crumbInstanceList: Crumb.list(params), crumbInstanceTotal: Crumb.count(), sec: springSecurityService]
	}
	
    def show = {
        def crumbInstance = Crumb.get(params.id)
        if (!crumbInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'crumb.label', default: 'Crumb'), params.id])}"
            redirect(action: "list")
        }
        else {
            [crumbInstance: crumbInstance]
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
		System.out.println(params);
		def crumbInstance = new Crumb(params)
		return [crumbInstance: crumbInstance]
	}
	
	def showResults = {
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
	

}