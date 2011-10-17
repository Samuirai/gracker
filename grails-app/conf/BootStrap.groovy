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
    }
    def destroy = {
    }
}
