//
//  GuessView.h
//  HumSomething
//
//  Created by Pravesh Uniyal on 16/07/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainHeaderFile.h"
#import"DataClass.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
#import "GlobalVars.h"

@interface GuessView : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,UITableViewDataSource>
{
    
    
   
    NSString *userIdString;
    NSMutableString *capturedCharacters;
    BOOL inItemElement;
    NSMutableArray *resultArray;
    NSMutableArray *resultArrayFinal;
      AVAudioPlayer*  audioPlayer;
    ///////// 
    UIWindow *keyValue;
    UISwitch *sw;
    NSString *privacyStatus;
    UIView *myView;
	UITableView *table;
    UIView *myview;
   
    MBProgressHUD *HUD;
    UILabel *lblCoins;
    UILabel *lblDinamite;
    int i;
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
