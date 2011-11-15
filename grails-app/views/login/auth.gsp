<head>
<title><g:message code='spring.security.ui.login.title'/></title>
<meta name='layout' content='main'/>

</head>

<body>

<div class="login s2ui_center ui-corner-all" >
	<div class="login-inner">
	<form action='${postUrl}' method='POST' id="loginForm" name="loginForm" autocomplete='off'>
	<div  style="width: 600px; margin: 0 auto;">

	<h1>Login</h1>
	<g:if test="${flash.message}">
    	<div class="message">${flash.message}</div>
    </g:if>
	<table style="width: 600px;">
		<tr>
			<td><label for="username"><g:message code='spring.security.ui.login.username'/></label></td>
			<td><input name="j_username" id="username" size="20" /></td>
		</tr>
		<tr>
			<td><label for="password"><g:message code='spring.security.ui.login.password'/></label></td>
			<td><input type="password" name="j_password" id="password" size="20" /></td>
		</tr>
		<tr>
			<td></td>
			<td>
				<input type="checkbox" class="checkbox" name="${rememberMeParameter}" id="remember_me" checked="checked" />
				<label for='remember_me'><g:message code='spring.security.ui.login.rememberme'/></label><br/>
				<span class="forgot-link">
					<g:link controller='register' action='forgotPassword'><g:message code='spring.security.ui.login.forgotPassword'/></g:link>
				</span>
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<g:link elementId='register' controller='register' messageCode='spring.security.ui.login.register'> Register Account </g:link>
				<g:actionSubmit elementId='loginButton' form='loginForm' value='Login'/>

			</td>
		</tr>
	</table>

	</div>
	</form>
	</div>
</div>

<script>
$(document).ready(function() {
	$('#username').focus();
});


</script>

</body>
