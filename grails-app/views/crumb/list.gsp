
<%@ page import="org.gracker.Crumb" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'crumb.label', default: 'Crumb')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
    	<div class="sub_navi">
	        <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
	        <g:link class="list" action="list"><g:message code="Your Crumbs" args="[entityName]" /></g:link>
	        <g:link class="list" action="listPublic"><g:message code="Public Crumbs" args="[entityName]" /></g:link>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <h1>Your Crumbs</h1>
            
            <div>
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="name" title="${message(code: 'crumb.name.label', default: 'Name')}" />
                           
                            <g:sortableColumn property="description" title="${message(code: 'crumb.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="refreshInterval" title="${message(code: 'crumb.refreshInterval.label', default: 'Refresh Interval')}" />
                        
                            <g:sortableColumn property="regEx" title="${message(code: 'crumb.regEx.label', default: 'Reg Ex')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    
                    <g:each in="${crumbInstanceList}" status="i" var="crumbInstance">
                   		
                        <g:if test="${crumbInstance?.user.id == sec.currentUser.id}">
                      
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${crumbInstance.id}">${fieldValue(bean: crumbInstance, field: "name")}</g:link></td>
                        
                            <td>${fieldValue(bean: crumbInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: crumbInstance, field: "refreshInterval")}</td>
                        
                            <td>${fieldValue(bean: crumbInstance, field: "regEx")}</td>
                        
                        </tr>
                        </g:if>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${crumbInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
