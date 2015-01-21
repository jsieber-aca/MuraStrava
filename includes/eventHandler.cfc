/*

This file is part of MuraFW1

Copyright 2010-2014 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component persistent="false" accessors="true" output="false" extends="mura.plugin.pluginGenericEventHandler" {

	// framework variables
	include 'fw1config.cfm';

	// ========================== Mura CMS Specific Methods ==============================
	// Add any other Mura CMS Specific methods you need here.

	public void function onApplicationLoad(required struct $) {
		// trigger FW/1 to reload
		lock scope='application' type='exclusive' timeout=20 {
			getApplication().setupApplicationWrapper(); // this ensures the appCache is cleared as well
		};

		// register this file as a Mura eventHandler
		variables.pluginConfig.addEventHandler(this);

		//Get site bound Mura scope instance
		$=application.serviceFactory.getBean('$').init('develop');

		//Register Mura Strava entities
		$.getServiceFactory()
			.declareBean(beanName='athlete',dottedPath='plugins.MuraStrava.model.entity.athlete', isSingleton=false)
			.getBean('athlete')
			.checkSchema();

		$.getServiceFactory()
			.declareBean(beanName='bike',dottedPath='plugins.MuraStrava.model.entity.bike', isSingleton=false)
			.getBean('bike')
			.checkSchema();

		$.getServiceFactory()
			.declareBean(beanName='activity',dottedPath='plugins.MuraStrava.model.entity.activity', isSingleton=false)
			.getBean('activity')
			.checkSchema();

        /*
        $.getServiceFactory()
			.declareBean(beanName='gear',dottedPath='plugins.MuraStrava.model.entity.gear', isSingleton=false)
			.getBean('gear')
			.checkSchema();
        */
		
application.muraStrava = new plugins.MuraStrava.model.service.strava(variables.pluginConfig.getsettings().client_id, variables.pluginConfig.getsettings().client_secret);
		application.callback = "http://local.john-sieber.com/plugins/MuraStrava/index.cfm?MuraStravamsaction=main.callback";
	}

	public void function onSiteRequestStart(required struct $) {
		// make the methods in displayObjects.cfc accessible via $.packageName.methodName()
		arguments.$.setCustomMuraScopeKey(variables.framework.package, new displayObjects());
		//arguments.$.setCustomMuraScopeKey('muraStrava', new plugins.MuraStrava.model.service.strava());
	}

	public any function onRenderStart(required struct $) {
		arguments.$.loadShadowboxJS();
	}

	// ========================== Helper Methods ==============================

	private any function getApplication() {
		if( !StructKeyExists(request, '#variables.framework.applicationKey#Application') ) {
			request['#variables.framework.applicationKey#Application'] = new '#variables.framework.package#.Application'();
		};
		return request['#variables.framework.applicationKey#Application'];
	}

}
