//
//  FriendRequestDetail.h
//  HumSomething
//
//  Created by Pravesh Uniyal on 01/08/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainHeaderFile.h"
#import"DataClass.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "GlobalVars.h"
#import "MBProgressHUD.h"
@interface FriendRequestDetail : UIViewController<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>
{
    UITableView *tvFriendRequest;
    NSString *userIdString;
      NSMutableArray *resultArray;
    NSMutableString *capturedCharacters;
    BOOL inItemElement;
     NSMutableArray *resultArrayFinal;
  AVAudioPlayer*  audioPlayer;
    
    //setting button////
    UIWindow *keyValue;
    UISwitch *sw;
    NSString *privacyStatus;
    UIView *myView;
	UITableView *table;
    UIView *myview;
    UILabel *lblCoins;
    UILabel *lblDinamite;
    MBProgressHUD *HUD;
    
}
@property(nonatomic,retain) NSString *userIdString;
@property (nonatomic,retain) NSMutableData *responseData;
@property(nonatomic,retain) NSMutableArray *resultArrayFinal;

@property (nonatomic, retain) NSString *privacyStatus;
@property (nonatomic, retain) UISwitch *sw;
CGPoint vectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) ;
CGFloat angleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint);


- (void) parseXML;
-(void)playSound;
@end
