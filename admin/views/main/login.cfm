
<h1>Login Required</h1>

<p>
  In order to use this app, you must login with your Strava account. Click to login below.
</p>

<cfoutput>
	<p>
      <a href="#rc.authurl#" class="btn"><img src="#rc.$.globalConfig('context')#/plugins/#rc.pc.getDirectory()#/includes/assets/images/ConnectWithStrava.png"/></a>
	</p>
</cfoutput>
