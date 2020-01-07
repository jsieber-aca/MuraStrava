<cfoutput>
	<h2>Athlete - #rc.athleteProfile.firstname# #rc.athleteProfile.lastname#</h2>
    
    <div>
        <img src="#rc.athleteProfile.profile#" alt="#rc.athleteProfile.firstname# #rc.athleteProfile.lastname# profile image" />
    </div>
    <dl class="dl-horizontal">
        <dt>Sex</dt>
        <dd>#rc.athleteProfile.sex#</dd>
        <dt>City</dt>
        <dd>#rc.athleteProfile.city#</dd>
        <dt>State</dt>
        <dd>#rc.athleteProfile.state#</dd>
        <dt>Country</dt>
        <dd>#rc.athleteProfile.country#</dd>
        <dt>Strava Profile Created</dt>
        <dd>#dateFormat(rc.athleteProfile.created_at, "medium")#</dd>
        <dt>Athletes Followed</dt>
        <dd>#rc.athleteProfile.friend_count#</dd>
        <dt>Followers</dt>
        <dd>#rc.athleteProfile.follower_count#</dd>
    </dl>
    
    <h3>Bikes</h3>
    <dl class="dl-horizontal">
        <cfloop array="#rc.athleteProfile.bikes#" index="local.bike">
            <dt>#local.bike.name#</dt>
            <dd>#decimalFormat(application.muraStrava.convertMetersToMiles(local.bike.distance))# miles</dd>
        </cfloop>
    </dl>
    <h3>Shoes</h3>
    <dl class="dl-horizontal">
        <cfloop array="#rc.athleteProfile.shoes#" index="local.shoe">
            <dt>#local.shoe.name#</dt>
            <dd>#decimalFormat(application.muraStrava.convertMetersToMiles(local.shoe.distance))# miles</dd>
        </cfloop>
    </dl>
    
    <h3>Clubs</h3>
    <dl class="dl-horizontal">
        <cfloop array="#rc.athleteProfile.clubs#" index="local.club">
            <dt>#local.club.name#</dt>
        </cfloop>
    </dl>
        
</cfoutput>