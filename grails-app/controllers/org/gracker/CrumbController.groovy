package org.gracker

import grails.converters.JSON

class CrumbController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def scaffold = Crumb
	def crumbService
	def test = {
		
			render crumbService.test2(params.urlToParse )
		}

    def create = {
        def crumbInstance = new Crumb()
        crumbInstance.properties = params
        return [crumbInstance: crumbInstance]
    }

}
