package org.gracker

class Crumb {

	static belongsTo = [user: User]
	static hasMany   = [jobs: Job]
	
	String name
	String attributesMapString
	Date dateCreated
	String description
	String refreshInterval
	String regEx
	String urlToParse
	Date   validThrough
	boolean isPublic
		
    static constraints = {
    	name(blank: false, siaze: 1..30)
		attributesMapString()
		dateCreated()
		description(size: 0..200)
		refreshInterval()
		regEx(size:0..500)
		urlToParse(url: true, size:5..120)
		validThrough()
		isPublic()
	}
	
}
