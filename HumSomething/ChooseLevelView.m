//
//  ChooseLevelView.m
//  HumSomething
//
//  Created by Pravesh Uniyal on 12/07/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ChooseLevelView.h"
#import <QuartzCore/QuartzCore.h>
#import "GuessView.h"
#import "ChangeProfilePicViewController.h"
#import "NSAttributedString+Attributes.h"
#import "MainHeaderFile.h"
#import "HumStartView.h"
extern NSString *kCAFilterPageCurl; 
@class CAFilter;
@implementation ChooseLevelView
@synthesize privacyStatus,sw;
@synthesize responseData,capturedCharacters;
@synthesize strChooseUserID,strChooseUserName;
@synthesize sep4,sep3,sep2,sep1;

float y2t2=5.0f;




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
    
    resultArrayFinal=[[NSMutableArray alloc]init];
    resultArray=[[NSMutableArray alloc]init];
     resultArrayFinal2=[[NSMutableArray alloc]init];
    resultArrayFinal3=[[NSMutableArray alloc]init];
   // [self callRequestParsing];
 
    
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
    // Create tableview
    
    
    chooseLavelView=[[UIView alloc]initWithFrame:CGRectMake(10,65, 300,350)];
    
    
    chooseLavelView.layer.cornerRadius =6.0;
    chooseLavelView.backgroundColor =[UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    
    chooseLavelView.layer.borderColor = [UIColor whiteColor].CGColor;
	chooseLavelView.layer.borderWidth = 1.0; //#import <QuartzCore/QuartzCore.h>
    
    [self.view addSubview:chooseLavelView];
    

    
    sep1 =[[UILabel alloc]initWithFrame:CGRectMake(0, 62.5f, 300, 2)];
    sep1.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [chooseLavelView addSubview:sep1];
   
    [sep1 release];
    
    sep2 =[[UILabel alloc]initWithFrame:CGRectMake(0, 125.0f, 300, 1)];
    sep2.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [chooseLavelView addSubview:sep2];
    [sep2 release];
    
    sep3 =[[UILabel alloc]initWithFrame:CGRectMake(0, 187.5, 300, 2)];
    sep3.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [chooseLavelView addSubview:sep3];
    [sep3 release];
    
    sep4=[[UILabel alloc]initWithFrame:CGRectMake(0, 250, 300, 1)];
    sep4.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [chooseLavelView addSubview:sep4];
    [sep4 release];
    
     
    
    
        topLabel10 = [[UILabel alloc]initWithFrame:CGRectMake(8 ,18 ,150, 40)];
        topLabel10.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        topLabel10.textColor = [UIColor blackColor];
        topLabel10.backgroundColor=[UIColor clearColor];
        topLabel10.lineBreakMode=UILineBreakModeWordWrap;
        topLabel10.numberOfLines=0;

        [chooseLavelView addSubview:topLabel10];
       
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(8 ,5 ,40, 20)];
    topLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:10.0];
    topLabel.textColor = [UIColor blackColor];
    topLabel.backgroundColor=[UIColor clearColor];
    
    topLabel.text=@"Easy";
    [chooseLavelView addSubview:topLabel];
    
    
    UILabel*coin = [[UILabel alloc]initWithFrame:CGRectMake(190.5 ,20 ,40, 15)];
    coin.font = [UIFont fontWithName:@"Helvetica-bold" size:12.0f];
    coin.backgroundColor=[UIColor clearColor];
    [coin setAdjustsFontSizeToFitWidth:YES]; 
    coin.text=@"1 coin";
    [chooseLavelView addSubview:coin];
    
    
    UIImageView *cellCoinsImage = [[UIImageView alloc]initWithFrame:CGRectMake(250,21,18,18)];
    cellCoinsImage.image=[UIImage imageNamed:@"1_coin_ico@2x.png"];
    [chooseLavelView addSubview:cellCoinsImage];
   /////// 
    UILabel *topLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(8 ,70.5 ,70, 20)];
    topLabel1.font = [UIFont fontWithName:@"Helvetica-bold" size:12.0];
    topLabel1.textColor = [UIColor blackColor];
    topLabel1.backgroundColor=[UIColor clearColor];
    topLabel1.text=@"Medium";
    [chooseLavelView addSubview:topLabel1];
    
    NSLog(@"%@",resultArrayFinal);
    
    
        topLabel11 = [[UILabel alloc]initWithFrame:CGRectMake(8 ,80.5 ,150, 40)];
        topLabel11.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        topLabel11.backgroundColor=[UIColor clearColor];
        topLabel11.lineBreakMode=UILineBreakModeWordWrap;
        topLabel11.numberOfLines=0;
        [chooseLavelView addSubview:topLabel11];
       
    UILabel *coin1 = [[UILabel alloc]initWithFrame:CGRectMake(190.5 ,82.5 ,40, 20)];
    coin1.font = [UIFont fontWithName:@"Helvetica-bold" size:12.0f];
    coin1.backgroundColor=[UIColor clearColor];
    [coin1 setAdjustsFontSizeToFitWidth:YES]; 
    
    coin1.text=@"2 coin";
    [chooseLavelView addSubview:coin1];
    
    
    UIImageView *cellCoinsImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(245,83.5,27,18)];
    cellCoinsImage1.image=[UIImage imageNamed:@"2_coin_ico@2x.png"];
    [chooseLavelView addSubview:cellCoinsImage1];
    
///
    
    UILabel *topLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(8 ,130 ,40, 20)];
    topLabel2.font = [UIFont fontWithName:@"Helvetica-bold" size:12.0f];
    topLabel2.textColor = [UIColor blackColor];
    topLabel2.backgroundColor=[UIColor clearColor];
    topLabel2.text=@"Hard";
    [chooseLavelView addSubview:topLabel2];
    
    
    
   
       topLabel12 = [[UILabel alloc]initWithFrame:CGRectMake(8 ,143 ,150, 40)];
        topLabel12.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
        
        topLabel12.backgroundColor=[UIColor clearColor];
       
        topLabel12.lineBreakMode=UILineBreakModeWordWrap;
        topLabel12.numberOfLines=0;
        topLabel12.textAlignment=UITextAlignmentLeft;
        [chooseLavelView addSubview:topLabel12];
    

    UILabel *coin3 = [[UILabel alloc]initWithFrame:CGRectMake(190.5 ,145 ,40, 20)];
    coin3.font = [UIFont fontWithName:@"Helvetica-bold" size:12.0f];
    [coin3 setAdjustsFontSizeToFitWidth:YES]; 
    
    coin3.backgroundColor=[UIColor clearColor];
    coin3.text=@"3 coin";
    [chooseLavelView addSubview:coin3];
    
    
    UIImageView *cellCoinsImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(240,146,31,18)];
    cellCoinsImage3.image=[UIImage imageNamed:@"3_coin_ico@2x.png"];
    [chooseLavelView addSubview:cellCoinsImage3];
    
    btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn0.frame = CGRectMake(0,0 ,300,62.5);
    btn0.tag=0;
    [btn0 addTarget:self action:@selector(btnSongClick:) forControlEvents:UIControlEventTouchUpInside];
    [chooseLavelView addSubview:btn0];
    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,62.5 ,300,62.5);
    btn1.tag=1;
    [btn1 addTarget:self action:@selector(btnSongClick:) forControlEvents:UIControlEventTouchUpInside];
    [chooseLavelView addSubview:btn1];
    
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0,123 ,300,62.5);
    btn2.tag=2;
    [btn2 addTarget:self action:@selector(btnSongClick:) forControlEvents:UIControlEventTouchUpInside];
    [chooseLavelView addSubview:btn2];

    
    // neww get new song\\
    
    UIButton *btnGetSong = [UIButton buttonWithType:UIButtonTypeCustom];
    btnGetSong.frame = CGRectMake(200,202.5,90,30);
    btnGetSong.backgroundColor=[UIColor clearColor];
    [btnGetSong setBackgroundImage:[UIImage imageNamed:@"btn_button@2x.png"] forState: UIControlStateNormal] ;
    [btnGetSong setTitle:@"Get New Song" forState:UIControlStateNormal];
    btnGetSong.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
    [btnGetSong addTarget:self action:@selector(btnGuessClicked) forControlEvents:UIControlEventTouchUpInside];
    [chooseLavelView addSubview:btnGetSong];
    
    
    topLabel23 = [[UILabel alloc]initWithFrame:CGRectMake(55 ,205.5 ,103.5, 20)];
    topLabel23.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    
    topLabel23.backgroundColor=[UIColor clearColor];
    [topLabel23 setAdjustsFontSizeToFitWidth:YES]; 
    [chooseLavelView addSubview:topLabel23];
    
    
    imgArray = [NSArray arrayWithObjects:
                [UIImage imageNamed:@"1.png"],
                [UIImage imageNamed:@"2.png"],
                [UIImage imageNamed:@"4.png"],
                [UIImage imageNamed:@"5.png"],nil];
    
    
    dynamite = [[UIImageView alloc]initWithFrame:CGRectMake(20, 2,60, 60)];
    dynamite.animationImages= imgArray;
    dynamite.animationDuration = 1.0;
    dynamite.animationRepeatCount = 1;
    [chooseLavelView addSubview:dynamite];
    
       
  
    dynamite1= [[UIImageView alloc]initWithFrame:CGRectMake(20 ,70.5 ,60, 60)];
    dynamite1.animationImages= imgArray;
    dynamite1.animationDuration = 1.0;
    dynamite1.animationRepeatCount = 1;
    [chooseLavelView addSubview:dynamite1];
    
    dynamite2=[[UIImageView alloc]initWithFrame:CGRectMake(20 ,130 ,60, 60)];
    dynamite2.animationImages= imgArray;
    dynamite2.animationDuration = 1.0;
    dynamite2.animationRepeatCount = 1;
    [chooseLavelView addSubview:dynamite2];
    
    
    UIImageView *cellCoinsImage6 = [[UIImageView alloc]initWithFrame:CGRectMake(18, 202.5,30, 30)];
    cellCoinsImage6.image=[UIImage imageNamed:@"dynamite_sticks_big@2x.png"];
    [chooseLavelView addSubview:cellCoinsImage6];
    

    [self updateSticks];
    
    
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


-(void)changeTimepeice
{
    UIScrollView *scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,250, 300, 100)];
    scr.userInteractionEnabled=YES;
    [chooseLavelView addSubview:scr];
    
    UILabel*topLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(5 ,5 ,104.5, 15)];
    topLabel4.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    [topLabel4 setAdjustsFontSizeToFitWidth:YES]; 
    topLabel4.backgroundColor=[UIColor clearColor];
    topLabel4.text=@"Currently You have";
    [scr addSubview:topLabel4];
    
    
    if ([resultArrayFinal2 count]>0) 
    {
        
        
        
        
        
        for (int j=0; j<[resultArrayFinal2 count]; j++)
            
        {                
            
            
            NSString* txt;
            // NSLog(@"%@",txt);
            myAttributedLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(5 ,y2t2=y2t2+15 ,200, 20)];
            
            // [strAddString stringByAppendingString:@""];
            NSLog(@"resultArray %@",resultArrayFinal2);
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle: NSNumberFormatterSpellOutStyle];
            // [formatter setLocale:...]; // Set locale if you want to use something other then the current one
            NSString* numberString = [formatter stringFromNumber:[NSNumber numberWithInt: [[[resultArrayFinal2 objectAtIndex:j]valueForKey:@"TimePiecesCount"]intValue]]];
            if  ([numberString isEqualToString:@"one"])
            {
                
                    
                     txt =[NSString stringWithFormat:@" %@ %@ second time piece ",numberString,[[resultArrayFinal2 objectAtIndex:j]valueForKey:@"intTimePiece"]];;
              
                           }
            else {
                
               
                    txt =[NSString stringWithFormat:@" %@ %@ second time pieces ",numberString,[[resultArrayFinal2 objectAtIndex:j]valueForKey:@"intTimePiece"]];;
               
               
            }
            myAttributedLabel.attributedText =[NSString stringWithString:txt];
            [myAttributedLabel setBackgroundColor:[UIColor clearColor]];
            
            
            
            // myAttributedLabel.numberOfLines=0;
            NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:txt];
            [attrStr setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            [attrStr setTextColor:[UIColor blackColor]];
            
            ///  NSString* plainText = [attrStr string];
            for (int i=0; i<[resultArrayFinal2 count]; i++) 
            {
                NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                [formatter setNumberStyle: NSNumberFormatterSpellOutStyle];
                // [formatter setLocale:...]; // Set locale if you want to use something other then the current one
                NSString* numberString = [formatter stringFromNumber:[NSNumber numberWithInt: [[[resultArrayFinal2 objectAtIndex:i]valueForKey:@"TimePiecesCount"]intValue]]];
                
                [attrStr setTextColor:[UIColor redColor] range:[txt rangeOfString:numberString]];
                //  [attrStr setTextBold:YES range:[plainText rangeOfString:@"one"]];
                
            }
            
            [myAttributedLabel setBackgroundColor:[UIColor clearColor]];
            [myAttributedLabel setAttributedText:attrStr];
            [scr addSubview:myAttributedLabel];
            
                    
        }
        
    }
    

}

-(void)updateSticks
{
    topLabel23.text=[NSString stringWithFormat:@"%@ Dynamite Sticks",[[myGlobalArray objectAtIndex:0]valueForKey:@"intSticks"]] ;//@"10 Dynamite Sticks";
    
}
-(void)btnSongClick:(UIButton *)tag

{
    
    
        
        if(tag.tag== 0)
        {
            HumStartView *hst =[[HumStartView alloc]initWithNibName:@"HumStartView" bundle:nil];
            hst.strSongID=[[resultArrayFinal3 objectAtIndex:0]valueForKey:@"intID"];
            hst.strOpponentID=strChooseUserID;
            hst.strUserName=strChooseUserName;
            [self.navigationController pushViewController:hst animated:YES];
            
        }
        else if(tag.tag==1)
        {
            HumStartView *hst =[[HumStartView alloc]initWithNibName:@"HumStartView" bundle:nil];
            hst.strSongID=[[resultArrayFinal3 objectAtIndex:1]valueForKey:@"intID"];
            hst.strOpponentID=strChooseUserID;
            hst.strUserName=strChooseUserName;
            [self.navigationController pushViewController:hst animated:YES];
        }
        else if(tag.tag==2)
        {
            HumStartView *hst =[[HumStartView alloc]initWithNibName:@"HumStartView" bundle:nil];
            hst.strSongID=[[resultArrayFinal3 objectAtIndex:2]valueForKey:@"intID"];
            hst.strOpponentID=strChooseUserID;
            hst.strUserName=strChooseUserName;
            [self.navigationController pushViewController:hst animated:YES];      
        }
        
    

    
}


-(void)updateSong
{
    NSLog(@"%@",resultArrayFinal);
    if ([[[resultArrayFinal objectAtIndex:0]valueForKey:@"vchVategory" ] isEqualToString:@"Easy"]) 
    {
        topLabel10.text=[NSString stringWithFormat:@"%@,Artist-%@",[[resultArrayFinal objectAtIndex:0]valueForKey:@"vchSongName"],[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:0]valueForKey:@"vchArtist"]]];
    }
    if ([[[resultArrayFinal objectAtIndex:1]valueForKey:@"vchVategory" ] isEqualToString:@"Medium"]) 
    {
        topLabel11.text=[NSString stringWithFormat:@"%@,Artist-%@",[[resultArrayFinal objectAtIndex:1]valueForKey:@"vchSongName"],[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:1]valueForKey:@"vchArtist"]]]; 
    }
    if ([[[resultArrayFinal objectAtIndex:2]valueForKey:@"vchVategory" ] isEqualToString:@"Hard"]) 
    {
        topLabel12.text=[NSString stringWithFormat:@"%@ ,Artist- %@",[[resultArrayFinal objectAtIndex:2]valueForKey:@"vchSongName"],[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:2]valueForKey:@"vchArtist"]]];
    }
    if (resultArrayFinal3) {
        [resultArrayFinal3 removeAllObjects];
    }
    [resultArrayFinal3 addObjectsFromArray:resultArrayFinal];
    [resultArrayFinal removeAllObjects];
    
}

#pragma mark - TableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag==1) {
        
        if (indexPath.row==0) {
            return 62.5f;
        }
        else if(indexPath.row==1){
            return 62.5f;
        }
        
        else if(indexPath.row==2){
            return 62.5f;
        }
        else if(indexPath.row==3){
            return 62.5f;
        }
        else if(indexPath.row==4){
            return 100.0f;
        }
    }
    
   else if (tableView.tag==185)
    {
        return 40;
        
    }

    return 0;
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    
    if (tableView.tag==185) {
        return 5;
        
    }
    else if(tableView.tag==1)
    {
        if ([resultArrayFinal count]>0) {
          return 5;
        }
        else {
            return 0;
        }
    }
    return 0;
}



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

//    else if (tableView.tag==1) {
//    
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil)
//    {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
//        
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        
//        
//    }
//   
//      else  if(indexPath.row==4)
//        {
//            
//            UIScrollView *scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, 300, 100)];
//            scr.userInteractionEnabled=YES;
//            [cell.contentView addSubview:scr];
//            
//            UILabel*topLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(5 ,5 ,104.5, 15)];
//            topLabel4.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
//              [topLabel4 setAdjustsFontSizeToFitWidth:YES]; 
//            topLabel4.backgroundColor=[UIColor clearColor];
//            topLabel4.text=@"Currently You have";
//            [scr addSubview:topLabel4];
//            
//            
//            if ([resultArrayFinal2 count]>0) 
//            {
//                
//                
//                
//
//            
//            for (int j=0; j<[resultArrayFinal2 count]; j++)
//            
//            {                
//                
//               
//                NSString* txt;
//               // NSLog(@"%@",txt);
//                myAttributedLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(5 ,y2t2=y2t2+15 ,200, 20)];
//                
//                // [strAddString stringByAppendingString:@""];
//                NSLog(@"resultArray %@",resultArrayFinal2);
//                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//                        [formatter setNumberStyle: NSNumberFormatterSpellOutStyle];
//                        // [formatter setLocale:...]; // Set locale if you want to use something other then the current one
//                        NSString* numberString = [formatter stringFromNumber:[NSNumber numberWithInt: [[[resultArrayFinal2 objectAtIndex:j]valueForKey:@"TimePiecesCount"]intValue]]];
//                if  ([numberString isEqualToString:@"one"])
//                {
//                    if ([[[resultArrayFinal2 objectAtIndex:j]valueForKey:@"TimePiecesCount"] length]==1) {
//                        
//                        txt =[NSString stringWithFormat:@" %@   %@  second time piece ",numberString,[[resultArrayFinal2 objectAtIndex:j]valueForKey:@"intTimePiece"]];
//                    }
//                    else {
//                        
//                       txt =[NSString stringWithFormat:@" %@ %@ second time piece ",numberString,[[resultArrayFinal2 objectAtIndex:j]valueForKey:@"intTimePiece"]];;
//                    }
//                }
//                else {
//                    
//                    if ([[[resultArrayFinal2 objectAtIndex:j]valueForKey:@"TimePiecesCount"] length]==1) {
//                    txt =[NSString stringWithFormat:@" %@  %@  second time pieces ",numberString,[[resultArrayFinal2 objectAtIndex:j]valueForKey:@"intTimePiece"]];
//                    }
//                    else {
//                        txt =[NSString stringWithFormat:@" %@ %@ second time pieces ",numberString,[[resultArrayFinal2 objectAtIndex:j]valueForKey:@"intTimePiece"]];;
//                    }
//                }
//                        myAttributedLabel.attributedText =[NSString stringWithString:txt];
//                        [myAttributedLabel setBackgroundColor:[UIColor clearColor]];
//                                       
//               
//                
//               // myAttributedLabel.numberOfLines=0;
//                NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:txt];
//                [attrStr setFont:[UIFont fontWithName:@"Helvetica" size:12]];
//                [attrStr setTextColor:[UIColor blackColor]];
//                
//                ///  NSString* plainText = [attrStr string];
//                for (int i=0; i<[resultArrayFinal2 count]; i++) 
//                {
//                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//                    [formatter setNumberStyle: NSNumberFormatterSpellOutStyle];
//                    // [formatter setLocale:...]; // Set locale if you want to use something other then the current one
//                    NSString* numberString = [formatter stringFromNumber:[NSNumber numberWithInt: [[[resultArrayFinal2 objectAtIndex:i]valueForKey:@"TimePiecesCount"]intValue]]];
//                    
//                    [attrStr setTextColor:[UIColor redColor] range:[txt rangeOfString:numberString]];
//                    //  [attrStr setTextBold:YES range:[plainText rangeOfString:@"one"]];
//                    
//                }
//                
//                [myAttributedLabel setBackgroundColor:[UIColor clearColor]];
//                [myAttributedLabel setAttributedText:attrStr];
//                [scr addSubview:myAttributedLabel];
//                
//
//                
//                // [myAttributedLabel setTextAlignment:UITextAlignmentLeft];
//                // [myAttributedLabel setLineBreakMode:UILineBreakModeCharacterWrap];
//                 
//                                
//            }
//            
//            }
//            
//            
//        }
//
//          return  cell;
    //} 
   

    return  0;
    
}



-(void)btnGuessClicked
{
      [self btnStickClicked];
    [dynamite startAnimating];
    [dynamite1 startAnimating];
    [dynamite2 startAnimating];
//    NSString *filepath= [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Hole_Punch-Simon_Craggs-1910998415.mp3"];    
//    NSURL *fileurl = [NSURL fileURLWithPath:filepath];
//    NSError *error=nil;
//    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileurl error:&error];
//    if (error) {
//        //(@"error %@",error);
//    }
//    else
//    {
//        audioPlayer.volume=0.3;
//        [audioPlayer play];
//        
//    }
   /* GuessView *guessView = [[GuessView alloc]initWithNibName:@"GuessView" bundle:nil];
    [self.navigationController pushViewController:guessView animated:YES];
    [guessView release];
    */
}

- (void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:YES];
    
    
   
 
    y2t2=5.0f;
        
    [self.navigationItem setHidesBackButton: YES animated:NO];
    [resultArrayFinal removeAllObjects];
    [resultArrayFinal2 removeAllObjects];
    [self callgettimeStrings];
    [self callRequestParsing];
    
    [lblCoins setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intCoins"]] ;
    [lblDinamite setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intSticks"]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125.0,0.0, 180.0, 35.0)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont boldSystemFontOfSize:20.0f]];
    // [label setAdjustsFontSizeToFitWidth:YES];
    [label setText:@"Choose Level"];
    [label setTextColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];   
    [label setTextAlignment:UITextAlignmentCenter];
    [[self navigationItem] setTitleView:label];
    [label release];
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
            ChangePasswordView *pwd = [[ChangePasswordView alloc]initWithNibName:@"ChangePasswordView" bundle:nil]; 
            [self.navigationController pushViewController:pwd animated:YES];

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
        ///[myView removeFromSuperview];
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
        //(@"error %@",error);
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
        //(@"%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus" ] );
        
	}
	else {
        [[NSUserDefaults standardUserDefaults] setObject:@"OFF"  forKey:@"SoundStatus"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
		privacyStatus = @"1";
	}    
    //[self localPrivacyChange];
}


-(void)callLoginParsing
{
    
    // ht tp://humsomething.netsmartz.us/HumServices.svc/loginuser/UserName=brad,Password=brad12
    
	// Create the Request.
    
    ///(@"user %@ and pass %@",userStr,passStr);
	NSURLRequest *request = [NSURLRequest requestWithURL:
							 [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/loginuser/UserName=%@,Password=%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"userStr" ],[[NSUserDefaults standardUserDefaults] stringForKey:@"passStr" ]]]
											 cachePolicy:NSURLRequestUseProtocolCachePolicy
										 timeoutInterval: 30.0];
	
	// Create the connection and send the request
	
	NSURLConnection *connection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	// Make sure that the connection is good
	
	if (connection)
		
	{
		// Instantiate the responseData data structure to store to response
		
		self.responseData = [NSMutableData data];
		
	}
	else 
	{
		// (@"The connection failed");
		
	}
	
}


-(void)callRequestParsing
{
    
    //h ttp://humsomething.netsmartz.us/HumServices.svc/getSongsToHum
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/getSongsToHum"]]
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval: 10.0];
    
    // Create the connection and send the request
    
    NSURLConnection *connection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    // Make sure that the connection is good
    
    if (connection)
        
    {
        // Instantiate the responseData data structure to store to response
        
        self.responseData = [NSMutableData data];
        
    }
    else 
    {
        // (@"The connection failed");
        
    }
    
}


-(void)btnStickClicked
{
    if ([[[myGlobalArray objectAtIndex:0]valueForKey:@"intSticks"] intValue]>0)
    {
       // [self callRequestParsing];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:
                                 [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/updateusersticks/intUserID=%@,intSticks=%@,intCoins=%@",[[myGlobalArray objectAtIndex:0]valueForKey:@"intID"],@"1",@"0"]]
                                                 cachePolicy:NSURLRequestReloadIgnoringCacheData
                                             timeoutInterval: 10.0];
        
        // Create the connection and send the request
        
        NSURLConnection *connection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        // Make sure that the connection is good
        
        if (connection)
            
        {
            // Instantiate the responseData data structure to store to response
            
            self.responseData = [NSMutableData data];
            
        }
        else 
        {
            // (@"The connection failed");
            
        }
        
    }
    else {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"OOps!\ue403" message:@"You have no extra coins for buy more sticks" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    
}

-(void)callgettimeStrings
{
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/getTimePiecesForStore/intUserID=%@",[[myGlobalArray objectAtIndex:0]valueForKey:@"intID"]]]
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval: 10.0];
    
    // Create the connection and send the request
    
    NSURLConnection *connection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    // Make sure that the connection is good
    
    if (connection)
        
    {
        // Instantiate the responseData data structure to store to response
        
        self.responseData = [NSMutableData data];
        
    }
    else 
    {
        // (@"The connection failed");
        
    }
    
}

//*************************** NSUrlConnection class delegate method ***************************************************************

// Called when a redirect will cause the URL of the request to change


- (NSURLRequest *)connection:(NSURLConnection *)connection
             willSendRequest:(NSURLRequest *)request
            redirectResponse:(NSURLResponse *)redirectResponse

{
    
    //NSLog (@"connection:willSendRequest:redirectResponse:");
    
    return request;
    
    
}



// Called when the server requires authentication

- (void)connection:(NSURLConnection *)connection
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge

{
    // here this time we are not using authentication
    
    //NSLog (@"connection:didReceiveAuthenticationChallenge:");
    
}



// Called when the authentication challenge is cancelled on the connection

- (void)connection:(NSURLConnection *)connection
didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge

{
    
    
    //NSLog (@"connection:didCancelAuthenticationChallenge:");
    
    
}


// Called when the connection has enough data to create an NSURLResponse

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response 

{
    //NSLog (@"connection:didReceiveResponse:");
    
    //NSLog(@"expectedContentLength: %qi", [response expectedContentLength] );
    
    //NSLog(@"textEncodingName: %@", [response textEncodingName]);
    
    [self.responseData setLength:0];
    
}



// Called each time the connection receives a chunk of data

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    // (@"connection:didReceiveData:");
    
    // Append the received data to our responseData property
    
    [self.responseData appendData:data];
    
}




// Called when the connection has successfully received the complete response

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog (@"connectionDidFinishLoading:");
    
    // Convert the data to a string and log the response string
    
    NSString *responseString = [[NSString alloc]
                                initWithData:self.responseData
                                encoding:NSUTF8StringEncoding];
    
    NSLog(@"Response String: \n%@", responseString);
    
    [responseString release];
    
    // Free the connection
    [connection release];
    
    [self parseXML];
   
    [self updateSticks];
    
    
    
}


-(void)backButtonClicked
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    
	[self.navigationController popViewControllerAnimated:YES];
}

// Called when an error occurs in loading the response


- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    
    //NSLog (@"connection:didFailWithError:");
    
    //NSLog (@"%@",[error localizedDescription]);
    
    // Free the connection
    
    [connection release];
    
    
    
}

//********************************************************* start the parse given xml data ************************************* coded by mohit bisht

- (void) parseXML

{
    NSLog (@"parseXML");
    
    // Initialize the parser with our NSData from the RSS feed
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:self.responseData];
    
    // Set the delegate to self
    
    [xmlParser setDelegate:self];
    
    // Start the parser
    
    if (![xmlParser parse])
    {
        // (@"An error occurred in the parsing");
    }
    
    // Release the parser because we are done with it
    
    [xmlParser release];
}

// Called when the parser begins parsing the document

- (void)parserDidStartDocument:(NSXMLParser *)parser 

{
    //NSLog (@"parserDidStartDocument");
    inItemElement = NO;
    
}


// Called when the parser finishes parsing the document

- (void)parserDidEndDocument:(NSXMLParser *)parser

{
    //NSLog (@"parserDidEndDocument");
}


// Called when the parser encounters a start element

- (void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qualifiedName
     attributes:(NSDictionary *)attributeDict

{
    NSLog (@"didStartElement");
    
    // Check to see which element we have found
    
    
    
    
    if ([elementName isEqualToString:@"ArrayOfUserTimePiecesTable"])
        
	{
		// We are in an item element
        
        resultArray=[[NSMutableArray alloc]init];
        
		inItemElement = YES;
	}

    
    if ([elementName isEqualToString:@"ArrayOftblUsers"])
        
	{
        resultArray=[[NSMutableArray alloc]init];
        
        inItemElement = YES;

        
    }
    
    if ([elementName isEqualToString:@"ArrayOfSongsToHumTable"])
        
    {
        // We are in an item element
        
        resultArray=[[NSMutableArray alloc]init];
        
        inItemElement = YES;
    }
    
    
    if ([elementName isEqualToString:@"updateusersticksResponse"])
        
    {
        // We are in an item element
        
        //resultArray=[[NSMutableArray alloc]init];
        
        inItemElement = YES;
        
    }

    
    // If we are in an item and found a title
    
    if (inItemElement) {
        
        capturedCharacters = [[NSMutableString alloc]init];
    }
    
    if ([elementName isEqualToString:@"SongsToHumTable"])
        
    {
        
        capturedCharacters = [[NSMutableString alloc]init];
        
    }
    
    
   
    
}


// Called when the parser encounters an end element

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 

{
    NSLog (@"didEndElement");
    
    
    // Check to see which element we have ended
    // If we are in an item and ended a title
    
        
    
    if (inItemElement && [elementName isEqualToString:@"intCoinstowin"]) 
        
    {
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
        
        [capturedCharacters release];
        capturedCharacters = nil;
        
    }
    if (inItemElement && [elementName isEqualToString:@"vchArtist"])
        
    {
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
        
        [capturedCharacters release];
        capturedCharacters = nil;
        
    }
    if (inItemElement && [elementName isEqualToString:@"vchSongName"])
        
    {
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
        
        [capturedCharacters release];
        capturedCharacters = nil;
        
    }
    if (inItemElement && [elementName isEqualToString:@"vchVategory"])
        
    {
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
        
        [capturedCharacters release];
        capturedCharacters = nil;	 
        
        
       	
    }
    
    /// login parse
    
    if (inItemElement && [elementName isEqualToString:@"IsPushActive"]) 
        
	{
        [resultArray addObject:capturedCharacters];
        
		// Release the capturedCharacters instance variable
		
		[capturedCharacters release];
		capturedCharacters = nil;
		
	}
    if (inItemElement && [elementName isEqualToString:@"IsActive"])
        
	{
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
		
		[capturedCharacters release];
		capturedCharacters = nil;
		
	}
    if (inItemElement && [elementName isEqualToString:@"dtCreate"])
        
	{
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
		
		[capturedCharacters release];
		capturedCharacters = nil;		
	}
    if (inItemElement && [elementName isEqualToString:@"intCoins"])
        
	{
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
		
		[capturedCharacters release];
		capturedCharacters = nil;
		
	}
    if (inItemElement && [elementName isEqualToString:@"intID"])
        
	{
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
		
		[capturedCharacters release];
		capturedCharacters = nil;
        
    }
    if (inItemElement && [elementName isEqualToString:@"intSticks"])
        
	{
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
		
		[capturedCharacters release];
		capturedCharacters = nil;
		
	}
    if (inItemElement && [elementName isEqualToString:@"vchEmail"])
        
	{
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
		
		[capturedCharacters release];
		capturedCharacters = nil;
		
	}
    
    if (inItemElement && [elementName isEqualToString:@"vchUserName"])
        
	{
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
		
		[capturedCharacters release];
		capturedCharacters = nil;
		
	}
    
    if (inItemElement && [elementName isEqualToString:@"vchImage"])
        
    {
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
        
        [capturedCharacters release];
        capturedCharacters = nil;
        
    }
    
    
    
    if (inItemElement && [elementName isEqualToString:@"TimePiecesCount"]) 
        
	{
        [resultArray addObject:capturedCharacters];
        
		// Release the capturedCharacters instance variable
		
		[capturedCharacters release];
		capturedCharacters = nil;
		
	}
    if (inItemElement && [elementName isEqualToString:@"intTimePiece"]) 
        
	{
        [resultArray addObject:capturedCharacters];
        
		// Release the capturedCharacters instance variable
		
		[capturedCharacters release];
		capturedCharacters = nil;
		
	}
    if (inItemElement && [elementName isEqualToString:@"vchType"]) 
        
	{
        [resultArray addObject:capturedCharacters];
        
		// Release the capturedCharacters instance variable
		
		[capturedCharacters release];
		capturedCharacters = nil;
		
	}
    ///////// get time pieces ////////
    if ([elementName isEqualToString:@"UserTimePiecesTable"])
        
    {
        NSMutableDictionary *dic;
        // NSLog(@"resultArray %@",resultArray);
        if ([resultArray count]>0) 
        {
            dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[resultArray objectAtIndex:0],@"TimePiecesCount",[resultArray objectAtIndex:1],@"intTimePiece",[resultArray objectAtIndex:2],@"vchType",nil];
            
            //inItemElement = NO;
            [resultArray removeAllObjects];
            [resultArrayFinal2 addObject:dic];
            NSLog(@" result arryfinal2 time is %@",resultArrayFinal2);
            
            
        }
        
    }

    if ([elementName isEqualToString:@"ArrayOfUserTimePiecesTable"])
        
    {
        [self changeTimepeice];
    }
    
    ////////////
    
    if ([elementName isEqualToString:@"ArrayOftblUsers"])
        
	{
		// We are no longer in an item element
        NSMutableDictionary *dic;
        //    NSLog(@"%@",resultArray);
        if ([resultArray count]>0) 
        {
            
            dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[resultArray objectAtIndex:0],@"IsActive",[resultArray objectAtIndex:1],@"IsPushActive",[resultArray objectAtIndex:2],@"dtCreate",[resultArray objectAtIndex:3],@"intCoins",[resultArray objectAtIndex:4],@"intID",[resultArray objectAtIndex:5],@"intSticks",[resultArray objectAtIndex:6],@"vchEmail",[resultArray objectAtIndex:7],@"vchImage",[resultArray objectAtIndex:8],@"vchUserName",nil];
            
            
            inItemElement = NO;
            [resultArray removeAllObjects];
            [resultArray addObject:dic];
            
            
            [myGlobalArray removeAllObjects];
            [myGlobalArray addObjectsFromArray:resultArray];
            [lblCoins setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intCoins"]] ;
            [lblDinamite setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intSticks"]];      
        }
       [self callRequestParsing];
    }

    if ([elementName isEqualToString:@"updateusersticksResult"])
        
    {
        if ([capturedCharacters isEqualToString:@"Success"]) {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message!\ue405" message:@"Get stick Successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//            [alert show];
//            [alert release];
            //[self callRequestParsing];
            [self callLoginParsing];
            
        }
        
        // Release the capturedCharacters instance variable
        
        [capturedCharacters release];
        capturedCharacters = nil;
        
    }

    
    
    if ([elementName isEqualToString:@"SongsToHumTable"])
        
    {
        NSMutableDictionary *dic;
        //(@"resultArray %@",resultArray);
        if ([resultArray count]>0  ) 
        {
            dic = [NSMutableDictionary dictionaryWithObjectsAndKeys :[resultArray objectAtIndex:0],@"intCoinstowin",[resultArray objectAtIndex:1],@"intID",[resultArray objectAtIndex:2],@"vchArtist",[resultArray objectAtIndex:3],@"vchSongName",[resultArray objectAtIndex:4],@"vchVategory",nil];
            //inItemElement = NO;
            [resultArray removeAllObjects];
            [resultArrayFinal addObject:dic];
            NSLog(@"result array %@",resultArrayFinal);
            
        }  
    }    
    
    if ([elementName isEqualToString:@"ArrayOfSongsToHumTable"])
        
    {
        
         [self updateSong];
               
        
    }
    
    
}






// Called when the parser finds characters contained within an element

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string

{
    if (capturedCharacters != nil)
        
    {
        [capturedCharacters appendString:string];
    }
}

//****************************************************************************** parse delegate method end ****************************************


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

@end
