//
//  MainScreenView.m
//  HumSomething
//
//  Created by Pravesh Uniyal on 10/07/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainScreenView.h"
#import "MainHeaderFile.h"
#import"DataClass.h"
#import <QuartzCore/QuartzCore.h>
#import "SearchUserView.h"
#import "ActiveGameUserView.h"

extern NSString *kCAFilterPageCurl; 
@class CAFilter;

@implementation MainScreenView

@synthesize privacyStatus;
@synthesize sw;

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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
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
   
    
	
    return cell;
    
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








////############################ end......



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

- (void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:YES];
    
    
    
    [self.navigationItem setHidesBackButton: YES animated:NO];
   // NSLog(@"%@",mydetailArray);
    
    [lblCoins setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intCoins"]] ;
    [lblDinamite setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intSticks"]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125.0,0.0, 180.0, 35.0)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont boldSystemFontOfSize:18.0f]];
    // [label setAdjustsFontSizeToFitWidth:YES];
    [label setText:@"Welcome"];
    [label setTextColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];   
    [label setTextAlignment:UITextAlignmentCenter];
    [[self navigationItem] setTitleView:label];
    [label release];
}





- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
       
//    UIView *parentView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 6,51, 44)];
//	UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 6, 51, 30)];
//	[btnBack setBackgroundImage:[UIImage imageNamed:@"back@2x.png"] forState:UIControlStateNormal];
//	[btnBack addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//	[parentView1 addSubview:btnBack];
//	[btnBack release];
//	UIBarButtonItem *homeBarButtomItem2 = [[UIBarButtonItem alloc] initWithCustomView:parentView1];
//	[parentView1 release];
//	[self.navigationItem setLeftBarButtonItem:homeBarButtomItem2];
//	[homeBarButtomItem2 release];

    
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
    //[lblCoins setText:@"0"];
    lblCoins.textColor=[UIColor blackColor];
    lblCoins.backgroundColor=[UIColor clearColor];
    [coinImage addSubview:lblCoins];
    
    
    lblDinamite=[[UILabel alloc]init];
    lblDinamite.frame=CGRectMake(260,10,80, 25);
    //[lblDinamite setText:@"0"];
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
    
    
    //add button on view
    UIButton *   btnNewGame = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNewGame.frame = CGRectMake(37.5,80 ,245,38);
    [btnNewGame setTitle:@"New Game" forState:UIControlStateNormal]; 
    btnNewGame.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [btnNewGame setTitleColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f] forState:UIControlStateNormal ];   
    [btnNewGame setBackgroundImage:[UIImage imageNamed:@"round@2x.png"] forState:UIControlStateNormal];
    [btnNewGame addTarget:self action:@selector(newGamePressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNewGame];
    
    /////////////
    UIButton *btnActiveGame = [UIButton buttonWithType:UIButtonTypeCustom];
    btnActiveGame.frame = CGRectMake(37.5,130 ,245,38);
    [btnActiveGame setTitle:@"Active Games" forState:UIControlStateNormal];
    btnActiveGame.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [btnActiveGame setTitleColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f] forState:UIControlStateNormal ];
    [btnActiveGame setBackgroundImage:[UIImage imageNamed:@"round@2x.png"] forState:UIControlStateNormal];

    [btnActiveGame addTarget:self action:@selector(btnActiveGameClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnActiveGame];
    ////////////
    
    UIButton *   btnFriendCircle = [UIButton buttonWithType:UIButtonTypeCustom];
    btnFriendCircle.frame = CGRectMake(37.5,180 ,245,38);
    [btnFriendCircle setTitle:@"Friend Circle" forState:UIControlStateNormal]; 
    btnFriendCircle.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [btnFriendCircle setTitleColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f] forState:UIControlStateNormal ]; 
    [btnFriendCircle setBackgroundImage:[UIImage imageNamed:@"round@2x.png"] forState:UIControlStateNormal];
    [btnFriendCircle addTarget:self action:@selector(btnFriendCircleClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFriendCircle];
    
    /////////
    UIButton *btnFindfriend = [UIButton buttonWithType:UIButtonTypeCustom];
    btnFindfriend.frame = CGRectMake(37.5,230 ,245,38);
    [btnFindfriend setTitle:@"Find Friends On Facebook" forState:UIControlStateNormal];
       btnFindfriend.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [btnFindfriend setTitleColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f] forState:UIControlStateNormal ];
    [btnFindfriend setBackgroundImage:[UIImage imageNamed:@"round@2x.png"] forState:UIControlStateNormal];
    [btnFindfriend addTarget:self action:@selector(btnFacbookClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnFindfriend];
    
   ////////////
    UIButton *btnStore = [UIButton buttonWithType:UIButtonTypeCustom];
    btnStore.frame = CGRectMake(37.5,280 ,245,38);
    [btnStore setTitle:@"Store" forState:UIControlStateNormal];
    btnStore.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [btnStore setTitleColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f] forState:UIControlStateNormal ];
    [btnStore setBackgroundImage:[UIImage imageNamed:@"round@2x.png"] forState:UIControlStateNormal];
    [btnStore addTarget:self action:@selector(btnStoreClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnStore];
    //////////////////
    
    UIButton *btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMore.frame = CGRectMake(37.5,330 ,245,38);
    [btnMore setTitle:@"More" forState:UIControlStateNormal];
    btnMore.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [btnMore setTitleColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f] forState:UIControlStateNormal ];
    [btnMore setBackgroundImage:[UIImage imageNamed:@"round@2x.png"] forState:UIControlStateNormal];
    [btnMore addTarget:self action:@selector(btnMoreClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMore];
    
    
    
}



#pragma mark- all actions method here

-(void)btnStoreClicked
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    StoreView *store=[[StoreView alloc]initWithNibName:@"StoreView" bundle:nil];
    [self.navigationController pushViewController:store animated:YES];
}
-(void)btnMoreClicked
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
}
-(void)btnFriendCircleClicked
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
   
    FriendRequest *frv=[[FriendRequest alloc]initWithNibName:@"FriendRequest" bundle:nil];
    [self.navigationController pushViewController:frv animated:YES];
   

    
}
-(void)btnActiveGameClicked
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    ActiveGameUserView *agv=[[ActiveGameUserView alloc]initWithNibName:@"ActiveGameUserView" bundle:nil];
    [self.navigationController pushViewController:agv animated:YES];
   
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
-(void)playSound
{
    NSString *filepath= [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"Hole_Punch-Simon_Craggs-1910998415.mp3"];    
    NSURL *fileurl = [NSURL fileURLWithPath:filepath];
    NSError *error=nil;
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileurl error:&error];
    if (error) {
        NSLog(@"error %@",error);
    }
    else
    {
        audioPlayer.volume=0.3;
        [audioPlayer play];
        
    }    
}
-(void)backButtonClicked
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    
	[self.navigationController popViewControllerAnimated:YES];
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
        obj.checkSetting=@"No";
        
	}
    else
    {
        obj.checkSetting=@"Yes";
        [self showPopUpMenu];
        
    }

    
}


- (void)newGamePressed

{
   if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
   {
       [self playSound]; 
   }
     
   
    FindOpponentView *opponentView = [[FindOpponentView alloc]initWithNibName:@"FindOpponentView" bundle:nil];
    [self.navigationController pushViewController:opponentView animated:YES];
    [opponentView release];
    
       
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
        //NSLog(@"%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus" ] );

	}
	else {
        [[NSUserDefaults standardUserDefaults] setObject:@"OFF"  forKey:@"SoundStatus"];
        [[NSUserDefaults standardUserDefaults] synchronize];

		privacyStatus = @"1";
	}    
   //[self localPrivacyChange];
}
-(void)btnFacbookClicked
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    FBFriendsView *fbView = [[FBFriendsView alloc]initWithNibName:@"FindOpponentView" bundle:nil];
    [self.navigationController pushViewController:fbView animated:YES];
    [fbView release];
  
}

-(void)viewWillDisappear:(BOOL)animated
{
    [myView setHidden:YES];
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

//
#pragma mark:------------------------------------------------------------------------------------
#pragma mark:-------------------- staic view move animation -------------------------------------
#pragma mark:------------------------------------------------------------------------------------

//

static CAFilter *filter = nil;



CGFloat fingerDelta = 0.0;
//  CGPoint lastPos;

//    -(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//    {
//        lastPos = [[touches anyObject] locationInView:myView];
//    }
//    

CGPoint vectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) {
    CGFloat xDifference = firstPoint.x - secondPoint.x;
    CGFloat yDifference = firstPoint.y - secondPoint.y;
    
    CGPoint result = CGPointMake(xDifference, yDifference);
    
    return result;
}

CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) {
    CGFloat distance;
    
    CGFloat xDifferenceSquared = pow(firstPoint.x - secondPoint.x, 2);
    
    CGFloat yDifferenceSquared = pow(firstPoint.y - secondPoint.y, 2);
    
    distance = sqrt(xDifferenceSquared + yDifferenceSquared);
    return distance;
    
}
CGFloat angleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint)
{
    CGPoint previousDifference = vectorBetweenPoints(firstPoint, secondPoint);
    CGFloat xDifferencePrevious = previousDifference.x;
    
    CGFloat previousDistance = distanceBetweenPoints(firstPoint,
                                                     secondPoint);
    CGFloat previousRotation = acosf(xDifferencePrevious / previousDistance); 
    
    return previousRotation;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    lastPos = [[touches anyObject] locationInView:myView];
    
    [super      touchesBegan:touches withEvent:event]; //may be not required
	//[self     dismissInputControls];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint currentPos = [[touches anyObject] locationInView:myView];
    
    fingerDelta = distanceBetweenPoints(currentPos, lastPos)/2;
    
    CGPoint fingerVector = vectorBetweenPoints(currentPos, lastPos);
    
    
    
    if ([[filter valueForKey:@"inputTime"] floatValue] < 0.9)
    {	
        [filter release];
        filter = nil;
        filter = [[CAFilter filterWithType:kCAFilterPageCurl] retain];
        [filter setDefaults];
        [filter setValue:[NSNumber numberWithFloat:((NSUInteger)fingerDelta)/100.0] forKey:@"inputTime"];
        
        CGFloat _angleRad = angleBetweenCGPoints(currentPos, lastPos);
        CGFloat _angle = _angleRad*180/M_PI ;		
        if (_angle < 180 && _angle > 120)
        {
            if (fingerVector.y > 0)
                [filter setValue:[NSNumber numberWithFloat:_angleRad] forKey:@"inputAngle"];
            else
                [filter setValue:[NSNumber numberWithFloat:-_angleRad] forKey:@"inputAngle"];
            
            myView.layer.filters = [NSArray arrayWithObject:filter];
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{	
    if ([[filter valueForKey:@"inputTime"] floatValue] > 0.7)
    {
        
        
        myView.layer.filters = nil;
        
        [filter setValue:[NSNumber numberWithFloat:0.0] forKey:@"inputTime"];
        
        
        CAFilter *previousFilter = [[CAFilter filterWithType:kCAFilterPageCurl] retain];
        [previousFilter setDefaults];
        [previousFilter setValue:[NSNumber numberWithFloat:0.91] forKey:@"inputTime"];
        
        [previousFilter setValue:[NSNumber numberWithFloat: M_PI] forKey:@"inputAngle"];
        [myView setHidden:YES];
        
    }
    else
    {		
        
    }
}


//

@end
