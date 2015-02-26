component extends="mura.bean.beanORM" entityName="activity" table="msactivities" usetrash=true {

	property name="activityid" fieldtype="id";
    property name="id" required=true type="integer" message="The Strava ID is required";
    property name="athleteid" type="string";
    property name="resource_state" type="integer";
	property name="name" type="string" length="255" required=true message="The name attribute is required.";
    property name="description" type="text";
    property name="distance" type="float";
    property name="moving_time" type="integer";
    property name="elapsed_time" type="integer";
    property name="total_elevation_gain" type="float";
    property name="type" type="string" length="50";
    property name="start_date" type="timestamp";
    property name="start_date_local" type="timestamp";
    property name="timezone" type="string" length="50";
    //property name="start_latlng" type="string";
    //property name="end_latlng" type="string";
    property name="location_city" fieldtype="string" length="255";
	property name="location_state" fieldtype="string" length="100";
    property name="location_country" fieldtype="string" length="100";
	property name="achievement_count" type="integer";
    property name="kudos_count" type="integer";
    property name="comment_count" type="integer";
    property name="athlete_count" type="integer";
	property name="photo_count" type="integer";
	// property name="map_id" type="string";
	//create map table
    //property name="trainer" type="string";
	property name="commute" type="string";
	property name="manual" type="string";
	property name="private" type="string";
	property name="flagged" type="string";
	property name="workout_type" type="string";
	//create workout type table
    property name="gear_id" type="string" length="25";
	//create gear table
    property name="average_speed" type="float";
	property name="max_speed" type="float";
	property name="average_cadence" type="string" required=false;
	property name="average_temp" type="string";
	property name="average_watts" type="string";
	property name="weighted_average_watts" type="string";
	property name="kilojoules" type="string" required=false;
	property name="device_watts" type="string" required=false;
	property name="average_heartrate" type="string";
	property name="max_heartrate" type="string";
	property name="calories" type="string";
	property name="truncated" type="string";
	property name="has_kudoed" type="string";
	//segment_efforts not sure how to best handle yet.
	//splits_metric
	//splits_standard
	//best_efforts
	//property name="athlete" fieldtype="many-to-one" cfc="athlete" fkcolumn="athleteid";




}
