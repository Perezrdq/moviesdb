<h1>i'm Here</h1>

<cfquery  name="MoviesQry" datasource="cc">
	SELECT title, release_date, vote_count
	  FROM movies
	 LIMIT 20
	 ORDER BY vote_count DESC  
</cfquery> 
