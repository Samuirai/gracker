package org.gracker


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
}
