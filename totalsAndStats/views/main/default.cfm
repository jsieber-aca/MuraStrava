<cfoutput>
    <cfset data = rc.totalsAndStatsData />
    <div id="runningStats">
        <h3>Running</h3>
        <h4>Recent Runs (Last 4 weeks)</h4>
            <dl class="dl-horizontal">
                <dt>Count:</dt>
                <dd>#data.recent_run_totals.count#</dd>
                <dt>Distance:</dt>
                <dd>#decimalFormat(application.muraStrava.convertMetersToMiles(data.recent_run_totals.distance))# miles</dd>
                <dt>Moving time:</dt>
                <dd>#application.muraStrava.convertSecondsToTimeString(data.recent_run_totals.moving_time)#</dd>
                <dt>Elapsed time:</dt>
                <dd>#application.muraStrava.convertSecondsToTimeString(data.recent_run_totals.elapsed_time)#</dd>
                <dt>Elevation gain:</dt>
                <dd>#numberFormat(application.muraStrava.convertMetersToFeet(data.recent_run_totals.elevation_gain), ",")# feet</dd>
                <dt>Achievement count:</dt>
                <dd>#data.recent_run_totals.achievement_count#</dd>
            </dl>
         <h4>Year To Date Runs</h4>
            <dl class="dl-horizontal">
                <dt>Count:</dt>
                <dd>#data.ytd_run_totals.count#</dd>
                <dt>Distance:</dt>
                <dd>#decimalFormat(application.muraStrava.convertMetersToMiles(data.ytd_run_totals.distance))# miles</dd>
                <dt>Moving time:</dt>
                <dd>#application.muraStrava.convertSecondsToTimeString(data.ytd_run_totals.moving_time)#</dd>
                <dt>Elapsed time:</dt>
                <dd>#application.muraStrava.convertSecondsToTimeString(data.ytd_run_totals.elapsed_time)#</dd>
                <dt>Elevation gain:</dt>
                <dd>#numberFormat(application.muraStrava.convertMetersToFeet(data.ytd_run_totals.elevation_gain), ",")# feet</dd>
            </dl>
        <h4>All Time Runs</h4>
            <dl class="dl-horizontal">
                <dt>Count:</dt>
                <dd>#data.all_run_totals.count#</dd>
                <dt>Distance:</dt>
                <dd>#decimalFormat(application.muraStrava.convertMetersToMiles(data.all_run_totals.distance))# miles</dd>
                <dt>Moving time:</dt>
                <dd>#application.muraStrava.convertSecondsToTimeString(data.all_run_totals.moving_time)#</dd>
                <dt>Elapsed time:</dt>
                <dd>#application.muraStrava.convertSecondsToTimeString(data.all_run_totals.elapsed_time)#</dd>
                <dt>Elevation gain:</dt>
                <dd>#numberFormat(application.muraStrava.convertMetersToFeet(data.all_run_totals.elevation_gain), ",")# feet</dd>
            </dl>
    </div>

    <div id="ridingStats">
        <h3>Riding</h3>
        <h4>Recent Riding (Last 4 weeks)</h4>
            <dl class="dl-horizontal">
                <dt>Count:</dt>
                <dd>#data.recent_ride_totals.count#</dd>
                <dt>Distance:</dt>
                <dd>#decimalFormat(application.muraStrava.convertMetersToMiles(data.recent_ride_totals.distance))# miles</dd>
                <dt>Moving time:</dt>
                <dd>#application.muraStrava.convertSecondsToTimeString(data.recent_ride_totals.moving_time)#</dd>
                <dt>Elapsed time:</dt>
                <dd>#application.muraStrava.convertSecondsToTimeString(data.recent_ride_totals.elapsed_time)#</dd>
                <dt>Elevation gain:</dt>
                <dd>#numberFormat(application.muraStrava.convertMetersToFeet(data.recent_ride_totals.elevation_gain), ",")# feet</dd>
                <dt>Achievement count:</dt>
                <dd>#data.recent_ride_totals.achievement_count#</dd>
            </dl>
        <h4>Year To Date Rides</h4>
            <dl class="dl-horizontal">
                <dt>Count:</dt>
                <dd>#data.ytd_ride_totals.count#</dd>
                <dt>Distance:</dt>
                <dd>#decimalFormat(application.muraStrava.convertMetersToMiles(data.ytd_ride_totals.distance))# miles</dd>
                <dt>Moving time:</dt>
                <dd>#application.muraStrava.convertSecondsToTimeString(data.ytd_ride_totals.moving_time)#</dd>
                <dt>Elapsed time:</dt>
                <dd>#application.muraStrava.convertSecondsToTimeString(data.ytd_ride_totals.elapsed_time)#</dd>
                <dt>Elevation gain:</dt>
                <dd>#numberFormat(application.muraStrava.convertMetersToFeet(data.ytd_ride_totals.elevation_gain), ",")# feet</dd>
            </dl>
        <h4>All Time Rides</h4>
            <dl class="dl-horizontal">
                <dt>Count:</dt>
                <dd>#data.all_ride_totals.count#</dd>
                <dt>Distance:</dt>
                <dd>#decimalFormat(application.muraStrava.convertMetersToMiles(data.all_ride_totals.distance))# miles</dd>
                <dt>Moving time:</dt>
                <dd>#application.muraStrava.convertSecondsToTimeString(data.all_ride_totals.moving_time)#</dd>
                <dt>Elapsed time:</dt>
                <dd>#application.muraStrava.convertSecondsToTimeString(data.all_ride_totals.elapsed_time)#</dd>
                <dt>Elevation gain:</dt>
                <dd>#numberFormat(application.muraStrava.convertMetersToFeet(data.all_ride_totals.elevation_gain), ",")# feet</dd>
                <dt>Biggest ride distance:</dt>
                <dd>#decimalFormat(application.muraStrava.convertMetersToMiles(data.biggest_ride_distance))# miles</dd>
                <dt>Biggest climb:</dt>
                <dd>#numberFormat(application.muraStrava.convertMetersToFeet(data.biggest_climb_elevation_gain), ",")# feet</dd>
            </dl>
    </div>
</cfoutput>
