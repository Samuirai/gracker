

<%@ page import="org.gracker.Crumb" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'crumb.label', default: 'Crumb')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
	        <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
	        <span class="menuButton"><g:link class="list" action="list"><g:message code="Your Crumbs" args="[entityName]" /></g:link></span>
	        <span class="menuButton"><g:link class="list" action="listPublic"><g:message code="Public Crumbs" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${crumbInstance}">
            <div class="errors">
                <g:renderErrors bean="${crumbInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${crumbInstance?.id}" />
                <g:hiddenField name="version" value="${crumbInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="crumb.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: crumbInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${crumbInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="attributesMapString"><g:message code="crumb.attributesMapString.label" default="Attributes Map String" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: crumbInstance, field: 'attributesMapString', 'errors')}">
                                    ${crumbInstance?.attributesMapString}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="crumb.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: crumbInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" maxlength="200" value="${crumbInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="refreshInterval"><g:message code="crumb.refreshInterval.label" default="Refresh Interval | next Update" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: crumbInstance, field: 'refreshInterval', 'errors')}">
                                    <g:textField name="name" value="${crumbInstance?.refreshInterval}" /> | ${crumbInstance?.nextDate}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="regEx"><g:message code="crumb.regEx.label" default="Reg Ex" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: crumbInstance, field: 'regEx', 'errors')}">
                                    <g:textArea name="regEx" cols="40" rows="5" value="${crumbInstance?.regEx}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="urlToParse"><g:message code="crumb.urlToParse.label" default="Url To Parse" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: crumbInstance, field: 'urlToParse', 'errors')}">
                                    ${crumbInstance?.urlToParse}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="isPublic"><g:message code="crumb.isPublic.label" default="Is Public" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: crumbInstance, field: 'isPublic', 'errors')}">
                                    <g:checkBox name="isPublic" value="${crumbInstance?.isPublic}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="jobs"><g:message code="crumb.jobs.label" default="Entries" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: crumbInstance, field: 'jobs', 'errors')}">
                                    ${crumbInstance?.countJobs}
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
