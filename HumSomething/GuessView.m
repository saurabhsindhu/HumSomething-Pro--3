//
//  GuessView.m
//  HumSomething
//
//  Created by Pravesh Uniyal on 16/07/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GuessView.h"
#import <QuartzCore/QuartzCore.h>
#import "AnswerView.h"
#import "GreatJobView.h"
#import "ChangeProfilePicViewController.h"
extern NSString *kCAFilterPageCurl; 
@class CAFilter;
@implementation GuessView
@synthesize userIdString,responseData,resultArrayFinal,privacyStatus,sw;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *parentView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 6,51, 44)];
	UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 6, 51, 30)];
	[btnBack setBackgroundImage:[UIImage imageNamed:@"back@2x.png"] forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
	[parentView1 addSubview:btnBack];
	[btnBack release];
	UIBarButtonItem *homeBarButtomItem2 = [[UIBarButtonItem alloc] initWithCustomView:parentView1];
	[parentView1 release];
	[self.navigationItem setLeftBarButtonItem:homeBarButtomItem2];
	[homeBarButtomItem2 release];
    
    
    // add setting button on navigation bar
    
    UIView *parentView2 = [[UIView alloc] initWithFrame:CGRectMake(250, 6, 68, 44)];
	UIButton *btnSetting = [[UIButton alloc] initWithFrame:CGRectMake(0, 6, 68, 30)];
	[btnSetting setBackgroundImage:[UIImage imageNamed:@"Setting@2x.png"] forState:UIControlStateNormal];
	[btnSetting addTarget:self action:@selector(btnSettingButtonClicked) forControlEvents:UIControlEventTouchUpInside];
	[parentView2 addSubview:btnSetting];
	[btnSetting release];
	UIBarButtonItem *homeBarButtomItem = [[UIBarButtonItem alloc] initWithCustomView:parentView2];
	[parentView2 release];
	[self.navigationItem setRightBarButtonItem:homeBarButtomItem];
	[homeBarButtomItem release];
    
    
    //add a imageview
    UIImageView *coinImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,44)];
    coinImage.backgroundColor = [UIColor clearColor];
    [coinImage setImage:[UIImage imageNamed:@"coinImg@2x.png"]];
    [self.view addSubview:coinImage];
    
    
    // add a label on imageview
    lblCoins=[[UILabel alloc]init];
    lblCoins.frame=CGRectMake(35, 10,80, 25);
    
    lblCoins.textColor=[UIColor blackColor];
    lblCoins.backgroundColor=[UIColor clearColor];
    [coinImage addSubview:lblCoins];
    
    
    lblDinamite=[[UILabel alloc]init];
    lblDinamite.frame=CGRectMake(260,10,80, 25);
    
    lblDinamite.textColor=[UIColor blackColor];
    lblDinamite.backgroundColor=[UIColor clearColor];
    [coinImage addSubview:lblDinamite];
    
    //add button on imageview
    UIButton* addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(70,10 ,25,25);
    [addButton setImage:[UIImage imageNamed:@"Add@2x.png"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addCoin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    
    UIButton* addButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton1.frame = CGRectMake(290,10,25,25);
    [addButton1 setImage:[UIImage imageNamed:@"Add@2x.png"] forState:UIControlStateNormal];
    [addButton1 addTarget:self action:@selector(addStick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton1];    
    
    UIView *guessView =[[UIView alloc]initWithFrame:CGRectMake(20, 109, 280, 298)];
    guessView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    guessView.layer.cornerRadius=10.0f;
    
    [self.view addSubview:guessView];
    
    UILabel *seperater1=[[UILabel alloc]initWithFrame:CGRectMake(0, 53.5, 280, 1)];
    seperater1.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [guessView addSubview:seperater1];
    [seperater1 release];

    
    UILabel *seperater2=[[UILabel alloc]initWithFrame:CGRectMake(0, 141.5, 280, 1)];
    seperater2.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [guessView addSubview:seperater2];
    [seperater2 release];
    
    
    UILabel *lblArtistName=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, 180, 30)];
    lblArtistName.backgroundColor=[UIColor clearColor];
     lblArtistName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    //lblArtistName.textAlignment=UITextAlignmentCenter;
    lblArtistName.text=@"Please enter the artist name";
    [guessView addSubview:lblArtistName];
    [lblArtistName release];

    //          
    
    UILabel *lblSongName=[[UILabel alloc]initWithFrame:CGRectMake(10, 54, 180, 30)];
    lblSongName.backgroundColor=[UIColor clearColor];
    lblSongName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    lblSongName.textAlignment=UITextAlignmentLeft;
    lblSongName.text=@"Enter Song Name";
    [guessView addSubview:lblSongName];
    [lblSongName release];
    
    
    //make keyboard...
    
    
    UIButton *btnA=[UIButton buttonWithType:UIButtonTypeCustom];
    btnA.frame=CGRectMake(8.5,153,25.5,21.5);
     btnA.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnA setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnA setTitle:@"A" forState:UIControlStateNormal];
    [btnA setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnA addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnA];
    
 
    UIButton *btnB=[UIButton buttonWithType:UIButtonTypeCustom];
    btnB.frame=CGRectMake(42.5,153,25.5,21.5);
      btnB.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnB setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnB setTitle:@"B" forState:UIControlStateNormal];
    [btnB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnB addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnB];
    
    UIButton *btnC=[UIButton buttonWithType:UIButtonTypeCustom];
    btnC.frame=CGRectMake(76.5,153,25.5,21.5);
      btnC.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnC setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnC setTitle:@"C" forState:UIControlStateNormal];
    [btnC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnC addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnC];

    
   UIButton *btnD=[UIButton buttonWithType:UIButtonTypeCustom];
    btnD.frame=CGRectMake(110.5,153,25.5,21.5);
      btnD.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnD setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnD setTitle:@"D" forState:UIControlStateNormal];
    [btnD setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnD addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnD];

    
    UIButton *btnE=[UIButton buttonWithType:UIButtonTypeCustom];
    btnE.frame=CGRectMake(144.5,153,25.5,21.5);
    btnE.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnE setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnE setTitle:@"E" forState:UIControlStateNormal];
    [btnE setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnE addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnE];

    
    UIButton *btnF=[UIButton buttonWithType:UIButtonTypeCustom];
    btnF.frame=CGRectMake(178.5,153,25.5,21.5);
      btnF.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnF setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnF setTitle:@"F" forState:UIControlStateNormal];
    [btnF setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnF addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnF];

    
    UIButton *btnG=[UIButton buttonWithType:UIButtonTypeCustom];
    btnG.frame=CGRectMake(212.5,153,25.5,21.5);
      btnG.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnG setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnG setTitle:@"G" forState:UIControlStateNormal];
    [btnG setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnG addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnG];

    
    UIButton *btnH=[UIButton buttonWithType:UIButtonTypeCustom];
    btnH.frame=CGRectMake(246.5,153,25.5,21.5);
      btnH.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnH setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnH setTitle:@"H" forState:UIControlStateNormal];
    [btnH setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnH addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnH];
//////
    
    UIButton *btnI=[UIButton buttonWithType:UIButtonTypeCustom];
    btnI.frame=CGRectMake(8.5,185,25.5,21.5);
      btnI.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnI setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnI setTitle:@"I" forState:UIControlStateNormal];
    [btnI setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnI addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnI];
    
    
    UIButton *btnJ=[UIButton buttonWithType:UIButtonTypeCustom];
    btnJ.frame=CGRectMake(42.5,185,25.5,21.5);
      btnJ.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnJ setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnJ setTitle:@"J" forState:UIControlStateNormal];
    [btnJ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnJ addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnJ];
    
    UIButton *btnK=[UIButton buttonWithType:UIButtonTypeCustom];
    btnK.frame=CGRectMake(76.5,185,25.5,21.5);
      btnK.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnK setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnK setTitle:@"K" forState:UIControlStateNormal];
    [btnK setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnK addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnK];
    
    
    UIButton *btnL=[UIButton buttonWithType:UIButtonTypeCustom];
    btnL.frame=CGRectMake(110.5,185,25.5,21.5);
      btnL.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnL setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnL setTitle:@"L" forState:UIControlStateNormal];
    [btnL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnL addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnL];
    
    
    UIButton *btnM=[UIButton buttonWithType:UIButtonTypeCustom];
    btnM.frame=CGRectMake(144.5,185,25.5,21.5);
      btnM.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnM setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnM setTitle:@"M" forState:UIControlStateNormal];
    [btnM setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnM addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnM];
    
    
    UIButton *btnN=[UIButton buttonWithType:UIButtonTypeCustom];
    btnN.frame=CGRectMake(178.5,185,25.5,21.5);
      btnN.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnN setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnN setTitle:@"N" forState:UIControlStateNormal];
    [btnN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnN addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnN];
    
    
    UIButton *btnO=[UIButton buttonWithType:UIButtonTypeCustom];
    btnO.frame=CGRectMake(212.5,185,25.5,21.5);
      btnO.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnO setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnO setTitle:@"O" forState:UIControlStateNormal];
    [btnO setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnO addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnO];
    
    
    UIButton *btnP=[UIButton buttonWithType:UIButtonTypeCustom];
    btnP.frame=CGRectMake(246.5,185,25.5,21.5);
      btnP.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnP setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnP setTitle:@"P" forState:UIControlStateNormal];
    [btnP setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnP addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnP];
  /////////
    
    UIButton *btnQ=[UIButton buttonWithType:UIButtonTypeCustom];
    btnQ.frame=CGRectMake(8.5,217,25.5,21.5);
      btnQ.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnQ setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnQ setTitle:@"Q" forState:UIControlStateNormal];
    [btnQ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnQ addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnQ];
    
    
    UIButton *btnR=[UIButton buttonWithType:UIButtonTypeCustom];
    btnR.frame=CGRectMake(42.5,217,25.5,21.5);
    btnR.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnR setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnR setTitle:@"R" forState:UIControlStateNormal];
    [btnR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnR addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnR];
    
    UIButton *btnS=[UIButton buttonWithType:UIButtonTypeCustom];
    btnS.frame=CGRectMake(76.5,217,25.5,21.5);
      btnS.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnS setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnS setTitle:@"S" forState:UIControlStateNormal];
    [btnS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnS addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnS];
    
    
    UIButton *btnT=[UIButton buttonWithType:UIButtonTypeCustom];
    btnT.frame=CGRectMake(110.5,217,25.5,21.5);
     btnT.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnT setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnT setTitle:@"T" forState:UIControlStateNormal];
    [btnT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnT addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnT];
    
    
    UIButton *btnU=[UIButton buttonWithType:UIButtonTypeCustom];
    btnU.frame=CGRectMake(144.5,217,25.5,21.5);
      btnU.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnU setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnU setTitle:@"U" forState:UIControlStateNormal];
    [btnU setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnU addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnU];
    
    
    UIButton *btnV=[UIButton buttonWithType:UIButtonTypeCustom];
    btnV.frame=CGRectMake(178.5,217,25.5,21.5);
      btnV.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnV setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnV setTitle:@"V" forState:UIControlStateNormal];
    [btnV setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnV addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnV];
    
    
    UIButton *btnW=[UIButton buttonWithType:UIButtonTypeCustom];
    btnW.frame=CGRectMake(212.5,217,25.5,21.5);
      btnW.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnW setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnW setTitle:@"W" forState:UIControlStateNormal];
    [btnW setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnW addTarget:self action:@selector(WWW) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnW];
    
    
    UIButton *btnX=[UIButton buttonWithType:UIButtonTypeCustom];
    btnX.frame=CGRectMake(246.5,217,25.5,21.5);
      btnX.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnX setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnX setTitle:@"X" forState:UIControlStateNormal];
    [btnX setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnX addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnX];
    ////////
    
    UIButton *btnY=[UIButton buttonWithType:UIButtonTypeCustom];
    btnY.frame=CGRectMake(8.5,249,25.5,21.5);
      btnY.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnY setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnY setTitle:@"Y" forState:UIControlStateNormal];
    [btnY setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnY addTarget:self action:@selector(YYY) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnY];
    
    
    UIButton *btnZ=[UIButton buttonWithType:UIButtonTypeCustom];
    btnZ.frame=CGRectMake(42.5,249,25.5,21.5);
      btnZ.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnZ setBackgroundImage:[UIImage imageNamed:@"btnbg@2x.png"] forState:UIControlStateNormal];
    [btnZ setTitle:@"Z" forState:UIControlStateNormal];
    [btnZ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnZ addTarget:self action:@selector(ZZZ) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnZ];

    /////////
    
    UIButton *btnOk=[UIButton buttonWithType:UIButtonTypeCustom];
    btnOk.frame=CGRectMake(76.5,249,30,20);
    btnOk.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0f];
    [btnOk setBackgroundImage:[UIImage imageNamed:@"btn_button@2x.png"] forState:UIControlStateNormal];
    [btnOk setTitle:@"Ok" forState:UIControlStateNormal];
    [btnOk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOk addTarget:self action:@selector(btnokClicked) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnOk];
    
    UIButton *btnGiveUp=[UIButton buttonWithType:UIButtonTypeCustom];
    btnGiveUp.frame=CGRectMake(110.5,249,49,20);
    btnGiveUp.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0f];
    [btnGiveUp setBackgroundImage:[UIImage imageNamed:@"btn_button@2x.png"] forState:UIControlStateNormal];
    [btnGiveUp setTitle:@"GiveUp" forState:UIControlStateNormal];
    [btnGiveUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnGiveUp addTarget:self action:@selector(ZZZ) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btnGiveUp];
    

    UIButton *btndynamite=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btndynamite.frame=CGRectMake(231,249,41,33);
    btndynamite.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
    [btndynamite setBackgroundImage:[UIImage imageNamed:@"dynamite_sticks_big@2x.png"] forState:UIControlStateNormal];
    [btndynamite setTitle:@"10" forState:UIControlStateNormal];
    [btndynamite setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btndynamite addTarget:self action:@selector(ZZZ) forControlEvents:UIControlEventTouchUpInside];
    [guessView addSubview:btndynamite];
    

    
    
}

-(void)addCoin
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    
    BuyCoinsView *buyCoins = [[BuyCoinsView alloc]initWithNibName:@"BuyCoinsView" bundle:nil];
    [self.navigationController pushViewController:buyCoins animated:NO];
    
    
}

-(void)addStick
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    StoreView *store=[[StoreView alloc]initWithNibName:@"StoreView" bundle:nil];
    [self.navigationController pushViewController:store animated:YES];
}


#pragma mark - TableViewDelegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    if (tableView.tag==185) 
    {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell %i",indexPath.section]];
        
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Cell %i",indexPath.section]] autorelease];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        UILabel *lbl=[[[UILabel alloc]initWithFrame:CGRectMake(15,2,150,20)]autorelease];
        // lbl.tag=MYPRICELABEL_TAG;
        lbl.font=[UIFont systemFontOfSize:15.0];
        lbl.textColor=[UIColor blackColor];
        [lbl setBackgroundColor:[UIColor clearColor]];
        //ADD THE LABEL TO CELLS CONTACT VIEW
        [cell.contentView addSubview:lbl];
        
        if(indexPath.row==0)
        {
            lbl.text=@"Notification";
            sw = [[UISwitch alloc]initWithFrame:CGRectMake(140,5,20,10)];
            // [sw setFrame:CGRectMake(145,5,20,10)];
            // [sw setOnTintColor:[UIColor lightGrayColor]];
            
            // Use the ivar here
            // onoff = [[UISwitch alloc] initWithFrame: CGRectZero];
            [sw addTarget: self action: @selector(flip:) forControlEvents: UIControlEventValueChanged];
            sw.tag=indexPath.row;
            // Set the desired frame location of onoff here
            [cell  addSubview:sw];
            // [sw release];
            
        }
        else if(indexPath.row==1)
        {
            lbl.text=@"Sounds";
            sw = [[UISwitch alloc]initWithFrame:CGRectMake(140,5,20,10)];
            //[sw setFrame:CGRectMake(145,5,20,10)];
            // [sw setOnTintColor:[UIColor lightGrayColor]];
            if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"OFF"])
            {
                [sw setOn:NO];
                
            }
            else
            {
                [sw setOn:YES];
            }
            // Use the ivar here
            // onoff = [[UISwitch alloc] initWithFrame: CGRectZero];
            [sw addTarget: self action: @selector(flip1:) forControlEvents: UIControlEventValueChanged];
            sw.tag=indexPath.row;
            // Set the desired frame location of onoff here
            [cell  addSubview:sw];
            // [sw release];
            
        }
        else if(indexPath.row==2)
        {
            lbl.text=@"Change Profile Photo";
        } 
        else if(indexPath.row==3)
        {
            lbl.text=@"Change Password";
        } 
        else if(indexPath.row==4)
        {
            lbl.text=@"Log Out";
        } 
        
        
        return  cell;
        
    }
      
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     if (tableView.tag==185)
    {
        return 40;
        
    }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    
    if (tableView.tag==185) {
        return 5;
        
    }
    
}


-(void)btnokClicked
{
    UIAlertView*  alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Worng Guess!Would you like to try again?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"GiveUp", nil];
    [alert show];
    [alert release];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        
        GreatJobView *greatJobView = [[GreatJobView alloc]initWithNibName:@"GreatJobView" bundle:nil];
        [self.navigationController pushViewController:greatJobView animated:YES];
        
//        GuessView *guessView = [[GuessView alloc]initWithNibName:@"GuessView" bundle:nil];
//        [self.navigationController pushViewController:guessView animated:YES];
    }
    else if(buttonIndex==1)
    {
        AnswerView *ansView = [[AnswerView alloc]initWithNibName:@"AnswerView" bundle:nil];
        [self.navigationController pushViewController:ansView animated:YES];

        
    }
    
}




- (void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:YES];
    
    
    [self.navigationItem setHidesBackButton: YES animated:NO];
    [resultArrayFinal removeAllObjects];
    //  [self callRequestParsing];
    
    [lblCoins setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intCoins"]] ;
    [lblDinamite setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intSticks"]];

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125.0,0.0, 180.0, 35.0)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont boldSystemFontOfSize:20.0f]];
    // [label setAdjustsFontSizeToFitWidth:YES];
    [label setText:@"Guess"];
    [label setTextColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];   
    [label setTextAlignment:UITextAlignmentCenter];
    [[self navigationItem] setTitleView:label];
    [label release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


CGPoint lastPos;
#pragma Mark-.###########################################
#pragma Mark-#### popup menu for all screen #############
#pragma Mark-############################################

-(void)showPopUpMenu
{
    
	// create and configure the view
    //CGRect cgRct = CGRectMake(219,-1, 93, 135); //define size and position of view 
    CGRect cgRct = CGRectMake(67, 28,239,249); //define size and position of view 
    
	myView = [[UIView alloc] initWithFrame:cgRct];
    myView.backgroundColor=[UIColor clearColor];
    [myView setUserInteractionEnabled:YES];
    //myView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"popupbg@2x.png"]];
    UIButton *btnpop=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,239,249)];
    [btnpop setUserInteractionEnabled:YES];
    [btnpop setImage:[UIImage imageNamed:@"settings@2x.png"] forState:UIControlStateNormal];
    [myView addSubview:btnpop];
    
    //[self.navigationController.navigationBar bringSubviewToFront:myView];
	// [myView release];
    
	
    table = [[UITableView alloc]initWithFrame:CGRectMake(1,48,238,190) style:UITableViewStylePlain];
    [table setUserInteractionEnabled:YES];
    //table.backgroundColor=[UIColor blueColor];
    table.backgroundColor = [UIColor clearColor];
    table.separatorColor=[UIColor lightGrayColor];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"popupline@2x.png"]];
    table.scrollEnabled=NO;
    table.tag=185;
    table.layer.borderColor = [UIColor clearColor].CGColor;
	table.layer.borderWidth=1.0;
	table.layer.cornerRadius = 8;
	[table setDataSource:self];
	[table setDelegate:self];
    table.tag=185;
	//[self.view addSubview:table];
	[btnpop addSubview:table];
    
    myView.autoresizesSubviews = YES;
    keyValue=[[UIApplication sharedApplication]keyWindow];
	[keyValue addSubview:myView];
    table.hidden=NO;
    
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView.tag==185) {
        cell.backgroundColor=[UIColor clearColor];
        
    }
}







-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"Mohit pop up clicked");
    if (tableView.tag==185) {
        
        if(indexPath.row== 0)
        {
            
        }
        else if(indexPath.row==1)
        {
            
        }
        else if(indexPath.row==2)
        {
            ChangeProfilePicViewController *chv=[[ChangeProfilePicViewController alloc]initWithNibName:@"ChangeProfilePicViewController" bundle:nil]; 
            [self.navigationController pushViewController:chv animated:YES];
            

        }
        else if(indexPath.row==3)
        {
            
        }
        else if(indexPath.row==4)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        DataClass *obj=[DataClass getInstance];
        obj.checkSetting=@"No";
        
        [table setHidden:YES];
        [myView setHidden:YES];
        
    }
}


-(void)btnSettingButtonClicked
{
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    
    DataClass *obj=[DataClass getInstance];
    if(obj.checkSetting==@"Yes")
    {
        [myView setHidden:YES];
      [myView removeFromSuperview];
        obj.checkSetting=@"No";
        
	}
    else
    {
        obj.checkSetting=@"Yes";
        [self showPopUpMenu];
        
    }
    
    
}

-(void)playSound
{
    NSString *filepath= [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Hole_Punch-Simon_Craggs-1910998415.mp3"];    
    NSURL *fileurl = [NSURL fileURLWithPath:filepath];
    NSError *error=nil;
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileurl error:&error];
    if (error) {
       // NSLog(@"error %@",error);
    }
    else
    {
        audioPlayer.volume=0.3;
        [audioPlayer play];
        
    }
}

- (void)flip:(UIButton *)tag 
{
    if(!sw.on)
	{		
		privacyStatus = @"0";
	}
	else {
		privacyStatus = @"1";
	}    
    //[self callPrivacyParshing];
}

- (void)flip1:(UIButton *)tag 
{
    if(sw.on)
	{		
		privacyStatus = @"0";
        [[NSUserDefaults standardUserDefaults] setObject:@"ON"  forKey:@"SoundStatus"];
        [[NSUserDefaults standardUserDefaults] synchronize];
       // NSLog(@"%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus" ] );
        
	}
	else {
        [[NSUserDefaults standardUserDefaults] setObject:@"OFF"  forKey:@"SoundStatus"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
		privacyStatus = @"1";
	}    
    //[self localPrivacyChange];
}



@end
