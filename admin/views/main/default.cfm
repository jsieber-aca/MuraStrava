<cfsilent>
<!---

This file is part of MuraFW1

Copyright 2010-2014 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
</cfsilent>
<cfoutput>
	<h2>Welcome to Mura Strava!</h2>
	<p>The Mura Strava plugin utilizes the <a href="http://strava.github.io/api/">Strava API</a> to allow the user to store and display Strava data within Mura CMS.</p>
<!--- --->
    <cfset $.currentUser('stravaToken', '') /> 
<cfset $.currentUser().save() /> 
<cfdump var="#$.currentUser('stravaToken')#" top=3>
</cfoutput>
