package org.gracker

class Job {

	static belongsTo = [crumb: Crumb]
	
	Date   dateCreated
	String result
	
    static constraints = {
		dateCreated()
		result(size: 0..9001)
	}

}
