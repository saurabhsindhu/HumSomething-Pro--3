//
//  SearchUserView.h
//  HumSomething
//
//  Created by Mohit Bisht on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
#import "GlobalVars.h"
@interface SearchUserView : UIViewController<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate,UITextFieldDelegate>
{
    UITableView *usertable;
    UIWindow *keyValue;
    UISwitch *sw;
    NSString *privacyStatus;
    UILabel *lblCoins;
    UILabel *lblDinamite;
    NSMutableString *capturedCharacters;
    BOOL inItemElement;
    NSMutableArray *resultArray;
    NSMutableArray *resultArrayFinal;
    UITextField *searchtextfield;
    AVAudioPlayer*  audioPlayer;

    //****************** searching in table
    NSMutableArray  *searchTableArray;
   // NSMutableArray *listOfFriendsArray;
    BOOL searching;
    BOOL letUserSelectRow;

    UIView *myView;
	UITableView *table;
    MBProgressHUD *HUD;
    UIImageView *imgSearch;
    int i;
    int count;
}


@property(nonatomic,retain) NSMutableArray *resultArrayFinal;
@property (nonatomic, retain) NSString *privacyStatus;
@property (nonatomic, retain) UISwitch *sw;



CGPoint vectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) ;
CGFloat angleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint);
-(void)playSound;
-(void)showPopUpMenu;
@property (nonatomic,retain) NSMutableData *responseData;
- (void) parseXML;
-(void)callUserGetParsing;
@end
