component {

    public function init(client_id, client_secret, client_token){

        variables.client_id = arguments.client_id;
        variables.client_secret = arguments.client_secret;
        variables.client_token = arguments.client_token;
        variables.perPage = 200;
        // load Mura scope
        if ( !IsDefined('m') ) {
          siteid = structKeyExists(session, 'siteid') ? session.siteid : 'johnsieber';
          m = application.serviceFactory.getBean('m').init(siteid);
          $ = m;
        }
        variables.pluginConfig = $.getBean('pluginManager').getConfig('MuraStrava');
        return this;
    }

        public function convertCelsiusToFahrenheit( required numeric celsiusTemp){
            var fahrenheitTemp = arguments.celsiusTemp * 1.8000 + 32.00;
            return round(fahrenheitTemp);
        }

        public function convertMetersPerSecondToMilesPerHour( required numeric metersPerHour){
            var milesPerHour = arguments.metersPerHour * 2.2369362920544;
            return decimalFormat(milesPerHour);
        }

        public function convertMetersPerSecondToAvgPace( required numeric distanceInMeters, required numeric elaspedTimeInSeconds, required numeric metersPerHour ){
            var avgPace = decimal2Time(60/decimalFormat(arguments.metersPerHour * 2.2369362920544), "hh:mm");
            return avgPace;
        }

        public function convertMetersToFeet( required numeric elevationInMeters){
            var elevationInFeet = arguments.elevationInMeters * 3.2808399;
            return int(elevationInFeet);
        }

		public function convertMetersToMiles( required numeric distanceInMeters){
            var distanceInMiles = arguments.distanceInMeters * 0.00062137;
            return distanceInMiles;
        }

    public function convertSecondsToMinutes( required numeric timeInSeconds){
            var minutes = arguments.timeInSeconds \ 60;
            var seconds = timeInSeconds - minutes * 60;
            var timeInMinutes = minutes & " m " & seconds & " s";
            return timeInMinutes;

        }

    public function totalTimeFromSec(seconds){
        	var xHr = (seconds\3600); // find hour
        	var xMin = (seconds\60) - (xHr*60); // Find minutes
        	var xSec = seconds - (xHr * 3600) - (xMin*60); // find seconds
        	var xTime = "#NumberFormat(xHr,'0')#:#NumberFormat(xMin,'00')#:#NumberFormat(xSec,'00')#"; //return in time format
        	return xTime;
      }

  /**
   * Converts decimal to time.
   *
   * @param decimal 	 A number between 0 and 23.99. (Required)
   * @param timeMask 	 Mask for formatting. Defaults to hh:mm tt. (Optional)
   * @return Returns a string.
   * @author Nick Giovanni (audi.tt@verizon.net)
   * @version 1, August 9, 2005
   */
  public function decimal2Time(decimal){
  	var timeMask = "hh:mm tt";
  	var timeValue = "";
  	var decimalMinutes = "";
  	var decimalHours = "";

  	//make sure passed value is numeric
  	if(not isNumeric(decimal)) return "The value passed to function decimalToTime() is not a valid number!";

  	timeValue =  numberFormat(decimal,"99.99");

  	if(timeValue LT 0 OR timeValue GTE 24) return "The value passed to function decimalToTime() is not within the valid range of 0 - 23.99";

  	//if the optional mask was passed use that otherwise default to "hh:mm tt"
  	if(arrayLen(arguments) gt 1) timeMask = arguments[2];

  	decimalHours = listfirst(timeValue,".");
  	decimalMinutes = listLast(timeValue,".");

  	//attempt to determine minutes
  	if(decimalMinutes neq 0) decimalMinutes = round(60*decimalMinutes/100);

  	timeValue = timeFormat(decimalHours & ":" & decimalMinutes,timeMask);
  	return timeValue;
  }

      /**
  		 * Takes a time in seconds argument and converts to a time string in &quot;4d 12h 30m&quot; format.
  		 * v0.9 by Simon Bingham
  		 * v1.0 by Adam Cameron. Tweaking small bug if a float is passed-in rather than an integer.
  		 *
  		 * @param timeInSeconds      Time in seconds (Required)
  		 * @param workingHoursPerDay      Number of hours to consider "a day" (Optional)
  		 * @return Returns a string formatting the passed-in seconds value in days, hours and minutes
  		 * @author Simon Bingham (me@simonbingham.me.uk)
  		 * @version 1.0, September 29, 2012
  		 */
  		public string function convertSecondsToTimeString( required numeric timeInSeconds, string workingHoursPerDay=24 ){
  		    // create a struct containing placeholder values for days, hours and minutes
  		    var timeStruct = { days=0, hours=0, minutes=0 };

  		    // create a variable to store the return value
  		    var timeAsString = "";

  		    // convert the number of working hours per day to seconds
  		    var workingSecondsPerDay = arguments.workingHoursPerDay * 3600;

  		    timeInSeconds = int(timeInSeconds); // will give unpredictable results if this is a float

  		    // calculate the number of whole working days and add to the 'days' element of our structure
  		    timeStruct.days = ( arguments.timeInSeconds - ( arguments.timeInSeconds mod workingSecondsPerDay ) ) / workingSecondsPerDay;
  		    arguments.timeInSeconds = timeInSeconds mod workingSecondsPerDay;

  		    // calculate the number of hours and add to the 'hours' element of our structure
  		    timeStruct.hours = ( arguments.timeInSeconds - ( arguments.timeInSeconds mod 3600 ) ) / 3600;
  		    arguments.timeInSeconds = arguments.timeInSeconds mod 3600;

  		    // calculate the number of minutes and add to the 'minutes' element of our structure
  		    timeStruct.minutes = arguments.timeInSeconds / 60;

  		    // build the return string
  		    if( val( timeStruct.days ) ) timeAsString = timeStruct.days & "d ";
  		    if( val( timeStruct.hours ) ) timeAsString &= timeStruct.hours & "h ";
  		    if( val( timeStruct.minutes ) ) timeAsString &= numberFormat(timeStruct.minutes, "__") & "m";

  		    // return the string
  		    return trim( timeAsString );
  		}

      public function epochToDate(dateSeconds){
       // set the base time from when epoch time starts
       startDate = DateConvert("utc2Local", CreateDateTime( 1970,1,1,0,0,0 ));
       if ( NOT isnumeric( arguments.dateSeconds ) ){
           return '';
       }
       // return the date
       // this adds the seconds to the startDate and the converts it to to a local time from UTC format
       return DateConvert("local2Utc", dateadd( 's', arguments.dateSeconds, startDate ));
      }

        public string function generateAuthURL(redirecturl) {
            return "https://www.strava.com/oauth/authorize?" &
                    "client_id=#urlEncodedFormat(variables.client_id)#" &
                    "&response_type=code" &
                    "&redirect_uri=#urlEncodedFormat(redirecturl)#" &
                    "&approval_prompt=auto" &
                    "&scope=profile:read_all,activity:read";

        }


        // chnage this to pass these variables in or load mura scope.
        private function getAccessToken(){
          //variables.pluginConfig.setsetting('access_token', '12345');
          //writedump(var=variables.pluginConfig.getsettings().access_token, abort=true);
          if(dateCompare(epochToDate($.pluginConfig.getsettings().expires_at), now()) eq 1){
            return $.pluginConfig.getsettings().access_token;
          }else{
            return refreshToken($.pluginConfig.getsettings().refresh_token);
          }
        }

        public function getActivityMap( activityID){
           var apiRequestUrl = "https://www.strava.com/api/v3/activities/#arguments.activityID#";
           var data = getData(apiRequestUrl);
           return data;
        }

        public function getActivities(perPage, page){
            var apiRequestUrl = "https://www.strava.com/api/v3/athlete/activities";
            var data = getData(apiRequestUrl, arguments.perPage, arguments.page);
            return data;
        }

        public struct function getCurrentAthlete(){
            var apiRequestUrl = "https://www.strava.com/api/v3/athlete";
            var data = getData(apiRequestUrl);
            return data;
        }

        private any function getData(url, perPage, page=1){
            var access_token = getAccessToken();

            var httpCall = new http();

            httpCall.setURL("#arguments.url#");
            httpCall.setMethod("get");
            httpCall.addParam(type="URL", name="access_token", value="#access_token#");
            httpCall.addParam(type="URL", name="per_page", value="#arguments.perPage#");
            httpCall.addParam(type="URL", name="page", value="#arguments.page#");
            httpCall.setResolveURL(true);
            var result = httpCall.send().getPreFix();
            var data = deserializeJSON(result.filecontent);
            if(isStruct(data) && structKeyExists(data, "errors") && isArray(data.errors)){
                writeDump(var="#data#", abort=true);
            }else{
                return data;
            }
        }

        public struct function getTotalsAndStats(athleteID){
            var apiRequestUrl = "https://www.strava.com/api/v3/athletes/#arguments.athleteID#/stats";
            var data = getData(apiRequestUrl, variables.perPage);
            return data;
        }

        public array function getK_QOMs_CRs(athleteID){
            var apiRequestUrl = "https://www.strava.com/api/v3/athletes/#arguments.athleteID#/koms";
            var data = getData(apiRequestUrl, variables.perPage);
            return data;
        }

        private function refreshToken(refresh_token){

          var httpCall = new http();
          httpCall.setURL("https://www.strava.com/api/v3/oauth/token");
          httpCall.setMethod("post");
          httpCall.addParam(type="URL", name="client_id", value="#variables.client_id#");
          httpCall.addParam(type="URL", name="client_secret", value="#variables.client_secret#");
          httpCall.addParam(type="URL", name="grant_type", value="refresh_token");
          httpCall.addParam(type="URL", name="refresh_token", value="#$.currentUser('refresh_token')#");
          var result = httpCall.send().getPrefix();
          //writeDump(var=result, abort=true);
          var stravaAuthResponse = deserializeJSON(result.filecontent);
          variables.pluginConfig.setsetting('access_token', stravaAuthResponse.access_token);
          variables.pluginConfig.setsetting('refresh_token', stravaAuthResponse.refresh_token);
          variables.pluginConfig.setsetting('expires_at', stravaAuthResponse.expires_at);
          //writeDump(var="#stravaAuthResponse#", label="refreshResponse", abort=true);
          return $.currentUser('access_token');



        }


        public struct function validateResult(code, error) {

            var result = {};

            if(error != ""){
                result.status = false;
                result.message = error;
                return result;
            }

            var token = getStravaToken(code);
            // writeDump(var=token, label="this is the one", abort=true);

            if(structKeyExists(token, "error")) {
                result.status = false;
                result.message = token.error;
                return result;
            }

          try{
            result.status = true;
            result.access_token = token.access_token;
            result.token_type = token.token_type;
            result.expires_at = token.expires_at;
            result.expires_in = token.expires_in;
            result.refresh_token = token.refresh_token;
            //writeDump(var=result, label="this is the one", abort=true);
            return result;

          } catch(any e){
            writedump(var=e, label="error dump", abort=true);
          }

        }

        private function getStravaToken(code) {

            var httpCall = new http();
            httpCall.setURL("https://www.strava.com/oauth/token");
            httpCall.setMethod("post");
            httpCall.addParam(type="URL", name="client_id", value="#variables.client_id#");
            httpCall.addParam(type="URL", name="client_secret", value="#variables.client_secret#");
            httpCall.addParam(type="URL", name="code", value="#arguments.code#");
            httpCall.setResolveURL(true);
            var result = httpCall.send().getPrefix();
            var stravaAuthResponse = deserializeJSON(result.filecontent);
            //writeDump(var="#stravaAuthResponse#", label="AuthResponse", abort=true);
            return stravaAuthResponse;

        }

}
