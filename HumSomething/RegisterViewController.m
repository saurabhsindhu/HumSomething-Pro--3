 //
//  RegisterViewController.m
//  photosharing1
//
//  Created by jk menon on 2/22/12.
//  Copyright (c) 2012 interworld commnet. All rights reserved.
//

#import "RegisterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "HumSomethingViewController.h"
#import "ASIFormDataRequest.h"


@implementation RegisterViewController
@synthesize responseData;

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

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton: YES animated:NO];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90.0,0.0, 140.0, 35.0)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:@"Arial" size:18.0f]];
    [label setFont:[UIFont boldSystemFontOfSize:18.0f]];
   // [label setAdjustsFontSizeToFitWidth:YES];
    [label setText:@"Registration"];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];
    [[self navigationItem] setTitleView:label];
    [label release];

        
 }
#pragma mark - View lifecycle

- (void)viewDidLoad
{
  
    [super viewDidLoad];
    self.navigationController.navigationBarHidden =NO;
 appDelegate = (HumSomethingAppDelegate *)[[UIApplication sharedApplication] delegate];

	    // Do any additional setup after loading the view from its nib.
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

	cameraImageView =[[UIImageView alloc]init];
    
    
    
    UIView *registerView=[[UIView alloc]initWithFrame:CGRectMake(10, 40,300,295)];//315
    registerView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    registerView.userInteractionEnabled=YES;
    registerView.layer.cornerRadius =6.0;
    registerView.layer.borderColor = [UIColor whiteColor].CGColor;
	registerView.layer.borderWidth = 1.0; //#import <QuartzCore/QuartzCore.h>
    [self.view addSubview:registerView];

          
    UILabel *seperater=[[UILabel alloc]initWithFrame:CGRectMake(0, 42, 300, 1)];
    seperater.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [registerView addSubview:seperater];
    [seperater release];
    
    
    
    UILabel *seperater1=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, 300, 1)];
    seperater1.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [registerView addSubview:seperater1];
    [seperater1 release];
    
    UILabel *seperater2=[[UILabel alloc]initWithFrame:CGRectMake(0, 120, 300, 1)];
    seperater2.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    [registerView addSubview:seperater2];
    [seperater2 release];

    //add a textField for username
    
    txt_Name=[[UITextField alloc]init];
    txt_Name.frame =CGRectMake(10, 12.5, 285, 25);
    txt_Name.borderStyle=UITextBorderStyleNone ;
    txt_Name.placeholder=@"Username" ;
    [txt_Name setFont:[UIFont fontWithName:@"Helvetica" size:14.f]];
    txt_Name.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txt_Name.autocorrectionType = UITextAutocorrectionTypeNo;
    txt_Name.clearButtonMode=TRUE;
    txt_Name.userInteractionEnabled=YES;
    txt_Name.delegate=self;
    
    [registerView addSubview:txt_Name];
    
    //add a textField for Email
    
    txt_Password=[[UITextField alloc]init];
    txt_Password.frame =CGRectMake(10,51.5, 285, 25);
    txt_Password.borderStyle=UITextBorderStyleNone ;
    txt_Password.placeholder=@"Password" ;
    [txt_Password setFont:[UIFont fontWithName:@"Helvetica" size:14.f]];
    txt_Password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txt_Password.autocorrectionType = UITextAutocorrectionTypeNo;
    txt_Password.clearButtonMode=TRUE;
    txt_Password.userInteractionEnabled=YES;
    txt_Password.secureTextEntry=YES;
    txt_Password.delegate=self;
    
    [registerView addSubview:txt_Password];

    
    //add a textField for Email
    
    txt_Email=[[UITextField alloc]init];
    txt_Email.frame =CGRectMake(10, 91.5, 285, 25);
    txt_Email.borderStyle=UITextBorderStyleNone ;
    txt_Email.placeholder=@"Email" ;
    txt_Email.clearButtonMode=TRUE;
    [txt_Email setFont:[UIFont fontWithName:@"Helvetica" size:14.f]];
    txt_Email.autocapitalizationType = UITextAutocapitalizationTypeNone;
    txt_Email.autocorrectionType = UITextAutocorrectionTypeNo;
    txt_Email.userInteractionEnabled=YES;
    txt_Email.delegate=self;
    
    [registerView addSubview:txt_Email];
    
 
    
    img_UserPic=[[UIImageView alloc]initWithFrame:CGRectMake(110, 153, 80,80)];
    [img_UserPic setImage:[UIImage imageNamed:@"defaultImage@2x"]];
    [registerView addSubview:img_UserPic];
    
//    
//    txt_Uploadphoto=[[UITextField alloc]init];
//    txt_Uploadphoto.frame =CGRectMake(10,183, 138, 25);
//    txt_Uploadphoto.borderStyle=UITextBorderStyleLine ;
//    txt_Uploadphoto.placeholder=@"Default Image" ;
//    [txt_Uploadphoto setFont:[UIFont fontWithName:@"Helvetica" size:14.f]];
//    [txt_Uploadphoto setEnabled:NO];
//    txt_Uploadphoto.userInteractionEnabled=YES;
//    txt_Uploadphoto.delegate=self;
    
    [registerView addSubview:txt_Uploadphoto];
    
    //add button for register
    
    btn_Browse = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Browse.frame = CGRectMake(110,234,80,26);
    [btn_Browse setImage:[UIImage imageNamed:@"Browse@2x.png"] forState:UIControlStateNormal]; 
    [btn_Browse addTarget:self action:@selector(browseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [registerView addSubview:btn_Browse];

    //add button for Submit
    
    btn_Submit = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Submit.frame = CGRectMake(43.5,355 ,233,38);
    [btn_Submit setImage:[UIImage imageNamed:@"Submit@2x.png"] forState:UIControlStateNormal]; 
    [btn_Submit addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_Submit];
}


-(void)backButtonClicked
{
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
	
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)browseBtnClick
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
	[txt_Name resignFirstResponder];
	[txt_Email resignFirstResponder];
	[txt_Password resignFirstResponder];
	[txt_Uploadphoto resignFirstResponder];

	UIActionSheet *cameraActionSheet = [[UIActionSheet alloc] initWithTitle:@"" 
                                                                   delegate:self 
                                                          cancelButtonTitle:@"Cancel"
                                                     destructiveButtonTitle:@"Photo Library" 
                                                          otherButtonTitles:@"Take Picture",nil];
	cameraActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[cameraActionSheet showInView:[[UIApplication sharedApplication]keyWindow]];
}
-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
		{
			
			picker.navigationBarHidden=YES;

			if (picker == nil) {
				picker = [[UIImagePickerController alloc] init];
				picker.allowsEditing = NO;
			}
			picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
			picker.delegate = self;
			picker.wantsFullScreenLayout = YES;
			[picker.navigationBar setTintColor:[UIColor blackColor]];
			[self.navigationController presentModalViewController:picker animated:NO];
		}
	}
	else if(buttonIndex == 1) {
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		
			//Now this seems to do the trick. The picker only gets allocated once. Therefore no memory issues any longer!
			if (picker == nil) {
				picker = [[UIImagePickerController alloc] init];
				picker.allowsEditing = NO;
			}
			picker.sourceType = UIImagePickerControllerSourceTypeCamera;
			
			// Hide the controls:
			picker.showsCameraControls = YES;
			picker.navigationBarHidden = YES;
			picker.delegate = self;
			
			// Make camera view full screen:
			picker.wantsFullScreenLayout = YES;
			
			[self presentModalViewController:picker animated:YES];
			[super viewDidAppear:YES];
		}
       
		else {
			[self callAlertView:@"Message" message:@"Device doesn't support camera"];
		}
	}
   
}



#pragma mark -----------------------------
#pragma mark Image Picker Delegate Methods
#pragma mark -----------------------------

- (void)imagePickerController:(UIImagePickerController *)picker1 didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *newImage = [[UIImage alloc] init];
	newImage=[info objectForKey:UIImagePickerControllerOriginalImage];
	cameraImageView.image=newImage ;
	
	if (picker1.sourceType==UIImagePickerControllerSourceTypeCamera) {
		txt_Uploadphoto.text =@"Camera Image";
	}
	else
    {
		txt_Uploadphoto.text = [NSString stringWithFormat:@"%@",[info objectForKey: UIImagePickerControllerReferenceURL]];
	}
	
    [picker dismissModalViewControllerAnimated:YES];
    img_UserPic.image=cameraImageView.image;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker1
{
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)submitBtnClick
{
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }

    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL b = [emailTest evaluateWithObject:txt_Email.text];
    
    if (b==NO) 
    {
        
        UIAlertView *messageBox = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid Email ID" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [messageBox show];
        [messageBox release];
        
    }
    
    else 
    {
        
    
	if([[txt_Name text] length] < 1)
	{
		[self callAlertView:@"Message!" message:@"Please Enter Your Name"];
	}
	else if([[txt_Email text] length] < 1)
	{
		[self callAlertView:@"Message!" message:@"Please Enter Your Email Address"];
	}
	else if([[txt_Password text] length] < 1) {
		[self callAlertView:@"Message!" message:@"Please Enter Your Password"];
	}
	
//	else if([[txt_Uploadphoto text] length] < 1) {
//		[self callAlertView:@"Message!" message:@"Please Select Image"];
//	}
//	
	
        
    
    else
    {
        
		[self callRegisterParsing];
		
    }
        
        if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
        {
            [self playSound]; 
        }
}

}
#pragma mark --------------------------------------------------------------------------------------------
#pragma mark ------------------------------   Call Alert Method Methods  --------------------------------
#pragma mark --------------------------------------------------------------------------------------------


-(void) callAlertView :(NSString *)titlemessage message:(NSString *)msg
{
	UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:titlemessage message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[errorAlert show];

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


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    [self.view  endEditing:YES]; //may be not required
    [super touchesBegan:touches withEvent:event]; //may be not required
	[self  dismissControls];
}

#pragma mark -
#pragma mark ---------------               RESIGN KEYBOARD on touch Method                ---------------
#pragma mark -
- (void)dismissControls
{	
	[txt_Name resignFirstResponder];
	[txt_Email resignFirstResponder];
	[txt_Password resignFirstResponder];
	[txt_Uploadphoto resignFirstResponder];
	
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string 
{		
	if(textField ==txt_Name)
	{
		static NSCharacterSet *charSet = nil;
		if(!charSet) {
			charSet =[ [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz@.1234567890 "] invertedSet]retain];
		}
		NSRange location = [string rangeOfCharacterFromSet:charSet];
		return (location.location == NSNotFound);
	}
	
	if(textField ==txt_Email)
	{
		static NSCharacterSet *charSet = nil;
		if(!charSet) {
			charSet = [[[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz@.1234567890"] invertedSet] retain];
		}
		NSRange location = [string rangeOfCharacterFromSet:charSet];
		return (location.location == NSNotFound);
	} 
	return YES;
}

- (NSString *)getUUID {
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceUUID"];
    if (string == nil) {
        CFUUIDRef   uuid;
        CFStringRef uuidStr;
        
        uuid = CFUUIDCreate(NULL);
        uuidStr = CFUUIDCreateString(NULL, uuid);
        
        string = [NSString stringWithFormat:@"%@", uuidStr];
        [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"deviceUUID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        CFRelease(uuidStr);
        CFRelease(uuid);
    }
    
    return string;
}


-(void)callRegisterParsing
{
  
    
  //  ht tp://humsomething.netsmartz.us/HumServices.svc/reguser/UserName=rocky,Password=rocky12,Email=raj.g.sharma@gmail.com,Lat=0,Long=0,UDID=1234567,IsPush=0,TokenID=abcxyz
    
    NSString *udid=[self getUUID];
    //NSLog(@"%@",udid);
    NSString *latStr = [[NSString alloc] initWithFormat:@"%f",appDelegate.mUserCurrentLocation.coordinate.latitude];
	NSString *longStr = [[NSString alloc] initWithFormat:@"%f",appDelegate.mUserCurrentLocation.coordinate.longitude];

    
    
	NSURLRequest *request = [NSURLRequest requestWithURL:
[NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/reguser/UserName=%@,Password=%@,Email=%@,Lat=%@,Long=%@,UDID=%@,IsPush=%@,TokenID=%@",txt_Name.text,txt_Password.text,txt_Email.text,latStr,longStr,udid,@"1",appDelegate.devicestr]]cachePolicy:NSURLRequestUseProtocolCachePolicy
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


-(void)callImagesendParsing:(NSString *)strID
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	HUD.labelText = @"Uploading...";
	[HUD show:YES];
    
    NSString *urlString =[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/updateimage/intUserID=%@",strID];
    
    
    NSURL *url = [NSURL URLWithString: urlString];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setUseKeychainPersistence:YES];
   // NSLog(@"%@ %@",img_UserPic.image,strID);
    //  UIImage * image = [[UIImage imageNamed:@"SelectImage.png"] autorelease];
     NSData *imageData = UIImageJPEGRepresentation(img_UserPic.image, 90);
    [request setPostBody:imageData];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestFinished:)];
    [request setDidFailSelector:@selector(requestFailed:)];
        
    [request startAsynchronous];
    
      
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
	HUD.labelText = @"Uploading...";
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
	NSLog (@"parseXML");
	
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
	NSLog (@"didStartElement");
	
	// Check to see which element we have found
	
    
   
    
    
	if ([elementName isEqualToString:@"RegisterUserResult"])
        
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
	
     
    
    
	if (inItemElement && [elementName isEqualToString:@"RegisterUserResult"]) 
        
	{
        [resultArray addObject:capturedCharacters];
      
        int userId=[capturedCharacters intValue];

        if (userId>0) {
            
       
            NSString *str=[[NSNumber numberWithInt:userId] stringValue];

            [self callImagesendParsing:str];
            
        }
        else {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message!" message:@"Registration not successful" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            [alert release]; 
        }
		// Release the capturedCharacters instance variable
		 NSLog(@" REPONSE %@",resultArray);
		[capturedCharacters release];
		capturedCharacters = nil;
		
        
	}
  
        // NSLog(@"%@",resultArray);
	}
    


// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) 
    {
        HumSomethingViewController *login=[[HumSomethingViewController alloc]initWithNibName:@"HumSomethingViewController" bundle:nil];
        [self.navigationController pushViewController:login animated:YES];
              
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
- (void)requestFinished:(ASIHTTPRequest *)request {
	
	NSString *receivedString = [request responseString];
//	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"finish" message:receivedString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    
//    
//	[alertView show];
//	[alertView release];
//   
    
	[HUD hide:YES];
	[HUD removeFromSuperview];
    HUD=nil;
    
    
    
	[HUD hide:YES];
	[HUD removeFromSuperview];
    HUD=nil;
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message!" message:@"Registration successful" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
    [alert release]; 
    
    txt_Name.text=@"";
    txt_Email.text=@"";
    txt_Password.text=@"";
    NSLog(@"response %@",receivedString);
}   


- (void)requestFailed:(ASIHTTPRequest *)request {
	
	NSString *receivedString = [request responseString];
//	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Message" message:receivedString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//	[alertView show];
//	[alertView release];
    NSLog(@"response %@",receivedString);
    
    
    NSLog(@"failed");
}




@end
