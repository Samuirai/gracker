

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
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
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
                                    <g:textField name="attributesMapString" value="${crumbInstance?.attributesMapString}" />
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
                                  <label for="refreshInterval"><g:message code="crumb.refreshInterval.label" default="Refresh Interval" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: crumbInstance, field: 'refreshInterval', 'errors')}">
                                    <g:textField name="refreshInterval" value="${crumbInstance?.refreshInterval}" />
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
                                    <g:textField name="urlToParse" maxlength="120" value="${crumbInstance?.urlToParse}" />
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
                                  <label for="validThrough"><g:message code="crumb.validThrough.label" default="Valid Through" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: crumbInstance, field: 'validThrough', 'errors')}">
                                    <g:datePicker name="validThrough" precision="day" value="${crumbInstance?.validThrough}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nextDate"><g:message code="crumb.nextDate.label" default="Next Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: crumbInstance, field: 'nextDate', 'errors')}">
                                    <g:datePicker name="nextDate" precision="day" value="${crumbInstance?.nextDate}" default="none" noSelection="['': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="jobs"><g:message code="crumb.jobs.label" default="Jobs" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: crumbInstance, field: 'jobs', 'errors')}">
                                    
<ul>
<g:each in="${crumbInstance?.jobs?}" var="j">
    <li><g:link controller="job" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="job" action="create" params="['crumb.id': crumbInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'job.label', default: 'Job')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="user"><g:message code="crumb.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: crumbInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${org.gracker.User.list()}" optionKey="id" value="${crumbInstance?.user?.id}"  />
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
