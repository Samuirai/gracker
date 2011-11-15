<html>
<head>
	<title>Gracker | Crumb Result</title>
	<meta name='layout' content='main'/>
</head>
<body>
	
	<h1>Crumb Result for '${crumbName}'</h1>
	
	<p>
		<b>${flash.message}</b><br/>
	</p>
	<br />
	
	<h2>Results</h2>	
	<g:link action="analyse" id="${crumbId}">Analyse...</g:link>
	<div class="list">
		<table>
			<thead>
				<tr>
					<g:each in="${attNames}" status="i" var="a">
						<td>${a}: <i style="color: #aaaaaa;">${attTypes.get(i)}</i></td>
					</g:each>
				</tr>
			</thead>
			<tbody>
				<g:each in="${jobList}" var="job">
		    	<tr>
		    		<g:each in="${job}" var="d">
		    		<td>${d}</td>
		    		</g:each>
				</tr>
				</g:each>
			</tbody>
		</table>
	</div>
	<g:if test="${jobList?.isEmpty()}">
		<i>Sorry but there is no data tracked for '${crumbName}' yet</i>
	</g:if>
	
</body>
</html>