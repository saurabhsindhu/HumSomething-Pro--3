//
//  GuessSongView.h
//  HumSomething
//
//  Created by Pravesh Uniyal on 13/08/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainHeaderFile.h"
#import"DataClass.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "GlobalVars.h"
#import <MediaPlayer/MediaPlayer.h>
@interface GuessSongView : UIViewController<UITableViewDelegate,UITableViewDataSource,MPMediaPickerControllerDelegate,MPMediaPlayback>

{
    
    MPMoviePlayerController *moviePlayer;
    AVAudioPlayer*  audioPlayer;
    AVAudioRecorder* recorder;
    AVAudioPlayer* player;
    NSString *soundFilePath;
    //setting button////
    UIWindow *keyValue;
    UISwitch *sw;
    NSString *privacyStatus;
    UIView *myView;
	UITableView *table;
    UIView *myview;
    UILabel *lblCoins;
    UILabel *lblDinamite;
    
    UISlider *songSlider;
    
}
@property(nonatomic,retain) NSString *userIdString;

@property (nonatomic, retain) NSString *privacyStatus;
@property (nonatomic, retain) UISwitch *sw;
CGPoint vectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) ;
CGFloat angleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint);


-(void)playSound;


@end
