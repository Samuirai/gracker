<head>
<title><g:message code='spring.security.ui.login.title'/></title>
<meta name='layout' content='main'/>

</head>

<body>

<p/>

<div class="login s2ui_center ui-corner-all" >
	<div class="login-inner" style='width: 300px'>
	<form action='${postUrl}' method='POST' id="loginForm" name="loginForm" autocomplete='off'>
	<div class="sign-in">

	<h1><g:message code='spring.security.ui.login.signin'/></h1>

	<table>
		<tr>
			<td><label for="username"><g:message code='spring.security.ui.login.username'/></label></td>
			<td><input name="j_username" id="username" size="20" /></td>
		</tr>
		<tr>
			<td><label for="password"><g:message code='spring.security.ui.login.password'/></label></td>
			<td><input type="password" name="j_password" id="password" size="20" /></td>
		</tr>
		<tr>
			<td colspan='2'>
				<input type="checkbox" class="checkbox" name="${rememberMeParameter}" id="remember_me" checked="checked" />
				<label for='remember_me'><g:message code='spring.security.ui.login.rememberme'/></label><br/>
				<span class="forgot-link">
					<g:link controller='register' action='forgotPassword'><g:message code='spring.security.ui.login.forgotPassword'/></g:link>
				</span>
			</td>
		</tr>
		<tr>
			<td colspan='2'>
				<s2ui:linkButton elementId='register' controller='register' messageCode='spring.security.ui.login.register'/>
				
				<a id="loginButton" >Log in</a>
				<script>
				$(document).ready(function() {
					
					$("#loginButton").button();
					$('#loginButton').bind('click', function() {
					   document.forms.loginForm.submit();
					});
				
				});
				</script>
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

<s2ui:initCheckboxes/>

</script>

</body>
