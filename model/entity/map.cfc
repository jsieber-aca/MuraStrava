component extends="mura.bean.beanORM" entityName="map" table="msmap" usetrash=true {
	property name="mapid" fieldtype="id";
	property name="id" required=true type="string" message="The Strava ID is required";
	//property name="activityid" datatype="varchar";
	property name="summary_polyline" datatype="text" required=false;
	property name="polyline" datatype="text" required=false;
	property name="resource_state" datatype="int" required=false;
	property name="activity" fieldtype="many-to-one" fkcolumn="activityid" cfc="activity";

}
