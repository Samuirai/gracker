<%@ page import="org.gracker.Crumb" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'crumb.label', default: 'Crumb')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
	        <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
	        <span class="menuButton"><g:link class="list" action="list"><g:message code="Your Crumbs" args="[entityName]" /></g:link></span>
	        <span class="menuButton"><g:link class="list" action="listPublic"><g:message code="Public Crumbs" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${crumbInstance}">
            <div class="errors">
                <g:renderErrors bean="${crumbInstance}" as="list" />
            </div>
            </g:hasErrors>
                
        </div>
        
        <div class="clear"> </div>
        
        <g:form id="crumb_form" url="[action:'save']">
        <div id="scroll_0" class="step float_left">0</div>
	        <div class="float_left">
	        	<b>Crumb Recipe</b>
	        	<ul>
	        		<li> <a href="#scroll_1" class="scroll">1x General Data </a> </li>
	        		<li> <a href="#scroll_2" class="scroll">2x Crumb Data </a> </li>
	        		<li> <a href="#scroll_3" class="scroll">3x Regular Expression </a> </li>
	        		<li> <a href="#scroll_4" class="scroll">4x Test your Recipe </a> </li>
	        		<li> <a href="#scroll_5" class="scroll">5x Taste your Crumb </a> </li>
	        	</ul>
			</div>
	        <div class="clear"> </div>
	        <hr>
            <div id="scroll_1" class="step float_left">1</div>
	        <div class="float_left">
	        	<b>let's start with the recipe.</b>
	        	<table class="clean">
                	<tr>
                		<td><g:textField name="name" id="add_name" class="crumbs" maxlength="30" value="${crumbInstance?.name}" /></td>
                		<td><g:message code="crumb.name.label" default="Name" /></td>
                	</tr>
                	
                </table>
                Tell us more about your delicious plans.</br>
                <textarea name="description" id="add_description" class="crumbs focus textarea" > </textarea>
	        </div>
	        <div class="clear"> </div>
	        <hr>
            <div id="scroll_2" class="step float_left">2</div>
            <div class="float_left">
                <b>add more ingredients.</b>
                <table class="clean">
                	<tr>
                		<td><g:textField name="urlToParse" size="63" id="add_url" class="crumbs" value="${crumbInstance?.urlToParse}" /></td>
                		<td>URL of the Source</td>
                	</tr>
                	
                	<tr>
                		<td>
                			<table>
                				<tr>
                					<td>day</td>
                					<td>hours</td>
                					<td>mins</td>
                					<td>secs</td>
                					<td></td>
                				</tr>
                				<tr>
                					<td><g:textField name="refresh_time_day" class="crumbs cronjob" id="refresh_time_day" size="1" value="*" /></td>
                					<td><g:textField name="refresh_time_hour" class="crumbs cronjob" id="refresh_time_hour" size="1" value="*" /></td>
                					<td><g:textField name="refresh_time_minute" class="crumbs cronjob" id="refresh_time_minute" size="1" value="*" /></td>
                					<td><g:textField name="refresh_time_seconds" class="crumbs cronjob" id="refresh_time_seconds" size="1" value="*" disabled="disabled" /></td>
                					<td><input onclick="refreshTime(this)" type="radio" name="refresh_time_interval" id="refresh_time_weekly" checked="checked" value="daily"> daily</br><input id="refresh_time_daily" onclick="refreshTime(this)" type="radio" name="refresh_time_interval" value="weekly"> weekly</td>
                					<input type="hidden" name="refreshInterval" id="refreshInterval" value="* * * * * *" />
                				</tr>
                			</table>
                		</td>
                		<td>Refresh Time in minutes<br><br>* or number (0, 1, 2, 3, ...)</td>
                		
                	</tr>
                	<tr>
                		<td>
                			<textarea name="attributesMapString" id="attributesMapString" cols="40" rows="5" class="crumbs focus textarea" > </textarea>
                		</td>
                		<td>
                			What are your ingredients?<br>Example:<br><br> [<br> 1: [Name: "Quote", Type: "String"],<br> 2: [Name: "Author", Type: "String"]<br>]
                		</td>
                	</tr>
                </table>
                <script>

					function updateRefreshInterval(){
						if($("#refresh_time_weekly").attr("checked") == "checked") {
							$("#refreshInterval").val($("#refresh_time_seconds").val()+" "+$("#refresh_time_minute").val()+" "+$("#refresh_time_hour").val()+" "+$("#refresh_time_day").val()+" * 1")
						} else if($("#refresh_time_daily").attr("checked") == "checked") {
							$("#refreshInterval").val($("#refresh_time_seconds").val()+" "+$("#refresh_time_minute").val()+" "+$("#refresh_time_hour").val()+" "+$("#refresh_time_day").val()+" 1 *")
						}
					}
                
               		$('.cronjob').keyup(updateRefreshInterval);
					function refreshTime(e) {
						if(e.value == "weekly") {
							$("#refresh_time_day").attr("disabled", false);
							$("#refresh_time_hour").attr("disabled", false);
							$("#refresh_time_minute").attr("disabled", false);
							$("#refresh_time_seconds").attr("disabled", false);
						} else if(e.value == "daily") {

							$("#refresh_time_day").attr("disabled", true);
							$("#refresh_time_day").val("*")
							$("#refresh_time_hour").attr("disabled", false);
							$("#refresh_time_minute").attr("disabled", false);
							$("#refresh_time_seconds").attr("disabled", false);
							
						}
						updateRefreshInterval();
					}
                </script>
                </br>
                
             </div>
		    <div class="clear"> </div>
	        <hr>
          	<div id="scroll_3" class="step float_left">3</div>
		    <div class="float_left">
		    	<b>do the magic!</b><br>
		    	<div id="regex_magic"> </div>
		    	<textarea name="regEx" id="add_regex" cols="40" rows="5" class="crumbs focus textarea" > </textarea>
		    	
		    </div>
		    <div class="clear"> </div>
	        <hr>
	        <div id="scroll_4" class="step float_left">4</div>
		    <div class="float_left">
		    	<b>test your recipe</b> </br>
		    	<textarea id="data" name="data" cols="40" rows="5" class="crumb focus textarea"></textarea></br>
                <input type="button" id="test_crumb" value="Test Crumb" />
		    </div>
		    <div class="clear"> </div>
	        <hr>
	        <div id="scroll_5" class="step float_left">5</div>
		    <div class="float_left">
				
		    	<b>mmmhhh... tastes delicious</b> </br>
		    	<table class="clean">
                	<tr>
		    			<td><g:checkBox name="isPublic" value="${crumbInstance?.isPublic}" /> public</td>
		    			<td>buy us a coffee with a cracker, and get a premium account.</td>
		    		</tr>
		    		<tr>
		    			<td><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></td>
		    			<td>bake your crumb</td>
		    		</tr>
		    	</table>
		    	
		    </div>
		    <div class="clear"> </div>
	        <hr>
        </div>
        </g:form>
        
        <script type="text/javascript">
        
	        var magic;
			var attr = 0;
			var ponyMagic = [];
			
			var associativeArray = [];
        	associativeArray["one"] = "First";
        	associativeArray["two"] = "Second";
        	associativeArray["three"] = "Third";
        	for (i in associativeArray) { 
        	   document.writeln(i+':'+associativeArray[i]+', '); 
        	   // outputs: one:First, two:Second, three:Third
        	};

			function compare(a,b) {
				alert("a: "+a+"\n"+"b: "+b)
			}
        	
			function parseRegex() {
				ponyMagic = [];
				for(nr=0; nr<attr; ++nr){
					i = 1;
					do{
						//$("#add_regex").val($("#add_regex").val()+"#magic_tag"+i+"_"+nr)
						if($("#magic_tag"+i+"_"+nr).length){ 
							ponyMagic.push($("#magic_tag"+i+"_"+nr).attr("pony"))
							ponyMagic.push($("#magic_tag"+i+"_"+nr).val())
							//ponyMagic[""+nr+","+i+",key,tag"] = $("#magic_tag"+i+"_"+nr).attr("pony")
							//ponyMagic[""+nr+","+i+",val,tag"] = $("#magic_tag"+i+"_"+nr).val()
							j = 0;
							if($("#magic_tag"+i+"_"+nr).attr("pony")=="tag_name_start") {
								do{
									if($("#magic_attr"+j+"_"+nr).length){
										ponyMagic.push($("#magic_attr"+j+"_"+nr).attr("pony"))
										ponyMagic.push($("#magic_attr"+j+"_"+nr).val())
										if($("#magic_attr"+j+"_"+nr).attr("pony") == "attr_value") ponyMagic.push("attr_value_end")
										//ponyMagic[""+nr+","+j+",key,attr"] = $("#magic_attr"+j+"_"+nr).attr("pony")
										//ponyMagic[""+nr+","+j+",val,attr"] = $("#magic_attr"+j+"_"+nr).val()
									}
									j++
								} while ($("#magic_attr"+j+"_"+nr).length);
							}
						}
						i++;
					}while ($("#magic_tag"+i+"_"+nr).length);
					ponyMagic.push("ende");
				}
				var fluttershy = ""
				// <p class="quote">(.*)<br><br>(.*)<\/p>
				/*
					0,1,key,tag: tag_name_start
					0,1,val,tag: 
					0,2,key,tag: prefix
					0,2,val,tag: 
					0,3,key,tag: suffix
					0,3,val,tag: 
					0,4,key,tag: tag_name_end
					0,4,val,tag: 
					0,0,key,attr: attr_name
					0,0,val,attr: 
					0,1,key,attr: attr_value
					0,1,val,attr: 
				*/
				for (j in ponyMagic) { 
					if(ponyMagic[j]=="tag_name_start") fluttershy += "<"
					else if(ponyMagic[j]=="attr_name") fluttershy += " "
					else if(ponyMagic[j]=="attr_value") fluttershy += '="'
					else if(ponyMagic[j]=="attr_value_end") fluttershy += '"'
					else if(ponyMagic[j]=="prefix") fluttershy += ">"
					else if(ponyMagic[j]=="suffix") fluttershy += "(.*)"
					else if(ponyMagic[j]=="ende") fluttershy += ">"
					else if(ponyMagic[j]=="tag_name_end") fluttershy += "<\\\/"
					else fluttershy += ponyMagic[j]
					$("#add_regex").val($("#add_regex").val()+"\n"+j+": "+ponyMagic[j]);
				}
				$("#add_regex").val(fluttershy)
				
			}
			
        
			function getAnzahl(nr) {
				i=0;
				while($("#magic_attr"+i+"_"+nr).length) {
					i++;
				}
				return i;
			}
			
	        function magicAddAttr(nr) {
		        anz = getAnzahl(nr);
			    tmp = '';
			    tmp += ' &nbsp;&nbsp;<input pony="attr_name" type="text" class="magic_tag" id="magic_attr'+anz+'_'+nr+'" />';
			    tmp += '="<input type="text" pony="attr_value" class="magic_tag" id="magic_attr'+(anz+1)+'_'+nr+'" />"&nbsp; ';
			    
				$("#magic_attributes_"+nr).append(tmp);
			    $('.magic_tag').keyup(editing_key_press);
			    $('.magic_tag').keydown(editing_key_press);
		    }
		    
		    function editing_key_press(e){
				if(!e.which)editing_restore(this.parentNode);
				var text = $('<span class="magic_tag">')
				    .html($(this).val())
				    .appendTo(this.parentNode);
				var w = text.innerWidth();
				text.remove();
				if(w<=1) w = 15;
				$(this).width(w+5);
			}
			
			function /* Class */ RegexMagic(_typ,_tag,_attributes) {
				var typ = _typ;
				var tag = _tag;
				var attributes = _attributes;
				
			}
			
			
			
        	$(document).ready(function(){
	        	
	        	var url = "";
	        	var regex = "";
	        	var refresh_time = "";
	        	var json = "";
	        	
	        	
		        function updateSize() {
		        	
		        }
		        
		        
		        var magicNr = 0;
	        	// chris macht
	        	function initRegexMagic() {
		        	obj = 0;
					select = '<select id="magic_tag"><option value="0">&lt;tagname attrname="attrvalue" &gt;{data}&lt;/tagname&gt;</option>'
					select += '<option value="1">&lt;tagname attrname="{data}" &gt;&lt;/tagname&gt;</option>'
					select += '<option value="2">&lt;tagname attrname="{data}" /&gt;</option></select>';
					button1 = '<input type="button" class="magic_add_tag" value="Add Tag">';
					button2 = '<input type="button" class="magic_create_regex" onclick="parseRegex()" value="Create Regex">';
					table = '<table id="magic_table" class="clean"><tr><td>'+select+'</td><td>'+button1+'</td></tr></table>'+button2+'';
					
					$("#regex_magic").append(table);
					$(".magic_add_tag").click(function(event){
						tag = '';
						switch(parseInt($("#magic_tag").val())) {
							case 0: 
								
							// TODO: add automatic change tag when changing the other
								tag = '&lt;'
								tag += '<input type="text" pony="tag_name_start" class="magic_tag" id="magic_tag1_'+attr+'" />';
								tag += '<span id="magic_attributes_'+attr+'"> </span>'
								tag += '<input type="button" value="+" class="small" onClick="magicAddAttr('+attr+');" />';
								tag += '&gt;';
								tag += '<input type="text" pony="prefix" class="magic_tag" id="magic_tag2_'+attr+'" />';
								tag += '{data}'
								tag += '<input type="text" pony="suffix" class="magic_tag" id="magic_tag3_'+attr+'" />';
								tag += '';
								tag += '&lt;/<input type="text" pony="tag_name_end" class="magic_tag" id="magic_tag4_'+attr+'"/>&gt;';
								break;
							case 1:
								//tag = '&lt;tagname attrname="{data}" &gt;&lt;/tagname&gt;';
								tag = '&lt;'
								tag += '<input type="text" pony="tag_name_start" class="magic_tag" id="magic_tag1_'+attr+'" />';
								tag += '<span id="magic_attributes_'+attr+'"> </span>'
								tag += '<input type="button" value="+" class="small" onClick="magicAddAttr('+attr+');" />';
								tag += '<input type="text" pony="attr_name" class="magic_tag" id="magic_tag2_'+attr+'" />="{data}"'
								tag += '&gt;';
								tag += '<input type="text" pony="tag_value" class="magic_tag" id="magic_tag3_'+attr+'" />';
								tag += '';
								tag += '&lt;/<input type="text" pony="tag_name_end" class="magic_tag" id="magic_tag4_'+attr+'"/>&gt;';
								break;
							case 2:
								tag = '&lt;'
								tag += '<input type="text" pony="tag_name_start" class="magic_tag" id="magic_tag1_'+attr+'"/>';
								tag += '<span id="magic_attributes_'+attr+'"> </span>'
								tag += '<input type="button" value="+" class="small" onClick="magicAddAttr('+attr+');" />';
								tag += '<input type="text" pony="attr_name" class="magic_tag" id="magic_tag2_'+attr+'"/>="{data}"'
								tag += '/&gt;';
								//tag = '&lt;tagname attrname="{data}" /&gt;';
								break;
							default:
								tag = '<tr><td>error</td><td>error</td></tr>';
								break;
						}
						tag = '<tr><td>'+tag+'</td><td></td></tr>';
						$("#regex_magic").prepend(tag)
						attr += 1;
			     		$('.magic_tag').keyup(editing_key_press);
			     		$('.magic_tag').keydown(editing_key_press);
			     		$('.magic_tag').keypress(editing_key_press);
					});
	        	}
	        
	        	// get the values from the JASON Field an save in the temp variables url,regex and refresh_time
	        	// DELETED!
	        	function getJSON() {
		        	try {
		        		obj = jQuery.parseJSON(json);
		        		url = obj.url;
		        		regex = obj.regex;
		        		refresh_time = obj.refresh_time;
	        			$("#error_json").slideUp('fast');
	        		} catch(e) {
		        		$("#error_json").text(""+e);
		        		$("#error_json").slideDown('fast');
	        		}
	        	}
	        	
	        	// create the JSON crumb
	        	// DELETED!
	        	function updateCrumb() {
	        		var str='{'; str+='\n';
	        		str+='   "url": "'+$('#add_url').val()+'",'; str+='\n';
	        		str+='   "regex": "'+$('#add_regex').val()+'",'; str+='\n';
	        		str+='   "refresh_time": "'+$('#add_refresh_time').val()+'"'; str+='\n';
	        		str+='}';
	        		$('#data').val(str);
	        		json = str;
	        		getJSON();
	        		checkForm();
	        	}
	        	
	        	// parse the JSON crumb and use the temp variables to fill the forms
	        	function updateForm() {
	        		json = $('#data').val();
	        		getJSON();   
	        		checkForm();		
	        		$('#add_url').val(url);
					$('#add_regex').val(regex);
					$('#add_refresh_time').val(refresh_time);
	        	}
	        	
	        	// check the syntax and show errors
		        function checkForm() {
			        if(url.match(/^http:\/\//) || url=="") {
		        		$("#error_email").slideUp('fast');
			        }
			        else {
				        $("#error_email").text("Your URL should start with http://");
		        		$("#error_email").slideDown('fast');
			        }
		        }

		        function testCrumb() {
			        //alert($("#crumb_form").serialize())
		        	$.ajax({
						  type: "POST",
						  url: "${createLink(controller:'crumb', action:'test')}",
						  data: $("#crumb_form").serialize(),
						}).done(function( msg ) {
							$('#data').val( msg );
						});
			        }
	        	
	        	// add the key event handlers for 
	        	//$('.crumbs').keyup(updateCrumb);
	        	//$('.crumbs').keydown(updateCrumb);
	        	//$('#data').keyup(updateForm);
	        	//$('#data').keydown(updateForm);
	        	//$('.update_crumb').click(updateCrumb);
	        	//$('#update_form').click(updateForm);
	        	$('#test_crumb').click(testCrumb);
	        	
	        	// init the GUI
	        	//updateCrumb();
	        	initRegexMagic();
	        	$("#error_json").hide();
	        	$("#error_email").hide();
	     		
        	
				$(".scroll").click(function(event){
					//prevent the default action for the click event
					event.preventDefault();
			
					//get the full url - like mysitecom/index.htm#home
					var full_url = this.href;
			
					//split the url by # and get the anchor target name - home in mysitecom/index.htm#home
					var parts = full_url.split("#");
					var trgt = parts[1];
			
					//get the top offset of the target anchor
					var target_offset = $("#"+trgt).offset();
					var target_top = target_offset.top;
					target_top -= 20;
					//goto that anchor by setting the body scroll top to anchor top
					$('html, body').animate({scrollTop:target_top}, 500);
				});
			});

        	

        	
        </script>
    </body>
</html>
