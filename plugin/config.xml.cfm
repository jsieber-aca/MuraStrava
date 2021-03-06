<!---

This file is part of MuraFW1

Copyright 2010-2014 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
<cfinclude template="../includes/fw1config.cfm" />
<cfoutput>
	<plugin>

		<!-- Name : the name of the plugin -->
		<name>#variables.framework.package#</name>

		<!-- Package : a unique, variable-safe name for the plugin -->
		<package>#variables.framework.package#</package>

		<!--
			DirectoryFormat :
			This setting controls the format of the plugin directory.
				* default : /plugins/{packageName}_{autoIncrement}/
				* packageOnly : /plugins/{packageName}/
		-->
		<directoryFormat>packageOnly</directoryFormat>

		<!-- Version : Meta information. May contain any value you wish. -->
		<version>#variables.framework.packageVersion#</version>

		<!--
			LoadPriority :
			Options are 1 through 10.
			Determines the order that the plugins will fire during the
			onApplicationLoad event. This allows plugins to use other
			plugins as services. This does NOT affect the order in which
			regular events are fired.
		-->
		<loadPriority>5</loadPriority>

		<!--
			Provider :
			Meta information. The name of the creator/organization that
			developed the plugin.
		-->
		<provider>John Sieber</provider>

		<!--
			ProviderURL :
			URL of the creator/organization that developed the plugin.
		-->
		<providerURL>https://john-sieber.com</providerURL>

		<!-- Category : Usually either 'Application' or 'Utility' -->
		<category>Application</category>

		<!--
			ORMCFCLocation :
			May contain a list of paths where Mura should look for
			custom ORM components.
		-->
		<!-- <ormCFCLocation>/extensions/orm</ormCFCLocation> -->

		<!--
			CustomTagPaths :
			May contain a list of paths where Mura should look for
			custom tags.
		-->
		<!-- <customTagPaths></customTagPaths> -->

		<!--
			Mappings :
			Allows you to define custom mappings for use within your plugin.
		-->
		<mappings>
			<!--
			<mapping
				name="myMapping"
				directory="someDirectory/anotherDirectory" />
			-->
			<!--
				Mappings will automatically be bound to the directory
				your plugin is installed, so the above example would
				refer to: {context}/plugins/{packageName}/someDirectory/anotherDirectory/
			-->
		</mappings>

		<!--
			AutoDeploy :
			Works with Mura's plugin auto-discovery feature. If true,
			every time Mura loads, it will look in the /plugins directory
			for new plugins and install them. If false, or not defined,
			Mura will register the plugin with the default setting values,
			but a Super Admin will need to login and manually complete
			the deployment.
		-->
		<!-- <autoDeploy>false|true</autoDeploy> -->

		<!--
			SiteID :
			Works in conjunction with the autoDeploy attribute.
			May contain a comma-delimited list of SiteIDs that you would
			like to assign the plugin to during the autoDeploy process.
		-->
		<!-- <siteID></siteID> -->


		<!--
				Plugin Settings :
				The settings contain individual settings that the plugin
				requires to function.
		-->
		<settings>
			<!--
			<setting>
				<name>yourNameAttribute</name>
				<label>Your Label</label>
				<hint>Your hint</hint>
				<type>text|radioGroup|textArea|select|multiSelectBox</type>
				<required>false|true</required>
				<validation>none|email|date|numeric|regex</validation>
				<regex>your javascript regex goes here (if validation=regex)</regex>
				<message>Your message if validation fails</message>
				<defaultvalue>1</defaultvalue>
				<optionlist>1^2^3</optionlist>
				<optionlabellist>One^Two^Three</optionlabellist>
			</setting>
			-->
			<setting>
				<name>client_id</name>
				<label>Strava API Client ID</label>
				<hint>Strava API Client ID</hint>
				<type>text</type>
				<required>true</required>
				<validation>none</validation>
			<!--	<regex>your javascript regex goes here (if validation=regex)</regex> -->
				<message>Please enter your Strava API client ID</message>
				<defaultvalue></defaultvalue>
			<!--	<optionlist>1^2^3</optionlist>
				<optionlabellist>One^Two^Three</optionlabellist> -->
			</setting>
			<setting>
				<name>client_secret</name>
				<label>Strava API Client Secret</label>
				<hint>Strava API Client ID</hint>
				<type>text</type>
				<required>true</required>
				<validation>none</validation>
			<!--	<regex>your javascript regex goes here (if validation=regex)</regex> -->
				<message>Please enter your Strava API client Secret</message>
				<defaultvalue></defaultvalue>
			<!--	<optionlist>1^2^3</optionlist>
				<optionlabellist>One^Two^Three</optionlabellist> -->
			</setting>
			<setting>
				<name>client_token</name>
				<label>Strava API Client Token</label>
				<hint>Strava API Client Token</hint>
				<type>text</type>
				<required>true</required>
				<validation>none</validation>
			<!--	<regex>your javascript regex goes here (if validation=regex)</regex> -->
				<message>Please enter your Strava API client Secret</message>
				<defaultvalue></defaultvalue>
			<!--	<optionlist>1^2^3</optionlist>
				<optionlabellist>One^Two^Three</optionlabellist> -->
			</setting>
			<setting>
				<name>callback</name>
				<label>Strava API Redirect Url</label>
				<hint>Strava API Redirect Url</hint>
				<type>text</type>
				<required>true</required>
				<validation>none</validation>
			<!--	<regex>your javascript regex goes here (if validation=regex)</regex> -->
				<message>Please enter your Strava API redirect url</message>
				<defaultvalue></defaultvalue>
			<!--	<optionlist>1^2^3</optionlist>
				<optionlabellist>One^Two^Three</optionlabellist> -->
			</setting>

			<setting>
				<name>mapboxId</name>
				<label>Mapbox ID</label>
				<hint>Mapbox API user id</hint>
				<type>text</type>
				<required>false</required>
				<validation>none</validation>
			<!--	<regex>your javascript regex goes here (if validation=regex)</regex> -->
				<message>Please enter your Mapbox API user id</message>
				<defaultvalue></defaultvalue>
			<!--	<optionlist>1^2^3</optionlist>
				<optionlabellist>One^Two^Three</optionlabellist> -->
			</setting>

			<setting>
				<name>mapboxAccessToken</name>
				<label>Mapbox Access Token</label>
				<hint>Mapbox API access token</hint>
				<type>text</type>
				<required>true</required>
				<validation>none</validation>
			<!--	<regex>your javascript regex goes here (if validation=regex)</regex> -->
				<message>Please enter your Mapbox API user id</message>
				<defaultvalue></defaultvalue>
			<!--	<optionlist>1^2^3</optionlist>
				<optionlabellist>One^Two^Three</optionlabellist> -->
			</setting>


		</settings>


		<!-- Event Handlers -->
		<eventHandlers>
			<!-- only need to register the eventHandler.cfc via onApplicationLoad() -->
			<eventHandler
					event="onApplicationLoad"
					component="includes.eventHandler"
					persist="false" />
		</eventHandlers>


		<!--
			Display Objects :
			Allows developers to provide widgets that end users can apply to a
			content node's display region(s) when editing a page. They'll be
			listed under the Layout & Objects tab. The 'persist' attribute
			for CFC-based objects determine whether they are cached or instantiated
			on a per-request basis.
		-->
		<displayobjects location="global">

			<!-- An uber simple display object, has nothing to do with FW/1 -->
			<displayobject
					name="MuraFW1 Simple Display Object"
					displayobjectfile="includes/display_objects/simple.cfm" />

			<!-- Athlete Profile is a FW/1 sub-application -->
			<displayobject
					name="Athlete Profile"
					component="includes.displayObjects"
					displaymethod="dspMuraStravaMuraStrava"
					persist="false" />

      <!-- Athlete Profile is a FW/1 sub-application -->
      <displayobject
					name="Athlete Totals and Stats"
					component="includes.displayObjects"
					displaymethod="dspMuraStravaTotalsAndStats"
					persist="false" />

      <!-- Display Shoe Data is a FW/1 sub-application -->
      <displayobject
					name="Display Shoe Data"
					component="includes.displayObjects"
					displaymethod="dspShoeData"
					persist="false" />
			<!-- Display Shoe Data is a FW/1 sub-application -->
      <displayobject
					name="Display Races"
					component="includes.displayObjects"
					displaymethod="dspRaceData"
					persist="false" />

			<!-- App2 is a FW/1 sub-application -->
			<displayobject
					name="MuraFW1 App2"
					component="includes.displayObjects"
					displaymethod="dspMuraFW1App2"
					persist="false" />

			<!-- App3 is a FW/1 sub-application -->
			<!-- Configurable Display Object Example -->
			<displayobject name="MuraFW1 App3"
					component="includes.displayObjects"
					displaymethod="dspConfiguredMuraFW1App3"
					configuratorJS="includes/configurators/app3/configurator.js"
					configuratorInit="initApp3Configurator"
					persist="false" />

		</displayobjects>


		<!--
			Extensions :
			Allows you to create custom Class Extensions of any type.
			See /default/includes/themes/MuraBootstrap/config.xml.cfm
			for examples.
		-->

		<extensions>
			<extension type="Site">
				<attributeset name="Mura Strava" container="Default">
					<attribute
						name="access_token"
						label="Strava API access token"
						hint="Strava API temporary access token"
						type="text"
						defaultValue=""
						required="false"
						validation=""
						regex=""
						message=""
						optionList=""
						optionLabelList="" />
					<attribute
						name="refresh_token"
						label="Strava API refresh token"
						hint="Strava API refresh token"
						type="text"
						defaultValue=""
						required="false"
						validation=""
						regex=""
						message=""
						optionList=""
						optionLabelList="" />
					<attribute
						name="expires_at"
						label="Strava API access token expires at"
						hint="Strava API access token expiration."
						type="text"
						defaultValue=""
						required="false"
						validation=""
						regex=""
						message=""
						optionList=""
						optionLabelList="" />
				</attributeset>
			</extension>
		</extensions>


		<!--
			ImageSizes:
			Allows you to create pre-defined image sizes.
		-->
		<!--
		<imagesizes>
			<imagesize name="yourcustomimage" width="1200" height="600" />
		</imagesizes>
		-->
	</plugin>
</cfoutput>
