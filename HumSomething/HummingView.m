//
//  HummingView.m
//  HumSomething
//
//  Created by Pravesh Uniyal on 10/08/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import "HumSomethingViewController.h"
#import "HummingView.h"
#import <QuartzCore/QuartzCore.h>
#import "GuessView.h"
#import "GuessSongView.h"
#import "ChangeProfilePicViewController.h"
#import "ASIHTTPRequest.h"
#import "MainHeaderFile.h"
extern NSString *kCAFilterPageCurl; 
@class CAFilter;
@implementation HummingView

@synthesize sw,privacyStatus,timerString;

@synthesize strSongIDf,strUserNamef,strOpponentIDf,responseData;

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
/*
- (NSString *)adWhirlApplicationKey {
	// return your SDK key  
	return @"8e19540849b74a94839a6bd18627d57c";
	
}
- (UIViewController *)viewControllerForPresentingModalView {
	
	//return UIWindow.viewController;
	return [(HumSomethingAppDelegate *)[[UIApplication sharedApplication] delegate] viewController];
	
}
- (void)adWhirlDidReceiveAd:(AdWhirlView *)adWhirlView {
	
	[UIView beginAnimations:@"AdWhirlDelegate.adWhirlDidReceiveAd:"context:nil];
	
	
	[UIView setAnimationDuration:0.7];
	
	
	
	CGSize adSize = [adView actualAdSize];
	
	CGRect newFrame = adView.frame;
	
	
	
	newFrame.size = adSize;
	
	newFrame.origin.x = (self.view.bounds.size.width - adSize.width)/ 2;
	
	NSLog(@"%f",newFrame.origin.y);
	NSLog(@"%f",newFrame.origin.x);
    
	newFrame.origin.y=410;
	NSLog(@"%f",newFrame.origin.y);
    
	adView.frame = newFrame;
	NSLog(@"adview%f  %f",adView.frame.origin.x,adView.frame.origin.y);
	
	[UIView commitAnimations];
	
}
*/
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
     NSLog(@"songid %@ oppid %@ user%@",strSongIDf,strOpponentIDf,strUserNamef);
    //////recording//////
    
   
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* path = [paths objectAtIndex:0];
    
 soundFilePath = [path stringByAppendingPathComponent:@"sounds.caf"];
    
    NSLog(@"%@",soundFilePath);
    NSURL* url1 = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    
    //AVAudioQualityMin
    
    
   
    


    
    NSError* error = nil;
    
    recorder = [[AVAudioRecorder alloc] initWithURL:url1 settings:recordSettings error:&error];
    
    
    if (error) {
        NSLog(@"Failed to record");
    }
    else
    {
        [recorder prepareToRecord];
    }
    
    
    
    if(error)
    {
        NSLog(@"Failed to record");
    }
    
    

    
//    /////////////////
//    AdWhirlView *adWhirlView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
//	adWhirlView.frame=CGRectMake(0,386, 320, 50);
//	[self.view addSubview:adWhirlView];
//    
//    self.navigationController.navigationBarHidden =NO;
//    appDelegate = (HumSomethingAppDelegate *)[[UIApplication sharedApplication] delegate];
//    

    
    //add back button on navigation bar
    
    UIView *parentView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 6,51, 44)];
	//UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 6, 51, 30)];
	//[btnBack setBackgroundImage:[UIImage imageNamed:@"back@2x.png"] forState:UIControlStateNormal];
	//[btnBack addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
	//[parentView1 addSubview:btnBack];
	//[btnBack release];
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
    [self.view addSubview:addButton1];    /////////
    
    UIView *humView =[[UIView alloc]initWithFrame:CGRectMake(10,65, 300,350)];
    humView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    humView.layer.cornerRadius=10.0f;
    
    [self.view addSubview:humView];
    
    UILabel *seperater1=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, 300, 1)];
    seperater1.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [humView addSubview:seperater1];
    [seperater1 release];
    
    
    UILabel *seperater3=[[UILabel alloc]initWithFrame:CGRectMake(0, 200, 300, 1)];
    seperater3.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [humView addSubview:seperater3];
    [seperater3 release];
    
    
    
    UILabel *lblArtistName=[[UILabel alloc]initWithFrame:CGRectMake(30, 50, 300, 30)];
    lblArtistName.backgroundColor=[UIColor clearColor];
    lblArtistName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    lblArtistName.textAlignment=UITextAlignmentLeft;
    lblArtistName.text=[NSString stringWithFormat:@"You are humming Song for %@",strUserNamef]; //@"You are humming Song for Jhon smith";
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
    
    // button for turn 1
    
    UIButton *btnTurn1=[UIButton buttonWithType:UIButtonTypeCustom];
    btnTurn1.frame=CGRectMake(100, 15, 80, 30);
    btnTurn1.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    [btnTurn1 setBackgroundImage:[UIImage imageNamed:@"turn_bg.png"] forState:UIControlStateNormal];
    [btnTurn1 setTitle:@"Turn 1" forState:UIControlStateNormal];
    [btnTurn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   // [btnTurn1 addTarget:self action:@selector(btnTurn1) forControlEvents:UIControlEventTouchUpInside];
    [humView addSubview:btnTurn1];
    
    
    UIButton *btnDone=[UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame=CGRectMake(97, 270, 103, 50);
    btnDone.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [btnDone setBackgroundImage:[UIImage imageNamed:@"done_bt.png"] forState:UIControlStateNormal];
    [btnDone setTitle:@"" forState:UIControlStateNormal];
    [btnDone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(btnDoneClicked) forControlEvents:UIControlEventTouchUpInside];
    [humView addSubview:btnDone];
    
    //NSLog(@" timerstr%@",timerString);
    ///////
//    btnTime=[UIButton buttonWithType:UIButtonTypeCustom];
//    btnTime.frame=CGRectMake(92, 130, 120, 50);
//    btnTime.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
//    [btnTime setBackgroundImage:[UIImage imageNamed:@"time-box_bg.png"] forState:UIControlStateNormal];
//    btnTime.titleLabel.textAlignment=UITextAlignmentLeft;
//    [btnTime setTitle:[NSString stringWithFormat: @"%dSec",countTime] forState:UIControlStateNormal];
//    [btnTime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btnTime addTarget:self action:@selector(btnTurn1) forControlEvents:UIControlEventTouchUpInside];
//    [humView addSubview:btnTime];
    
    
    btnTime=[[UILabel alloc]initWithFrame:CGRectMake(92, 130, 120, 50)];
    btnTime.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"time-box_bg.png"]];
    btnTime.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
    btnTime.textAlignment=UITextAlignmentCenter;
    btnTime.text=[NSString stringWithFormat: @"%d Second",countTime];

    [humView addSubview:btnTime];
    
    
    ////////////////////
    UILabel *lblTime=[[UILabel alloc]initWithFrame:CGRectMake(120, 90, 50, 50)];
    lblTime.backgroundColor=[UIColor clearColor];
    lblTime.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    lblTime.textAlignment=UITextAlignmentCenter;
    lblTime.text=@"Time";
    [humView addSubview:lblTime];
    [lblTime release];
    
      
    
    myProgressView = [[UIProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
    myProgressView.frame=CGRectMake(50, 230, 200, 20);
    [myProgressView setProgress:0.0];//[timerString floatValue]];
    
    [humView addSubview:myProgressView];
    
    
    countTime=[timerString intValue];
  progressTime=(float)100/countTime;
    
    //NSLog(@"%i   %f",countTime,progressTime);
    
    [self timerCalled];
    [self startRecording];

}

-(void)timerCalled
{
    
   
    t1=[NSTimer scheduledTimerWithTimeInterval:1.0 
                                        target:self
                                      selector:@selector(targetMethod)
                                      userInfo:nil
                                       repeats:YES];
//[self startRecording];
}

-(void)targetMethod
{
    
    btnTime.text= [NSString stringWithFormat: @"%i Second",countTime];
      countTime--;
    mynumber=mynumber+ progressTime;
    [myProgressView setProgress:mynumber/100];
    if (countTime<1) {
        btnTime.text= [NSString stringWithFormat: @"%@ Second",@"0"];
        [t1 invalidate];
        t1=0;
        [self stopPlaying];
    }
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



-(void)startRecording
{
    
    
    if (!recorder.recording) {
       // startRecord.enabled = NO;
      //  stopRecord.enabled = YES;
        recorder.delegate = self;
        
        [recorder record];
    }
    
    
}


-(void)startPlaying
{
    if(!recorder.recording)
    {
      //  startRecord.enabled = NO;
      //  stopRecord.enabled = YES;
        
        if(player)
            [player release];
        NSError* error ;
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:&error];
        player.delegate = self;
        
        if(error)
            NSLog(@"Erroorr %@", [error localizedDescription]);
        else
            [player play];
        
    }
    
}
-(void)stopPlaying
{
   // startRecord.enabled = YES;
    //stopRecord.enabled = NO;
  //  playRecord.enabled = YES;
    if (recorder.recording) {
        [recorder stop];
    }
    else if (player.playing)
        [player stop];
    
}



-(void)btnDoneClicked
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    
    /// createing alert //////
  UIAlertView*  alert = [[UIAlertView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    
    alert.title = @"Add Comments?";
    alert.message = @"\n\n\n\n\n";
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"NO"];
    alert.delegate = self;
    
    //////creating the textfield of alert ///////
  UITextField*  myTextFiled=[[UITextField alloc]initWithFrame:CGRectMake(12.0, 50.0, 260.0, 70)];
    CGAffineTransform myTransform=CGAffineTransformMakeTranslation(0.0, -100.0);
    [alert setTransform:myTransform];
    [alert addSubview:myTextFiled];
  //  myTextFiled.placeholder=@"Bookmark Name";
    myTextFiled.borderStyle=UITextBorderStyleRoundedRect;
    myTextFiled.returnKeyType=UIReturnKeyDone;
    [myTextFiled setTextColor:[UIColor blueColor]];
    myTextFiled.delegate=self;
    
    
        
    [alert show];
    [alert release];
    
    
}

int k;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        
        
        if (k==0) 
        {
            k=1;
            //[self callparsing];
            
           // NSString *urlString =[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/sendsoudfile/intUserID=%@",[[myGlobalArray objectAtIndex:0]valueForKey:@"intID"]];
            
            NSString *urlString =[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/AddActiveGame/intUserID=%@,intOpponentID=%@,intTurn=%@,intGameID=%@,GameStatus=%@,intSongID=%@",[[myGlobalArray objectAtIndex:0] valueForKey:@"intID"],strOpponentIDf,@"1",@"0",@"P",strSongIDf];
            
            
          
            
            
            NSMutableData *body = [NSMutableData data];
            
            NSURL *url = [NSURL URLWithString: urlString];
            
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
            
            [request setUseKeychainPersistence:YES];
            //  NSLog(@"%@ %@",imgProfile.image,strID);
            //  UIImage * image = [[UIImage imageNamed:@"SelectImage.png"] autorelease];
            NSData *postData = [[NSData alloc] initWithContentsOfFile:soundFilePath];
           
            [body appendData:[NSData dataWithData:postData]];
            [request setPostBody:body];
            [request setDelegate:self];
            [request setDidFinishSelector:@selector(requestFinished:)];
            [request setDidFailSelector:@selector(requestFailed:)];
            
            [request startAsynchronous];
            
            
            
        }
        
        else {
            k=0;
            GuessSongView *guessView = [[GuessSongView alloc]initWithNibName:@"GuessSongView" bundle:nil];
            [self.navigationController pushViewController:guessView animated:YES];
        }
        
        
        }
    
    
}


- (void)requestFinished:(ASIHTTPRequest *)request {
	
	NSString *receivedString = [request responseString];
    UIAlertView *alertView1 = [[UIAlertView alloc]initWithTitle:@"Message!" message:receivedString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    
    [alertView1 show];
    [alertView1 release];
    //    
    NSLog(@"response %@",receivedString);
}   


- (void)requestFailed:(ASIHTTPRequest *)request 
{
	
    //receivedString = [request responseString];
    UIAlertView *alertView2 = [[UIAlertView alloc]initWithTitle:@"Message" message:@"failed" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView2 show];
    [alertView2 release];
    // NSLog(@"res2ponse %@",receivedString);
    
    NSLog(@"failed");
}

/*
-(void)callparsing
{
    
    
    //h/ttp://humsomething.netsmartz.us/HumServices.svc/AddActiveGame/intUserID=117,intOpponentID=134,intTurn=1,intGameID=0,GameStatus=P,intSongID=12
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/AddActiveGame/intUserID=%@,intOpponentID=%@,intTurn=%@,intGameID=%@,GameStatus=%@,intSongID=%@",[[myGlobalArray objectAtIndex:0] valueForKey:@"intID"],strOpponentIDf,@"1",@"0",@"P",strSongIDf]]
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


// Called when the connection has enough data to create an NSURLResponse

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response 

{
    //NSLog (@"connection:didReceiveResponse:");
    
    //NSLog(@"expectedContentLength: %qi", [response expectedContentLength] );
    
    //NSLog(@"textEncodingName: %@", [response textEncodingName]);
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	HUD.labelText = @"Loading..";
	[HUD show:YES];
    
    
    
    [self.responseData setLength:0];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [myView setHidden:YES];
}

// Called each time the connection receives a chunk of data

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    // NSLog (@"connection:didReceiveData:");
    
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
    
    [HUD hide:YES];
	[HUD removeFromSuperview];
    HUD=nil;
    
    [self parseXML];
    
    
    
    
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
    //  NSLog (@"didStartElement");
    
    // Check to see which element we have found
    
    
    if ([elementName isEqualToString:@"updatepasswordResponse"])
    {
        capturedCharacters = [[NSMutableString alloc]init];
    }
    
    
    
    // If we are in an item and found a title
    
    if (inItemElement) {
        
        capturedCharacters = [[NSMutableString alloc]init];
    }
    
    
    if ([elementName isEqualToString:@"updatepasswordResult"])
        
    {
        // We are in an item element
        
        
        
        inItemElement = YES;
    }
    
    
}


// Called when the parser encounters an end element

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 

{
    //  NSLog (@"didEndElement");
    
    
    // Check to see which element we have ended
    // If we are in an item and ended a title
    
    if ([elementName isEqualToString:@"updatepasswordResult"])
    {
        
        if([capturedCharacters isEqualToString:@"Success"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message!" message:@"Password Successfully Change" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
            
            [capturedCharacters release];
            capturedCharacters = nil;
        }
        else if([capturedCharacters isEqualToString:@"The old passowrd do not match."])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message!" message:@"The old passowrd do not match" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
            
            [capturedCharacters release];
            capturedCharacters = nil;
            
        }
        else if([capturedCharacters isEqualToString:@"Error processing request."])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message!" message:@"Error processing request" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
            
            [capturedCharacters release];
            capturedCharacters = nil;
        }
        
        
        
    }
    
    
    
    if ([elementName isEqualToString:@"updatepasswordResponse"])
        
    {
        
        
        
        
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

*/
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
      //  NSLog(@"%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus" ] );
        
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
       // NSLog(@"error %@",error);
    }
    else
    {
        audioPlayer.volume=0.3;
        [audioPlayer play];
        
    }    
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    
    NSLog(@"FINISH%@",@"FINISH");
}
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
     NSLog(@"ERROR%@",@"ERROR");
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    
}




@end
