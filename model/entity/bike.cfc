component extends="mura.bean.beanORM" entityName="bike" table="msbikes" usetrash=true {

	property name="id" required=true type="string" message="The Strava ID is required";
	property name="bikeid" fieldtype="id";
    property name="bikeathleteid" fieldtype="string";
    property name="isprimary" type="string";
	property name="name" type="string" length="255" required=true message="The name attribute is required.";
	property name="distance" type="float";
	property name="brand_name" type="string" length="150";
	property name="model_name" type="string" length="150";
	property name="frame_type" type="string" length="50";
	property name="description" type="text";
    property name="resource_state" type="integer";
	property name="athlete" fieldtype="many-to-one" fkcolumn="athleteid" cfc="athlete" lazy="true";

}
