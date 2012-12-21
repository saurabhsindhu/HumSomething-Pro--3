//
//  ChangeProfilePicViewController.h
//  HumSomething
//
//  Created by Mohit Bisht on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataClass.h"
#import "MBProgressHUD.h"
#import "HumSomethingAppDelegate.h"
#import <AVFoundation/AVFoundation.h>
@interface ChangeProfilePicViewController : UIViewController<UINavigationControllerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDataSource>
{
    UIImageView *cameraImageView;
    UIImageView *img_UserPic;
    UIButton *updateButton ;
    UIButton *cancelButton;
    UIButton *browsebtn;
     UIImagePickerController *picker;
    UIButton *btn_Browse;
    AVAudioPlayer*  audioPlayer;
    NSString *receivedString;
    
    UIWindow *keyValue;
    UISwitch *sw;
    NSString *privacyStatus;
    UIView *myView;
	UITableView *table;
    UIView *myview;
    
}
@property (retain, nonatomic) IBOutlet UIImageView *imgUpdatePicture;
@property (nonatomic, retain) NSString *privacyStatus;
@property (nonatomic, retain) UISwitch *sw;
CGPoint vectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) ;
CGFloat angleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint);
-(void) callAlertView :(NSString *)titlemessage message:(NSString *)msg;


-(void)playSound;
@end
