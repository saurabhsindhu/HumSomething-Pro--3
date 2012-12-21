//
//  HumSomethingViewController.h
//  HumSomething
//
//  Created by Pravesh Uniyal on 28/06/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
#import "ASIFormDataRequest.h"

@class ASIHTTPRequest;

typedef enum _ASIAuthenticationType {
	ASIStandardAuthenticationType = 0,
    ASIProxyAuthenticationType = 1
} ASIAuthenticationType;

@interface HumSomethingViewController : UIViewController<UITextFieldDelegate,NSXMLParserDelegate>

{
    BOOL transitioning;
    UILabel *lblUserName;
    UILabel *lblPassword;
    UITextField *txtUserName;
    UITextField *txtPassword;
    UIButton *btnLogin;
    UIButton *btnRegister;
    CGFloat animatedDistance;
    UIView *loginView;
    NSMutableData *responseData;
    NSMutableString *capturedCharacters;
    BOOL inItemElement;
    NSMutableArray *resultArray;
    IBOutlet UIImageView *imgView;
    MBProgressHUD *HUD;
        AVAudioPlayer*  audioPlayer;
}

@property (nonatomic,retain) NSMutableData *responseData;
- (void) parseXML;
-(void)callLoginParsing;
-(void)playSound;
@end
