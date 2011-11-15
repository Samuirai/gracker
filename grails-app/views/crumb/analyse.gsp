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
	Chart:
	<div id="chart_div"></div>
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<script type="text/javascript">
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      var data;
      function drawChart() {
        data = new google.visualization.DataTable();
        data.addColumn('string', 'Online Users');
        data.addColumn('number', 'Online Users');
        data.addRows(2);

        <g:each in="${jobList}" status="i" var="job">
			data.setValue(${i}, 1, ${job.get(1)});
			data.addRows(1);
		</g:each>
        
        

        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
        chart.draw(data, {width: 900, height: 300, title: 'German Bash', curveType: 'function'});
        
      }

    </script>
    
    <input type="button" onClick="test()">
	
	
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