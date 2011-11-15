package org.gracker

class Crumb implements Comparable<Crumb>{

	String name
	String attributesMapString
	
	static belongsTo = [user: User]
	static hasMany   = [jobs: Job]
	
	String description
	String refreshInterval
	String regEx
	String urlToParse
	boolean isPublic
	
	Date validThrough
	Date nextDate
	Date dateCreated
		
	
	static transients = ["countJobs"] 
	
    static constraints = {
    	name(blank: false, siaze: 1..30)
		attributesMapString()
		description(size: 0..200)
		refreshInterval()
		regEx(size:0..500)
		urlToParse(url: true, size:5..120)
		isPublic()
		validThrough()
		nextDate(nullable: true)
		dateCreated()
	}
	
	public int getCountJobs() {
		return jobs? jobs.size() : 0
	}
	
	public int compareTo(Crumb compareObject)
	{
		if (nextDate < compareObject.nextDate)
			return -1;
		else if (nextDate == compareObject.nextDate)
			return 0;
		else
			return 1;
	}
	
	public String toString(){
		return name	
	}
	
}
