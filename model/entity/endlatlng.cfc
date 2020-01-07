component extends="mura.bean.beanORM" entityName="endlatlng" table="msendlatlng" usetrash=true {

	property name="id" required=true type="string" message="The Strava ID is required";
	property name="activityid" fieldtype="id";
    property name="end_latlng" fieldtype="string";
	property name="activity" fieldtype="many-to-one" fkcolumn="activityid" cfc="activity" lazy="true";

}
