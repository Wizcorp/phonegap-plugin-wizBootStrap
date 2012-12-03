/* WizBootStrap - For bootstrapping.
 *
 * @author Chris Wynn
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2012
 * @file WizBootStrap.m for PhoneGap
 *
 */ 

#import "WizBootStrap.h"
#import <Cordova/CDVViewController.h>

// Note: CDVViewController has a private property required by this plugin
// in the case where a plugin attempts to load a non-existent file.
// The following is a forward declaration of the private property defined
// and implemented in CDVViewController.m
@interface CDVViewController ()
@property (nonatomic, readwrite, assign) BOOL loadFromString;
@end

@interface WizBootStrap ()
@property (nonatomic, readwrite, retain) NSString *appFileURI;
@end

@implementation WizBootStrap

- (void)dealloc
{
    self.appFileURI = nil;
    [super dealloc];
}

-(void)load:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    // If the show splash parameter was specified, use that to decide to show the splash screen.
    // Otherwise, use the AutoHideSplashScreen from the Cordova.plist to decide.
    NSString *fileString = [arguments objectAtIndex:1];
    NSNumber *showSplashScreen = [arguments objectAtIndex:2];
    
    CDVViewController *myViewController = (CDVViewController *)self.viewController;
    NSString *startFilePath = [myViewController.commandDelegate pathForResource:fileString];
    if (startFilePath == nil) {
        // Generate an error message
        NSString *loadErr = [NSString stringWithFormat:@"ERROR: Start Page at '%@/%@' was not found.", myViewController.wwwFolderName, fileString];
        
        // Wrap the message so that it is valid HTML.
        NSString *html = [NSString stringWithFormat:@"<html><body> %@ </body></html>", loadErr];
        
        // Load/display the error string.
        // Note: Cordova requires setting loadFromString to YES in order to display the string.
        myViewController.loadFromString = YES;
        [self.webView loadHTMLString:html baseURL:nil];
    } else {
        [self load:startFilePath withSplashScreen:showSplashScreen];
    }
}

-(void)loadFromFileURI:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    NSString *startFilePath = [arguments objectAtIndex:1];
    NSNumber *showSplashScreen = [arguments objectAtIndex:2];
    
    [self load:startFilePath withSplashScreen:showSplashScreen];
}

#pragma mark Private Methods

-(void)load:(NSString *)fileURI withSplashScreen:(NSNumber *)showSplashScreen {
    // Retain the requested file URI so that it can be used later.
    // This is required in case of delayed load due to showing the splash screen
    // so that memory is not released before we've had a chance to use it.
    self.appFileURI = fileURI;
    BOOL show = NO;

    // Determine if splash screen should be shown.
    if ( ![showSplashScreen isEqual:[NSNull null]] ) {
        show = [showSplashScreen boolValue];
    } else {
        // Path to the Cordova.plist (in the application bundle)
        NSString *path = [[NSBundle mainBundle] pathForResource:
                          @"Cordova" ofType:@"plist"];
        
        // Build dictionary from the plist
        NSMutableDictionary *cordovaConfig = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        show  = [[cordovaConfig objectForKey:@"AutoHideSplashScreen"] boolValue];
    }

    if ( show ) {
        // Show splash before reload
        NSString *jsString = @"cordova.exec(null, null, 'SplashScreen', 'show', []);";
        [self.webView stringByEvaluatingJavaScriptFromString:jsString];

        // Perform reload a second later as this gives time for our JS method to execute splash
        [self performSelector:@selector(reloadFromFileURI:) withObject:self.appFileURI afterDelay:1.0f];
        
    } else {
        // Perform reload immediately
        [self reloadFromFileURI:self.appFileURI];
    }
}

- (void)reloadFromFileURI:(NSString *)uri {
    // Create the app URL (from the filename)
    NSURL *appURL = [NSURL fileURLWithPath:uri];
        
    // Create the URL request
    NSURLRequest *appReq = [NSURLRequest requestWithURL:appURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
        
    // Issue the new request
    [self.webView loadRequest:appReq];
}

@end