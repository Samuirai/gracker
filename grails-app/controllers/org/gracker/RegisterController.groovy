package org.gracker

import groovy.text.SimpleTemplateEngine

import org.codehaus.groovy.grails.commons.ApplicationHolder as AH
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.codehaus.groovy.grails.plugins.springsecurity.ui.RegistrationCode


class RegisterController extends grails.plugins.springsecurity.ui.RegisterController {
	
		static defaultAction = 'index'
	
		def mailService
	
		def index = {
			[command: new RegisterCommand()]
		}
		
		def save_error = {
		}
	
	def register = { RegisterCommand command ->

		if (command.hasErrors()) {
			render view: 'index', model: [command: command]
			return
		}

		def user = lookupUserClass().newInstance(email: command.email, username: command.username,
				password: command.password, accountLocked: true, enabled: true,
				forename: command.forename, surename: command.surename,
				website: command.website)
		if (!user.validate() || !user.save()) {
				flash.error = "Problem with saving/validating User"
				redirect(action: save_error)
				return
		}

		def registrationCode = new RegistrationCode(username: user.username).save()
		String url = generateLink('verifyRegistration', [t: registrationCode.token])

		def conf = SpringSecurityUtils.securityConfig
		def body = conf.ui.register.emailBody
		if (body.contains('$')) {
			body = evaluate(body, [user: user, url: url])
		}
		mailService.sendMail {
			to command.email
			from conf.ui.register.emailFrom
			subject conf.ui.register.emailSubject
			html body.toString()
		}

		render view: 'index', model: [emailSent: true]
	}
	
	def verifyRegistration = {

			def conf = SpringSecurityUtils.securityConfig
			String defaultTargetUrl = conf.successHandler.defaultTargetUrl
	
			String token = params.t
	
			def registrationCode = token ? RegistrationCode.findByToken(token) : null
			if (!registrationCode) {
				flash.error = message(code: 'spring.security.ui.register.badCode')
				redirect(action: save_error)
				return
			}
	
			def user
			RegistrationCode.withTransaction { status ->
				user = lookupUserClass().findByUsername(registrationCode.username)
				if (!user) {
					flash.error = message(code: 'spring.security.ui.register.badCode')
					redirect(action: save_error)
					return
				}
				user.accountLocked = false
				user.save()
				registrationCode.delete()
			}
	
			if (!user) {
				flash.error = message(code: 'spring.security.ui.register.badCode')
				redirect uri: defaultTargetUrl
				return
			}
	
			springSecurityService.reauthenticate user.username
	
			flash.message = message(code: 'spring.security.ui.register.complete')
			//redirect uri: conf.ui.register.postRegisterUrl ?: defaultTargetUrl
			render view: 'success'
		}
}

class RegisterCommand {
		String username
		String email
		String password
		String password2
		
		String forename
		String surename
		String website
	
		static constraints = {
			username blank: false, validator: { value, command ->
				if (value) {
					def User = AH.application.getDomainClass(
						SpringSecurityUtils.securityConfig.userLookup.userDomainClassName).clazz
					if (User.findByUsername(value)) {
						return 'registerCommand.username.unique'
					}
				}
			}
			email blank: false, email: true
			password blank: false, minSize: 8, maxSize: 64, validator: RegisterController.passwordValidator
			password2 validator: RegisterController.password2Validator
			
			forename nullable: true, blank: true, size: 2..50
			surename nullable: true, blank: true, size: 2..50
			website nullable: true, url: true, size:5..120
		}
	}
	
	class ResetPasswordCommand {
		String username
		String password
		String password2
	
		static constraints = {
			password blank: false, minSize: 8, maxSize: 64, validator: RegisterController.passwordValidator
			password2 validator: RegisterController.password2Validator
		}
	}
	
