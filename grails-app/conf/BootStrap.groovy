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
		new UserRole(user: chris).save();
		new UserRole(user: fabi, role: admin_role).save();
		
        def filipsCrumb = new Crumb(name: 'myZitatTestCrumb', attributesMapString:'[1:[Name:"Content", Type:"String"], 2:[Name:"Author", Type:"String"]]',description:'No Description', refreshInterval: "5 * * * * * *",
        regEx:/[\n\r.]*<p class="quote">(.*)<br><br>(.*)<\/p>/,urlToParse: 'http://www.randomquotes.net/', isPublic: false, user: filip, validThrough: new Date()+10).save();
		def filipsCrumb2 = new Crumb(name: 'testCrumb2', attributesMapString:'[1:[Name:"Content", Type:"String"], 2:[Name:"Author", Type:"String"]]',description:'This is a very long description. AYAY very long', refreshInterval: "30 * * * * * *",
		regEx:/[\n\r.]*<p class="quote">(.*)<br><br>(.*)<\/p>/,urlToParse: 'http://www.randomquotes.net/', isPublic: true, user: fabi, validThrough: new Date()+10).save();
		def filips3Crumb = new Crumb(name: 'testCrumb3', attributesMapString:'[1:[Name:"Content", Type:"String"], 2:[Name:"Author", Type:"String"]]',description:'No Description', refreshInterval: "* 1 * * * * *",
		regEx:/[\n\r.]*<p class="quote">(.*)<br><br>(.*)<\/p>/,urlToParse: 'http://www.randomquotes.net/', isPublic: true, user: filip, validThrough: new Date()+10).save();
		def gerbash = new Crumb(name: 'GermanBash Users', attributesMapString:'[1:[Name:"Anzahl",Type:"Number"]]', description: "get the online users from german-bash.org", refreshInterval: "10 * * * * * *",
		regEx:/<span class="zahl">(.*)<\/span>\/</, urlToParse: "http://german-bash.org", isPublic: true, user: fabi, validThrough: new Date()+10).save();
		def gerbash2 = new Crumb(name: 'GermanBash Users and Queue', attributesMapString:'[1:[Name:"User",Type:"Number"],2:[Name:"Queues",Type:"Number"]]', description: "get the online users and quote queue from german-bash.org", refreshInterval: "10 * * * * * *",
		regEx:/<span class="zahl">([0-9]*)<\/span>\/.*Warteschlange: <span class="zahl">([0-9]*)<\/span>/, urlToParse: "http://german-bash.org", isPublic: true, user: fabi, validThrough: new Date()+10).save();
		
	
		def theScheduler = new Scheduler(name: 'mainScheduler').save();
    }
    def destroy = {
    }
}
