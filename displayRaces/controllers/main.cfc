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
        rc.pc.addToHTMLHeadQueue('headQueue.cfm');
				rc.feed = rc.$.getBean('activity').getFeed();
				rc.feed.setSortBy('start_date');
				rc.feed.setSortDirection('desc');
			  rc.feed.addParam(
				field='msactivities.workout_type'
				, relationship='AND'
				, condition='EQUALS'
				, criteria='1'
				, dataType='numeric'
			);
			  /*
			  feed.addParam(
			  	field='{table}.{field}'
			  	, relationship='{AND | AND ( | OR ( | ) | OR}'
			  	, condition='{EQUALS|IN|NOT IN|GT|LT|NEQ|GTE|LTE|BEGINS|CONTAINS}'
			  	, criteria='{value}'
			  	, dataType='{varchar|numeric|timestamp|...}'
			    );
			*/
				rc.iterator = rc.feed.getIterator();

				rc.iterator.setNextN(20);
				rc.$.content('nextN', 20);
	}
}
