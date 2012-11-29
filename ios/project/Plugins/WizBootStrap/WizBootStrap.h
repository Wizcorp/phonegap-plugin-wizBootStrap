/* WizBootStrap - For bootstrapping.
 *
 * @author Chris Wynn
 * @copyright WizCorp Inc. [ Incorporated Wizards ] 2012
 * @file WizBootStrap.h for PhoneGap
 *
 */ 

#import <Foundation/Foundation.h>
#ifdef CORDOVA_FRAMEWORK
#import <Cordova/CDVPlugin.h>
#else
#import "CDVPlugin.h"
#endif

@interface WizBootStrap : CDVPlugin

-(void)load:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;
-(void)loadFromFileURI:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
