//
//  UserNameView.h
//  HumSomething
//
//  Created by Pravesh Uniyal on 08/08/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainHeaderFile.h"
#import"DataClass.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "GlobalVars.h"

@interface UserNameView : UIViewController<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate,UITextFieldDelegate>
{
    UITableView *tvRandomFriend;
    NSMutableArray *resultArray;
    NSMutableString *capturedCharacters;
    BOOL inItemElement;
    NSMutableArray *resultArrayFinal;
    NSString *strName;
    UITextField *searchtextfield;
    
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
   UIButton *btnImgSearch;
    int i;
    int count;
    
    //****************** searching in table
    NSMutableArray  *searchTableArray;
    // NSMutableArray *listOfFriendsArray;
    BOOL searching;
    BOOL letUserSelectRow;
    

}
@property (nonatomic,retain) NSMutableData *responseData;
@property (nonatomic,retain)NSMutableString *capturedCharacters;
@property (nonatomic, retain) NSString *privacyStatus;
@property (nonatomic, retain) UISwitch *sw;
CGPoint vectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) ;
CGFloat angleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint);


-(void)parseXML;
-(void)playSound;


@end
