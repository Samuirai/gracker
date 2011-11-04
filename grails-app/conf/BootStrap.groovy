import org.gracker.*;

class BootStrap {

    def init = { servletContext ->
        def filip = new User(username: "theflip", forename: 'Filip', surename: 'Haase',
            password: "password", enabled: true, email:'haase.filip@googlemail.com',
            website: 'http://www.f-haase.org').save();
		def chris = new User(username: "dark5in", forename: 'Christopher', surename: 'Westphal',
			password: "password", enabled: true, email:'chris90night@googlemail.com',
			website: 'http://www.timeofdarkness.de').save();
		def fabi = new User(username: "samuirai", forename: 'Fabian', surename: 'Fäßler',
			password: "password", enabled: true, email:'fabi.faessler@googlemail.com',
			website: 'http://www.samuirai.de').save();
        
        def admin_role = new Role(authority: "ROLE_ADMIN").save();
        new UserRole(user: filip, role: admin_role).save();
		new UserRole(user: chris, role: admin_role).save();
		new UserRole(user: fabi, role: admin_role).save();
		
        def filipsCrumb = new Crumb(name: 'myZitatTestCrumb', attributesMapString:'',description:'No Description', refreshInterval: "5 * * * * * *",
        regEx:/[\n\r.]*<p class="quote">(.*)<br><br>(.*)<\/p>/,urlToParse: 'http://www.randomquotes.net/', isPublic: true, user: filip, validThrough: new Date()+10).save();
		def filipsCrumb2 = new Crumb(name: 'testCrumb2', attributesMapString:'',description:'No Description', refreshInterval: "30 * * * * * *",
		regEx:/[\n\r.]*<p class="quote">(.*)<br><br>(.*)<\/p>/,urlToParse: 'http://www.randomquotes.net/', isPublic: true, user: filip, validThrough: new Date()+10).save();
		def filips3Crumb = new Crumb(name: 'testCrumb3', attributesMapString:'',description:'No Description', refreshInterval: "* 1 * * * * *",
		regEx:/[\n\r.]*<p class="quote">(.*)<br><br>(.*)<\/p>/,urlToParse: 'http://www.randomquotes.net/', isPublic: true, user: filip, validThrough: new Date()+10).save();

		def theScheduler = new Scheduler(name: 'mainScheduler').save();
    }
    def destroy = {
    }
}
