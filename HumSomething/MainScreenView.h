//
//  MainScreenView.h
//  HumSomething
//
//  Created by Pravesh Uniyal on 10/07/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
   
#import "GlobalVars.h"
#import <AVFoundation/AVFoundation.h>
@interface MainScreenView : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIView *myView;
	UITableView *table;
    UIWindow *keyValue;
    UISwitch *sw;
    NSString *privacyStatus;
    UILabel *lblCoins;
    UILabel *lblDinamite;
     AVAudioPlayer*  audioPlayer;
}
@property (nonatomic, retain) NSString *privacyStatus;
@property (nonatomic, retain) UISwitch *sw;
CGPoint vectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) ;
CGFloat angleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint);
-(void)playSound;
-(void)showPopUpMenu;
@end
