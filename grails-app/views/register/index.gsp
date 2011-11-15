<head>
	<meta name='layout' content='main'/>
	<title><g:message code='spring.security.ui.register.title'/></title>
</head>

<body>

<p/>

<s2ui:form width='400' height='360' elementId='loginFormContainer'
           titleCode='spring.security.ui.register.description' center='true'>

<g:form action='register' name='registerForm'>

	<g:if test='${emailSent}'>
	<br/>
	<g:message code='spring.security.ui.register.sent'/>
	</g:if>
	<g:else>

	<br/>

	<table>
	<tbody>

		<s2ui:textFieldRow name='username' labelCode='user.username.label' bean="${command}"
                         size='40' labelCodeDefault='Username*' value="${command.username}"/>

		<s2ui:textFieldRow name='email' bean="${command}" value="${command.email}"
		                   size='40' labelCode='user.email.label' labelCodeDefault='E-mail*'/>

		<s2ui:passwordFieldRow name='password' labelCode='user.password.label' bean="${command}"
                             size='40' labelCodeDefault='Password*' value="${command.password}"/>

		<s2ui:passwordFieldRow name='password2' labelCode='user.password2.label' bean="${command}"
                             size='40' labelCodeDefault='Password (again)*' value="${command.password2}"/>
                             

		<s2ui:textFieldRow name='forename' labelCode='user.forename.label' bean="${command}"
                             size='40' labelCodeDefault='Forename' value="${command.forename}"/>                         

		<s2ui:textFieldRow name='surename' labelCode='user.surename.label' bean="${command}"
                             size='40' labelCodeDefault='Surename' value="${command.surename}"/>
                             
       	<s2ui:textFieldRow name='website' labelCode='user.website.label' bean="${command}"
                             size='40' labelCodeDefault='Website' value="${command.website}"/>   
                                                          
	</tbody>
	</table>

	<s2ui:submitButton elementId='create' form='registerForm' messageCode='spring.security.ui.register.submit'/>

	</g:else>

</g:form>

</s2ui:form>

<script>
$(document).ready(function() {
	$('#username').focus();
});
</script>

</body>
