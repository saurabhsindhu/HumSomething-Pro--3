//
//  FriendRequestDetail.m
//  HumSomething
//
//  Created by Pravesh Uniyal on 01/08/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendRequestDetail.h"
#import <QuartzCore/QuartzCore.h>
#import "FriendRequest.h"
#import "MainHeaderFile.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "ChangeProfilePicViewController.h"
extern NSString *kCAFilterPageCurl; 
@class CAFilter;

@implementation FriendRequestDetail
@synthesize userIdString;
@synthesize responseData,resultArrayFinal;
@synthesize sw,privacyStatus;

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

-(void)callRequestParsing
{
    
   // h/ttp://humsomething.netsmartz.us/HumServices.svc/getFriendRequestssent/intUserID=66    // Create the Request.
    
    //ht tp://humsomething.netsmartz.us/HumServices.svc/getFriendRequestssent/intUserID=84
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/getFriendRequestssent/intUserID=%@",[[myGlobalArray objectAtIndex:0] valueForKey:@"intID"]]]
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
       // NSLog (@"The connection failed");
        
    }
 
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton: YES animated:NO];
    
    [lblCoins setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intCoins"]] ;
    [lblDinamite setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intSticks"]];

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80.0,0.0, 180.0, 35.0)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:@"Arial" size:18.0f]];
    [label setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [label setAdjustsFontSizeToFitWidth:YES];
    [label setText:@"Requests Sent"];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];
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
    
        
    
    [HUD hide:YES];
    [HUD removeFromSuperview];
    HUD=nil;

    
    [self parseXML];
    [tvFriendRequest reloadData];
    
    
    
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
  ///  NSLog (@"parseXML");
    
    // Initialize the parser with our NSData from the RSS feed
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:self.responseData];
    
    // Set the delegate to self
    
    [xmlParser setDelegate:self];
    
    // Start the parser
    
    if (![xmlParser parse])
    {
      //  NSLog (@"An error occurred in the parsing");
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
    
    
    
    if ([elementName isEqualToString:@"ArrayOftblUsers"])
        
    {
        // We are in an item element
        
        resultArray=[[NSMutableArray alloc]init];
        
        inItemElement = YES;
    }
    
    // If we are in an item and found a title
    
    if (inItemElement) {
        
        capturedCharacters = [[NSMutableString alloc]init];
    }
    
    if ([elementName isEqualToString:@"tblUsers"])
        
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
    
    if (inItemElement && [elementName isEqualToString:@"intFriendID"])
        
    {
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
        
        [capturedCharacters release];
        capturedCharacters = nil;
        
    }
    if (inItemElement && [elementName isEqualToString:@"intUserId"])
        
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
    if (inItemElement && [elementName isEqualToString:@"vchImage"])
        
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
    
    if ([elementName isEqualToString:@"tblUsers"])
        
    {
        NSMutableDictionary *dic;
        //    NSLog(@"%@",resultArray);
        if ([resultArray count]>0) 
        {
            dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[resultArray objectAtIndex:0],@"IsActive",[resultArray objectAtIndex:1],@"IsPushActive",[resultArray objectAtIndex:2],@"dtCreate",[resultArray objectAtIndex:3],@"intCoins",[resultArray objectAtIndex:4],@"intFriendID",[resultArray objectAtIndex:5],@"intID",[resultArray objectAtIndex:6],@"intSticks",[resultArray objectAtIndex:7],@"intUserId",[resultArray objectAtIndex:8],@"vchEmail",[resultArray objectAtIndex:9],@"vchImage",[resultArray objectAtIndex:10],@"vchUserName",nil];
            //inItemElement = NO;
            [resultArray removeAllObjects];
            [resultArrayFinal addObject:dic];
          //  NSLog(@"%@",resultArrayFinal);
            
        }
        
        if ([elementName isEqualToString:@"ArrayOftblUsers"])
            
        {
            
            
            
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    resultArrayFinal=[[NSMutableArray alloc]init];
    [self callRequestParsing];
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
    
    //Create SubView 
    
    UIView *requestView = [[UIView alloc]initWithFrame:CGRectMake(10,65, 300,350)];
    requestView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    requestView.layer.cornerRadius =6.0;
    [self.view addSubview:requestView];
    
    
    
    // Create tableview
    
    tvFriendRequest = [[UITableView alloc]initWithFrame:CGRectMake(0,0, 300,350) style:UITableViewStylePlain];
    tvFriendRequest.layer.cornerRadius =6.0;
    tvFriendRequest.delegate=self;
    tvFriendRequest.dataSource=self;
    tvFriendRequest.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    tvFriendRequest.separatorColor= [UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
      tvFriendRequest.tag=1;
    [requestView addSubview:tvFriendRequest];
    
    
      

    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [myView setHidden:YES];
}

-(void)backButtonClicked
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    
  
	[self.navigationController popViewControllerAnimated:YES];
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
    

    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryNone;
        
        UIButton *ProfileImageButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, 30, 30)];
        [ProfileImageButton setBackgroundColor:[UIColor clearColor]];
        [ProfileImageButton setClearsContextBeforeDrawing:YES];
        [ProfileImageButton setUserInteractionEnabled:NO];
        NSString *ImagePath =[[resultArrayFinal objectAtIndex:indexPath.row]valueForKey:@"vchImage"];
        
        [ProfileImageButton setImageWithURL:[NSURL URLWithString:ImagePath] placeholderImage:[UIImage imageNamed:@"defaultSmall@2x.png"]];	
        [cell.contentView addSubview:ProfileImageButton];
        [ProfileImageButton release];
        ProfileImageButton = nil; 
        
        
        
        UILabel *NameLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 10, 100, 30)];
        [NameLabel setTextColor:[UIColor blackColor]];
        [NameLabel setBackgroundColor:[UIColor clearColor]]; 
        [NameLabel setTextAlignment:UITextAlignmentLeft];
        [NameLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [NameLabel setText:[[resultArrayFinal objectAtIndex:indexPath.row]valueForKey:@"vchUserName"]];
        [cell.contentView addSubview:NameLabel];
        
        
               
    }
    
    
    return  cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag==1) {
        return 62.0f;
    }
    
    else if (tableView.tag==185)
    {
        return 40;
        
    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    
    if (tableView.tag==1) {
        return [resultArrayFinal count];
        
    }
    
    
    else if (tableView.tag==185) {
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
