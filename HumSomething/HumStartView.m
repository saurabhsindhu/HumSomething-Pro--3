//
//  HumStartView.m
//  HumSomething
//
//  Created by Pravesh Uniyal on 10/08/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import "HumSomethingViewController.h"
#import "HumStartView.h"
#import <QuartzCore/QuartzCore.h>
#import "HummingView.h"
#import "ChangeProfilePicViewController.h"
#import "MainHeaderFile.h"
@implementation HumStartView
@synthesize userIdString,btnTimet,strSongID,strOpponentID,strUserName;

@synthesize sw,privacyStatus;
@synthesize responseData,capturedCharacters;
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

    NSLog(@"songid %@ oppid %@",strSongID,strOpponentID);
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading..";
    //HUD.detailsLabelText = @"Just relax";
 //   HUD.mode = MBProgressHUDModeAnnularDeterminate;
    [self.view addSubview:HUD];
    [HUD show:YES];
    [HUD showWhileExecuting:@selector(doSomeFunkyStuff) onTarget:self withObject:nil animated:YES];

    
    
    
    resultArrayFinal=[[NSMutableArray alloc]init];
    resultArray=[[NSMutableArray alloc]init];
    [self callRequestParsing];
    //add back button on navigation bar
    
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
    /////////
    
   humView =[[UIView alloc]initWithFrame:CGRectMake(10,65, 300,300)];
    humView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    humView.layer.cornerRadius=10.0f;
    
    [self.view addSubview:humView];
    
    UILabel *seperater1=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, 300, 1)];
    seperater1.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [humView addSubview:seperater1];
    [seperater1 release];
    
    
    UILabel *seperater2=[[UILabel alloc]initWithFrame:CGRectMake(0, 150, 300, 1)];
    seperater2.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [humView addSubview:seperater2];
    [seperater2 release];
    
    
    UILabel *seperater3=[[UILabel alloc]initWithFrame:CGRectMake(0, 230, 300, 1)];
    seperater3.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [humView addSubview:seperater3];
    [seperater3 release];

    
    
    UILabel *lblArtistName=[[UILabel alloc]initWithFrame:CGRectMake(30, 50, 300, 30)];
    lblArtistName.backgroundColor=[UIColor clearColor];
    lblArtistName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    lblArtistName.textAlignment=UITextAlignmentLeft;
    lblArtistName.text=[NSString stringWithFormat:@"You are humming Song for %@",strUserName];
    [humView addSubview:lblArtistName];
    [lblArtistName release];
    
    //          
    
    UILabel *lblSongName=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, 180, 30)];
    lblSongName.backgroundColor=[UIColor clearColor];
    lblSongName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    lblSongName.textAlignment=UITextAlignmentCenter;
    lblSongName.text=@"Time";
   // [humView addSubview:lblSongName];
    [lblSongName release];
    
    
    //make keyboard...
    
    btnTimet=[[UILabel alloc]initWithFrame:CGRectMake(100, 180, 100, 30)];
    btnTimet.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"time-box_bg.png"]];
    btnTimet.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
    btnTimet.textAlignment=UITextAlignmentCenter;
   // btnTimet.text=@"Time";
    [humView addSubview:btnTimet];
    

   

    
// button for turn 1
    
    btnTurn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btnTurn1.frame=CGRectMake(115, 15, 71, 28);
[btnTurn1 setUserInteractionEnabled:NO];
    btnTurn1.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    [btnTurn1 setBackgroundImage:[UIImage imageNamed:@"turn_bg@2x.png"] forState:UIControlStateNormal];
    [btnTurn1 setTitle:@"Turn 1" forState:UIControlStateNormal];
    [btnTurn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[btnTurn1 addTarget:self action:@selector(btnTurn1) forControlEvents:UIControlEventTouchUpInside];
    btnTurn1.tag=99;

    [humView addSubview:btnTurn1];

    
    btnStartHumming=[UIButton buttonWithType:UIButtonTypeCustom];
    btnStartHumming.frame=CGRectMake(96, 240, 107, 55);
    btnStartHumming.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnStartHumming setBackgroundImage:[UIImage imageNamed:@"start_hum_bt@2x.png"] forState:UIControlStateNormal];
    [btnStartHumming setTitle:@"" forState:UIControlStateNormal];
    [btnStartHumming setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnStartHumming addTarget:self action:@selector(StartRecording) forControlEvents:UIControlEventTouchUpInside];
    btnStartHumming.tag=100;
    [humView addSubview:btnStartHumming];

    
//  btnTime=[UIButton buttonWithType:UIButtonTypeCustom];
//    btnTime.frame=CGRectMake(100, 180, 100, 30);
//    btnTime.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
//    [btnTime setBackgroundImage:[UIImage imageNamed:@"time-box_bg.png"] forState:UIControlStateNormal];
//    //[btnTime setTitle:@"10 Seconds" forState:UIControlStateNormal];
//    [btnTime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btnTime addTarget:self action:@selector(btnTurn1) forControlEvents:UIControlEventTouchUpInside];
//    [humView addSubview:btnTime];
    
    UILabel *lblTime=[[UILabel alloc]initWithFrame:CGRectMake(130, 145, 40, 50)];
    lblTime.backgroundColor=[UIColor clearColor];
    lblTime.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
    lblTime.textAlignment=UITextAlignmentCenter;
    lblTime.text=@"Time";
     [humView addSubview:lblTime];
    [lblTime release];
    
    ///timer label////////////////
    
      
    
    
    
    //////
       
    
       
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton: YES animated:NO];
    
    [lblCoins setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intCoins"]] ;
    [lblDinamite setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intSticks"]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125.0,0.0, 280.0, 44.0)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [label setAdjustsFontSizeToFitWidth:YES];
    [label setText:@"Start Humming"];
    label.lineBreakMode=UILineBreakModeWordWrap;
    label.numberOfLines=0;
    [label setTextAlignment:UITextAlignmentLeft];
    [label setTextColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];   
    [label setTextAlignment:UITextAlignmentCenter];
    [[self navigationItem] setTitleView:label];
    [label release];
    
    
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


-(void)backButtonClicked
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableViewDelegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
            sw = [[UISwitch alloc]initWithFrame:CGRectMake(145,5,20,10)];
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
            sw = [[UISwitch alloc]initWithFrame:CGRectMake(145,5,20,10)];
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
           return 40;
        
  
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
  
        return 5;
  
    
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


-(void)StartRecording
{
    
    if (btnTimet.text ==nil) {
        
        UIAlertView *altTime = [[UIAlertView alloc]initWithTitle:@"Message!" message:@"Please choose the time clock" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]; 
        [altTime show];
        [altTime release];
    }
    else
    {
    HummingView *humming = [[HummingView alloc]initWithNibName:@"HummingView" bundle:nil];
    humming.timerString=[NSString stringWithFormat:@"%d",i];
        humming.strSongIDf=strSongID;
        humming.strOpponentIDf=strOpponentID;
        humming.strUserNamef=strUserName;
    [self.navigationController pushViewController:humming animated:YES];
    }
    
}


-(void)callRequestParsing
{
    
   // NSLog(@"userid %@",[[myGlobalArray objectAtIndex:0]valueForKey:@"intID"]);
   //h/ttp://humsomething.netsmartz.us/HumServices.svc/getUserTimePieces/intUserID=117  
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/getUserTimePieces/intUserID=%@",[[myGlobalArray objectAtIndex:0]valueForKey:@"intID"]]]
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
        NSLog (@"The connection failed");
        
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

- (void)doSomeFunkyStuff {
	float progress = 0.0;
    
	while (progress < 1.0) {
		progress += 0.01;
		HUD.progress = progress;
		usleep(50000);
	}
    
    [self doSomeFunkyStuff];
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
  //  NSLog (@"connection:didReceiveData:");
    
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
    
  //  NSLog(@"Response String: \n%@", responseString);
    
    
    
    [responseString release];
    
    // Free the connection
    [connection release];
    
        
    
    [self parseXML];
    //[tvRandomFriend reloadData];
    [HUD hide:YES];
    [HUD removeFromSuperview];
    HUD=nil;

    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [myView setHidden:YES];
}


// Called when an error occurs in loading the response


- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    
    //NSLog (@"connection:didFailWithError:");
    
    //NSLog (@"%@",[error localizedDescription]);
    
    // Free the connection
    
    [connection release];
    
    [HUD hide:YES];
    [HUD removeFromSuperview];
    HUD=nil;
    
    
}

//********************************************************* start the parse given xml data ************************************* coded by mohit bisht

- (void) parseXML

{
   // NSLog (@"parseXML");
    
    // Initialize the parser with our NSData from the RSS feed
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:self.responseData];
    
    // Set the delegate to self
    
    [xmlParser setDelegate:self];
    
    // Start the parser
    
    if (![xmlParser parse])
    {
        NSLog (@"An error occurred in the parsing");
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
   // NSLog (@"didStartElement");
    
    // Check to see which element we have found
    
    
    if ([elementName isEqualToString:@"ArrayOfUserTimePieces"])
        
    {
        // We are in an item element
        
        resultArray=[[NSMutableArray alloc]init];
        
        inItemElement = YES;
    }
    
    // If we are in an item and found a title
    
    if (inItemElement) {
        
        capturedCharacters = [[NSMutableString alloc]init];
    }
    
    if ([elementName isEqualToString:@"UserTimePieces"])
        
    {
        
        // Initialize the capturedCharacters instance variable
        
        // capturedCharacters = [[NSMutableString alloc]init];
        
    }
    
}


// Called when the parser encounters an end element

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 

{
  //  NSLog (@"didEndElement");
    
    
    // Check to see which element we have ended
    // If we are in an item and ended a title
    
    
    if (inItemElement && [elementName isEqualToString:@"intID"]) 
        
    {
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
        
        [capturedCharacters release];
        capturedCharacters = nil;
        
    }
   
    if (inItemElement && [elementName isEqualToString:@"intNumberofPieces"])
        
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
    if (inItemElement && [elementName isEqualToString:@"intUserID"])
        
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

    
    
    
    if ([elementName isEqualToString:@"UserTimePieces"])
        
    {
        NSMutableDictionary *dic;
       // NSLog(@"resultArray %@",resultArray);
        if ([resultArray count]>0) 
        {
            dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[resultArray objectAtIndex:0],@"intID",[resultArray objectAtIndex:1],@"intNumberofPieces",[resultArray objectAtIndex:2],@"intTimePiece",[resultArray objectAtIndex:3],@"intUserID",[resultArray objectAtIndex:4],@"vchType",nil];
            
            //inItemElement = NO;
            [resultArray removeAllObjects];
            [resultArrayFinal addObject:dic];
            NSLog(@" result arryfinal%@",resultArrayFinal);
            
            
            
        }
        
            }
    
    
    if ([elementName isEqualToString:@"ArrayOfUserTimePieces"])
        
    {
        
               for (int k=0; k<[resultArrayFinal count]; k++) {
            
        
           
             
                if (k==0) {
                    
                    
                    
              btnA=[UIButton buttonWithType:UIButtonTypeCustom];
                    btnA.frame=CGRectMake(30,110,30,30);
                    btnA.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
                    [btnA setBackgroundImage:[UIImage imageNamed:@"time_ico.png"] forState:UIControlStateNormal];
                    btnA.tag=1;
                    [btnA setTitle:@"" forState:UIControlStateNormal];
                    [btnA setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [btnA addTarget:self action:@selector(btnTimerClicked:) forControlEvents:UIControlEventTouchUpInside];
                    [humView addSubview:btnA];

                    
                    
                    lblTime0=[[UILabel alloc]initWithFrame:CGRectMake(33,90,25.5,21.5)];
                    lblTime0.backgroundColor=[UIColor clearColor];
                    lblTime0.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
                    lblTime0.textAlignment=UITextAlignmentCenter;
                     lblTime0.text=[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:0]valueForKey:@"intTimePiece"]] ;
                    [humView addSubview:lblTime0];

                    NSLog(@" result arryfinal label0%@", lblTime0.text);
                }
      else if (k==1)
      {
        
        btnB=[UIButton buttonWithType:UIButtonTypeCustom];
          btnB.frame=CGRectMake(80,110,30,30);
          btnB.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
          [btnB setBackgroundImage:[UIImage imageNamed:@"time_ico.png"] forState:UIControlStateNormal];
               btnB.tag=2;
          [btnB setTitle:@"" forState:UIControlStateNormal];
          [btnB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [btnB addTarget:self action:@selector(btnTimerClicked:) forControlEvents:UIControlEventTouchUpInside];
          [humView addSubview:btnB];
          
          lblTime1=[[UILabel alloc]initWithFrame:CGRectMake(83,90,25.5,21.5)];
          lblTime1.backgroundColor=[UIColor clearColor];
          lblTime1.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
          lblTime1.textAlignment=UITextAlignmentCenter;
          lblTime1.text=[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:1]valueForKey:@"intTimePiece"]] ;
          [humView addSubview:lblTime1];

           NSLog(@" result arryfinal label1 %@", lblTime1.text);        
      } 
      else if (k==2)
      {
        btnC=[UIButton buttonWithType:UIButtonTypeCustom];
          btnC.frame=CGRectMake(130,110,30,30);
          btnC.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
          [btnC setBackgroundImage:[UIImage imageNamed:@"time_ico.png"] forState:UIControlStateNormal];
               btnC.tag=3;
          [btnC setTitle:@"" forState:UIControlStateNormal];
          [btnC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [btnC addTarget:self action:@selector(btnTimerClicked:) forControlEvents:UIControlEventTouchUpInside];
          [humView addSubview:btnC];
          
          lblTime2=[[UILabel alloc]initWithFrame:CGRectMake(133, 90,25.5,21.5)];
          lblTime2.backgroundColor=[UIColor clearColor];
          lblTime2.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
          lblTime2.textAlignment=UITextAlignmentCenter;
          lblTime2.text=[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:2]valueForKey:@"intTimePiece"]] ;
          [humView addSubview:lblTime2];
              //  NSLog(@" result arryfinal label%@", lblTime2.text);
      }
      else if (k==3)
      {
       btnD=[UIButton buttonWithType:UIButtonTypeCustom];
          btnD.frame=CGRectMake(180,110,30,30);
          btnD.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
          [btnD setBackgroundImage:[UIImage imageNamed:@"time_ico.png"] forState:UIControlStateNormal];
               btnD.tag=4;
          [btnD setTitle:@"" forState:UIControlStateNormal];
          [btnD setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [btnD addTarget:self action:@selector(btnTimerClicked:) forControlEvents:UIControlEventTouchUpInside];
          [humView addSubview:btnD];

          lblTime3=[[UILabel alloc]initWithFrame:CGRectMake(183, 90,25.5,21.5)];
          lblTime3.backgroundColor=[UIColor clearColor];
          lblTime3.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
          lblTime3.textAlignment=UITextAlignmentCenter;
          lblTime3.text=[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:3]valueForKey:@"intTimePiece"]] ;
          [humView addSubview:lblTime3];

                  // NSLog(@" result arryfinal label%@", lblTime3.text);
      }
      else if (k==4)
      {

         btnE=[UIButton buttonWithType:UIButtonTypeCustom];
          btnE.frame=CGRectMake(230,110,30,30);
          btnE.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
          [btnE setBackgroundImage:[UIImage imageNamed:@"time_ico.png"] forState:UIControlStateNormal];
               btnE.tag=5;
          [btnE setTitle:@"" forState:UIControlStateNormal];
          [btnE setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [btnE addTarget:self action:@selector(btnTimerClicked:) forControlEvents:UIControlEventTouchUpInside];
          [humView addSubview:btnE];
          

          lblTime4=[[UILabel alloc]initWithFrame:CGRectMake(233, 90,25.5,21.5)];
          lblTime4.backgroundColor=[UIColor clearColor];
          lblTime4.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
          lblTime4.textAlignment=UITextAlignmentCenter;
          lblTime4.text=[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:4]valueForKey:@"intTimePiece"]] ;
          [humView addSubview:lblTime4];

                //NSLog(@" result arryfinal label%@", lblTime4.text);
      }
        }
        
        //   [tvFriendRequest reloadData];
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


-(void)btnTimerClicked:(id)sender
{
   count=0;
    UIView *senderView = (UIView*)sender;
	if (![senderView isKindOfClass:[UIView class]])
		return;
  
    i=i+[[[resultArrayFinal objectAtIndex:senderView.tag-1]valueForKey:@"intTimePiece"]intValue] ;
    
    btnTimet.text= [NSString stringWithFormat:@"%d Second",i];
    if ( senderView.tag >= [resultArrayFinal count]+1 )
        printf("Deletion not possible.\n");
    else
    {
        
        [resultArrayFinal removeObjectAtIndex:senderView.tag-1];
        
        printf("Resultant array is\n");
    } 
    
    for (int k=0; k<[resultArrayFinal count]; k++) {
        
        
        
            count=count+1;
            if (k==0) {
                
                
                lblTime0.text= [[resultArrayFinal objectAtIndex:0]valueForKey:@"intTimePiece"];                
                // NSLog(@" result arryfinal label%@", lblTime0.text);
            }
            else if (k==1)
            {
                
                lblTime1.text= [[resultArrayFinal objectAtIndex:1]valueForKey:@"intTimePiece"];
                
                //  NSLog(@" result arryfinal label%@", lblTime1.text);        
            } 
            else if (k==2)
            {
                lblTime2.text= [[resultArrayFinal objectAtIndex:2]valueForKey:@"intTimePiece"];            }
            else if (k==3)
            {
                lblTime3.text= [[resultArrayFinal objectAtIndex:3]valueForKey:@"intTimePiece"];                    
                // NSLog(@" result arryfinal label%@", lblTime3.text);
            }
            else if (k==4)
            {
                
                 lblTime4.text= [[resultArrayFinal objectAtIndex:4]valueForKey:@"intTimePiece"];    
                
                //NSLog(@" result arryfinal label%@", lblTime4.text);
            }
        
    
     
    
        
         //[strAddString appendString:[NSString stringWithFormat:@"%d",i]];
    
    NSLog(@"%d",i);
   
}
    
    // animation changes ...
    
CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
anim.duration = 0.125;
anim.repeatCount = 1;
anim.autoreverses = YES;
anim.removedOnCompletion = YES;
anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)];
[senderView.layer addAnimation:anim forKey:nil];


    
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:senderView.center];
    [movePath addQuadCurveToPoint:btnTimet.center
                     controlPoint:CGPointMake(btnTimet.center.x, btnTimet.center.y)];
    
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim, opacityAnim, nil];
    animGroup.duration = 0.90;

    [btnTimet.layer addAnimation:animGroup forKey:nil];
    
/// animation end...
    
    
    
    for (int k=count; k<=5; k++) {
        if (k==0) {
            
            
            [lblTime0 setHidden:YES];
            [btnA setHidden:YES];
        }
        else if (k==1)
        {
            
            
            [lblTime1 setHidden:YES];
            [btnB setHidden:YES];      
        } 
        else if (k==2)
        {
            
            [lblTime2 setHidden:YES];
            [btnC setHidden:YES];
        }
        else if (k==3)
        {
            
            [lblTime3 setHidden:YES];
            [btnD setHidden:YES];
        }
        else if (k==4)
        {
            
            
            [lblTime4 setHidden:YES];
            [btnE setHidden:YES];
        }

    }  
    
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

@end
