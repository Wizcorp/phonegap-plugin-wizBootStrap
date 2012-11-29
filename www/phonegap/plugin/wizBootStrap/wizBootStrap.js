/* WizBootStrap for PhoneGap - 
*
 * @author Ally Ogilvie
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2012
 * @file - wizBootStrap.js
 * @about - JavaScript PhoneGap bridge for boot strapping
 *
 *
*/

var wizBootStrap = {
	// filename  -- file name relative to the app's 'www' directory
    load: function(filename, showSplashScreen) {
        return cordova.exec(null, null, "WizBootStrap", "load", [filename, showSplashScreen]);
    },

	// fileuri  -- the complete file URI for the on file
    loadFromFileURI: function(fileuri, showSplashScreen) {
        return cordova.exec(null, null, "WizBootStrap", "loadFromFileURI", [fileuri, showSplashScreen]);
    }
};

