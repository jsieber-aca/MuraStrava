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

		public any function createPages(required rc){
			var activities = $.getBean('activity').getFeed();
			it = activities.getIterator();
			//activities = activities.getFeed();
			while ( it.hasNext() ) {
			  var activity = it.next();
						//B0CF0D4F-0D4E-468D-941CC56BD066977E contentID of Activities Folder
						writeDump(var=activity.getAllValues(), abort=true);


			}

			writeDump(var=it, abort=true);
		}

    public any function default(required rc) {
		// rc.varName = 'whatever';
	}

    private any function importActivities(required rc, perPage) {
        var continue = true;
        var page = 1;
        var stravaActivities = "";
        var activity = {};
				var map = {};
        var theActivity = {};
		var theMap = {};
		var map = {};
		var results = {newActivities="", skippedActivities=""};
		var newActivities = [];
		var skippedActivities = [];
    var keyListIgnore = "returnFormat,removeobjects, errors, frommuracache, isnew, instanceid, addobjects, activityid, athlete,upload_id";
		var stravaActivityDetail = "";

		//	theActivity = $.getBean('activity').loadBy(id='632721629');
		//	WriteDump(var=theActivity.getMapsQuery(), abort=true);
		//writeLog(text="start", file="importActivity");
	  	//abort;
        while (continue eq true) {
            stravaActivities = application.muraStrava.getActivities(arguments.perPage, page);
            // writeDump(var="#stravaActivities#", abort=true);
            if(arrayLen(stravaActivities) lt arguments.perPage){
                continue = false;
            }else{
                page++;
            }

            for (activity in stravaActivities){
                //writeDump(var="#activity#", top=2, abort=true);
                theActivity = $.getBean('activity').loadBy(id=activity.id);
								theMap = theActivity.getMap();
                //writedump(var=theActivity.getActivityId(), abort=false);
                //writedump(var=theMap.getActivityId(), abort=false);
                if(theActivity.getIsNew()){
										//writeLog(text="New activity - #activity.id#", file="importActivity");
                    //writeDump(var="#theActivity.getAllValues()#", top=3, abort=true);
                    try{
											  //activityDetail = application.muraStrava.getActivityMap(activity.id);
												//WriteDump(var=activityDetail, abort=true );
                        for (key in theActivity.getAllValues()){
                            if(!listContainsNoCase(keyListIgnore, key)){
                                if(!structKeyExists(activity, key)){
                                    //writeoutput(key & "<br />");
                                    activity["#key#"] = "";

                                }
                            }
                        }
                        //writeDump(var="#theActivity.get('activityid')#", abort=true);
                        activity["id"] = theActivity.get('id');
                        activity["activityId"] = theActivity.get('activityid');
                        activity["athleteid"] = activity.athlete.id;
                        map["activityid"] = theActivity.get('activityid');
												map["id"] = activity.map.id;
												map["resource_state"] = activity.map.resource_state;
												map["summary_polyline"] = ((StructKeyExists(activity.map, "summary_polyline")) ? activity.map.summary_polyline : "");
												map["polyline"] = ((StructKeyExists(activity.map, "polyline")) ? activity.map.polyline : "");
                        //writeDump(var=map, abort=false);
                        theMap.setAllValues(map);
                        theMap.save();
                        //writeDump(var=theMap.getAllValues(), abort=false);
                        if(isStruct(theMap.getErrors()) AND !structIsEmpty(theMap.getErrors())){
                            writeDump(var="#theMap.getErrors()#", top=3, abort=false);
                            writeDump(var="#theMap.getAllValues()#", top=3, abort=true);
                        }
                      	theActivity.setAllValues(activity);
                        //theActivity.addMap(activity.map);

                        //writeDump(var=theActivity.getAllValues(), abort=true);
                        //WriteDump(var=map, abort=true);
												//theActivity.addMap(activity.map);

						            theActivity.save();

                        //WriteDump(var=theActivity.getAllValues(), abort=true);
                        //WriteDump(var=theActivity.getMap().getAllValues(), abort=true);

												newActivities.append(theActivity.getName());

                        if(isStruct(theActivity.getErrors()) AND !structIsEmpty(theActivity.getErrors())){
                            writeDump(var="#theActivity.getErrors()#", top=3, abort=false, label="Error Struct");
                            writeDump(var="#theActivity.getAllValues()#", top=3, abort=false, label="Activity Values");
                        }
                        //writeDump(var="#theActivity.getactivityId()#", top=3, abort=false, label="new record");
                    }
                    catch(any e){
                        writedump(var="#e#", top=3, abort=false);
            						writeDump(var="#theActivity.getErrors()#", top=3, abort=false);
            						writeDump(var="#theActivity.getAllValues()#", top=3, abort=true);
                    }
                }else{

						skippedActivities.append(theActivity.getName());

						//writeLog(text="Existing activity - #activity.id#", file="importActivity");
                     	//writeDump(var="#theActivity.getactivityId()#", top=3, abort=false, label="not new");
                }
				structUpdate(results, "newActivities", newActivities);
				structUpdate(results, "skippedActivities", skippedActivities);
            }

        }
		return results;
    }

	public any function importAthlete(required rc) {
        rc.stravaAthlete = application.muraStrava.getCurrentAthlete();
        rc.athlete = $.getBean('athlete').loadBy(id=rc.stravaAthlete.id);

				//writeLog(text="start", file="importActivity");
			  //writeDump(var="I'm here.", abort=true);

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

        rc.activities = importActivities(rc, 200);
    }

    public any function login(required rc) {
		// writeDump(var="#rc.pluginconfig.getsettings().client_id#", abort=true);
		rc.authurl = application.muraStrava.generateAuthUrl(application.callback);

	}

	public any function callback(required rc) {
		param name="url.code" default="";
    param name="url.scope" default="";
		param name="url.state" default="";
		param name="url.error" default="";
		rc.result = application.muraStrava.validateResult(url.code, url.error);
    //writeDump(var=rc.result, label="callback results", abort=true);
		if (rc.result.status) {
			$.currentUser('access_token', rc.result.access_token);
      $.currentUser('refresh_token', rc.result.refresh_token);
      $.currentUser('expires_at', rc.result.expires_at);
			$.currentUser().save();
			fw.redirect(action='admin:main');
		}
	}

}
