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
    },
    
    bootstrap: function(filename) {
        window.wizBootStrap.load( filename, true );
    },
    
    downloadThenBootStrapFromURL: function(url, user, pass) {
        var request = new XMLHttpRequest();
        if ( arguments.length < 2 ) {
            user = document.getElementById('usertextbox').value;
            if ( window.localStorage ) {
	            window.localStorage.setItem('user', document.getElementById('usertextbox').value);
	        }
        }
        if ( arguments.length < 3 ) {
            pass = document.getElementById('passtextbox').value;
            if ( window.localStorage ) {
                window.localStorage.setItem('pass', document.getElementById('passtextbox').value);
            }
        }
        
        if ( window.localStorage ) {
                window.localStorage.setItem('url', document.getElementById('urltextbox').value);
        }
        
        // alert( 'Requesting: ' + url );
        
        var gotFS = function (fileSystem) {
            fileSystem.root.getFile("tmp.html", {create: true}, gotFileEntry, fail);
        }
        
        var gotFileEntry = function (fileEntry) {
            fileEntry.createWriter(gotFileWriter, fail);
            // alert( 'Created: ' + fileEntry.fullPath \nNow will reboot using the file.');
            // sets customSettings in localStorage
            window.wizBootStrap.loadFromFileURI( fileEntry.fullPath, true );
        }
        
        var gotFileWriter = function (writer) {
            writer.onwrite = function(evt) {
                console.log("write success");
            };
            
            
            // If your root directory is not at www you may need to change your setup below
            var newRelavantPath = window.location.href.match(/^.+\.app\/www\//)[0];
            // "../../www/"
            var replaceText = 'src="'+newRelavantPath;

            var updatedCode = request.responseText.replace(/src=\"/mg,replaceText);
            writer.write( updatedCode );
        }
        
        var fail = function (error) {
            var errorObject = JSON.stringify( evt );
            console.log( 'Error: ' + errorObject );
            alert( 'Error: ' + errorObject );
        }
        
        // Issue a synchronous request using false parameter.
        request.open('GET', url, false, user, pass);
        try {
            request.send();
        } catch (e) {
            alert('An exception was triggered.  Please verify the server exists and try your request again.');
            return;
        }
        
        // Synchronous handling.
        if (request.status == 200) {
            window.requestFileSystem(LocalFileSystem.TEMPORARY, 0, gotFS, fail);
        } else if (request.status == 401) {
            alert("Incorrect username and/or password.");
        } else {
            alert("Request status: " + request.status + "\n\nRequest response text: " + request.responseText);
        }
                
        
    } 
};

