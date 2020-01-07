<cfoutput>

<cfset rc.$.event("currentNextNID",rc.$.content('contentID'))>

<cfif not len(rc.$.event("nextNID")) or rc.$.event("nextNID") eq rc.$.event("currentNextNID")>
	<cfif rc.$.content('NextN') gt 1>
		<cfset rc.currentNextNIndex=rc.$.event("startRow")>
		<cfset rc.iterator.setStartRow(rc.currentNextNIndex)>
	<cfelse>
		<cfset rc.currentNextNIndex=rc.$.event("pageNum")>
		<cfset rc.iterator.setPage(rc.currentNextNIndex)>
	</cfif>
<cfelse>
	<cfset rc.currentNextNIndex=1>
	<cfset rc.iterator.setPage(1)>
</cfif>

<cfset rc.nextN=rc.$.getBean('utility').getNextN(rc.iterator.getQuery(),rc.$.content('nextN'),rc.currentNextNIndex)>

<cfif rc.iterator.recordCount()>

	<cfif rc.nextn.numberofpages gt 1>
		#rc.$.dspObject_Include(thefile='dsp_nextN.cfm')#
	</cfif>
	<cfloop condition="#rc.iterator.hasNext()#">
		<cfset item = rc.iterator.next() />
		<cfset map = item.getMapsQuery() />

	  <!---
    <cfdump var="#item.getAllValues()#" abort=true>
		--->
		<!---		<cfset rc.contentBean = getBean("content").loadBy(contentID="#item.getContentID()#",siteID=$.event("siteID")) /> --->
				<div class="blog-items margin-btm40">

							<cfif map.summary_polyline neq "">
									<a href="/sport/activity/?id=#item.getactivityid()#" class="hover-color">
										<!--- Mapbox static map based on summary_polyline --->
										<img class="img-responsive" src="https://api.mapbox.com/v4/mapbox.streets/path(#urlEncode(map.summary_polyline)#)/auto/600x400.png?access_token=#$.getPlugin('muraStrava').getSettings().mapboxAccessToken#" alt="Activity Map">
									</a>
							</cfif>


							<h1><a href="/sport/activity/?id=#item.getactivityid()#" class="hover-color">#item.getName()#</a></h1>
									<ul class="list-inline blog-post-list">
											<li><i class="ion-calendar"></i> #dateFormat(item.getstart_date(), "medium")#</li>
											<li>|</li>
											<!--- <li><a href="##" class="hover-color"><i class="ion-ios7-person"></i> By #item.getLastUpdateBy()#</a></li>
											<li>|</li> --->
											<li>#item.getType()#</li>
											<li>|</li>
											<li>#decimalFormat(application.muraStrava.convertMetersToMiles(item.getdistance()))# miles</li>
											<li>|</li>
											<li>#decimalFormat(application.muraStrava.convertMetersToFeet(item.gettotal_elevation_gain()))# feet</li>
											<li>|</li>
											<li>#application.muraStrava.totalTimeFromSec(item.getMoving_time())# moving time</li>
									</ul>

							#item.getSummary()#
							<p class="blog-post-more"><a href="/sport/activity/?id=#item.getactivityid()#" class="btn btn-dark btn-xs">View</a></p>

				</div>
	</cfloop>

	<cfif rc.nextn.numberofpages gt 1>
		#rc.$.dspObject_Include(thefile='dsp_nextN.cfm')#
	</cfif>

<cfelse>
	<p class=""alert alert-danger"">No activities exist!</p>
</cfif>
</cfoutput>
