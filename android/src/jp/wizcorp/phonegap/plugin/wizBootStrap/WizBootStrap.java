package jp.wizcorp.phonegap.plugin.wizBootStrap;

import android.os.Handler;
import android.webkit.WebView;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.api.CallbackContext;
import org.apache.cordova.api.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

import android.util.Log;

/**
 * PhoneGap plugin for bootstrapping or loading a different html page/execution
 * environment.  This plugin allows for loading an html page from a remote server
 * or from an applications www directory.
 * 
 * @author Ally Ogilvie
 */
public class WizBootStrap extends CordovaPlugin {

    public static final String TAG = "WizBootStrap";
    static Handler loadHandler;
    static Runnable loadit;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

		Log.d(TAG, "Plugin execute called with action: " + action);
	
		/*
		 * Determine which action of the plugin needs to be invoked
		 */
		if (action.equalsIgnoreCase("load")) {
            // If the show splash parameter was specified, use that to decide to show the splash screen.
            // Otherwise, use the AutoHideSplashScreen from the config.xml to decide.
            if (args.length() < 1) {
                // Throw error
                Log.e(TAG, "Error: No path String to load.");
                callbackContext.error("Error: No path String to load.");
                return false;
            }

            String fileString = args.getString(0);
            fileString = "file:///android_asset/www/" + fileString;

            // Defaults to false
            Boolean showSplashScreen = false;
            if (args.length() > 1) {
                showSplashScreen = args.getBoolean(1);
            }

            load(fileString, showSplashScreen);
		} else if (action.equalsIgnoreCase("loadFromFileURI")) {
            if (args.length() < 1) {
                // Throw error
                Log.e(TAG, "Error: No path String to load.");
                callbackContext.error("Error: No path String to load.");
                return false;
            }

            String fileString = args.getString(0);

            // Defaults to false
            Boolean showSplashScreen = false;

            if (args.length() > 1) {
                showSplashScreen = args.getBoolean(1);
            }
            load(fileString, showSplashScreen);
		}
		return false;
    }


    /**
     * Load method.
     * 
     * @param fileURI
     * 			  String URI of file to load. URI can be a file:// or http://
     * @param showSplashScreen
     *            Boolean option to display splash screen or not
     */
    public void load(final String fileURI, final Boolean showSplashScreen) {
    	Log.d(TAG, " \nload with fileURI: " + fileURI + " \ndisplay splash: " + showSplashScreen);
        cordova.getActivity().runOnUiThread(
                new Runnable() {
                    public void run() {
                        Log.d(TAG, "Loading: " + fileURI);
                        if (showSplashScreen) {
                            // Load with splash
                            webView.loadUrl("javascript:cordova.exec(null, null, 'SplashScreen', 'show', []);");
                            webView.loadUrl(fileURI, 1);
                        } else {
                            // Perform load immediately
                            webView.loadUrl(fileURI, 1);
                        }
                    }
                }
        );
    }
}
