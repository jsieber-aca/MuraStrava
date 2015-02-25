component extends="mura.bean.beanORM" entityName="club" table="msclubs" usetrash=true {

	property name="id" required=true type="string" message="The Strava ID is required";
	property name="clubid" fieldtype="id";
    property name="clubathleteid" fieldtype="string";
	property name="name" type="string" length="255";
    property name="resource_state" type="integer";
	property name="profile_medium" type="string" length="255";
	property name="athlete" fieldtype="many-to-one" fkcolumn="athleteid" cfc="athlete" lazy="true";
}
