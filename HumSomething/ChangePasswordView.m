//
//  ChangePasswordView.m
//  HumSomething
//
//  Created by Pravesh Uniyal on 29/08/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ChangePasswordView.h"
#import "ChangeProfilePicViewController.h"
#import"GlobalVars.h"
#import <QuartzCore/QuartzCore.h>
#import "MainHeaderFile.h"
@implementation ChangePasswordView

@synthesize sw,privacyStatus,responseData;

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
    
    
       
    
    UIView *passwordView=[[UIView alloc]initWithFrame:CGRectMake(10, 110,300,180)];//315
    passwordView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    passwordView.userInteractionEnabled=YES;
    passwordView.layer.cornerRadius =6.0;
    passwordView.layer.borderColor = [UIColor whiteColor].CGColor;
	passwordView.layer.borderWidth = 1.0; //#import <QuartzCore/QuartzCore.h>
    [self.view addSubview:passwordView];
    
    UILabel *seperater=[[UILabel alloc]initWithFrame:CGRectMake(0, 42, 300, 1)];
    seperater.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [passwordView addSubview:seperater];
    [seperater release];
   
    UILabel *seperater1=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, 300, 1)];
    seperater1.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [passwordView addSubview:seperater1];
    [seperater1 release];
    // add textfield for password
    
    txt_OldPassword=[[UITextField alloc]init];
    txt_OldPassword.frame =CGRectMake(20, 12.5, 250, 25);
    txt_OldPassword.borderStyle=UITextBorderStyleNone ;
    txt_OldPassword.placeholder=@"Old Password" ;
    [txt_OldPassword setFont:[UIFont fontWithName:@"Helvetica" size:14.f]];
    txt_OldPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txt_OldPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    txt_OldPassword.clearButtonMode=TRUE;
    txt_OldPassword.userInteractionEnabled=YES;
    txt_OldPassword.delegate=self;
    
    [passwordView addSubview:txt_OldPassword];
    
    
    
    txt_Password=[[UITextField alloc]init];
    txt_Password.frame =CGRectMake(20,51.5, 250, 25);
    txt_Password.borderStyle=UITextBorderStyleNone ;
    txt_Password.placeholder=@"New Password" ;
    [txt_Password setFont:[UIFont fontWithName:@"Helvetica" size:14.f]];
    txt_Password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txt_Password.autocorrectionType = UITextAutocorrectionTypeNo;
    txt_Password.clearButtonMode=TRUE;
    txt_Password.userInteractionEnabled=YES;
    txt_Password.secureTextEntry=YES;
    txt_Password.delegate=self;
    
    [passwordView addSubview:txt_Password];

    
    
    updateButton = [[UIButton alloc] initWithFrame:CGRectMake(36, 230, 99, 28)];
	[updateButton setBackgroundImage:[UIImage imageNamed:@"update@2x.png"] forState:UIControlStateNormal];
	[updateButton addTarget:self action:@selector(callRequestParsing) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:updateButton];
	[updateButton release];
    
        
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(179, 230, 99, 28)];
	[cancelButton setBackgroundImage:[UIImage imageNamed:@"cacel@2x.png"] forState:UIControlStateNormal];
	[cancelButton addTarget:self action:@selector(cancelbtnClicked) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:cancelButton];
    [cancelButton release];
    
       

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)cancelbtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)callRequestParsing
{
    
    if ([txt_OldPassword.text length]<=0 && [txt_Password.text length]<=0) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message!" message:@"Fill the password detail" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];

        return ;
        
    }
    else
    {
    
   //h ttp://humsomething.netsmartz.us/HumServices.svc/updatepassword/intUserID=117,OldPassword=rock,NewPassword=rock12
    //  NSLog(@"%@",[[myGlobalArray objectAtIndex:0] valueForKey:@"intID"]);
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/updatepassword/intUserID=%@,OldPassword=%@,NewPassword=%@",[[myGlobalArray objectAtIndex:0] valueForKey:@"intID"],txt_OldPassword.text,txt_Password.text]]
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
    
    // NSLog(@"Response String: \n%@", responseString);
    
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





-(void)updateButtonClicked4
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    
    //[self callImagesendParsing:[[myGlobalArray objectAtIndex:0]valueForKey:@"intID"]];
    
}
-(void)backButtonClicked
{
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
	
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton: YES animated:NO];
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80.0,0.0, 180.0, 35.0)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:@"Arial" size:18.0f]];
    [label setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [label setAdjustsFontSizeToFitWidth:YES];
    [label setText:@"Change Password"];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];
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
        NSLog(@"error %@",error);
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
