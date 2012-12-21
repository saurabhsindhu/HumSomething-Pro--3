//
//  ChangePasswordView.h
//  HumSomething
//
//  Created by Pravesh Uniyal on 29/08/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataClass.h"
#import "MBProgressHUD.h"
#import "HumSomethingAppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
@interface ChangePasswordView : UIViewController<UINavigationControllerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDataSource,NSXMLParserDelegate>
{
    
    
    NSMutableString *capturedCharacters;
    BOOL inItemElement;
   
    MBProgressHUD *HUD;
    NSMutableData *responseData;
    UITextField * txt_OldPassword;
    UITextField * txt_Password;
    UIButton *updateButton ;
    UIButton *cancelButton;
    UIButton *browsebtn;
     AVAudioPlayer*  audioPlayer;
    //////
    UIWindow *keyValue;
    UISwitch *sw;
    NSString *privacyStatus;
    UIView *myView;
	UITableView *table;
    UIView *myview;

}
@property (nonatomic, retain)  NSMutableData *responseData;

@property (nonatomic, retain) NSString *privacyStatus;
@property (nonatomic, retain) UISwitch *sw;
CGPoint vectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) ;
CGFloat angleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint);
-(void) callAlertView :(NSString *)titlemessage message:(NSString *)msg;

- (void) parseXML;
-(void)playSound;
@end
