/*

This file is part of MuraFW1

Copyright 2010-2014 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component persistent="false" accessors="true" output="false" extends="controller" {

	// *********************************  PAGES  *******************************************

    public any function athleteProfile(required rc) {
        rc.athleteProfile = application.muraStrava.getCurrentAthlete($.currentUser('stravaToken'));
    }


    public any function default(required rc) {
		// rc.varName = 'whatever';
	}

	public any function importAthlete(required rc) {
        rc.stravaAthlete = application.muraStrava.getCurrentAthlete($.currentUser('stravaToken'));
        rc.athlete = $.getBean('athlete').loadBy(id=rc.stravaAthlete.id);

        //writeDump(var="#rc.athlete.getAllValues()#", abort=true);
        //writeDump(var="#rc.stravaAthlete.bikes#", abort=true);
        // save athlete properties
        // set athleteId if record already exists.
        if(!rc.athlete.getIsNew()){
            rc.stravaAthlete.athleteId = rc.athlete.getAthleteID();
        }

        rc.athlete.setAllValues(rc.stravaAthlete);

        rc.athlete.save();
        //writeDump(var="#rc.athlete.getAllValues()#", abort=true);
        //save athlete bike properties
        var bikes = rc.stravaAthlete.bikes;
        for (bike in bikes) {
            rc.bike = $.getBean('bike').loadBy(id=bike.id);
            bike.bikeathleteId = rc.athlete.getAthleteID();
            if(!rc.bike.getIsNew()){
            bike.bikeId = rc.bike.getbikeID();
            }
            rc.bike.setAllValues(bike);
            rc.bike.save();
        }

    }

    public any function login(required rc) {
		// writeDump(var="#rc.pluginconfig.getsettings().client_id#", abort=true);
		rc.authurl = application.muraStrava.generateAuthUrl(application.callback);

	}

	public any function callback(required rc) {
		param name="url.code" default="";
		param name="url.state" default="";
		param name="url.error" default="";
		//writeDump(var="#application.muraStrava.convertCelsiusToFahrenheit(0)#", abort=true);
		rc.result = application.muraStrava.validateResult(url.code, url.error);

		if (rc.result.status) {
			$.currentUser('stravaToken', rc.result.token);
			$.currentUser().save();
			fw.redirect(action='admin:main');
		}
	}

}
