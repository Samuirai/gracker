package org.gracker

class HomeController {

    def index = { 
		sendMail {     
		  to "filip.haase@googlemail.com"     
		  subject "Hello Flip"     
		  body 'Hier war jemand auf Home ;)' 
		}
	}
}
