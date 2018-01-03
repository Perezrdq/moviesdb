
<cfset process = "detail">

<cfif process eq "detail">
	<cfquery name="MoviesQry" datasource="cc">
				SELECT id, title, release_date, vote_count
				  FROM movies
	</cfquery>

	<cfloop query="MoviesQry">
		<cfoutput>#MoviesQry.currentRow#</cfoutput>	
		<cfoutput>#MoviesQry.id#</cfoutput>			
		<cfoutput>#MoviesQry.title#</cfoutput>		
		<cfoutput>#dateformat(MoviesQry.release_date,"short")#</cfoutput>		
		<cfoutput>#MoviesQry.vote_count#</cfoutput>	
		<br/>	
	</cfloop>
</cfif>
