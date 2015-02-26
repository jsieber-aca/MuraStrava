/*

This file is part of MuraFW1

Copyright 2010-2014 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component persistent="false" accessors="true" output="false" extends="controller" {

	// *********************************  PAGES  *******************************************

    public any function athleteProfile(required rc) {
        rc.athleteProfile = application.muraStrava.getCurrentAthlete();
    }


    public any function default(required rc) {
		// rc.varName = 'whatever';
	}

    private any function importActivities(required rc, perPage) {
        var continue = true;
        var page = 1;
        var stravaActivities = "";
        var activity = {};
        var theActivity = {}
        var keyListIgnore = "returnFormat,removeobjects, errors, frommuracache, isnew, instanceid, addobjects, activityid, athlete";
        /*
        param name="theActivity.achievement_count" default="";
        param name="theActivity.athlete_count" default="";
        param name="theActivity.athleteid" default="";
        param name="theActivity.average_cadence" default="";
        param name="theActivity.average_heartrate" default="";
        param name="theActivity.average_speed" default="";
        param name="theActivity.average_temp" default="";
        param name="theActivity.average_watts" default="";
        param name="theActivity.calories" default="";
        param name="theActivity.comment_count" default="";
        param name="theActivity.commute" default="";
        param name="theActivity.description" default="";
        param name="theActivity.device_watts" default="";
        param name="theActivity.kilojoules" default="0";
        param name="theActivity.average_watts" default="0";
        param name="theActivity.truncated" default="";
        */

        //writeDump(var="#page#", abort=true);

        while (continue eq true) {
            stravaActivities = application.muraStrava.getActivities(arguments.perPage, page, 1);
            //writeDump(var="#stravaActivities#", abort=true);
            if(arrayLen(stravaActivities) lt arguments.perPage){
                continue = false;
            }else{
                page++;
            }

            for (activity in stravaActivities){
                //writeDump(var="#activity#", top=2, abort=true);
                theActivity = $.getBean('activity').loadBy(id=activity.id);

                if(theActivity.getIsNew()){
                    //writeDump(var="#theActivity.getAllValues()#", top=3, abort=true);
                    try{
                        for (key in theActivity.getAllValues()){
                            if(!listContainsNoCase(keyListIgnore, key)){
                                if(!structKeyExists(activity, key)){
                                    //writeoutput(key & "<br />");
                                    activity["#key#"] = "";

                                }
                            }
                        }
                        //writeDump(var="#activity#", abort=true);
                        //abort;
                        activity["athleteid"] = activity.athlete.id;
                        //structDelete(activity, "athlete");

                        theActivity.setAllValues(activity);

                        theActivity.save();
                        if(isStruct(theActivity.getErrors()) AND !structIsEmpty(theActivity.getErrors())){
                            writeDump(var="#theActivity.getErrors()#", top=3, abort=false);
                            writeDump(var="#theActivity.getAllValues()#", top=3, abort=true);
                        }
                        writeDump(var="#theActivity.getactivityId()#", top=3, abort=false, label="new record");
                    }
                    catch(any e){
                        writedump(var="#e#", top=3, abort=true);
                    }
                }else{
                     writeDump(var="#theActivity.getactivityId()#", top=3, abort=false, label="not new");
                }
            }
        }
    }

	public any function importAthlete(required rc) {
        rc.stravaAthlete = application.muraStrava.getCurrentAthlete();
        rc.athlete = $.getBean('athlete').loadBy(id=rc.stravaAthlete.id);

        //writeDump(var="#rc.athlete.getAllValues()#", abort=true);
        //writeDump(var="#rc.stravaAthlete#", abort=true);
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

        //save athlete shoe properties
        var shoes = rc.stravaAthlete.shoes;
        for (shoe in shoes) {
            rc.shoe = $.getBean('shoe').loadBy(id=shoe.id);
            shoe.shoeathleteId = rc.athlete.getAthleteID();
            shoe.isPrimary = shoe.primary;
            if(!rc.shoe.getIsNew()){
                shoe.shoeId = rc.shoe.getshoeID();
            }
            rc.shoe.setAllValues(shoe);
            rc.shoe.save();
        }

        //save athlete club properties
        var clubs = rc.stravaAthlete.clubs;
        for (club in clubs) {
            rc.club = $.getBean('club').loadBy(id=club.id);
            club.clubathleteId = rc.athlete.getAthleteID();
            if(!rc.club.getIsNew()){
                club.clubId = rc.club.getclubID();
            }
            rc.club.setAllValues(club);
            rc.club.save();
        }

        var activities = importActivities(rc, 200);
    }

    public any function login(required rc) {
		// writeDump(var="#rc.pluginconfig.getsettings().client_id#", abort=true);
		rc.authurl = application.muraStrava.generateAuthUrl(application.callback);

	}

	public any function callback(required rc) {
		param name="url.code" default="";
		param name="url.state" default="";
		param name="url.error" default="";
		rc.result = application.muraStrava.validateResult(url.code, url.error);

		if (rc.result.status) {
			$.currentUser('stravaToken', rc.result.token);
			$.currentUser().save();
			fw.redirect(action='admin:main');
		}
	}

}
