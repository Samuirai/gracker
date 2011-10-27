package org.gracker

class CrumbService {

    static transactional = true

	def track(def url, def pattern){
		// Open a HTTPURLConnection
		def connection = new URL(url).openConnection();
		// It should not use Caches, that the content is always new
		connection.setUseCaches(false);
		
		//Connection successfull?
		if(connection.responseCode == 200){
		
			//Match it with the given Pattern and give some Attributes back
			def result = [:]
			def RegExRes = (connection.content.text =~ pattern);
			result.name = RegExRes[0][1];
			result.author = RegExRes[0][2].replace('-', '');
			return result;
			
		}else{
			def result = [:]
			result.name = "### ERROR ### : connection Failed"
			return result;
		}
	};
		
		def test() {
			def base = "http://www.randomquotes.net/"
			def url = new URL(base)
			def connection = url.openConnection();
			connection.setUseCaches(false);
			
			String xml = connection.content.text;
			
			def result = [:]
			
			// REGEX: pattern = ~/[.$^].*<p class="quote">(.*)</p>/
			def pattern = ~/[\n\r.]*<p class="quote">(.*)<\/p>/;
			result.name = (xml =~ /[\n\r.]*<p class="quote">(.*)<br><br>(.*)<\/p>/)[0][1];
			result.author = (xml =~ /[\n\r.]*<p class="quote">(.*)<br><br>(.*)<\/p>/)[0][2].replace('-', '');
			result.className = connection.getClass();
			connection = null;
			
			return result;
		}
		
		def test2(def request) {
			def base = request.urlToParse ?: "error"
			def url = new URL(base)
			def connection = url.openConnection();
			connection.setUseCaches(false);
			def str = connection.content.text
			
			return str;	
		}
		

}
