//
//  HumStartView.h
//  HumSomething
//
//  Created by Pravesh Uniyal on 10/08/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainHeaderFile.h"
#import"DataClass.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "GlobalVars.h"
//#import "HumSomethingAppDelegate.h"
//#import "AdWhirlDelegateProtocol.h"
//#import "AdWhirlView.h"
#import "MBProgressHUD.h"
@interface HumStartView : UIViewController<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>
{
  
    NSString *strSongID;
    NSString *strOpponentID;
    NSString *strUserName;
    
    NSString *userIdString;
    NSMutableArray *resultArray;
    NSMutableString *capturedCharacters;
    BOOL inItemElement;
    NSMutableArray *resultArrayFinal;
    MBProgressHUD *HUD;
     AVAudioPlayer*  audioPlayer;
    
    UIView *humView;
    UIButton *btnTime;
    UIButton *btnA;
    UIButton *btnB;
    UIButton *btnC;
    UIButton *btnD;
    UIButton *btnE;
    UILabel*  btnTimet;
    //////
    
    UILabel *lblTime0;
     UILabel *lblTime1;
     UILabel *lblTime2;
     UILabel *lblTime3;
     UILabel *lblTime4;
    //setting button////
    UIWindow *keyValue;
    UISwitch *sw;
    NSString *privacyStatus;
    UIView *myView;
	UITableView *table;
    UIView *myview;
    UILabel *lblCoins;
    UILabel *lblDinamite;
    UIButton *btnTurn1;
    UIButton *btnStartHumming;
     NSMutableString *strAddString;
     int i;
    int count;
}
@property(nonatomic,retain) NSString *strOpponentID;
@property(nonatomic,retain) NSString *strSongID;
@property(nonatomic,retain) NSString *strUserName;
@property(nonatomic,retain) NSString *userIdString;
@property(nonatomic,retain) UILabel*  btnTimet;
@property (nonatomic,retain) NSMutableData *responseData;
@property (nonatomic,retain) NSMutableString *capturedCharacters;
@property (nonatomic, retain) NSString *privacyStatus;
@property (nonatomic, retain) UISwitch *sw;
- (void) parseXML;
-(void)playSound;
@end
