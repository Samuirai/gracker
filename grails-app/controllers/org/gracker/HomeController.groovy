package org.gracker

class HomeController {

    def index = { 
		[crumbInstanceList: Crumb.findAllByIsPublic(true, params),  crumbInstanceTotal: Crumb.count()]
	}
	
	
}
