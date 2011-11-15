<head>
<title><g:message code='spring.security.ui.forgotPassword.title'/></title>
<meta name='layout' content='main'/>
</head>

<body>


<g:form action='forgotPassword' name="forgotPasswordForm" autocomplete='off'>
	<div  style="width: 600px; margin: 0 auto;">
	<g:if test='${emailSent}'>
	<br/>
	<g:message code='spring.security.ui.forgotPassword.sent'/>
	</g:if>

	<g:else>

	<br/>
	<h4><g:message code='spring.security.ui.forgotPassword.description'/></h4>

	<table style="width: 600px;">
		<tr>
			<td><label for="username"><g:message code='spring.security.ui.forgotPassword.username'/></label></td>
			<td><g:textField name="username" size="25" /></td>
		</tr>
		<tr>
			<td></td>
			<td>
				<g:actionSubmit elementId='reset' form='forgotPasswordForm' value='Reset PW'/>
			</td>
		</tr>
	</table>

	</g:else>
	</div>
</g:form>

<script>
$(document).ready(function() {
	$('#username').focus();
});
</script>

</body>
