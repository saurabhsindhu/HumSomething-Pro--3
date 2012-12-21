//
//  RegisterViewController.h
//  photosharing1
//
//  Created by jk menon on 2/22/12.
//  Copyright (c) 2012 interworld commnet. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"
#import "HumSomethingAppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,NSXMLParserDelegate,UIAlertViewDelegate>
{
    UITextField *txt_Name;
    UITextField *txt_Email;
    UITextField  *txt_Password;
    UITextField *txt_Uploadphoto;
    UIButton *btn_Browse;
    UIButton *btn_Submit;
    UIImageView *img_UserPic;
    BOOL flag;
    CGFloat animatedDistance;
    UIImagePickerController *picker;
    UIImageView *cameraImageView;
	MBProgressHUD *HUD;
    NSString *message;
    HumSomethingAppDelegate *appDelegate;
    NSArray *response;
    NSMutableArray *registerNewArr;
  NSData *dataImage;
    NSMutableArray* results;
   AVAudioPlayer*  audioPlayer;
    BOOL recordResults;
     BOOL inItemElement;
    NSMutableData *responseData;
    NSMutableString *capturedCharacters;
     NSMutableArray *resultArray;
}

@property (nonatomic,retain) NSMutableData *responseData;
- (void) parseXML;
-(void)callLoginParsing;
- (NSString *)getUUID;

-(void)performXML:(NSData*)data;

- (void)dismissControls;
-(void)callAlertView :(NSString *)titlemessage message:(NSString *)msg;
-(void)browseBtnClick;
-(void)submitBtnClick;
-(void)callRegisterParsing;
-(void)playSound;

@end
