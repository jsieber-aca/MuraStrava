component extends="mura.bean.beanORMVersioned" entityName="option" table="widgetoptions" {

	property name="optionid" fieldtype="id";
	property name="name" type="string" length="100" required=true message="The name attribute is required an must be.";
	property name="widget" fieldtype="many-to-one" cfc="widget" fkcolumn="widgetid";
}