//
//  HummingView.h
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
#import "MBProgressHUD.h"
//#import "HumSomethingAppDelegate.h"
//#import "AdWhirlDelegateProtocol.h"
//#import "AdWhirlView.h"
@interface HummingView : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate,AVAudioRecorderDelegate, AVAudioPlayerDelegate,NSXMLParserDelegate>
{
    
    float mynumber;
    UILabel *btnTime;
    NSTimer *t1;
    UIProgressView *myProgressView;
    NSString *timerString;
    //setting button////
    UIWindow *keyValue;
    UISwitch *sw;
    NSString *privacyStatus;
    UIView *myView;
	UITableView *table;
    UIView *myview;
    UILabel *lblCoins;
    UILabel *lblDinamite;
    UISlider *songSlider;
     AVAudioPlayer*  audioPlayer;
     AVAudioRecorder* recorder;
      AVAudioPlayer* player;
//    HumSomethingAppDelegate *appDelegate;
//    BOOL configFetched;
//	AdWhirlView *adView;
    int countTime;
    float progressTime;
    NSString * soundFilePath;
    
    
    
    ////////////
    MBProgressHUD *HUD;
    NSString *strSongIDf;
    NSString *strOpponentIDf;
    NSString *strUserNamef;
    NSMutableData *responseData;
    
    NSMutableString *capturedCharacters;
    BOOL inItemElement;
}
@property(nonatomic,retain) NSString *strOpponentIDf;
@property(nonatomic,retain) NSString *strSongIDf;
@property(nonatomic,retain) NSString *strUserNamef;
 @property(nonatomic,retain)NSString *timerString;
@property (nonatomic, retain)  NSMutableData *responseData;
@property (nonatomic, retain) NSString *privacyStatus;
@property (nonatomic, retain) UISwitch *sw;
CGPoint vectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) ;
CGFloat angleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint);


-(void)playSound;
-(void)targetMethod;
-(void)startRecording;
-(void)stopPlaying;
-(void)startPlaying;
-(void)timerCalled;
@end
