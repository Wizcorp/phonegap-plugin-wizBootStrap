


# phonegap-plugin-wizBootStrap 

Cordova version : 2.7<br />
last update : 22/07/2013<br />

## Description

PhoneGap plugin for bootstrapping or loading a different html page/execution
environment.  This plugin allows for loading an html page from a remote server
or from an applications www directory.

## Install (iOS)

Project tree

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



1 ) Arrange files to structure seen above.

2 ) Add to config.xml in the plugins array:

		Key : wizBootStrap
		Type : String
		Value : wizBootStrap

3 ) Add ```<script>``` tag to your index.html

 		<script type="text/javascript" charset="utf-8" src="phonegap/plugin/wizBootStrap/wizBootStrap.js"></script>

4 ) Follow example code below.

## Install (Android)

Project tree

		/ assets
			/ www
				/ phonegap
					/ plugin
						/ wizBootStrap
							/ wizBootStrap.js	
		/ src
			/ jp 
				/ wizcorp 
					/ phonegap 
						/ plugin
							/ wizBootStrap
								/ WizBootStrap.java

1 ) Arrange files to structure seen above.

2 ) Add to config.xml in the plugins array:

		<plugin name="WizBootStrap" value="jp.wizcorp.phonegap.plugin.wizBootStrap.WizBootStrap"/>

3 ) Add ```<script>``` tag to your index.html

 		<script type="text/javascript" charset="utf-8" src="phonegap/plugin/wizBootStrap/wizBootStrap.js"></script>

4 ) Follow example code below.

## Example Code

**Loading a new html page from a relative filename**

Restart the cordova app using fileName as the Cordova startPage.
		
		wizBootStrap.load(String fileName, Boolean true/false);

The fileName parameter is interpreted as a file name relative to the Cordova www folder name.

- If a boolean value of true is passed, the splash screen will be shown.
- If a boolean value of false is passed, the splash screen will not be shown.

**Loading a new html page from a file URI**
Restart the cordova app using fileuri as the Cordova startPage.

		wizBootStrap.loadFromFileURI(String fileuri, Boolean true/false);

The fileuri parameter is interpreted as an absolute file URI name. (eg. file:///)

- If a boolean value of true is passed, the splash screen will be shown.
- If a boolean value of false is passed, the splash screen will not be shown.
