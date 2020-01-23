<cfoutput>
    <cfif structKeyExists(rc, "activityID")>
        <cfdump var="#rc.theActivity.getAllValues()#" top=2>
    <cfelse>
        <form action="#buildURL('admin:main.detailedActivity')#" name="activity" method="post">
            <label>Activity ID</label>
            <input name="activityID" type="text" placeholder="Strava ActivityID">
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </cfif>
</cfoutput>