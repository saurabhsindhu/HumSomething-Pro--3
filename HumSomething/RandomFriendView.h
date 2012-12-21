//
//  RandomFriendView.h
//  HumSomething
//
//  Created by Pravesh Uniyal on 10/07/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainHeaderFile.h"
#import"DataClass.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "GlobalVars.h"
#import "MBProgressHUD.h"
@interface RandomFriendView : UIViewController<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>
{
    
    UITableView *tvRandomFriend;
    NSMutableArray *resultArray;
    NSMutableString *capturedCharacters;
    BOOL inItemElement;
    NSMutableArray *resultArrayFinal;
    NSString *strName;

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
    UIView *randomview;
    UIButton *btnImgUser;
    UILabel *lblUser;
    UIButton *btnrandom;
    NSMutableArray *resultArrayFinal3;
}
@property (nonatomic,retain) NSMutableData *responseData;
@property (nonatomic,retain)NSMutableString *capturedCharacters;
@property (nonatomic, retain) NSString *privacyStatus;
@property (nonatomic, retain) UISwitch *sw;
CGPoint vectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) ;
CGFloat angleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint);


- (void) parseXML;
-(void)playSound;

@end
