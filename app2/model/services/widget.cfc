component extends="mura.bean.beanORMVersioned" entityName="widget" table="widgets" {

	property name="widgetid" fieldtype="id";
	property name="name" type="string" length="100" required=true message="The name attribute is required an must be.";
	property name="options" singularname="option" fieldtype="one-to-many" cfc="option" cascade="delete"; 
}