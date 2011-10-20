package org.gracker

//import org.apache.jasper.tagplugins.jstl.core.Import;

import grails.converters.JSON;
import org.gracker.CrumbService;

class CrumbController {

    def scaffold = Crumb
	def crumbService
	def test = {
			render crumbService.track() as JSON
		}
}
