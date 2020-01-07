component extends="mura.bean.beanORM" entityName="startlatlng" table="msstartlatlng" usetrash=true {

	property name="id" required=true type="string" message="The Strava ID is required";
	property name="activityid" fieldtype="id";
    property name="start_latlng" fieldtype="string";
	property name="activity" fieldtype="many-to-one" fkcolumn="activityid" cfc="activity" lazy="true";

}
