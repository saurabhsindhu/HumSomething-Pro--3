//
//  StoreView.h
//  HumSomething
//
//  Created by Pravesh Uniyal on 10/07/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainHeaderFile.h"
#import"DataClass.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "GlobalVars.h"
#import "OHAttributedLabel.h"
#import "MBProgressHUD.h"

@interface StoreView : UIViewController<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>

{
    UITableView *tvDinamiteSticks;
    
    UITableView *tvTimePieces;
    NSArray *aa;
    UIImageView *dynamite1;
    UIScrollView *srl;
    NSMutableArray *resultArray;
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
    BOOL inItemElement;
    NSMutableArray *resultArrayFinal;
    NSMutableArray *resultArrayFinal1;
    NSMutableArray *resultArrayFinal2;

    NSMutableString *capturedCharacters;
    
    NSMutableArray * saveresult;
    NSString *firstcoinValue;
    NSString *firstbuttonValue;
     MBProgressHUD *HUD;
    UIButton *btnStore1;
    OHAttributedLabel *myAttributedLabel;
    NSMutableArray *tempCoinArray;
    float p,q,r,s,m,n,o;
    int z;
    NSMutableString *strAddString;
    NSString *temp;
}
//@property (nonatomic,retain)  NSString *strAddString;

@property (nonatomic,retain) NSMutableData *responseData;
@property(nonatomic,retain)UITableView *tvDinamiteSticks;
@property(nonatomic,retain)  UITableView *tvTimePieces;
@property (nonatomic,retain)NSMutableString *capturedCharacters;

@property (nonatomic, retain) NSString *privacyStatus;
@property (nonatomic, retain) UISwitch *sw;
CGPoint vectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) ;
CGFloat angleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint);

- (void) parseXML;
-(void)playSound;
@end
