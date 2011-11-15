<html>
<head>
	<title>Gracker | Scheduler</title>
	<meta name='layout' content='main'/>
</head>
<body>
	
	<h1>Scheduler Overview</h1>
	
	<p>
		<b>${flash.message}</b><br/>
		<b>State:</b>
		<g:if test="${thread == null}">
			Inactive | <a href="${createLink(action:'startThread', controller:'scheduler')}">Start</a>
		</g:if>
		<g:else>
			Active[<i>${thread.timeInt}ms</i>] | <a href="${createLink(action:'stopThread', controller:'scheduler')}">Stop</a>
		</g:else><br/>
		<i>[Time: ${now}]</i>
	</p>
	<br />
	
	<h2>Currently Running Crumbs</h2>	
	<div class="list">
		<table>
			<thead>
				<tr>
					<td>Name</td>
					<td>Owner</td>
					<td>NextDate</td>
					<td>Action</td>
				</tr>
			</thead>
			<tbody>
				<g:each in="${crumbsToDo}" var="j">
		    	<tr>
		    		<td><a href="${createLink(action:'showResults', controller:'crumb')}?id=${j.id}">${j.name}</a></td>
		    		<td>${j.user}</td>
		    		<td>${j.nextDate}</td>
		    		<td><a href="${createLink(action:'stopJob', controller:'scheduler')}/${j.id}">Stop</a></td>
				</tr>
				</g:each>
			</tbody>
		</table>
	</div>
	<g:if test="${crumbsToDo.isEmpty()}">
		<i>Sorry but there are currently no running Crumbs to Do for '${name}'</i>
	</g:if>
	
	<br />
	<h2>All Crumbs</h2>
	
	<div class="list">
		<table>
			<thead>	
				<tr>
					<td>Name</td>
					<td>Entries</td>
					<td>Owner</td>
					<td>State</td>
				</tr>
			</thead>
			
			<tbody>	
				<g:each in="${allCrumbs}" var="aC">
		    	<tr>
		    		<td>
		    			<a href="${createLink(action:'edit', controller:'crumb')}?id=${aC.id}">${aC.name}</a>
		    		</td>		    		
		    		
		    		<td>
		    			<g:link action="showResults" controller="crumb" id="${aC.id}">${fieldValue(bean: aC, field: "countJobs")}</g:link>
		    			| <g:link action="analyse" controller="crumb" id="${aC.id}">Analyse</g:link>
		    		</td>
		    		<td>${aC.user}</td>
		    		<td>
		    		<g:if test="${aC.nextDate == null}">
		    			<a href="${createLink(action:'startJob', controller:'scheduler')}/${aC.id}">Start</a>
		    		</g:if>
		    		<g:else>
		    			<a href="${createLink(action:'stopJob', controller:'scheduler')}/${aC.id}">Stop</a></i>
		    		</g:else>
		    		</td>
				</tr>
				</g:each>
			</tbody>
		</table>
	</div>
	<g:if test="${allCrumbs.isEmpty()}">
		<i>Sorry but there are currently no Crumbs in this App</i>
	</g:if>
	
</body>
</html>