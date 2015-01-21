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
    property name="time_zone" type="string" length="50";
    property name="start_latlng" type="text";
    property name="end_latlng" type="text";
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
    property name="trainer" type="boolean";
	property name="commute" type="boolean";
	property name="manual" type="boolean";
	property name="private" type="boolean";
	property name="flagged" type="boolean";
	property name="workout_type" type="integer";
	//create workout type table
    property name="gear_id" type="string" length="25";
	//create gear table
    property name="average_speed" type="float";
	property name="max_speed" type="float";
	property name="average_cadence" type="float";
	property name="average_temp" type="integer";
	property name="average_watts" type="float";
	property name="weighted_average_watts" type="integer";
	property name="kilojoules" type="float";
	property name="device_watts" type="boolean";
	property name="average_heartrate" type="float";
	property name="max_heartrate" type="integer";
	property name="calories" type="float";
	property name="truncated" type="integer";
	property name="has_kudoed" type="boolean";
	//segment_efforts not sure how to best handle yet.
	//splits_metric
	//splits_standard
	//best_efforts
	property name="athlete" fieldtype="many-to-one" cfc="athlete" fkcolumn="athleteid";




}
