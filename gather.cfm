<h1>Get Data from Movies </h1>
<cfset CountPag = 1> 
<!--- Loop until CountVar = 5 because each page return 20 records --->
<cfloop condition = "CountPag LESS THAN OR EQUAL TO 5"> 

	<cfhttp url="https://api.themoviedb.org/3/discover/movie?with_genres=878&primary_release_year=2015&certification=R&sort_by=popularity.desc&api_key=c99a785a40b3043bb1ca0518fba174bf&page=#CountPag#" method="GET" /> ;
	<cfset CountPag = CountPag + 1> 

	<cfset cfData=DeserializeJSON(CFHTTP.FileContent)> 

	<cfdump var="#cfData#">

	<cfloop array = "#cfData.results#" index = "row" >

		<!---
		<cfoutput>#row.id# - #row.title#  #structKeyExists(row, "backdrop_path")# <br> </cfoutput>
		--->

        <cfif NOT isdefined("row.backdrop_path")>
        	<cfset row.backdrop_path = "">
        </cfif>
		
		<cfquery  name="insert" datasource="cc">
			insert into movies
			 ( id,
			   adult,
			   backdrop_path,
			   genre_ids,
			   original_language,
			   original_title, 
			   overview, 
			   popularity, 
			   release_date, 
			   title,  
			   video, 
			   vote_average,
			   vote_count
			 ) 
			VALUES 
			 ( <cfqueryparam value = "#row.id#" cfsqltype="cf_sql_integer">,
			   <cfqueryparam value = "#row.adult#" cfsqltype="cf_sql_varchar">,
			   <cfqueryparam value = "#row.backdrop_path#" cfsqltype="cf_sql_varchar">,
			   <cfqueryparam value = "#arraytoList(row.genre_ids,"|")#" cfsqltype="cf_sql_varchar">,
			   <cfqueryparam value = "#row.original_language#" cfsqltype="cf_sql_varchar">,
			   <cfqueryparam value = "#row.original_title#" cfsqltype="cf_sql_varchar">, 
			   <cfqueryparam value = "#row.overview#" cfsqltype="cf_sql_varchar">, 
			   <cfqueryparam value = "#row.popularity#" cfsqltype="cf_sql_float">, 
			   <cfqueryparam value = "#row.release_date#" cfsqltype="cf_sql_date" >, 
			   <cfqueryparam value = "#row.title#" cfsqltype="cf_sql_varchar">,  
			   <cfqueryparam value = "#row.video#" cfsqltype="cf_sql_integer">, 
			   <cfqueryparam value = "#row.vote_average#" cfsqltype="cf_sql_float">,
			   <cfqueryparam value = "#row.vote_count#" cfsqltype="cf_sql_integer">
			 );  
		</cfquery>
	</cfloop>
</cfloop>

<cfquery name="MoviesQry" datasource="cc">
	SELECT title, release_date, vote_count
	  FROM movies
	 ORDER BY vote_count DESC  
</cfquery> 

<cfoutput>
	<table border="2" cellspacing="2" cellpadding="2">
		<thead>
			<tr>
				<th>Row</th>		
				<th>Title</th>		
				<th>Release Date</th>
				<th>Vote Count</th>
			</tr>
		</thead>
</cfoutput>

<cfloop query="MoviesQry">
	<cfoutput>
		<tr>
			<td>#MoviesQry.currentRow#</td>		
			<td>#MoviesQry.title#</td>		
			<td align="center">#dateformat(MoviesQry.release_date,"short")#</td>		
			<td align="center">#MoviesQry.vote_count#</td>		
		</tr>
	</cfoutput>
</cfloop> 



