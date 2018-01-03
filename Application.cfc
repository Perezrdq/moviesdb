<cfcomponent output="false">
	
	<!--- Application name, should be unique --->
	<cfset this.name = "TESTPROJECTS">
	<!--- How long application vars persist --->
	<cfset this.applicationTimeout = createTimeSpan(0,2,0,0)>
	<!--- Should client vars be enabled? --->
	<cfset this.clientManagement = true>
	<!--- Where should we store them, if enable?
	<cfset this.clientStorage = "cc"> --->
	<!--- Where should cflogin stuff persist --->
	<cfset this.loginStorage = "session">
	<!--- Should we even use sessions? --->
	<cfset this.sessionManagement = true>
	<!--- How long do session vars persist? --->
	<cfset this.sessionTimeout = createTimeSpan(0,0,20,0)>
	<!--- Should we set cookies on the browser? --->
	<cfset this.setClientCookies = true>
	<!--- should cookies be domain specific, ie, *.foo.com or www.foo.com --->
	<cfset this.setDomainCookies = false> 
	<!--- should we try to block 'bad' input from users --->
	<cfset this.scriptProtect = "none">
	<!--- should we secure our JSON calls? --->
	<cfset this.secureJSON = false>
	<!--- Should we use a prefix in front of JSON strings? --->
	<cfset this.secureJSONPrefix = "">
	<!--- Used to help CF work with missing files and dir indexes --->
	<cfset this.welcomeFileList = "">
	
	<!--- define custom coldfusion mappings. Keys are mapping names, values are full paths  --->
	<!--- 
	<cfset this.mappings = {} >
	<cfset this.mappings["/mapTeeTimes"] = "/usr/local/apache2/htdocs/golfrewards/teetimes" >
	 --->
	
	<!--- define a list of custom tag paths. --->
	<cfset this.customtagpaths = "">
	
	<!---  --->
	<cfset this.testing_ip_list = "168.103.143.187,207.225.37.1,96.18.154.64">
	
	
	
	
	<!--- Run when application starts up --->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">				
		<cfreturn true>
	</cffunction>
	

	<!--- Run when application stops --->
	<cffunction name="onApplicationEnd" returnType="void" output="false">
		<cfargument name="applicationScope" required="true">
	</cffunction>

	
	<!--- Fired when user requests a CFM that doesn't exist. --->
	<cffunction name="onMissingTemplate" returnType="boolean" output="false">
		<cfargument name="targetpage" required="true" type="string">		
		<cfset msg = "Sorry, file you are looking for [#arguments.targetpage#] does not exists.">
		<cfreturn true>
	</cffunction>
	
	
	<!--- Run before the request is processed --->
	<cffunction name="onRequestStart" returnType="boolean" output="false">
		<cfargument name="thePage" type="string" required="true">
		
		
		
		
		
		<cfreturn true>
	</cffunction>
	
	
	
	<!--- Runs before request as well, after onRequestStart --->
	<!--- 
	WARNING!!!!! THE USE OF THIS METHOD WILL BREAK FLASH REMOTING, WEB SERVICES, AND AJAX CALLS. 
	DO NOT USE THIS METHOD UNLESS YOU KNOW THIS AND KNOW HOW TO WORK AROUND IT!
	EXAMPLE: http://www.coldfusionjedi.com/index.cfm?mode=entry&entry=ED9D4058-E661-02E9-E70A41706CD89724
	
	<cffunction name="onRequest" returnType="void">
		<cfargument name="thePage" type="string" required="true">
		
		<cfscript>
			if( structkeyexists(request,"common") )
				common = request.common ;
			if( structkeyexists(request,"validate") )
				validate = request.validate ;
			if( structkeyexists(request,"TTDisplay") )
				TTDisplay = request.TTDisplay ;
			
			request.testing_ip_list = "168.103.143.187,207.225.37.1,96.18.154.64";		
				
		</cfscript>
		
		<cfinclude template="#arguments.thePage#">
	</cffunction>
	--->
	

	<!--- Runs at end of request --->
	<cffunction name="onRequestEnd" returnType="void" output="true">
		<cfargument name="thePage" type="string" required="true">
		
		
		<cftry>
			<cfinclude template="/config/cf/dsp.environment.cfm">			
			<cfcatch type="any">
				<cf_catchlog owner='michael,brady' 
		            dump="cfcatch,form,cgi,session" 
		            prod="true" 
		            prefix="adminpublish/Application.cfc OnRequestEnd.ERROR" 
		            mail="true" 
		            ignore="false" 
		        />
			</cfcatch>
		</cftry>

	</cffunction>
	
	
	<!--- Runs on error --->
	<cffunction
        name="OnError"
        access="public"
        returntype="void"
        output="true"
        hint="Fires when an exception occures that is not caught by a try/catch.">

        <!--- Define arguments. --->
        <cfargument
            name="Exception"
            type="any"
            required="true"
            />

        <cfargument
            name="EventName"
            type="string"
            required="false"
            default=""
            />


        <cfdump var="#arguments.Exception#">
        <!--- Return out. --->
        <cfreturn />
    </cffunction>

	
	
	<!--- Runs when your session starts --->
	<cffunction name="onSessionStart" returnType="void" output="false">
	</cffunction>

	
	
	<!--- Runs when session ends --->
	<cffunction name="onSessionEnd" returnType="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true">
		<cfargument name="appScope" type="struct" required="false">
	</cffunction>
</cfcomponent>