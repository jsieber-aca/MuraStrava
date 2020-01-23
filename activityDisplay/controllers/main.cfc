/*

This file is part of MuraFW1

Copyright 2010-2014 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component persistent="false" accessors="true" extends="controller" output="false" {

	// ********************************* PAGES *******************************************

    public any function default(required struct rc) {
		//var activity = rc.$.getBean('activity').getFeed().getQuery();
        rc.activity = rc.$.getBean('activity').loadBy(id=265848318).getAllValues();


        //rc.totalsAndStatsData = application.muraStrava.getTotalsAndStats(athleteID);
        //writeDump(var="#rc.totalsAndStatsData#", abort=true);
    }

}
