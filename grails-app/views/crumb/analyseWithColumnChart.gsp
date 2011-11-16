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

  	var anz = 0;
      function setValues() {
    	  <g:each in="${jobList}" status="i" var="job">
			<g:each in="${job}" status="j" var="d"><g:if test="${attTypes?.get(j) == 'Number'}">data.setValue(${i}, ${j-1}, ${d});</g:if></g:each>
			anz = ${i};
			data.addRow();
		</g:each>
      }
		function init() {
			data = new google.visualization.DataTable();
			<g:each in="${attNames}" status="i" var="a">
				<g:if test="${attTypes?.get(i) == 'Number'}">
		        	data.addColumn('number', '${a}');
		        </g:if>
	        </g:each>
	        data.addRow();
	        setValues();
	        drawChart();
		}

      var crumbID = ${crumbId};
    	
      function test() {
        
		$.ajax({
			  type: "POST",
			  url: "${createLink(controller:'crumb', action:'updateAnalyse')}",
			  data: "id1="+crumbID+"&id2="+(anz+1),
			}).done(function( msg ) {
				eval(msg);
				window.setTimeout("test()", 1000);
		});
		
      }

      window.setTimeout("test()", 1000);

    </script>
    
    <input type="button" onClick="test()">
	 
	 <h1>Example values</h1>
	<div class="list">
		<table>
			<thead>
				<tr>
					<g:each in="${attNames}" status="i" var="a">
						<td>${a}: <i style="color: #aaaaaa;">${attTypes.get(i)}</i></td>
					</g:each>
				</tr>
			</thead>
				<g:if test="${jobList?.size()>5}">
					<tbody>
						<g:each in="${jobList[0..5]}" var="job">
				    	<tr>
				    		<g:each in="${job}" var="d">
				    			<td>${d}</td>
				    		</g:each>
						</tr>
						</g:each>
					</tbody>
				</g:if>
				<g:if test="${jobList?.size()<=5 && jobList?.size()>0}">
					<tbody>
						<g:each in="${jobList[0..jobList?.size()-1]}" var="job">
				    	<tr>
				    		<g:each in="${job}" var="d">
				    			<td>${d}</td>
				    		</g:each>
						</tr>
						</g:each>
					</tbody>
				</g:if>
		</table>
	</div>
	
		
	
</body>
</html>