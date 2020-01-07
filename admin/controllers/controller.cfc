/*

This file is part of MuraFW1

Copyright 2010-2014 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

	NOTES:
		All ADMIN controllers should EXTEND this file.

*/
component persistent="false" accessors="true" output="false" extends="mura.cfobject" {

	property name='$';
	property name='fw';

	public any function init (required any fw) {
		setFW(arguments.fw);
	}

	public any function before(required struct rc) {
		if ( StructKeyExists(rc, '$') ) {
			var $ = rc.$;
			set$(rc.$);
		}
		// writedump(var="#request#", abort=true, top=3);
		// Verify that API login has been setup.
<<<<<<< HEAD
		//$.currentUser('access_token', '');
		if ( ! len( $.currentUser('access_token')) && ! findNoCase("login", request.action) && ! findNoCase("callback", request.action) ) {
=======
		if ( ! len( $.currentUser('stravaToken')) && ! findNoCase("login", request.action) && ! findNoCase("callback", request.action) ) {
>>>>>>> c4d25150914c1f8990f027ba38f623d3d3301121
			fw.redirect(action='admin:main.login');
		}

		// easy access to site attributes
		// rc.settingsManager = rc.$.getBean('settingsManager');
		// rc.siteBean = rc.settingsManager.getSite(rc.$.siteConfig('siteid'));
		// rc.siteName = rc.siteBean.getSite();
		// rc.rsAllSites = rc.settingsManager.getList();
		// rc.rsSites = rc.pc.getAssignedSites();
		// rc.listSites = ValueList(rc.rsSites.siteid);

		if ( rc.isFrontEndRequest ) {
			location(url='#rc.$.globalConfig('context')#/', addtoken=false);
		}

	}

}
