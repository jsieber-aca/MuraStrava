component extends="mura.bean.beanORM" entityName="shoe" table="msshoes" usetrash=true {

	property name="id" required=true type="string" message="The Strava ID is required";
	property name="shoeid" fieldtype="id";
    property name="shoeathleteid" fieldtype="string";
	property name="name" type="string" length="255";
    property name="resource_state" type="integer";
	property name="isPrimary" type="string" length="10";
    property name="distance" type="float";
	property name="athlete" fieldtype="many-to-one" fkcolumn="athleteid" cfc="athlete" lazy="true";
}
