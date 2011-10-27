<%@ page import="org.gracker.Crumb" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'crumb.label', default: 'Crumb')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        
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
                <g:textArea name="description" id="add_description" class="crumbs" maxlength="200" value="${crumbInstance?.description}" />
	        </div>
	        <div class="clear"> </div>
	        <hr>
            <div id="scroll_2" class="step float_left">2</div>
            <div class="float_left">
                <b>add more ingredients.</b>
                <table class="clean">
                	<tr>
                		<td><g:textField name="urlToParse" id="add_url" class="crumbs" maxlength="120" value="${crumbInstance?.urlToParse}" /></td>
                		<td>URL of the Source</td>
                	</tr>
                	
                	<tr>
                		<td><g:textField name="refreshInterval" class="crumbs" id="add_refresh_time" value="${crumbInstance?.refreshInterval}" /></td>
                		<td>Refresh Time in minutes</td>
                	</tr>
                </table>
                </br>
                
             </div>
		    <div class="clear"> </div>
	        <hr>
          	<div id="scroll_3" class="step float_left">3</div>
		    <div class="float_left">
		    	<b>do the magic!</b><br>
		    	<div id="regex_magic"> </div>
		    	<g:textArea name="regEx" id="add_regex" class="crumbs" cols="40" rows="5" value="${crumbInstance?.regEx}" />
		    	
		    </div>
		    <div class="clear"> </div>
	        <hr>
	        <div id="scroll_4" class="step float_left">4</div>
		    <div class="float_left">
		    	<textarea id="data" name="data" class="crumb focus textarea"></textarea></br>
                <input type="button" class="update_crumb" value="Update Crumb">
                <input type="button" id="update_form" value="Update Form"> <br/>
		    </div>
		    <div class="clear"> </div>
	        <hr>
	        <div id="scroll_5" class="step float_left">5</div>
		    <div class="float_left">
		    
                <div id="error_json" class="error">loading...</div>
                <div id="error_email" class="error">loading...</div>
		    	<table class="clean">
                	<tr>
		    			<td><g:checkBox name="isPublic" value="${crumbInstance?.isPublic}" /> public</td>
		    			<td>buy us a coffee with a cracker, and get a premium account.</td>
		    		</tr>
		    		<tr>
		    			<td><input type="button" id="test_crumb" value="Test Crumbs" /></td>
		    			<td>bake your crumb</td>
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
        	
	        function magicAddAttr(nr) {
			    tmp = '';
			    tmp += ' &nbsp;&nbsp;<input type="text" class="magic_tag"/>';
			    tmp += '="<input type="text" class="magic_tag"/>"&nbsp; ';
			    
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
			
			var magic
	        	
        	$(document).ready(function(){
	        	
	        	var url = "";
	        	var regex = "";
	        	var refresh_time = "";
	        	var json = "";
	        	var attr = 0;
	        	
		        function updateSize() {
		        	
		        }
		        
	        	// chris macht
	        	function initRegexMagic() {
		        	obj = 0;
					select = '<select id="magic_tag"><option value="0">&lt;tagname attrname="attrvalue" &gt;{data}&lt;/tagname&gt;</option>'
					select += '<option value="1">&lt;tagname attrname="{data}" &gt;&lt;/tagname&gt;</option>'
					select += '<option value="2">&lt;tagname attrname="{data}" /&gt;</option></select>';
					button1 = '<input type="button" class="magic_add_tag" value="Add Tag">';
					button2 = '<input type="button" class="magic_create_regex" value="Create Regex">';
					table = '<table id="magic_table" class="clean"><tr><td>'+select+'</td><td>'+button1+'</td></tr></table>'+button2+'';
					
					$("#regex_magic").append(table);
					$(".magic_add_tag").click(function(event){
						tag = '';
						switch(parseInt($("#magic_tag").val())) {
							case 0: 
							// TODO: add automatic change tag when changing the other
								tag = '&lt;'
								tag += '<input type="text" class="magic_tag"/>';
								tag += '<span id="magic_attributes_'+attr+'"> </span>'
								tag += '<input type="button" value="+" class="small" onClick="magicAddAttr('+attr+');" />';
								tag += '&gt;';
								tag += '<input type="text" class="magic_tag"/>';
								tag += '{data}'
								tag += '<input type="text" class="magic_tag"/>';
								tag += '';
								tag += '&lt;/<input type="text" class="magic_tag"/>&gt;';
								break;
							case 1:
								//tag = '&lt;tagname attrname="{data}" &gt;&lt;/tagname&gt;';
								tag = '&lt;'
								tag += '<input type="text" class="magic_tag"/>';
								tag += '<input type="text" class="magic_tag"/>="{data}"'
								tag += '<span id="magic_attributes_'+attr+'"> </span>'
								tag += '<input type="button" value="+" class="small" onClick="magicAddAttr('+attr+');" />';
								tag += '&gt;';
								tag += '<input type="text" class="magic_tag"/>';
								tag += '';
								tag += '&lt;/<input type="text" class="magic_tag"/>&gt;';
								break;
							case 2:
								tag = '&lt;'
								tag += '<input type="text" class="magic_tag"/>';
								tag += '<input type="text" class="magic_tag"/>="{data}"'
								tag += '<span id="magic_attributes_'+attr+'"> </span>'
								tag += '<input type="button" value="+" class="small" onClick="magicAddAttr('+attr+');" />';
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
					});
	        	}
	        
	        	// get the values from the JASON Field an save in the temp variables url,regex and refresh_time
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
						  alert( "RETURN: \n" + msg );
						});
			        }
	        	
	        	// add the key event handlers for 
	        	$('.crumbs').keyup(updateCrumb);
	        	$('.crumbs').keydown(updateCrumb);
	        	$('#data').keyup(updateForm);
	        	$('#data').keydown(updateForm);
	        	$('.update_crumb').click(updateCrumb);
	        	$('#update_form').click(updateForm);
	        	$('#test_crumb').click(testCrumb);
	        	
	        	// init the GUI
	        	updateCrumb();
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
