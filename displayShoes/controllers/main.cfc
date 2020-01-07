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
        var athleteId = application.muraStrava.getCurrentAthlete().id;
        rc.shoes = application.muraStrava.getCurrentAthlete().shoes;
        var shoeFound = 0;
        //writeDump(var="#rc.shoes#", abort=true);
        for (shoe in rc.shoes){
            //writeDump(var="#shoe#", abort=true);
            if(shoe.id eq rc.$.getcontentBean().getshoeId()){
                //var mileage = "<dt>Current Mileage:</dt><dd>#decimalFormat(application.muraStrava.convertMetersToMiles(shoe.distance))#</dd>";
                //var purchaseDate = "<dt>Purchase Date:</dt><dd>#rc.$.content('purchaseDate')#</dd>";
                var retirementDate = (len(rc.$.content('retirementDate'))) ? rc.$.content('retirementDate') : "--";
                //writeOutput("<dl>#mileage# #purchaseDate# #retirementDate#</dl>");
                writeOutput('<div class="table-responsive">
                                <table class="table table-condensed table-bordered shoeData">
                                    <tr>
                                        <th>Current Mileage</th>
                                        <th>Purchase Date</th>
                                        <th>Retirement Date</th>
                                    </tr>
                                    <tr>
                                        <td>#decimalFormat(application.muraStrava.convertMetersToMiles(shoe.distance))#</td>
                                        <td>#rc.$.content("purchaseDate")#</td>
                                        <td>#retirementDate#</td>
                                    </tr>
                                </table>
                             </div>')
                shoeFound = 1;
                rc.shoe.name = shoe.name;
                break;
            }
        }
        if(!shoeFound){
            writeOutput('<p class="alert">No Strava Data was found for these shoes!</p>');
        }
        
        //writeDump(var="#rc.$.getcontentBean().getshoeId()#", abort=true);
    }

}
