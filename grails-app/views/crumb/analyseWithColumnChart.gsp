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
	
	<div id="chart_div" style="width:860px;float:left;">
	</div>
	<div id="debug"> </div>
	<div style="float:left;width:110px;padding-top:50px;">
		<b>Use the following data:</b>
		<br />&nbsp;<br />
		<form name="graph_options">
		<g:each in="${attNames}" status="i" var="a">
			<g:if test="${attTypes?.get(i) == 'Number'}">
		    	<input id="graph${i}" type="checkbox" style="vertical-align:bottom;" checked="checked" onclick="refreshChart()" /> ${a}<br />
	    	</g:if>
	    </g:each>
	    </form>
	    <b>Change the interpretation:</b>
	    <br />&nbsp;<br />
	     <input type="radio" class="interpretation" name="interpretation" value="standard" checked="checked" onClick="interpret(this)"> standard<br>
	     <input type="radio" class="interpretation" name="interpretation" value="min-max" onClick="interpret(this)" > min-max<br>
	</div>
	<div style="clear:left;">
	</div>
	
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<script type="text/javascript">
	
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(init);
      var data;
      var jobs = [];
      var types = [];
      var anz = 0;

	  function refreshChart() {
		  if($(".interpretation:checked").val()=="min-max") {
				drawChart1();
			} else if($(".interpretation:checked").val()=="standard") {
				drawChart();
			}
	  }

	  function interpret(e) {
		if($(".interpretation:checked").val()=="min-max") {
			drawChart1();
		} else if($(".interpretation:checked").val()=="standard") {
			drawChart();
		}
	}

	// STANDARD DRAW
      function drawChart() {
  	  	data = new google.visualization.DataTable();

	    for (col in types) {
	    	if(types[col][1] != "Date") {
	  			if(document.getElementById('graph'+col) && document.getElementById('graph'+col).checked == true) {
	    		  	data.addColumn(types[col][1].toLowerCase(), types[col][0]);
	  			}
	    	  }
	    	if(types[col][1] == "Date") {
	    		  	data.addColumn('string', types[col][0]);
	    		  	
	    	  }
  	  	}
    	  anz = 0;
    	  	for (job in jobs) {
        	  	var i = 0;
        	  	data.addRow();
    	  		for (col in jobs[job]) {
    	  	  		
    	  			if(jobs[job][col][3] == "Number") {
		    	  	  	//alert('graph'+col)
	    	  	  		if(document.getElementById('graph'+col) && document.getElementById('graph'+col).checked == true) {
	  						data.setValue(parseInt(job), parseInt(i), parseFloat(jobs[job][col][2]));
	  						i++;
	    	  	  		}
    	  	  		}
    	  			if(jobs[job][col][3] == "Date") {
		    	  	  	date = new Date(jobs[job][col][2]);
  						data.setValue(parseInt(job), parseInt(i), date.getHours()+":"+date.getMinutes()+" "+date.getDate()+"."+date.getMonth()+"."+date.getFullYear() );
  						i++;
    	  	  		}
    	  		}
    			anz++;
    	  	}
          
        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
        chart.draw(data, {width:860, height: 300, title: 'German Bash', curveType: 'function'});
      }
     // ENDE STANDARD DRAW
     
     // MIN-MAX DRAW
      function drawChart1() {
  	  	data = new google.visualization.DataTable();
  	  	data.addColumn("string", "Data");
	    data.addColumn("number", "min");
	    data.addColumn("number", "max");
	    i=0;
      	for (col in types) {
      	  //data.addRow();  
    	  if(types[col][1] != "Date") {
    		  if(document.getElementById('graph'+col) && document.getElementById('graph'+col).checked == true) {
					
	    	  min = 'a';
	    	  max = 0.0;
	    	  for (job in jobs) {
	    			if(min=='a' || parseFloat(jobs[job][col][2])<min) {
						min = parseFloat(jobs[job][col][2]);
					}
	
	    			if(parseFloat(jobs[job][col][2])>max) {
						max = parseFloat(jobs[job][col][2]);
					}
	    	  }
	          data.addRow();
	    	  data.setValue(parseInt(i),0,types[col][0])
	      	  data.setValue(parseInt(i),1,min)
	          data.setValue(parseInt(i),2,max)	
	    	  //data.setValue(col,1,1)
	    	  //data.setValue(col,2,2)
	   		  //data.setValue(col,0,"asd")
	   		  i++
    		  }
    	  }
      }
          
        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
        chart.draw(data, {width:860, height: 300, title: 'German Bash', curveType: 'function'});
      }
     // ENDE MIN-MAX DRAW
  	  
		var tmp = [];
  	  function initArray() {
  	  	
  		<g:each in="${jobList}" status="i" var="job">
  			tmp = [];
			<g:each in="${job}" status="j" var="d">
					tmp.push(new Array(${i},${j},"${d}","${attTypes?.get(j)}"));
			</g:each>
			jobs.push(tmp);
			anz = ${i};
		 </g:each>
  	  }
  	  
	
      
	  function init() {
	  	types = [];
	  	<g:each in="${attNames}" status="i" var="a">
		  	tmp = new Array("${a}","${attTypes?.get(i)}");
		  	types.push(tmp);
	    </g:each>
	    initArray();
	    refreshChart();
 	  }

      var crumbID = ${crumbId};
    	
      function refresh() {
          
			$.ajax({
				  type: "POST",
				  url: "${createLink(controller:'crumb', action:'updateAnalyse')}",
				  data: "id1="+crumbID+"&id2="+(anz+1),
				}).done(function( msg ) {
					eval(msg);
					refreshChart();
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