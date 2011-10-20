package org.gracker

class User {

	/**Stuff from Security Plugin **/
	transient springSecurityService

	String username
	String password
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired
	
	
	/* Our Stuff*/
	static hasMany = [crumbs: Crumb]
	
	String forename
	String surename
	String email
	String website
	Date   dateCreated
	//Byte[] picture
	String profileText
	

	static constraints = {
		username(blank: false, unique: true, size:3..30)
		password blank: false
		forename(nullable: true, size:2..50)
		surename(nullable:true, size:2..50)
		email(blank: false, email: true, unique: true, size:5..120)
		website(nullable: true, url: true, size:5..120)
		dateCreated()
		//picture(nullable: true)
		profileText(nullable: true)
	}

	/**Stuff from Security Plugin **/
	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
	
	public String toString(){
		username;	
	}
}
