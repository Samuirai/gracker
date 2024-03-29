package org.gracker

import grails.converters.JSON

class CrumbService {

    static transactional = true

		def ponyMagic(def url,def regex) {
			
			def regexMap = [:]
			try {
				def parsed_url = new URL(url)
				def connection = parsed_url.openConnection();
				connection.setUseCaches(false);
				def str = connection.content.text
				
				def matcher = (str =~ regex)
				
				
				if(matcher.size()>0)
					for(int i=1; i<matcher[0].size(); ++i)
						regexMap.put(i,'"'+ (matcher[0].getAt(i).toString().replace('"','\''))+'"' )
				
			} catch (MalformedURLException e)
			{
				regexMap = [:]
			}
			
			return regexMap.toMapString()	
		}
		
		def getDataArray(def id){
			if(id && Crumb.get(id)){
				def jobs = Job.findAllByCrumb(Crumb.get(id))
				def result = []
	
				//Counter for the job Numbers
				int counter = 0
	
				//Iterate over all the Jobs
				for(Job j: jobs){
					//Get the Result String
					def mapString = j.result
					
					mapString = mapString.replace(']', '}')
					mapString = mapString.replace('[', '{')
					if(mapString != "{:}"){
						//Parse the String
						def parseResult = (JSON.parse(mapString))
						
						//Make a new Entry in the result List with a new List where we write in all the Components of the Job
						result[counter] = new ArrayList<Object>()
						result[counter][0] = j.dateCreated
						
						for(def k : parseResult.keySet())
							result[counter][new Integer(k)]= parseResult[k].toString()
							
					}else{
						result[counter] = new ArrayList<Object>()
						result[counter][0] = j.dateCreated

						for(int i=1; i <= getAttributCount(id); i++)
							result[counter][i] = 0
					}
					counter++
					
				}
				return result

			}else{
				throw new Exception("Crumb Not Found")
			}
		}
		
		def getAttributNames(def id){
			if(id && Crumb.get(id)){
				def aMS = Crumb.get(id).attributesMapString
				aMS = aMS.replace(']', '}')
				aMS = aMS.replace('[', '{')
				
				def result = []
				int counter = 0

				if(aMS != "{:}" && !aMS.isEmpty() && aMS){
					//Parse the AttributeMapString
					def parseResult = (JSON.parse(aMS))

					//Iterate over the Attributes
					for(def att : parseResult.keySet()){
						result[counter] = parseResult[att]['Name']
						counter++
					}
					result[counter] = "Date"
					return result.reverse()
				}else return null
	
			}else{
				throw new Exception("Crumb Not Found")
			}
		}
		
		def getAttributTypes(def id){
			if(id && Crumb.get(id)){
				def aMS = Crumb.get(id).attributesMapString
				aMS = aMS.replace(']', '}')
				aMS = aMS.replace('[', '{')
				
				def result = []
				int counter = 0

				if(aMS != "{:}" && !aMS.isEmpty() && aMS){
					//Parse the AttributeMapString
					def parseResult = (JSON.parse(aMS))

					//Iterate over the Attributes
					for(def att : parseResult.keySet()){
						result[counter] = parseResult[att]['Type']
						counter++
					}
					result[counter] = "Date"
					return result.reverse()
				}else return null
	
			}else{
				throw new Exception("Crumb Not Found")
			}
		}
		
		def getAttributCount(def id){
			if(id && Crumb.get(id)){
				def aMS = Crumb.get(id).attributesMapString
				aMS = aMS.replace(']', '}')
				aMS = aMS.replace('[', '{')
				
				if(aMS && !aMS?.isEmpty() && aMS != "{:}")	(JSON.parse(aMS)).keySet().size()
				else 				0
				
			}else{
				throw new Exception("Crumb Not Found")
			}
		}
		
		def getExportString(def id){
			String csvString ='"'
			for(def i in getAttributNames(id))
				csvString += i + '", "'
			
			csvString = csvString.substring(0, csvString.size()-3) + '\n"'
			
			for(def i in getAttributTypes(id))
				csvString += i + '", "'

			csvString = csvString.substring(0, csvString.size()-3) + '\n"'

			for(def i in getDataArray(id)){
				
				for(def j in i){
					if( j instanceof java.util.Date)
						csvString += String.format('%td.%<tm.%<tY %<tH:%<tM:%<tS', j) + '", "'
					else
						csvString += j.toString() + '", "'
				}
				csvString = csvString.substring(0, csvString.size()-3) + '\n"'
			}
			csvString = csvString.substring(0, csvString.size()-1)
		}
}
