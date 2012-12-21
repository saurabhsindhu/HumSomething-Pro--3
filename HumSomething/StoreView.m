//
//  StoreView.m
//  HumSomething
//
//  Created by Pravesh Uniyal on 10/07/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "StoreView.h"
#import <QuartzCore/QuartzCore.h>
#import "ChangeProfilePicViewController.h"
#import "NSAttributedString+Attributes.h"
#import "MainHeaderFile.h"

@implementation StoreView
@synthesize tvTimePieces,tvDinamiteSticks;
@synthesize sw,privacyStatus;
@synthesize responseData;
@synthesize capturedCharacters;
//@synthesize strAddString;
float x1t1=10.0f;
float x2t1=10.0f;
float x3t1=300.0f;
float x4t1=246.5f;

float x1t2=10.0f;
float x2t2=266.5f;
float x3t2=300.0f;
float x4t2=246.5f;



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
    tempCoinArray=[[NSMutableArray alloc]init];
     saveresult =[[NSMutableArray alloc]init];
    resultArrayFinal=[[NSMutableArray alloc]init];
   resultArrayFinal1=[[NSMutableArray alloc]init];
    resultArrayFinal2=[[NSMutableArray alloc]init];
    
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
    
    srl=[[UIScrollView alloc]initWithFrame:CGRectMake(0.0, 44, 320, 392)];
    srl.userInteractionEnabled=YES;
    srl.showsVerticalScrollIndicator=NO;
    srl.scrollEnabled=YES;
    [self.view addSubview:srl];
       
    tvDinamiteSticks = [[UITableView alloc]initWithFrame:CGRectMake(x1t1,x2t1,x3t1,x4t1)];// style:UITableViewStyleGrouped];//initWithFrame:];
    tvDinamiteSticks.backgroundColor =[UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    tvDinamiteSticks.layer.cornerRadius =10.0;
    [tvDinamiteSticks setTag:1];
    //[tvDinamiteSticks setScrollEnabled:NO];
    tvDinamiteSticks.layer.cornerRadius =6.0;
    tvDinamiteSticks.layer.borderColor = [UIColor whiteColor].CGColor;
	tvDinamiteSticks.layer.borderWidth = 1.0; //#import <QuartzCore/QuartzCore.h>
    tvDinamiteSticks.separatorColor= [UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    tvDinamiteSticks.delegate=self;
    tvDinamiteSticks.dataSource=self;
    [self.tvDinamiteSticks setBounces:NO];
    [self.tvDinamiteSticks setScrollEnabled:NO];
     [tvDinamiteSticks setShowsVerticalScrollIndicator:NO];
    [srl addSubview:tvDinamiteSticks];

    tvTimePieces = [[UITableView alloc]initWithFrame:CGRectMake(x1t2,x2t2,x3t2,x4t2)];
    tvTimePieces.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
     tvTimePieces.layer.cornerRadius =10.0;
    [tvTimePieces setTag:2];
    [tvTimePieces setShowsVerticalScrollIndicator:NO];
    [self.tvTimePieces setBounces:NO];
    [self.tvTimePieces setScrollEnabled:NO];
   
    tvTimePieces.layer.cornerRadius =6.0;
    tvTimePieces.layer.borderColor = [UIColor whiteColor].CGColor;
	tvTimePieces.layer.borderWidth = 1.0; //#import <QuartzCore/QuartzCore.h>
    tvTimePieces.separatorColor= [UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];

    tvTimePieces.delegate=self;
    tvTimePieces.dataSource=self;
    self.tvTimePieces.sectionHeaderHeight = 60;
    [self.tvTimePieces setBounces:NO];

    [srl addSubview:tvTimePieces];

    
    
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

-(NSMutableAttributedString *)customizeLabel
{
    
       NSString* txt =[NSString stringWithFormat:@"currently you have three 5seconds,two 10 seconds,and three 20 second time pieces"];
    myAttributedLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(5, 3, 740,3200)];
    myAttributedLabel.attributedText = [NSString stringWithString:txt];
    [myAttributedLabel setBackgroundColor:[UIColor clearColor]];
    
    NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:txt];
    [attrStr setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [attrStr setTextColor:[UIColor whiteColor]];
    
    NSString* plainText = [attrStr string];
    
    [attrStr setTextColor:[UIColor whiteColor] range:[txt rangeOfString:@"one"]];
    [attrStr setTextBold:YES range:[plainText rangeOfString:@"one"]];
    
    [attrStr setTextColor:[UIColor whiteColor] range:[txt rangeOfString:@"two"]];
    [attrStr setTextBold:YES range:[plainText rangeOfString:@"two"]];
    
    [attrStr setTextColor:[UIColor whiteColor] range:[txt rangeOfString:@"three"]];
    [attrStr setTextBold:YES range:[plainText rangeOfString:@"three"]];
    [myAttributedLabel setBackgroundColor:[UIColor clearColor]];
    [myAttributedLabel setAttributedText:attrStr];
    

    return attrStr;
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
-(void)callgettingStickparsing
{
    
    
    // h ttp://humsomething.netsmartz.us/HumServices.svc/getRandomUser
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/getStickstobuy"]]
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
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading..";
    //HUD.detailsLabelText = @"Just relax";
    //HUD.mode = MBProgressHUDModeAnnularDeterminate;
    [self.view addSubview:HUD];
    [HUD show:YES];
    [HUD showWhileExecuting:@selector(doSomeFunkyStuff) onTarget:self withObject:nil animated:YES];
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
    
    //(@"Response String: \n%@", responseString);
    
    [responseString release];
    
    // Free the connection
    [connection release];
    
    
    [self parseXML];
    [tvDinamiteSticks reloadData];
    [tvTimePieces reloadData];
    
    [HUD hide:YES];
	[HUD removeFromSuperview];
    HUD=nil;
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
- (void)doSomeFunkyStuff {
	float progress = 0.0;
    
	while (progress < 1.0) {
		progress += 0.01;
		HUD.progress = progress;
		usleep(50000);
	}
    
    [self doSomeFunkyStuff];
}

//********************************************************* start the parse given xml data ************************************* coded by mohit bisht

- (void) parseXML

{
    // (@"parseXML");
    
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
    
    
    if ([elementName isEqualToString:@"ArrayOfUserTimePiecesTable"])
        
	{
		// We are in an item element
        
        resultArray=[[NSMutableArray alloc]init];
        
		inItemElement = YES;
	}

    
    if ([elementName isEqualToString:@"ArrayOftblUsers"])
        
	{
		// We are in an item element
        
        resultArray=[[NSMutableArray alloc]init];
        
		inItemElement = YES;
	}
	
    
    // (@"didStartElement");
    
    // Check to see which element we have found
    if ([elementName isEqualToString:@"ArrayOfBuyTimePiecesTable"])
        
    {
        
        resultArray=[[NSMutableArray alloc]init];
        
        inItemElement = YES;

        
        
    }
    
    if ([elementName isEqualToString:@"ArrayOfBuySticksTable"])
        
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

    if ([elementName isEqualToString:@"updateusertimepiecesResponse"])
        
    {
        // We are in an item element
        
        //resultArray=[[NSMutableArray alloc]init];
        
        inItemElement = YES;
        
    }
    
    
    
    // If we are in an item and found a title
    
    if (inItemElement) {
        
        capturedCharacters = [[NSMutableString alloc]init];
    }
    
    if ([elementName isEqualToString:@"BuySticksTable"])
        
    {
        
        // Initialize the capturedCharacters instance variable
        
        // capturedCharacters = [[NSMutableString alloc]init];
        
    }
    
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

// Called when the parser encounters an end element

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 

{
    // (@"didEndElement");
    
    
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
            //(@" result arryfinal1 time is %@",resultArrayFinal1);
                   
            
        }
        
    }
    if ([elementName isEqualToString:@"ArrayOfUserTimePiecesTable"])
        
    {
               
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
        
    }

    
    if ([elementName isEqualToString:@"updateusersticksResult"])
        
    {
        if ([capturedCharacters isEqualToString:@"Success"]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message!\ue405" message:@"Get stick Successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            [alert release];
        [self callLoginParsing];
        
        }
        
        // Release the capturedCharacters instance variable
        
        [capturedCharacters release];
        capturedCharacters = nil;
        
    }
    
    if ([elementName isEqualToString:@"updateusertimepiecesResult"])
        
    {
        if ([capturedCharacters isEqualToString:@"Success"]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message!\ue405" message:@"Get timepieces Successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            [alert release];
            [self callLoginParsing];
            
        }
        
        // Release the capturedCharacters instance variable
        
        [capturedCharacters release];
        capturedCharacters = nil;
        
    }  
    
    
    if (inItemElement && [elementName isEqualToString:@"intTime"])
        
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
    /////////////////////////////////////////////////
    // Check to see which element we have ended
    // If we are in an item and ended a title
    
       
    if (inItemElement && [elementName isEqualToString:@"intSticksToBuy"])
        
    {
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
        
        [capturedCharacters release];
        capturedCharacters = nil;
        
    }
           
    //////
    
    if ([elementName isEqualToString:@"BuyTimePiecesTable"])
        
    {
        NSMutableDictionary *dic;
       // NSLog(@"resultArray %@",resultArray);
        if ([resultArray count]>0) 
        {
            dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[resultArray objectAtIndex:0],@"intCoins",[resultArray objectAtIndex:1],@"intID",[resultArray objectAtIndex:2],@"intTime",[resultArray objectAtIndex:3],@"vchType",nil];
            
            //inItemElement = NO;
            [resultArray removeAllObjects];
            [resultArrayFinal1 addObject:dic];
            //(@" result arryfinal1 time is %@",resultArrayFinal1);
            
            if ([resultArrayFinal1 count]>3) 
            {
                for (int i=4; i<=[resultArrayFinal1 count];i++) {
                   // tvDinamiteSticks.frame=CGRectMake(x1t1,x2t1,x3t1,x4t1=x4t1+60);
                    tvTimePieces.frame=CGRectMake(x1t2, x2t2, x3t2, x4t2=x4t2+60);
                }
                
            }
            
            srl.contentSize=CGSizeMake(320, x4t2+x4t1+25);

            
        }
        
    }
    
    if ([elementName isEqualToString:@"ArrayOfBuyTimePiecesTable"])
        
    {
    
    
    
    
    }
    ////
    if ([elementName isEqualToString:@"BuySticksTable"])
        
    {
        NSMutableDictionary *dic;
       // NSLog(@"resultArray %@",resultArray);
        if ([resultArray count]>0) 
        {
            dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[resultArray objectAtIndex:0],@"intCoins",[resultArray objectAtIndex:1],@"intID",[resultArray objectAtIndex:2],@"intSticksToBuy",nil];
            //inItemElement = NO;
            [resultArray removeAllObjects];
            [resultArrayFinal addObject:dic];
            //(@"coin final is   %@",resultArrayFinal);
            firstcoinValue=[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:0] valueForKey:@"intCoins"]];
            p=[firstcoinValue floatValue];
            firstbuttonValue=[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:0]valueForKey:@"intSticksToBuy"]];
            q=[firstbuttonValue floatValue];
          //  NSLog(@"coins %@ price %@",firstcoinValue,firstbuttonValue);
            

            if ([resultArrayFinal count]>3) 
            {
                for (int i=4; i<=[resultArrayFinal count];i++) {
                    tvDinamiteSticks.frame=CGRectMake(x1t1,x2t1,x3t1,x4t1=x4t1+60);
                    tvTimePieces.frame=CGRectMake(x1t2, x2t2=x2t2+60, x3t2, x4t2);
                }
                
            }
            
            srl.contentSize=CGSizeMake(320, x4t2+x4t1+25);
        }
                    

            
        }
    
    if ([elementName isEqualToString:@"ArrayOfBuySticksTable"])
        
    {
        
        for (int j=1; j<[resultArrayFinal count]  ; j++)
        {
            
            NSString *secondcoin =[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:j] valueForKey:@"intCoins"]];
            r=[secondcoin floatValue];
            
            
            
            NSString *secondprice =[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:j] valueForKey:@"dblPrice"]];
            s=[secondprice floatValue];
            
            
            m =r/p;
            // NSLog(@"m %f",m);
            n=m*q;
            // NSLog(@"n %f",n);
            o=(s*100)/n;
            // NSLog(@"o %f",o);
            z=100-o;
            
            [saveresult addObject:[NSString stringWithFormat:@"%d", z]];
           // NSLog(@"save %@",saveresult);
            
        }
        
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



-(void)backButtonClicked
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (tableView.tag==1) {
        
        if (indexPath.row==0) 
        {
             return 66.0f;
        }
        else
        {
            return 60.0f;
        }
        
    }
        
 
    
    else if(tableView.tag==2)
    {
        if (indexPath.row==0) {
            return  66.5f;
        }
        else
        {
            return 60.0f;
        }
    }
    
    else if (tableView.tag==185)
    {
        return 40;
        
    }
        
    return 0;
}
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     
    if (tableView.tag==1) {
        return 1;
        
    }
    if (tableView.tag==2) {
        return 1;
        
    }

    
    else if (tableView.tag==185) {
        return 5;
        
    }

}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    
    if (tableView.tag==1) {
        return ([resultArrayFinal count]+1);
        
    }
    
   else if (tableView.tag==2) {
      
        return ([resultArrayFinal1 count]+1);
        
    }
    
    
    else if (tableView.tag==185) {
        return 5;
        
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else
    {
        UIView *subview;
		while ((subview= [[[cell contentView]subviews]lastObject])!=nil) 		
            [subview removeFromSuperview];
        
    }

    
    if (tableView.tag==185) 
    {
        
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
    
        

   
    if(tableView.tag==1)
    {

                   
            if(indexPath.row==0)
            {
                        
                UILabel*topLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(80 ,5 ,150, 22)];
                topLabel1.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
                [topLabel1 setTextColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];  
                topLabel1.backgroundColor=[UIColor clearColor];
                topLabel1.text=@"Dynamite Sticks";
                [cell.contentView addSubview:topLabel1];
      
                UILabel*topLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(50 ,30 ,200, 22)];
                topLabel2.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
                [topLabel2 setTextColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];  
                topLabel2.backgroundColor=[UIColor clearColor];
                topLabel2.text=[NSString stringWithFormat: @"currently you have %@ sticks",[[myGlobalArray objectAtIndex:0]valueForKey:@"intSticks"]];
                [topLabel2 setTextAlignment:UITextAlignmentCenter];
                //[topLabel2 sizeToFit];
                [cell.contentView addSubview:topLabel2];
                
                
            }
       else
       {
                  if ([resultArrayFinal count]>0) {
               
                      if (indexPath.row==1) {
                          UILabel*topLabel = [[UILabel alloc]initWithFrame:CGRectMake(50 ,22 ,100, 15)];
                          topLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:12.0];
                          topLabel.textColor = [UIColor blackColor];
                          topLabel.backgroundColor=[UIColor clearColor];
                          topLabel.text=[NSString stringWithFormat:@" %@  Sticks",[[resultArrayFinal objectAtIndex:indexPath.row-1]valueForKey:@"intSticksToBuy"]];
                          [cell.contentView addSubview:topLabel];

                      }
                
                     
               if (indexPath.row>1) 
               {
                   UILabel*topLabel = [[UILabel alloc]initWithFrame:CGRectMake(50 ,15 ,100, 15)];
                   topLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:12.0];
                   topLabel.textColor = [UIColor blackColor];
                   topLabel.backgroundColor=[UIColor clearColor];
                   topLabel.text=[NSString stringWithFormat:@"%@ Sticks",[[resultArrayFinal objectAtIndex:indexPath.row-1]valueForKey:@"intSticksToBuy"]];
                   [cell.contentView addSubview:topLabel];

                   UILabel*topLabel10 = [[UILabel alloc]initWithFrame:CGRectMake(50 ,30 ,100, 15)];
                   topLabel10.font = [UIFont fontWithName:@"Helvetica" size:12.0];
                   topLabel10.textColor = [UIColor blackColor];
                   topLabel10.backgroundColor=[UIColor clearColor];
                   topLabel10.text=[NSString stringWithFormat:@"Save %@%@",[saveresult objectAtIndex:indexPath.row-2],@"%"] ;
                   [cell.contentView addSubview:topLabel10];    
               
               
               }
           
           
           UIButton *btnStore = [UIButton buttonWithType:UIButtonTypeCustom];
           btnStore.frame = CGRectMake(210,15,80,30);
           btnStore.backgroundColor=[UIColor clearColor];
               [btnStore setTitle:[NSString stringWithFormat:@"%@ Coins",[[resultArrayFinal objectAtIndex:indexPath.row-1]valueForKey:@"intCoins"] ] forState:UIControlStateNormal];
               btnStore.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
           [btnStore setBackgroundImage:[UIImage imageNamed:@"btn_button@2x.png"] forState: UIControlStateNormal] ;
                      btnStore.tag=indexPath.row-1; 
                      [btnStore addTarget:self action:@selector(btnStickClicked:) forControlEvents:UIControlEventTouchUpInside];
           [cell.contentView addSubview:btnStore];
           
       UIImageView*  dynamite = [[UIImageView alloc]initWithFrame:CGRectMake(10,12,28,36)];
           dynamite.image=[UIImage imageNamed:@"dynamite_sticks_big@2x.png"];
           [cell.contentView addSubview:dynamite];   
       }  
           
       }       

        return cell;        
             
    }
    
    else if(tableView.tag==2)
        
    {
                       
        if(indexPath.row==0)
        {
            
          
            UILabel*top1 = [[UILabel alloc]initWithFrame:CGRectMake(100 ,5 ,120, 22)];
            top1.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
          [top1 setTextColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];  
            top1.backgroundColor=[UIColor clearColor];
            top1.text=@"Time Pieces";
            [cell.contentView addSubview:top1];
            
            strAddString=[[NSMutableString alloc]init];
            
            // [strAddString stringByAppendingString:@""];
            NSLog(@"resultArray %@",resultArrayFinal2);
            if ([resultArrayFinal2 count]>0) 
            {
                for (int i=0; i<[resultArrayFinal2 count]; i++) 
                {
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setNumberStyle: NSNumberFormatterSpellOutStyle];
                    // [formatter setLocale:...]; // Set locale if you want to use something other then the current one
                    NSString* numberString = [formatter stringFromNumber:[NSNumber numberWithInt: [[[resultArrayFinal2 objectAtIndex:i]valueForKey:@"TimePiecesCount"]intValue]]];
                    
                    //NSLog(@"%@",numberString);
                    [strAddString appendString:[NSString stringWithFormat:@" %@ %@ sec ",numberString,[[resultArrayFinal2 objectAtIndex:i]valueForKey:@"intTimePiece"]]]; 
                    NSLog(@"%@",strAddString);
                }
                
            }

            
            NSString* txt =[NSString stringWithFormat:@"currently you have %@",strAddString];
            NSLog(@"%@",txt);
            myAttributedLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(5 ,25 ,300, 30)];
            myAttributedLabel.attributedText = [NSString stringWithString:txt];
            [myAttributedLabel setBackgroundColor:[UIColor clearColor]];
           // [myAttributedLabel setTextAlignment:UITextAlignmentLeft];
           // [myAttributedLabel setLineBreakMode:UILineBreakModeCharacterWrap];
            myAttributedLabel.numberOfLines=0;
            NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:txt];
            [attrStr setFont:[UIFont fontWithName:@"Helvetica" size:12]];
            [attrStr setTextColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];
            
          ///  NSString* plainText = [attrStr string];
            for (int i=0; i<[resultArrayFinal2 count]; i++) 
            {
               // NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
               // [formatter setNumberStyle: NSNumberFormatterSpellOutStyle];
                // [formatter setLocale:...]; // Set locale if you want to use something other then the current one
               // NSString* numberString = [formatter stringFromNumber:[NSNumber numberWithInt: [[[resultArrayFinal2 objectAtIndex:i]valueForKey:@"TimePiecesCount"]intValue]]];
               
            [attrStr setTextColor:[UIColor blackColor] range:[txt rangeOfString:[[resultArrayFinal2 objectAtIndex:i]valueForKey:@"intTimePiece"]]];
          //  [attrStr setTextBold:YES range:[plainText rangeOfString:@"one"]];
               
            }
                  
            [myAttributedLabel setBackgroundColor:[UIColor clearColor]];
            [myAttributedLabel setAttributedText:attrStr];
            [cell.contentView addSubview:myAttributedLabel];

            
        }
        else
        { 
            if ([resultArrayFinal1 count]>0) {
            

            
            UILabel*topLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(16 ,15 ,250, 20)];
            topLabel1.font = [UIFont fontWithName:@"Helvetica-bold" size:12.0];
            topLabel1.textColor = [UIColor blackColor];
            topLabel1.backgroundColor=[UIColor clearColor];
                if ([[[resultArrayFinal1 objectAtIndex:indexPath.row-1]valueForKey:@"intTime"] length]==1) {
                    topLabel1.text=[NSString stringWithFormat:@" %@  Second Time Piece",[[resultArrayFinal1 objectAtIndex:indexPath.row-1]valueForKey:@"intTime"]];
                }
                else {
                    topLabel1.text=[NSString stringWithFormat:@"%@ Second Time Piece",[[resultArrayFinal1 objectAtIndex:indexPath.row-1]valueForKey:@"intTime"]];
                }

            
            [cell.contentView addSubview:topLabel1];
            
            btnStore1 = [UIButton buttonWithType:UIButtonTypeCustom];
            btnStore1.frame = CGRectMake(210,15,80,30);
            btnStore1.backgroundColor=[UIColor clearColor];
            [btnStore1 setBackgroundImage:[UIImage imageNamed:@"btn_button@2x.png"] forState: UIControlStateNormal] ;
                btnStore1.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
                [btnStore1 setTitle:[NSString stringWithFormat:@"%@ Coins",[[resultArrayFinal1 objectAtIndex:indexPath.row-1]valueForKey:@"intCoins"] ] forState:UIControlStateNormal];
                 btnStore1.tag=indexPath.row-1;
                //[tempCoinArray addObject:[[resultArrayFinal1 objectAtIndex:indexPath.row-1]valueForKey:@"intCoins"]];
                [btnStore1 addTarget:self action:@selector(btnTimeClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btnStore1];
            
            
            
        }   
        }
        
    }
    
    return cell;

    
}

-(void)callTimeUpdateparsing
{
    // h ttp://humsomething.netsmartz.us/HumServices.svc/getRandomUser
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/getStickstobuy"]]
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
-(void)btnStickClicked:(UIButton *)tag
{
    if ([[[myGlobalArray objectAtIndex:0]valueForKey:@"intCoins"] intValue]>=[[[resultArrayFinal objectAtIndex:tag.tag]valueForKey:@"intCoins"] intValue])
    {
        
    
      NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/updateusersticks/intUserID=%@,intSticks=%@,intCoins=%@",[[myGlobalArray objectAtIndex:0]valueForKey:@"intID"],[[resultArrayFinal objectAtIndex:tag.tag]valueForKey:@"intSticksToBuy"],[[resultArrayFinal objectAtIndex:tag.tag]valueForKey:@"intCoins"]]]
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
-(void)btnTimeClicked:(UIButton *)tag
{
//   NSString *str1= [[resultArrayFinal1 objectAtIndex:tag.tag]valueForKey:@"intTime"];
//    NSString *str=[[resultArrayFinal1 objectAtIndex:tag.tag]valueForKey:@"intCoins"];
//    NSLog(@"%@",str);
//   
    //[self callTimeUpdateparsing];
    //h ttp://humsomething.netsmartz.us/HumServices.svc/updateusertimepieces/intUserID=134,intTimeValue=5,vchType=S,intCoins=10
    NSLog(@"%d",[[[resultArrayFinal1 objectAtIndex:tag.tag]valueForKey:@"intCoins"] intValue]);
    NSLog(@"result finalarry1 %@",resultArrayFinal1);
    
    if ([[[myGlobalArray objectAtIndex:0]valueForKey:@"intCoins"] intValue]>=[[[resultArrayFinal1 objectAtIndex:tag.tag]valueForKey:@"intCoins"] intValue])
    {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/updateusertimepieces/intUserID=%@,intTimeValue=%@,vchType=%@,intCoins=%@",[[myGlobalArray objectAtIndex:0]valueForKey:@"intID"],[[resultArrayFinal1 objectAtIndex:tag.tag]valueForKey:@"intTime"],[[resultArrayFinal1 objectAtIndex:tag.tag]valueForKey:@"vchType"],[[resultArrayFinal1 objectAtIndex:tag.tag]valueForKey:@"intCoins"]]]
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
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"OOps!\ue403" message:@"You have no extra coins for buy more time" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }

}

-(void)viewWillDisappear:(BOOL)animated
{
    [myView setHidden:YES];
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
            ChangePasswordView *pwd = [[ChangePasswordView alloc]initWithNibName:@"ChangePasswordView" bundle:nil]; 
            [self.navigationController pushViewController:pwd animated:YES];

        }
        else if(indexPath.row==4)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        
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
        //(@"%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus" ] );
        
	}
	else {
        [[NSUserDefaults standardUserDefaults] setObject:@"OFF"  forKey:@"SoundStatus"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
		privacyStatus = @"1";
	}    
    //[self localPrivacyChange];
}





-(void)btnStoreClicked1
{
    
      [UIView beginAnimations:nil context:nil];
     [UIView setAnimationDuration:1];
      [UIView setAnimationRepeatCount:1];
       
    dynamite1.transform=CGAffineTransformMakeScale(2, 5);
     [UIView commitAnimations];
    [dynamite1 setFrame:CGRectMake(20, 10,25, 40)];
       //[UIView setAnimationRepeatCount:NO];
    //    
    
   
}

-(void)callgetTimePieceparsing
{
    // h ttp://humsomething.netsmartz.us/HumServices.svc/getRandomUser
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/getTimePiecestobuy"]]
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

- (void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:YES];
    
    x1t1=10.0f;
    x2t1=10.0f;
    x3t1=300.0f;
    x4t1=246.5f;
    
    x1t2=10.0f;
    x2t2=266.5f;
    x3t2=300.0f;
    x4t2=246.5f;

    [resultArrayFinal removeAllObjects];
    [resultArrayFinal1 removeAllObjects];
    [resultArrayFinal2 removeAllObjects];
    
    [self callgettimeStrings];
    [self callgettingStickparsing];
    [self callgetTimePieceparsing];
         
    [lblCoins setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intCoins"]] ;
    [lblDinamite setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intSticks"]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125.0,0.0, 180.0, 35.0)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [label setText:@"Store"];
    [label setTextColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];   
    [label setTextAlignment:UITextAlignmentCenter];
    [[self navigationItem] setTitleView:label];
    [label release];
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
