


# PLUGIN: 

phonegap-plugin-wizBootStrap<br />
version : 2.3<br />
last update : 25/01/2013<br />


# CHANGELOG: 
- Updated to Cordova 2.3.
- Initial version.


# KNOWN ISSUES:
- None.


# DESCRIPTION :

PhoneGap plugin for bootstrapping or loading a different html page/execution
environment.  This plugin allows for loading an html page from a remote server
or from an applications www directory.


# INSTALL (iOS): #

Project tree<br />

<pre><code>
www
	/ phonegap
		/ plugin
			/ wizBootStrap
				/ wizBootStrap.js	
 ios
	/ project
		/ Plugins
			/ WizBootStrap
				/ WizBootStrap.h
				/ WizBootStrap.m

</code></pre>

1 ) Arrange files to structure seen above.

2 ) Add to Cordova.plist in the plugins array:<br />
- Key : wizBootStrap<br />
- Type : String<br />
- Value : wizBootStrap<br />

3 ) Add \<script\> tag to your index.html<br />
- \<script type="text/javascript" charset="utf-8" src="phonegap/plugin/wizBootStrap/wizBootStrap.js"\>\</script\><br />

4 ) Follow example code below.


# EXAMPLE CODE : #

Loading a new html page from a relative filename<br />
<pre><code>
wizBootStrap.load(String fileName, Boolean true/false);

* Restart the cordova app using fileName as the Cordova startPage.
*   The fileName paramter is interpreted as a file name relative to the Cordova
*   www folder name.
*
* If a boolean value of true is passed, the splash screen will be shown.
* If a boolean value of false is passed, the splash screen will not be shown.
* If a boolean value is not provided:
*   If the AutoHideSplashScreen key is set to YES in the Cordova.plist file.
*   Otherwise, the splash screen will not be shown.

</code></pre>

<br />
Loading a new html page from a file URI<br />
<pre><code>
wizBootStrap.loadFromFileURI(String fileuri, Boolean true/false);

* Restart the cordova app using fileuri as the Cordova startPage.
*   The fileuri parameter is interpreted as an absolute file URI name.
*
* If a boolean value of true is passed, the splash screen will be shown.
* If a boolean value of false is passed, the splash screen will not be shown.
* If a boolean value is not provided:
*   If the AutoHideSplashScreen key is set to YES in the Cordova.plist file.
*   Otherwise, the splash screen will not be shown.

</code></pre>

