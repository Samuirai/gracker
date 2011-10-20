<html>
<head>
	<meta name='layout' content='main'/>
</head>
<body>
	<span>
		<h1>Error<sec:loggedInUserInfo field="username"/><br /></h1>
		
		<p>
			We're sorry but an Error occured while saving the User.<br />
			Please try later again to register.
		</p>
		
		<p>
			<b>${flash.error}</b>
		</p>
		
		
	</span>
</body>
</html>