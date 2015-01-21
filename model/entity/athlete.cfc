component extends="mura.bean.beanORM" entityName="athlete" table="msathletes" usetrash=true {

	property name="athleteid" fieldtype="id" unique="true";
    property name="id" required=true type="integer" unique="true" message="The Strava ID is required.";
    property name="resource_state" type="integer";
	property name="firstname" type="string" length="100" required=true message="The firstname attribute is required.";
    property name="lastname" type="string" length="100" required=true message="The lastname attribute is required.";
    property name="profile_medium" type="string" length="255";
    property name="profile" type="string" length="255";
    property name="city" type="string" length="100";
    property name="state" type="string" length="50";
    property name="country" type="string" length="100";
    property name="sex" type="string" length="4";
    //property name="friend" type="string" length="10";
    //property name="follower" type="string" length="10";
    property name="premium" type="string";
    property name="created_at" fieldtype="timestamp";
    property name="updated_at" fieldtype="timestamp";
    property name="approve_followers" type="string";
    property name="follower_count" type="integer";
    property name="friend_count" type="integer";
    property name="mutual_friend_count" type="integer";
    property name="date_preference" type="string" length="50";
    property name="measurement_preference" type="string" length="10";
    property name="email" type="string" length="150";
    //property name="ftp" type="string";
	property name="bikes" singularname="bike" fieldtype="one-to-many" cfc="bike" cascade="delete";
	//property name="gears" singularname="gear" fieldtype="one-to-many" cfc="gear" fkcolumn="athleteid"  cascade="all";
	//property name="gears" singularname="gear" type="array" fieldtype="one-to-many" cfc="gear" fkcolumn="athleteid";
}
