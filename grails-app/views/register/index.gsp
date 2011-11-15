<head>
	<meta name='layout' content='main'/>
	<title><g:message code='spring.security.ui.register.title'/></title>
</head>

<body>

<p/>

<g:form action='register' name='registerForm'>

	<div style="width: 600px; margin: 0 auto;">
	<h1>Register</h1>
	
	<g:if test="${flash.message}">
    	<div class="message">${flash.message}</div>
    </g:if>
	<g:if test='${emailSent}'>
	<br/>
	<g:message code='spring.security.ui.register.sent'/>
	</g:if>
	<g:else>
	
	<table style="width: 600px;">
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
        <tr>
        	<td></td>
        	<td><g:actionSubmit elementId='create' form='registerForm' value='Register'/></td>
        </tr>                  
	</tbody>
	</table>

	
	</g:else>

</g:form>
</div>

<script>
$(document).ready(function() {
	$('#username').focus();
});
</script>

</body>
