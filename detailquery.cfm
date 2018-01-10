<cfcomponent output="false">
  <cffunction name="getDetail" access="remote" returnType="struct" returnFormat="json" output="false">
    <cfargument name="id" type="numeric" required="true" />

    <cfset var movie = structNew() />
	<cfquery name="DetailQry" datasource="cc">
		SELECT title, backdrop_path, popularity, overview
		  FROM movies
		 WHERE id =  <cfqueryparam value = "#id#" cfsqltype="cf_sql_integer">
	</cfquery> 

	<cfloop query="#DetailQry#">
   		<cfset movie["title"] = #DetailQry.title# />
   		<cfset movie["backdrop_path"] = 'https://image.tmdb.org/t/p/w300_and_h450_bestv2/#DetailQry.backdrop_path#'/>
   		<cfset movie[" popularity"] = #DetailQry.popularity# />
   		<cfset movie["overview"] = #DetailQry.overview# />
 	</cfloop> 	

    <cfreturn movie />
  </cffunction>
</cfcomponent>


<!---cfquery name="DetailQry" datasource="cc">
	SELECT backdrop_path, popularity, overview
	  FROM movies
	 WHERE id =  <cfqueryparam value = "#id#" cfsqltype="cf_sql_integer">
</cfquery> 

<cfloop query="#DetailQry#">
	<cfoutput>
		<tr>
			<td>
				<img src='https://image.tmdb.org/t/p/w300_and_h450_bestv2/#DetailQry.backdrop_path#' width="300px">
			</td>		
			<td>#DetailQry.popularity#</td>		
			<td>#DetailQry.overview#</td>
		</tr>
	</cfoutput>
<---/cfloop> 


