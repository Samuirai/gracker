package org.gracker

class CrumbController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def scaffold = Crumb
	def crumbService
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
