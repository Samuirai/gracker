<g:each in="${jobList}" status="i" var="job">
	tmp = [];
	<g:each in="${job}" status="j" var="d">
		tmp.push(new Array(${i},${j},"${d}","${attTypes?.get(j)}"));
	</g:each>
	jobs.push(tmp);
</g:each>
