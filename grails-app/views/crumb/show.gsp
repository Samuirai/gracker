
<%@ page import="org.gracker.Crumb" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'crumb.label', default: 'Crumb')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
	        <sec:ifLoggedIn>
			<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
	        <span class="menuButton"><g:link class="list" action="list"><g:message code="Your Crumbs" args="[entityName]" /></g:link></span>
	        <span class="menuButton"><g:link class="list" action="listPublic"><g:message code="Public Crumbs" args="[entityName]" /></g:link></span>
        	</sec:ifLoggedIn>
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
                            <td valign="top" class="name"><g:message code="crumb.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: crumbInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="crumb.attributesMapString.label" default="Attributes Map String" /></td>
                            
                            <td valign="top" class="value">${attNames }</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="crumb.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: crumbInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="crumb.refreshInterval.label" default="Refresh Interval" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: crumbInstance, field: "refreshInterval")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="crumb.regEx.label" default="Reg Ex" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: crumbInstance, field: "regEx")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="crumb.urlToParse.label" default="Url To Parse" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: crumbInstance, field: "urlToParse")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="crumb.isPublic.label" default="Is Public" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${crumbInstance?.isPublic}" /></td>
                            
                        </tr>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="crumb.nextDate.label" default="Next Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${crumbInstance?.nextDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="crumb.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${crumbInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="crumb.jobs.label" default="Entries" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <g:link action="showResults" id="${crumbInstance.id}">${fieldValue(bean: crumbInstance, field: "countJobs")}</g:link>
                            </td>
                            
                        </tr>
                         <sec:ifLoggedIn>
                        <tr class="prop">
                        	<td>Action</td>
                        	<td>
                        		<g:if test="${crumbInstance.nextDate == null}">
					    			<a href="${createLink(action:'startJob', controller:'crumb')}/${fieldValue(bean: crumbInstance, field: "id")}">Start</a>
                        		</g:if>
					    		<g:else>
					    			<a href="${createLink(action:'stopJob', controller:'crumb')}/${fieldValue(bean: crumbInstance, field: "id")}">Stop</a>
                        		</g:else>
                        	</td>
                        </tr>
                        </sec:ifLoggedIn>
                        <g:if test="${crumbInstance?.user?.id == sec.currentUser?.id}">
	                        <tr class="prob">
	                        	<td></td>
	                        	<td><g:form>
				                <g:hiddenField name="id" value="${crumbInstance?.id}" />
				                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
				                </g:form></td>
	                        </tr>
                        </g:if>
                    
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
