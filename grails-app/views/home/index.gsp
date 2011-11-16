<html>
<head>
	<meta name='layout' content='main'/>
</head>
<body>
	<span>
		
			<div class="small_crumblist">
				<h1>Welcome <sec:loggedInUserInfo field="username"/></h1>
				<br />				
				<p>
					If you have at least a little knowledge of HTML and always wanted to track
					data from the Internet quick, automated and with the possibility create
					fancy graphics from your result then <b>Your search is over</b>
				</p>
				<br />
				<p>
					Gracker is an awesome tool to track anything you want. 
					Check out some crumbs from the public list on the left. 
					Or just register an account and try it yourself.
				</p>
				<br><br>
				<iframe width="450" height="260" src="http://www.youtube.com/embed/-cxjQ-fyezY" frameborder="0" allowfullscreen></iframe>
				
			</div>
			<div class="small_crumblist">
				<h1>Public Crumbs</h1>
                <table>
                    <tbody>
                    <g:each in="${crumbInstanceList}" status="i" var="crumbInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td>
                            	<g:link action="show" controller="crumb" id="${crumbInstance.id}">${fieldValue(bean: crumbInstance, field: "name")}</g:link><br>
                            	<span style="color: #999999;">by ${fieldValue(bean: crumbInstance, field: "user")}</span>
                            </td>
                            <td>${fieldValue(bean: crumbInstance, field: "description")}</td>
                            <td>
                            	<g:link action="showResults" controller="crumb" id="${crumbInstance.id}">${fieldValue(bean: crumbInstance, field: "countJobs")}</g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <g:if test="${crumbInstanceTotal}">
				<g:paginate total="${crumbInstanceTotal}" />
				</g:if>
            </div>
		
	</span>
</body>
</html>