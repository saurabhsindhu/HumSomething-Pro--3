//
//  HumSomethingAppDelegate.m
//  HumSomething
//
//  Created by Pravesh Uniyal on 28/06/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HumSomethingAppDelegate.h"

#import "HumSomethingViewController.h"
#import "DataClass.h"
#import "Reachability.h"
#import "GlobalVars.h"
#import "Flurry.h"

//@implementation UINavigationBar (UINavigationBarCategory)
//
//- (void) drawRect:(CGRect)rect 
//{
//    UIImage *image;
//    
//    image = [UIImage imageNamed: @"navigationBar.png"];
//    
//    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];  
//    
//    [self setTintColor:[UIColor clearColor]];
//    
//    NSLog(@"Draw Rect");
//    
//}
//
//
//@end

@implementation HumSomethingAppDelegate
@synthesize _deviceToken;
@synthesize payload;
@synthesize certificate;
@synthesize devicestr;


@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize facebook,apiData,userPermissions;
@synthesize FbInformationArray;
@synthesize FBFriendListArray;
@synthesize mUserCurrentLocation;
@synthesize locationManager;
@synthesize humSomething;
@synthesize localNav,controller;
static NSString* kAppId = @"331680636926724";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // [Flurry startSession:@"WRQB34847DRVJ6NV3FFZ"];
    
    self.viewController = [[[HumSomethingViewController alloc] initWithNibName:@"HumSomethingViewController" bundle:nil] autorelease];
    
    self.controller = [[[UINavigationController alloc] initWithRootViewController:_viewController] autorelease];
    self.controller.navigationBarHidden = NO;
    
//    if([[UINavigationBar class] respondsToSelector:@selector(appearance)]) //iOS >=5.0
//            {
//               [[UINavigationBar appearance] setFrame:CGRectMake(0, 0, 320, 44)];
//                [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
//                
//            }
//    
    [self.window addSubview:self.controller.view];
    myGlobalArray =[[NSMutableArray alloc]init];
   
    [self.window makeKeyAndVisible];


netStr = [self checkNetworkConnectivity];

if([netStr isEqualToString:@"NoAccess"])
{
    [self callNoNetworkAlert];
}
else {
    [self getUserCurrentLocation];
    ///[self checkUserLoginExist];
 
    
    facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }

}
  
    if (!kAppId) {
        UIAlertView *alertView = [[UIAlertView alloc] 
                                  initWithTitle:@"Setup Error" 
                                  message:@"Missing app ID. You cannot run the app until you provide this in the code." 
                                  delegate:self 
                                  cancelButtonTitle:@"OK" 
                                  otherButtonTitles:nil, 
                                  nil];
        [alertView show];
        [alertView release];
    } else {
        // Now check that the URL scheme fb[app_id]://authorize is in the .plist and can
        // be opened, doing a simple check without local app id factored in here
        NSString *url = [NSString stringWithFormat:@"fb%@://authorize",kAppId];
        BOOL bSchemeInPlist = NO; // find out if the sceme is in the plist file.
        NSArray* aBundleURLTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
        if ([aBundleURLTypes isKindOfClass:[NSArray class]] && 
            ([aBundleURLTypes count] > 0)) {
            NSDictionary* aBundleURLTypes0 = [aBundleURLTypes objectAtIndex:0];
            if ([aBundleURLTypes0 isKindOfClass:[NSDictionary class]]) {
                NSArray* aBundleURLSchemes = [aBundleURLTypes0 objectForKey:@"CFBundleURLSchemes"];
                if ([aBundleURLSchemes isKindOfClass:[NSArray class]] &&
                    ([aBundleURLSchemes count] > 0)) {
                    NSString *scheme = [aBundleURLSchemes objectAtIndex:0];
                    if ([scheme isKindOfClass:[NSString class]] && 
                        [url hasPrefix:scheme]) {
                        bSchemeInPlist = YES;
                    }
                }
            }
        }
        // Check if the authorization callback will work
        BOOL bCanOpenUrl = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: url]];
        if (!bSchemeInPlist || !bCanOpenUrl) {
            UIAlertView *alertView = [[UIAlertView alloc] 
                                      initWithTitle:@"Setup Error" 
                                      message:@"Invalid or missing URL scheme. You cannot run the app until you set up a valid URL scheme in your .plist." 
                                      delegate:self 
                                      cancelButtonTitle:@"OK" 
                                      otherButtonTitles:nil, 
                                      nil];
            [alertView show];
            [alertView release];
        }
    }
  // remote notification    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    return YES;
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
	application.applicationIconBadgeNumber=application.applicationIconBadgeNumber+1;
	
	//-----------------------APNS HANDLE----------------
	
	UIApplicationState state = [application applicationState];
	if (state == UIApplicationStateActive)
	{
	}
}


- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSString *str = [NSString stringWithFormat:@"%@",deviceToken];
	//NSLog(@"%@",str);
	self.devicestr=	str;
    //	NSLog(@"%@",self.devicestr);
	self.devicestr=[self.devicestr stringByReplacingOccurrencesOfString:@"<" withString:@""];
	self.devicestr=[self.devicestr stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    self.devicestr=[self.devicestr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",self.devicestr);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

#pragma mark ---------------------
#pragma mark Location manager delegate methods

-(void)getUserCurrentLocation {
	locationManager = [self locationManager];
	locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
	locationManager.distanceFilter = 10;
	[locationManager startUpdatingLocation];
}

#pragma mark ---------------------
#pragma mark Location manager delegate methods

- (CLLocationManager *)locationManager 
{	
	if (locationManager != nil) {
		return locationManager;
	}
	locationManager = [[CLLocationManager alloc] init];
    	[locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
	[locationManager setDelegate:self];
	[locationManager startUpdatingLocation];
	return locationManager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	mUserCurrentLocation = [[CLLocation alloc] init];
	self.mUserCurrentLocation = newLocation;
    
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error getting Current Location" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

/*Delegate Method of faceBook*/

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self.facebook handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self.facebook handleOpenURL:url];
}




- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}
#pragma mark -
#pragma mark --------------------------------------------------------------------------------------------
#pragma mark ------------------------------ checkNetworkConnectivity  Method ----------------------------
#pragma mark --------------------------------------------------------------------------------------------
#pragma mark -


-(NSString *)checkNetworkConnectivity
{
	if(networkValue)
	{
		[networkValue release];
		networkValue = nil;
	}
	networkValue = [[NSString alloc] init];
	
	if([[Reachability sharedReachability] internetConnectionStatus]==0)
	{
		networkValue = @"NoAccess";
	} 
	else if([[Reachability sharedReachability] internetConnectionStatus]==1) 
	{
		networkValue = @"e";
		
	} else if([[Reachability sharedReachability] internetConnectionStatus]==2) 
	{
		networkValue = @"wifi";
	}
	else  if([[Reachability sharedReachability] internetConnectionStatus]==3) 
	{
		networkValue = @"3g";
	}
	
	return networkValue;
}

-(void)callNoNetworkAlert
{
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Oops!! \ue403" message:@"Internet Connection Error \n\n No Internet Connection found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
	[errorAlert release];
}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [facebook release];
    [apiData release];
    [userPermissions release];
	[FbInformationArray release];
	[FBFriendListArray release];
    [mUserCurrentLocation release];
	[locationManager release];
    [super dealloc];
}

@end
