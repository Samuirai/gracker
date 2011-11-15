<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Gracker" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.png')}" type="image/x-icon" />
        <g:javascript library='jquery' plugin='jquery' />
		<link rel="stylesheet" media="screen" href="${resource(dir:'css',file:'reset.css')}"/>
		<link rel="stylesheet" media="screen" href="${resource(dir:'css',file:'spring-security-ui.css')}"/>
		<jqui:resources />
		<link rel="stylesheet" media="screen" href="${resource(dir:'css/smoothness',file:'jquery-ui-1.8.2.custom.css',plugin:'spring-security-ui')}"/>
		<link rel="stylesheet" media="screen" href="${resource(dir:'css',file:'jquery.jgrowl.css')}"/>
		<link rel="stylesheet" media="screen" href="${resource(dir:'css',file:'jquery.safari-checkbox.css')}"/>
		<link rel="stylesheet" media="screen" href="${resource(dir:'css',file:'auth.css')}"/>
		
        
        <g:layoutHead />
        <g:javascript library="application" />
    </head>
    <body>
    <g:javascript src='jquery/jquery.jgrowl.js'/>
	<g:javascript src='jquery/jquery.checkbox.js'/>
	<g:javascript src='spring-security-ui.js'/>

	
	<s2ui:showFlash/>
        <div id="top_menu">
        	<sec:ifLoggedIn>
        		<div class="top_menu_item">
        			<g:link controller="user" action="editProfile"><sec:loggedInUserInfo field="username"/></g:link>
        		</div>
        	</sec:ifLoggedIn>
            <div class="top_menu_item">
            	<g:link controller="home">Gracker</g:link>
            </div>
            <div class="top_menu_item">
				<g:link controller="crumb">Crumbs</g:link>
			</div>
			
			<sec:ifAllGranted roles="ROLE_ADMIN">
				<div class="top_menu_item">
					<g:link controller="user">User</g:link>
				</div>
				<div class="top_menu_item">
					<g:link controller="role">Roles</g:link>
				</div>
				<div class="top_menu_item">
					<g:link controller="userRole">UserRoles</g:link>
				</div>
				<div class="top_menu_item">
					<g:link controller="scheduler">Scheduler</g:link>
				</div>
			</sec:ifAllGranted>
			

            <div class="top_menu_item" style="float:right">
            	<sec:ifNotLoggedIn>
            		<g:link controller="login">Anmelden</g:link>
            	</sec:ifNotLoggedIn>
            	<sec:ifLoggedIn>
					<g:link controller="logout">Logout</g:link>
				</sec:ifLoggedIn>
            </div>
                        <div class="clear"> </div>
        </div>
        <div id="main">
	        <div id="header">
	                <div id="header_left">
	                    <img width="320" height="134" src="${resource(dir:'images',file:'gracker.png')}">
	                </div>
	                <div id="header_right">
	                    <div class="dictionary_entry">
	                        <div class="dictionary_word">
	                            grack•er
	                        </div>
	                        <div class="dictionary_sound">
	                            ˈkrakər
	                        </div>
	                        <div class="clear"> </div>
	                        <div class="dictionary_description">
	                            a web-tracker written with groovy and grails.
	                        </div>
	                    </div>
	                </div>
	                <div class="clear"> </div>           
	            </div> 
        	<g:layoutBody />
        	<div class="clear"> </div>
        </br>
        <div id="footer"> <a href="http://www.gracker.org">gracker.com</a> - the groovy and grails webtracker by <a href="http://www.samuirai.de">Fabian</a>, <a href="http://www.f-haase.com">Filip</a> and <a href="hhttp://www.timeofdarkness.de/">Chris</a> </div>
    
        </div>
        </body>
</html>
