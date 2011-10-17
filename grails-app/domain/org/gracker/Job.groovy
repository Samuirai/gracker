package org.gracker

class Job {

	static belongsTo = [crumb: Crumb]
	
	Date   parsingTime
	String result
	
    static constraints = {
		parsingTime()
		result(size: 0..9001)
	}

}
