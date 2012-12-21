//
//  HumSomethingViewController.m
//  HumSomething
//
//  Created by Pravesh Uniyal on 28/06/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HumSomethingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MainScreenView.h"
#import "RegisterViewController.h"
#import"FBFriendsView.h"

@implementation HumSomethingViewController

@synthesize responseData;

-(void)callLoginParsing
{
   
    // http://humsomething.netsmartz.us/HumServices.svc/loginuser/UserName=brad,Password=brad12

	// Create the Request.
   
    
	NSURLRequest *request = [NSURLRequest requestWithURL:
							 [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/loginuser/UserName=%@,Password=%@",txtUserName.text,txtPassword.text]]
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
	HUD.labelText = @"Signing in...";
	[HUD show:YES];  
    
	[self.responseData setLength:0];
    
}



// Called each time the connection receives a chunk of data

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
	//NSLog (@"connection:didReceiveData:");
	
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
	//NSLog (@"parseXML");
	
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
	//NSLog (@"didStartElement");
	
	// Check to see which element we have found
	
	if ([elementName isEqualToString:@"ArrayOftblUsers"])
        
	{
		// We are in an item element
	
        resultArray=[[NSMutableArray alloc]init];

		inItemElement = YES;
	}
	
	// If we are in an item and found a title
	
	if (inItemElement)
        
	{
          
		// Initialize the capturedCharacters instance variable
		
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
            
           
            
            MainScreenView *mainView = [[MainScreenView alloc]initWithNibName:@"MainScreenView" bundle:nil];
           // mainView.mydetailArray=resultArray;
            [myGlobalArray addObjectsFromArray:resultArray];
         
            [self.navigationController pushViewController:mainView animated:YES];
                      [mainView release];
                       
        }
        
        else {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Please Fill Correct Username or Password" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            [alert release]; 
        }
        
       // NSLog(@"%@",resultArray);
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

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
 
    // Add a login view

    
    loginView=[[UIView alloc]initWithFrame:CGRectMake(10, 110, 300, 130)];
    loginView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    loginView.userInteractionEnabled=YES;
    loginView.layer.cornerRadius =6.0;
    loginView.layer.borderColor = [UIColor whiteColor].CGColor;
	loginView.layer.borderWidth = 1.0; //#import <QuartzCore/QuartzCore.h>
    [self.view addSubview:loginView];
    

     
    //add a textField for username
    
    txtUserName=[[UITextField alloc]init];
    txtUserName.frame =CGRectMake(10, 18, 285, 30);
    txtUserName.borderStyle=UITextBorderStyleNone ;
    txtUserName.placeholder=@"User Name" ;
    txtUserName.clearButtonMode=TRUE;
    txtUserName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txtUserName.autocorrectionType = UITextAutocorrectionTypeNo;
    //[txtUserName setTextAlignment:UITextAlignmentCenter];
    [txtUserName setFont:[UIFont fontWithName:@"Helvetica" size:14.f]];

    txtUserName.userInteractionEnabled=YES;
    txtUserName.delegate=self;

    [loginView addSubview:txtUserName];
    
    UILabel *seperater=[[UILabel alloc]initWithFrame:CGRectMake(0, 65,300, 1)];
    seperater.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [loginView addSubview:seperater];
    
    //add a textField for password
    txtPassword=[[UITextField alloc]init];
    txtPassword.frame=CGRectMake(10, 94, 285, 30);
    txtPassword.placeholder=@"Password";
    txtPassword.clearButtonMode=TRUE;
    txtPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txtPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    [txtPassword setFont:[UIFont fontWithName:@"Helvetica" size:14.f]];
    //[txtPassword setTextAlignment:UITextAlignmentCenter];
    txtPassword.borderStyle=UITextBorderStyleNone;
    txtPassword.delegate=self;
    [txtPassword setSecureTextEntry:YES];
    [loginView addSubview:txtPassword];
   
    
    //add button for login
    btnLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnLogin.frame = CGRectMake(43.5,258 ,233,38);
    [btnLogin setImage:[UIImage imageNamed:@"login@2x.png"] forState:UIControlStateNormal]; 
    [btnLogin addTarget:self action:@selector(btnLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    
    //add button for register
    
    btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRegister.frame = CGRectMake(43.5,308 ,233,38);
    [btnRegister setImage:[UIImage imageNamed:@"register@2x.png"] forState:UIControlStateNormal]; 
    [btnRegister addTarget:self action:@selector(btnRegisterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRegister];
    
    
    
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




-(void)btnLoginClick
{
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }

[txtPassword resignFirstResponder];
     [[NSUserDefaults standardUserDefaults] setObject:txtUserName.text  forKey:@"userStr"];
     [[NSUserDefaults standardUserDefaults] setObject:txtPassword.text  forKey:@"passStr"];
[self callLoginParsing];


}

-(void)btnRegisterClick
{
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }


    RegisterViewController *rView=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:rView animated:YES];
    
  

}

#pragma mark -
#pragma mark --------------------------------------------------------------------------------------------
#pragma mark ------------------------------ Text Field Delegate  Methods --------------------------------
#pragma mark --------------------------------------------------------------------------------------------
#pragma mark -

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	//textField.text=@"";
	static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
	static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
	static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
	static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
	static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
	
	CGRect textFieldRect;
	CGRect viewRect;
	
	
	textFieldRect =[self.view.window convertRect:textField.bounds fromView:textField];
	viewRect =[self.view.window convertRect:self.view.bounds fromView:self.view];
	
	
	CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
	CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
	CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
	CGFloat heightFraction = numerator / denominator;
	
	if (heightFraction < 0.0)
	{
		heightFraction = 0.0;
	}
	else if (heightFraction > 1.0)
	{
		heightFraction = 1.0;
	}
	
	UIInterfaceOrientation orientation =[[UIApplication sharedApplication] statusBarOrientation];
	if (orientation == UIInterfaceOrientationPortrait ||orientation == UIInterfaceOrientationPortraitUpsideDown)
	{
		animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
	}
	else
	{
		animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
	}
	
	CGRect viewFrame;
	
	viewFrame= self.view.frame;
	viewFrame.origin.y -= animatedDistance;
	
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
	
	[self.view setFrame:viewFrame];
	
	[UIView commitAnimations];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	[textField resignFirstResponder];
	if(textField.tag==0)
	{
		static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
		CGRect viewFrame;
		
		viewFrame= self.view.frame;
		viewFrame.origin.y += animatedDistance;
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
		[self.view setFrame:viewFrame];
		[UIView commitAnimations];
		
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    	return TRUE;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    [super      touchesBegan:touches withEvent:event]; //may be not required
	[self     dismissInputControls];
}

#pragma mark -
#pragma mark ---------------               RESIGN KEYBOARD on touch Method                ---------------
#pragma mark -
- (void)dismissInputControls
{	
	[txtPassword resignFirstResponder];
	[txtUserName resignFirstResponder];
}



-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton: YES animated:NO];
    
   self.navigationController.navigationBarHidden =NO;
        [myGlobalArray removeAllObjects];
   
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(165.0,0.0, 90.0, 35.0)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:@"Arial" size:18.0f]];
    [label setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [label setAdjustsFontSizeToFitWidth:YES];
    [label setText:@"User Login"];
    [label setTextAlignment:UITextAlignmentCenter];
     [label setTextColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];
    [[self navigationItem] setTitleView:label];
    [label release];



}
-(void)viewWillDisappear:(BOOL)animated
{
    txtPassword.text=@"";
    txtUserName.text=@"";
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
