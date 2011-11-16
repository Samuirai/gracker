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
	
	<div style="height:10px;"></div>
	
	<g:link action="analyse" id="${crumbId}">Back to chart selection</g:link>
	
	<div></div>
	
	<div id="chart_div" style="width:680px;float:left;">
	</div>
	<div style="float:left;width:220px;padding-top:50px;">
		<b>Show the following graphs:</b>
		<br />&nbsp;<br />
		<form name="graph_options">
		<g:each in="${attNames}" status="i" var="a">
			<g:if test="${attTypes?.get(i) == 'Number'}">
		    	<input id="graph${i}" type="checkbox" style="vertical-align:bottom;" checked="checked" onclick="refreshChart()" /> ${a}<br />
	    	</g:if>
	    </g:each>
	    </form>
	</div>
	<div style="clear:left;">
	</div>
	
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<script type="text/javascript">
	
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(init);
      var data;

	  function refreshChart() {
		  init();
		  drawChart();
	  }
      
      function drawChart() {
        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
        chart.draw(data, {width:600, height: 300, title: 'German Bash', curveType: 'function'});
      }

  	  var anz = 0;
  	  
      function setValues() {
    	  <g:each in="${jobList}" status="i" var="job">
    	  	var k = 0;
			<g:each in="${job}" status="j" var="d">
				<g:if test="${attTypes?.get(j) == 'Number'}">
					if(document.getElementById('graph${j}').checked == true) {
						data.setValue(${i}, k, ${d});
						k++;
					}
				</g:if>
			</g:each>
			anz = ${i};
			data.addRow();
		  </g:each>
      }
      
	  function init() {
	  	data = new google.visualization.DataTable();
		<g:each in="${attNames}" status="i" var="a">
			<g:if test="${attTypes?.get(i) == 'Number'}">
				if(document.getElementById('graph${i}').checked == true) {
		    		data.addColumn('number', '${a}');
				}
		    </g:if>
	    </g:each>
	    data.addRow();
	    setValues();
	    drawChart();
 	  }

      var crumbID = ${crumbId};
    	
      function refresh() {
          
			$.ajax({
				  type: "POST",
				  url: "${createLink(controller:'crumb', action:'updateAnalyse')}",
				  data: "id1="+crumbID+"&id2="+(anz+1),
				}).done(function( msg ) {
					eval(msg);
					if(document.getElementById('live-view').checked == true) {
						window.setTimeout("refresh()", 1000);
					}
			});
		
      }

      function activateRefresh() {

        	if(document.getElementById('live-view').checked == true) {
      			window.setTimeout("refresh()", 1000);
      		}
      		
      }

    </script>
    
    <input id="live-view" type="checkbox" style="vertical-align:top;" onclick="activateRefresh()" enabled=false /> <b>Enable live-view</b>
	
</body>
</html>