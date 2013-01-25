/* WizBootStrap - For bootstrapping.
 *
 * @author Chris Wynn
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2012
 * @file WizBootStrap.h for PhoneGap
 *
 */ 

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

@interface WizBootStrap : CDVPlugin

-(void)load:(CDVInvokedUrlCommand*)command;
-(void)loadFromFileURI:(CDVInvokedUrlCommand*)command;

@end
