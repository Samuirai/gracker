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
	<div class="list">
		<table>
			<thead>
				<tr>
					<td>Date</td>
					<g:each in="${attNames}" var="a">
						<td>${a}</td>
					</g:each>
				</tr>
				<tr>
					<td><i>Date</i></td>
					<g:each in="${attTypes}" var="a">
						<td><i>${a}</i></td>
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