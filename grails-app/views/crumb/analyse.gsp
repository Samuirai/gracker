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
	
	<br />&nbsp;<br />
	
	<h3>Make a choice and use your favorite chart to display your results.</h3>	
	
	<div style="height:30px;"></div>
	
	<g:link action="analyseWithPieChart" id="${crumbId}" style="display:block;width:271px;float:left;text-decoration:none;">
		<div>
			<span style="color:#000;font-weight:bold;">Pie Chart</span>
			<div style="border:1px solid #666;width:269px;height:175px;text-align:center;">
				<div style="height:15px;"></div>
				<img src="${resource(dir:'images',file:'pie_chart.png')}" />
			</div>
		</div>
	</g:link>
	
	<g:link action="analyseWithLineChart" id="${crumbId}" style="display:block;width:271px;float:left;text-decoration:none;margin-left:50px;">
	<div>
		<span style="color:#000;font-weight:bold;">Line Chart</span>
		<div style="border:1px solid #666;width:269px;height:175px;text-align:center;">
			<div style="height:15px;"></div>
			<img src="${resource(dir:'images',file:'line_chart.png')}" />
		</div>
	</div>
	</g:link>
	
	<g:link action="analyseWithColumnChart" id="${crumbId}" style="display:block;width:271px;float:left;text-decoration:none;margin-left:50px;">
	<div>
		<span style="color:#000;font-weight:bold;">Column Chart</span>
		<div style="border:1px solid #666;width:269px;height:175px;text-align:center;">
			<div style="height:15px;"></div>
			<img src="${resource(dir:'images',file:'column_chart.png')}" />
		</div>
	</div>
	</g:link>
	
	<div style="clear:left;height:30px;"></div>
	
</body>
</html>