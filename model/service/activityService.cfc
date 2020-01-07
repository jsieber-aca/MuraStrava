component persistent="false" accessors="true" output="false" extends="mura.cfobject" {

  public function updateActivity(required struct MuraScope, required struct activity, required any map){
    var $ = arguments.MuraScope;
    // WriteDump(var=arguments.activity.getAllValues(), abort=true);
    var activity = arguments.activity;

    var stravaActivity = application.muraStrava.getActivityMap(arguments.activity.getId());
    var keyListIgnore = "returnFormat,removeobjects, errors, frommuracache, isnew, instanceid, addobjects, athlete, gear";
    //writedump(var=activity.getMapsIterator(), abort=true);
    //writedump(var=map.getAllValues(), abort=false);
    for (key in activity.getAllValues()){
        //writeDump(var=stravaActivity, abort=true);
        if(!listContainsNoCase(keyListIgnore, key)){
            if(!structKeyExists(stravaActivity, key)){
                // writeoutput(key & "<br />");
                stravaActivity["#key#"] = "";
            }
        }
    }

    stravaActivity["athleteid"] = stravaActivity.athlete.id;
    stravaActivity["activityId"] = activity.getActivityId();

    activity.setAllValues(stravaActivity);

    try{
      activity.save();
    } catch(any e){
      writedump(var=e, abort=true);
    }
    //WriteDump(var=activity.getAllValues(), abort=false);
    //WriteDump(var=activity.getMapsQuery(), abort=true);
    //Update Map Object
    activiy.map = updateMap($, activity);
    //Update Gear object
    activity.gear = updateGear($, activity);
    return activity;
  }

  public function updateGear(required struct MuraScope, required struct activity){
    var $ = arguments.MuraScope;
    var gear = $.getBean('gear').loadBy(id=activity.getGear_Id());
    var gearStruct = arguments.activity.getGear();
    // writeDump(var=gear.getAllValues(), abort=true, label="Gear Object");
    gearStruct["gearId"] = gear.getGearId();
    gearStruct["activityId"] = arguments.activity.getActivityId();
    try{
    gear.setAllValues(gearStruct);
      //writeDump(var=gear.getAllValues(), abort=true, label="Gear Object");

      gear.save();
      //writeDump(var=gear.getAllValues(), abort=true, label="Gear Object");

    } catch(any e){
      WriteDump(var=e, abort=true);
    }
    return gear;
  }
  
  private function updateMap(required struct MuraScope, required struct activity){
    var $ = arguments.MuraScope;
    var map = $.getBean('map').loadBy(id=activity.get('map').id);
    var mapStruct = arguments.activity.get('map');
    mapStruct["mapId"] = map.getMapId();
    mapStruct["activityId"] = arguments.activity.getActivityId();
    try{
      map.setAllValues(mapStruct);
      map.save();
    } catch(any e){
      WriteDump(var=e, abort=true);
    }
    return map;
  }
}
