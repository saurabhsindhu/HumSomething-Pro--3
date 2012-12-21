//
//  HumSomethingAppDelegate.h
//  HumSomething
//
//  Created by Pravesh Uniyal on 28/06/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "DataSet.h"
#import <CoreLocation/CoreLocation.h>

@class HumSomethingViewController;
@class RegisterViewController;
@interface HumSomethingAppDelegate : NSObject <UIApplicationDelegate,FBSessionDelegate,CLLocationManagerDelegate>
{
    Facebook *facebook;
    DataSet *apiData;
    NSMutableDictionary *userPermissions;
	NSMutableArray *FbInformationArray;
	NSMutableArray *FBFriendListArray;     
    CLLocation *mUserCurrentLocation;
	CLLocationManager *locationManager;
	UINavigationController *localNav;
    HumSomethingViewController *humSomething;
    NSString *networkValue;
	NSString *netStr;
    
    UIImageView *image;
    UINavigationController *controller;
	NSString *devicestr;
	NSString *_deviceToken, *payload, *certificate;
}
@property (nonatomic, retain) UINavigationController *controller;
@property (nonatomic, retain)NSString *devicestr;
@property (nonatomic, retain)NSString *_deviceToken;
@property (nonatomic, retain)NSString *payload;
@property (nonatomic, retain)NSString *certificate;


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HumSomethingViewController *viewController;
@property (nonatomic, retain) NSMutableArray *FBFriendListArray;
@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) DataSet *apiData;
@property (nonatomic, retain) NSMutableDictionary *userPermissions;
@property (nonatomic, retain) NSMutableArray *FbInformationArray;
@property (nonatomic, retain) CLLocation *mUserCurrentLocation;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) UINavigationController *localNav;
@property (nonatomic, retain) HumSomethingViewController *humSomething;

-(NSString *)checkNetworkConnectivity;
-(void)callNoNetworkAlert;
-(void)getUserCurrentLocation;

@end
