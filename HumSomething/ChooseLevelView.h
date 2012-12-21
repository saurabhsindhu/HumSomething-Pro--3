//
//  ChooseLevelView.h
//  HumSomething
//
//  Created by Pravesh Uniyal on 12/07/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainHeaderFile.h"
#import"DataClass.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
#import "GlobalVars.h"
#import "OHAttributedLabel.h"

@interface ChooseLevelView : UIViewController <UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>
{
    
    UIView *chooseLavelView;  
    UIImageView * dynamite;
        UIImageView * dynamite1;
        UIImageView * dynamite2;
    NSArray *imgArray;
    AVAudioPlayer*  audioPlayer;
    
    
    
    NSMutableArray *resultArray;
    NSMutableString *capturedCharacters;
    BOOL inItemElement;
    NSMutableArray *resultArrayFinal;
     NSMutableArray *resultArrayFinal2;
    NSMutableArray *resultArrayFinal3;
    
    UIWindow *keyValue;
    UISwitch *sw;
    NSString *privacyStatus;
    UIView *myView;
	UITableView *table;
    UIView *myview;
    
    UILabel *lblCoins;
    UILabel *lblDinamite;
    UILabel*topLabel3;
    
    NSMutableString *strAddString;
     OHAttributedLabel *myAttributedLabel;
    UILabel *topLabel10;
    UILabel*topLabel11;
    UILabel*topLabel12;
    UIButton *btn0;
    UIButton *btn1;
    UIButton *btn2;
    UILabel *topLabel23;
    
    UILabel *sep1;
    UILabel *sep2;
    UILabel *sep3;
    UILabel *sep4;
    
    
   }
@property(nonatomic,retain)UILabel *sep1;
@property(nonatomic,retain)UILabel *sep2;
@property(nonatomic,retain)UILabel *sep3;
@property(nonatomic,retain)UILabel *sep4;
@property(nonatomic,retain) NSString *strChooseUserID;
@property(nonatomic,retain) NSString *strChooseUserName;
@property (nonatomic,retain) NSMutableData *responseData;
@property (nonatomic,retain)NSMutableString *capturedCharacters;
@property (nonatomic, retain) NSString *privacyStatus;
@property (nonatomic, retain) UISwitch *sw;

- (void) parseXML;
-(void)playSound;
@end
