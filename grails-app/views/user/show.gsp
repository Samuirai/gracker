
<%@ page import="org.gracker.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
        	<sec:ifAllGranted roles="ROLE_ADMIN">
	            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
	            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
	            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        	</sec:ifAllGranted>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.username.label" default="Username" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "username")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.password.label" default="Password" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "password")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.forename.label" default="Forename" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "forename")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.surename.label" default="Surename" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "surename")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.email.label" default="Email" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "email")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.website.label" default="Website" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "website")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${userInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.profileText.label" default="Profile Text" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: userInstance, field: "profileText")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.accountExpired.label" default="Account Expired" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${userInstance?.accountExpired}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.accountLocked.label" default="Account Locked" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${userInstance?.accountLocked}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.crumbs.label" default="Crumbs" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${userInstance.crumbs}" var="c">
                                    <li><g:link controller="crumb" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.enabled.label" default="Enabled" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${userInstance?.enabled}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="user.passwordExpired.label" default="Password Expired" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${userInstance?.passwordExpired}" /></td>
                            
                        </tr>
                    	<tr>
                    		<td></td>
                    		<td>
                    		
                    		<g:form>
			                    <g:hiddenField name="id" value="${userInstance?.id}" />
			                    <span class="button"><g:actionSubmit class="edit" action="editProfile" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
			                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
			                </g:form>
                    		
                    		</td>
                    	</tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
