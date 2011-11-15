<g:each in="${jobList}" status="i" var="job">
	<g:each in="${job}" status="j" var="d">
		<g:if test="${attTypes?.get(j) == 'Number'}"> 
			data.setValue(${i+id2}, ${j-1}, ${d});
		</g:if>
		anz = ${i+id2};
	</g:each>
	data.addRows(1);
</g:each>

drawChart();