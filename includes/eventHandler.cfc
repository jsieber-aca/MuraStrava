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
		// This is how you could register a 'model' directory in a plugin
		arguments.m.globalConfig().registerModelDir('/plugins/MuraStrava/model/');

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
			.declareBean(beanName='shoe',dottedPath='plugins.MuraStrava.model.entity.shoe', isSingleton=false)
			.getBean('shoe')
			.checkSchema();

		$.getServiceFactory()
			.declareBean(beanName='club',dottedPath='plugins.MuraStrava.model.entity.club', isSingleton=false)
			.getBean('club')
			.checkSchema();

		$.getServiceFactory()
			.declareBean(beanName='activity',dottedPath='plugins.MuraStrava.model.entity.activity', isSingleton=false)
			.getBean('activity')
			.checkSchema();

		$.getServiceFactory()
			.declareBean(beanName='map',dottedPath='plugins.MuraStrava.model.entity.map', isSingleton=false)
			.getBean('map')
			.checkSchema();

		$.getServiceFactory()
			.declareBean(beanName="gear", dottedPath='plugins.MuraStrava.model.entity.gear', isSingleton=false)
			.getBean('gear')
			.checkSchema();

		application.muraStrava = new plugins.MuraStrava.model.service.strava(variables.pluginConfig.getsettings().client_id, variables.pluginConfig.getsettings().client_secret, variables.pluginConfig.getsettings().client_token);
		application.activityService = new plugins.MuraStrava.model.service.activityService();
		application.callback = "https://john-sieber.com/plugins/MuraStrava/index.cfm?MuraStravamsaction=main.callback";

		var APIUtility = getBean('settingsManager').getSite('johnsieber').getAPI('json', 'v1');
		APIUtility.registerEntity(entityName='activity', config={fields='activityid,name,description,type,start_date_local,achievement_count,kudos_count,distance,moving_time,elapsed_time,total_elevation_gain,average_cadence,average_speed, max_speed,suffer_score,calories,average_heartrate,max_heartrate,map,mapid',allowfieldselect=true,public=true});
		APIUtility.registerEntity(entityName='map', config={fields='id,resource_state,summary_polyline,activityid,mapid,polyline',allowfieldselect=true,public=true});
	}

	public void function onSiteRequestStart(required struct $) {
		// make the methods in displayObjects.cfc accessible via $.packageName.methodName()
		arguments.$.setCustomMuraScopeKey(variables.framework.package, new displayObjects());
		//arguments.$.setCustomMuraScopeKey('muraStrava', new plugins.MuraStrava.model.service.strava());
	}

    // display plugin display object at top of shoe page
    public any function onPageShoeBodyRender(required struct $) {


    // writeDump(var="#arguments.$.content().getImageURL(size='large')#", top=2, abort=true);
    var newBody = "#arguments.$.murastrava.dspShoeData()# <p><img src='#arguments.$.content().getImageURL(size=617)#' alt='#arguments.$.content().getTitle()#' /></p> #arguments.$.setDynamicContent($.content('body'))#";

    //$.content('body', newBody);
    return newBody;
    }
    public any function onPageActivityBodyRender(required struct $){
			if(! len($.event('id'))){
				location(url="/sport/activities/", addToken=false);
			}
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
