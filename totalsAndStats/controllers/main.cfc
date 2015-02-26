/*

This file is part of MuraFW1

Copyright 2010-2014 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component persistent="false" accessors="true" extends="controller" output="false" {

	// ********************************* PAGES *******************************************

	public any function sample(required struct rc) {

		// if we need some service...
		//rc.thisIsJustSomeRCVariable = variables.sampleService.doSomeService();

		// example of accessing the parentBeanFactory (Mura) to get a bean
		//rc.jsonSerializerBean = variables.beanFactory.getBean('jsonSerializer');
	}

    public any function default(required struct rc) {
        var athleteId = application.muraStrava.getCurrentAthlete().id;
        rc.totalsAndStatsData = application.muraStrava.getTotalsAndStats(athleteID);
        //writeDump(var="#rc.totalsAndStatsData#", abort=true);
    }

}
