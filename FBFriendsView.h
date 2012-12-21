//
//  FBFriendsView.h
//  HumSomething
//
//  Created by Mohit Bisht on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

#import "MBProgressHUD.h"
#import "MainHeaderFile.h"
#import"DataClass.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "GlobalVars.h"

@class HumSomethingAppDelegate;

@interface FBFriendsView : UIViewController<FBRequestDelegate,FBSessionDelegate,FBDialogDelegate,UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate>
{
    HumSomethingAppDelegate *appDelegate;
    UITableView *tvFriends;
     NSMutableArray *infoFeeds;
    NSMutableData *responseData;
    NSMutableString *capturedCharacters;
    BOOL inItemElement;
    NSMutableArray *resultArray;
    MBProgressHUD *HUD;
    NSString *appUserFacebookid;
    NSString *userId;
    NSMutableArray *arrayFBActiveUser;
   AVAudioPlayer*  audioPlayer;
    //setting button////
    UIWindow *keyValue;
    UISwitch *sw;
    NSString *privacyStatus;
    UIView *myView;
	UITableView *table;
    UIView *myview;
      /////
    NSMutableArray *resultArrayFinal;
    NSMutableArray *fbnewdetail;
    UILabel *lblCoins;
    UILabel *lblDinamite;
}

- (void) apiFQLIMe;
-(void)logOut;
- (void) showLoggedIn;
//-(void)callAlertView :(NSString *)titlemessage message:(NSString *)mesg;
//@property(nonatomic,retain)NSMutableArray *infoFeeds;
@property (nonatomic,retain) NSMutableData *responseData;
@property (nonatomic,retain) NSString *userId;
@property(nonatomic,retain)  NSMutableArray *resultArrayFinal;
@property (nonatomic, retain) NSString *privacyStatus;
@property (nonatomic, retain) UISwitch *sw;
CGPoint vectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) ;
CGFloat angleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint);

- (void) parseXML;
-(void)playSound;


-(void)callregisterFacebookParsing:(NSString *)FBappUser;

@end
