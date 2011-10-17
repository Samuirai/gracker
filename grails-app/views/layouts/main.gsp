<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Gracker" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />
    </head>
    <body>
        <div id="top_menu">
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
        	<g:layoutBody />
        </div>
    </body>
</html>