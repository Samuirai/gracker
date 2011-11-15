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
      google.setOnLoadCallback(init);
      var data;

      
      function drawChart() {
        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
        chart.draw(data, {width: 900, height: 300, title: 'German Bash', curveType: 'function'});
        
      }

      function setValues() {
    	  <g:each in="${jobList}" status="i" var="job">
			<g:each in="${job}" status="j" var="d">
				<g:if test="${attTypes?.get(j) == 'Number'}"> 
					data.setValue(${i}, ${j-1}, ${d});
					data.addRows(1);
				</g:if>
			</g:each>
		</g:each>
      }

		function init() {
			data = new google.visualization.DataTable();
			<g:each in="${attNames}" status="i" var="a">
				<g:if test="${attTypes?.get(i) == 'Number'}">
		        	data.addColumn('number', '${a}');
		        </g:if>
	        </g:each>
	        data.addRows(2);
	        setValues();
	        drawChart();
		}
    	
      function test() {
		data.setValue(1, 1, 1);
		data.addRows(1);
		data.setValue(2, 1, 2);
		data.addRows(1);
		data.setValue(1, 1, 1);
		data.addRows(1);
		data.setValue(3, 1, 4);
		data.addRows(1);
		data.setValue(4, 1, 3);
		data.addRows(1);
		drawChart();
      }

    </script>
    
    <input type="button" onClick="test()">
	 
	
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