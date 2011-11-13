

<%@ page import="org.gracker.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userInstance}">
            <div class="errors">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${userInstance?.id}" />
                <g:hiddenField name="version" value="${userInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="username"><g:message code="user.username.label" default="Username" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'username', 'errors')}">
                                    <g:textField name="username" maxlength="30" value="${userInstance?.username}" style="width:250px;" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="password"><g:message code="user.password.label" default="Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'password', 'errors')}">
                                    <g:textField name="password" value="${userInstance?.password}" style="width:250px;" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="forename"><g:message code="user.forename.label" default="Forename" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'forename', 'errors')}">
                                    <g:textField name="forename" maxlength="50" value="${userInstance?.forename}" style="width:250px;" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="surename"><g:message code="user.surename.label" default="Surename" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'surename', 'errors')}">
                                    <g:textField name="surename" maxlength="50" value="${userInstance?.surename}" style="width:250px;" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="email"><g:message code="user.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" maxlength="120" value="${userInstance?.email}" style="width:250px;" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="website"><g:message code="user.website.label" default="Website" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'website', 'errors')}">
                                    <g:textField name="website" maxlength="120" value="${userInstance?.website}" style="width:250px;" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="profileText"><g:message code="user.profileText.label" default="Profile Text" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'profileText', 'errors')}">
                                    <g:textArea name="profileText" value="${userInstance?.profileText}" style="width:250px;height:100px;" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
