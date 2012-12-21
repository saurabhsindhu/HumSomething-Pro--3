//
//  FBFriendsView.m
//  HumSomething
//
//  Created by Mohit Bisht on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FBFriendsView.h"
#import "FBDialog.h"
#import "SBJsonParser.h"
#import "JSON.h"
#import "HumSomethingAppDelegate.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "ChangeProfilePicViewController.h"
@interface FBFriendsView ()

@end


extern NSString *kCAFilterPageCurl; 
@class CAFilter;

@implementation FBFriendsView

@synthesize responseData,userId;
@synthesize sw,privacyStatus,resultArrayFinal;
NSMutableArray *placeIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    
else if(tableView.tag==1)
{
    
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
		cell.backgroundColor=[UIColor clearColor];
		cell.selectionStyle=UITableViewCellSelectionStyleNone;
    	cell.accessoryType=UITableViewCellAccessoryNone;
        
    }
    else
    {
        UIView *subview;
		while ((subview= [[[cell contentView]subviews]lastObject])!=nil) 		
            [subview removeFromSuperview];
        
    }

		// LOAD FRIENDS FROM FACEBOOBK
		
//		
//		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//		btn.frame=CGRectMake(245,15,46,24);
//		[btn setImage:[UIImage imageNamed:@"invitepng@2x.png"] forState:UIControlStateNormal];
//		btn.tag=indexPath.row;
//		[btn addTarget:self action:@selector(sendFBPost:) forControlEvents:UIControlEventTouchUpInside];
//		
//		
//		btn.backgroundColor=[UIColor clearColor];
//		[cell  addSubview:btn];
		
		
		
//		UIView *backroundSelecView=[[[UIView alloc]init]autorelease];
//		cell.backgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navigationBar@2x.png"]]autorelease];
//		cell.selectedBackgroundView=backroundSelecView;
//		
//		cell.backgroundColor=[UIColor clearColor];
//		[[cell layer] setBorderWidth:1.0f];
//		[[cell layer] setBorderColor:[[UIColor whiteColor] CGColor]];
		
    
    
				
    
    NSString *alphabet = [placeIndex objectAtIndex:[indexPath section]];
    NSPredicate *predicate = 
	[NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", alphabet];
    NSArray *places = [infoFeeds filteredArrayUsingPredicate:predicate];
   // NSLog(@"%@",arrayFBActiveUser);
    for (int i=0; i<[infoFeeds count]; i++)
    {
        if ([[[arrayFBActiveUser objectAtIndex:i]valueForKey:@"name"] isEqualToString:[places objectAtIndex:indexPath.row]])
        {
            UIButton *ProfileImageButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, 30, 30)];
            [ProfileImageButton setBackgroundColor:[UIColor clearColor]];
            [ProfileImageButton setClearsContextBeforeDrawing:YES];
            [ProfileImageButton setUserInteractionEnabled:NO];
            NSString *ImagePath =[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture",[[arrayFBActiveUser objectAtIndex:i] objectForKey:@"id"]];
            [ProfileImageButton setImageWithURL:[NSURL URLWithString:ImagePath] placeholderImage:[UIImage imageNamed:@"defaultSmall@2x.png"]];	
            [cell.contentView addSubview:ProfileImageButton];
            [ProfileImageButton release];
            ProfileImageButton = nil; 
            
            cell.backgroundColor=[UIColor clearColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
           // 
            UIButton* requestAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
            requestAddButton.frame = CGRectMake(240,15 ,23,23);
            [requestAddButton setImage:[UIImage imageNamed:@"addrequestBtn@2x.png"] forState:UIControlStateNormal];
            
            requestAddButton.tag=indexPath.row;
            [requestAddButton addTarget:self action:@selector(invitefriend:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:requestAddButton];
            //
            UILabel *NameLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 10, 300, 30)];
            [NameLabel setTextColor:[UIColor blackColor]];
            [NameLabel setBackgroundColor:[UIColor clearColor]]; 
            [NameLabel setTextAlignment:UITextAlignmentLeft];
            [NameLabel setFont:[UIFont systemFontOfSize:16.0f]];
            if ([places count]>0) {
               // NSString *cellValue = [places objectAtIndex:indexPath.row];
                [NameLabel setText:[NSString stringWithFormat:@"%@",[[arrayFBActiveUser objectAtIndex:i] valueForKey:@"name"]]];
                
                
                [cell.contentView addSubview:NameLabel];
                [NameLabel release];
                    
            }
        }
    }
    

	

    
    return  cell;
		
	}
      return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
    
    if (tableView.tag==1) {
        
        return [placeIndex count];        
    }
    else if (tableView.tag==185)  
    {
        return 1;    
    }
    
  	 
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    if (tableView.tag==1) {
        
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)] autorelease];
//    if (section%2)
//        [headerView setBackgroundColor:[UIColor redColor]];
//    else 
        [headerView setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:187.0f/255.0f alpha:1]];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 3, tableView.bounds.size.width - 10, 18)] autorelease];
    label.text = [placeIndex objectAtIndex:section];
    label.textColor = [UIColor colorWithRed:255.0f/255.0f green:18.0f/255.0f blue:87.0f/255.0f alpha:1];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];

    return headerView;
    }
      return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.tag==1) {
        return [placeIndex objectAtIndex:section];
    }
    else if (tableView.tag==185)
    {
        return 0;
        
    }
  return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag==1) {
        return 52.0f;
    }
    
    else if (tableView.tag==185)
    {
        return 40.0f;
        
    }
  return 0;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView.tag==1) {
          return placeIndex;
    }
  
    else if(tableView.tag==185)
    {
        return 0;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    
    
    if (tableView.tag==1) {
       	//return [appDelegate.FBFriendListArray count];
        NSString *alphabet = [placeIndex objectAtIndex:section];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", alphabet];
        NSArray *places = [infoFeeds filteredArrayUsingPredicate:predicate];
       // NSLog(@"%i",[places count]);
        return [places count]; 
        
    }
    
    
    else if (tableView.tag==185) {
        return 5;
        
    }

    
	
    return 0;
	
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





#pragma mark - FBSessionDelegate Methods

/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
    [self showLoggedIn];
    
    // Save authorization information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[[appDelegate facebook] accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[[appDelegate facebook] expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}
/*
-(void)sendFBPost:(UIButton *)tag
{
    
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    
    NSString *Message = [NSString stringWithFormat:@"-posted via HumSomething iPhone App"];
    NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    Message, @"message", nil];
    NSString *post=[[appDelegate.FBFriendListArray objectAtIndex:tag.tag] objectForKey:@"id"];
    
    [[appDelegate facebook] requestWithGraphPath:[NSString stringWithFormat:@"/%@/feed",post] andParams:params1 andHttpMethod:@"POST" andDelegate:self];
    UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"Message!" message:@"Invitation Send Sucessfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
	[alert release];
}
*/
-(void)logOut
{
	
	
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"FBAccessTokenKey"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"authData"];
	
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
	
	[[NSUserDefaults standardUserDefaults] synchronize];
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        NSString* domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"facebook"];
		
		NSString* domainName1 = [cookie domain];
        NSRange domainRange1 = [domainName1 rangeOfString:@"twitter"];
		
		if(domainRange.length > 0)
        {
            [storage deleteCookie:cookie];
        }
		if(domainRange1.length > 0)
        {
            [storage deleteCookie:cookie];
        }
    }
	[[appDelegate facebook] logout];
}

- (void) showLoggedIn 
{    
    [self apiFQLIMe];
}

- (void) apiFQLIMe 
{
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid,name,birthday,first_name,last_name,current_location,pic,email,sex FROM user WHERE uid=me()", @"query",
                                   nil];
	
    [[appDelegate facebook] requestWithMethodName:@"fql.query"
                                        andParams:params
                                    andHttpMethod:@"POST"
                                      andDelegate:self];
    
   // [[appDelegate facebook] requestWithGraphPath:@"me/feed" andDelegate:self];

    [[appDelegate facebook] requestWithGraphPath:@"me/friends" andDelegate:self];
}

- (void) apiGraphUserPermissions {
	
    [[appDelegate facebook] requestWithGraphPath:@"me/permissions" andDelegate:self];
}

/**
 * Called when a request returns and its response has been parsed into
 * an object. The resulting object may be a dictionary, an array, a string,
 * or a number, depending on the format of the API response. If you need access
 * to the raw response, use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(FBRequest *)request didLoad:(id)result
{
		
    if ([result isKindOfClass:[NSArray class]]) 
	{
        result = [result objectAtIndex:0];
    }
    // This callback can be a result of getting the user's basic
    // information or getting the user's permissions.
     
    if ([result objectForKey:@"name"])
	{
		appDelegate.FbInformationArray = result;
    //    NSLog(@"%@",appDelegate.FbInformationArray);
        appUserFacebookid=[appDelegate.FbInformationArray valueForKey:@"uid"];
       //  NSLog(@"%@",appUserFacebookid);
        [self callregisterFacebookParsing:(NSString *)appUserFacebookid];
         
    }
    
    if ([result objectForKey:@"data"])
	{
       
		appDelegate.FBFriendListArray = [result objectForKey:@"data"];
        
               
        //NSLog(@"%@",appDelegate.FBFriendListArray);
         
       

        
      //  NSLog(@" my array %@",appDelegate.FBFriendListArray);
//        for (int i=0; i<[appDelegate.FBFriendListArray count]; i++) {
//           [infoFeeds addObject:[[appDelegate.FBFriendListArray objectAtIndex:i] valueForKey:@"name"]]; 
//        }
        
        //[infoFeeds addObject:[appDelegate.FBFriendListArray ]];
      //  NSLog(@"%@",infoFeeds);
        
      
        
	}
    //[tvFriends reloadData];
}
//ht tp://humsomething.netsmartz.us/HumServices.svc/updatefbid/intUserID=75,vchFBID=xyz123

-(void)callGetFacebookParsing
{
    //100001788515255
    
  //ht tp://humsomething.netsmartz.us/HumServices.svc/GetUsersToSendFriendRequests/intUserID=84    
    
	NSURLRequest *request = [NSURLRequest requestWithURL:
							 [NSURL URLWithString:[NSString stringWithFormat:@"%@/GetUsersToSendFriendRequests/intUserID=%@",globleUrl,[[myGlobalArray objectAtIndex:0]valueForKey:@"intID"]]]
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

-(void)callregisterFacebookParsing:(NSString *)FBappUser
{
    // Create the Request.
  
    NSLog(@"%@ %@",FBappUser,[[myGlobalArray objectAtIndex:0] valueForKey:@"intID"]);
   // ht tp://humsomething.netsmartz.us/HumServices.svc/updatefbid/intUserID=75,vchFBID=xyz123
    
	NSURLRequest *request = [NSURLRequest requestWithURL:
							 [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/updatefbid/intUserID=%@,vchFBID=%@",[[myGlobalArray objectAtIndex:0]valueForKey:@"intID"],FBappUser]]
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
	HUD.labelText = @"Loading...";
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
	
	//NSLog(@"Response String: \n%@", responseString);
	
	[HUD hide:YES];
	[HUD removeFromSuperview];
    HUD=nil;
	[responseString release];
	
	// Free the connection
	[connection release];
	
    [self parseXML];
    [tvFriends reloadData];
}




// Called when an error occurs in loading the response


- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
	
	//NSLog (@"connection:didFailWithError:");
	
	//NSLog (@"%@",[error localizedDescription]);
	
	// Free the connection
    
    
	[HUD hide:YES];
	[HUD removeFromSuperview];
    HUD=nil;
    
	
	[connection release];
    
	
	
}

//********************************************************* start the parse given xml data ************************************* coded by mohit bisht






- (void) parseXML

{
    
	
//	NSLog (@"parseXML");
	
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
	
	if ([elementName isEqualToString:@"UpdateFBIDResult"])
        
	{
		// We are in an item element
        
        //resultArray=[[NSMutableArray alloc]init];
        
		inItemElement = YES;
        
	}
	if ([elementName isEqualToString:@"ArrayOftblUsers"])
        
	{
		// We are in an item element
        
        resultArray=[[NSMutableArray alloc]init];
        
		inItemElement = YES;
	}
    if ([elementName isEqualToString:@"sendfriendrequestResponse"])
        
	{
		// We are in an item element
        
       // resultArray=[[NSMutableArray alloc]init];
        
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
	//NSLog (@"didEndElement");
	
	// Check to see which element we have ended
	// If we are in an item and ended a title
	
	if (inItemElement && [elementName isEqualToString:@"UpdateFBIDResult"]) 
        
	{
       // [resultArray addObject:capturedCharacters];
        
		// Release the capturedCharacters instance variable
		if ([capturedCharacters isEqualToString:@"Success"]) 
        {
           // NSLog(@"sucessfull upload id");
             [self callGetFacebookParsing];
        }
		[capturedCharacters release];
		capturedCharacters = nil;
        
		 //[self callGetFacebookParsing];
	}
       
    if ([elementName isEqualToString:@"sendfriendrequestResult"]) 
        
	{
        // [resultArray addObject:capturedCharacters];
        
		// Release the capturedCharacters instance variable
		if ([capturedCharacters isEqualToString:@"Success"]) 
        {
            [resultArrayFinal removeAllObjects];
            [resultArray removeAllObjects];
            [arrayFBActiveUser removeAllObjects];
            [fbnewdetail removeAllObjects];
            [infoFeeds removeAllObjects];
            [self callGetFacebookParsing];
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message!" message:[NSString stringWithFormat:@"Friend request sent"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            //[tvFriends reloadData];

        }
		[capturedCharacters release];
		capturedCharacters = nil;
        
        //[self callGetFacebookParsing];
	}
    
    if (inItemElement && [elementName isEqualToString:@"vchFBID"]) 
        
    {
       // if(![capturedCharacters isEqualToString:@""]) 
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
    
    if ([elementName isEqualToString:@"tblUsers"])
        
    {
        NSMutableDictionary *dic;
           // NSLog(@"%@",resultArray);
        if ([resultArray count]>0  && ![[resultArray objectAtIndex:1] isEqualToString:@""]) 
        {
            dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[resultArray objectAtIndex:0],@"intID",[resultArray objectAtIndex:1],@"vchFBID",nil];
            //inItemElement = NO;
            //[resultArray removeAllObjects];
          
            [resultArrayFinal addObject:dic];
          //  NSLog(@"%@",resultArrayFinal);
            
        }  
            [resultArray removeAllObjects]; 

        
    }
    if ([elementName isEqualToString:@"ArrayOftblUsers"])
        
	{
        
        

		// We are in an item element
        
       // resultArray=[[NSMutableArray alloc]init];
        
		inItemElement = YES;
      // NSLog(@"%@",resultArrayFinal);
        
             if([resultArrayFinal  count]==0)
             {
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message!" message:[NSString stringWithFormat:@"No more Facebook friend using this app."] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                 [alert show];
                 [alert release];
             }
                
        for (int i=0; i<[resultArrayFinal count]; i++)
        {
            for (int j=0;j< [appDelegate.FBFriendListArray count]; j++)
            {
                if ([[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:i]valueForKey:@"vchFBID"]] isEqualToString:[NSString stringWithFormat:@"%@",[[appDelegate.FBFriendListArray objectAtIndex:j]valueForKey:@"id"]]] )
                {
                    [arrayFBActiveUser addObject:[appDelegate.FBFriendListArray objectAtIndex:j]];
                    [fbnewdetail addObject:[resultArrayFinal objectAtIndex:i]];
                }
            }
            
        }
        
        
     //   NSLog(@"%@",fbnewdetail) ;
        
        
        [arrayFBActiveUser setArray:[[NSSet setWithArray:arrayFBActiveUser] allObjects]];
        infoFeeds=[[NSMutableArray alloc]initWithArray:[arrayFBActiveUser valueForKey:@"name"]];
        
        placeIndex = [[NSMutableArray alloc] init];
        
        for (int i=0; i<[infoFeeds count]; i++)
        {
            char alphabet = [[infoFeeds	objectAtIndex:i] characterAtIndex:0];
            NSString *uniChar = [NSString stringWithFormat:@"%C", alphabet];
            if (![placeIndex containsObject:uniChar])
            {           
                [placeIndex addObject:uniChar];
                
            }   
        }
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:TRUE];
        [placeIndex sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [sortDescriptor release];
        

       // NSLog(@"%@",arrayFBActiveUser);
        
      //  [tvFriends reloadData];
	}
    
    
    
        // NSLog(@"%@",resultArray);
	
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


-(void)viewWillAppear:(BOOL)animated
{
    
    
    
    [self.navigationItem setHidesBackButton: YES animated:NO];
    
    [lblCoins setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intCoins"]] ;
    [lblDinamite setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intSticks"]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125.0,0.0, 280.0, 44.0)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont boldSystemFontOfSize:18.0f]];
     [label setAdjustsFontSizeToFitWidth:YES];
    [label setText:@"Invite Friends from Facebook"];
    label.lineBreakMode=UILineBreakModeWordWrap;
    label.numberOfLines=0;
    [label setTextAlignment:UITextAlignmentLeft];
    [label setTextColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];   
    [label setTextAlignment:UITextAlignmentCenter];
    [[self navigationItem] setTitleView:label];
    [label release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     resultArrayFinal=[[NSMutableArray alloc]init];
     fbnewdetail=[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
    arrayFBActiveUser=[[NSMutableArray alloc]init];
    
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
    

    appDelegate = (HumSomethingAppDelegate *)[[UIApplication sharedApplication] delegate];

    tvFriends=[[UITableView alloc]initWithFrame:CGRectMake(10,65, 300,350) style:UITableViewStylePlain];
    tvFriends.backgroundColor =[UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    tvFriends.layer.cornerRadius =6.0;
    tvFriends.layer.borderColor = [UIColor whiteColor].CGColor;
	tvFriends.layer.borderWidth = 1.0; //#import <QuartzCore/QuartzCore.h>
    tvFriends.separatorColor= [UIColor colorWithRed:255.0f/255.0f green:168.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
    tvFriends.tag=1;
    tvFriends.showsVerticalScrollIndicator=NO;
    [self.view addSubview:tvFriends];
    
    [tvFriends setDelegate:self];
    [tvFriends setDataSource:self];
    [tvFriends release];
   // [self logOut];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        [appDelegate facebook].accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        [appDelegate facebook].expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    if (![[appDelegate facebook] isSessionValid])
    {
        [appDelegate facebook].sessionDelegate = self;
        appDelegate.userPermissions = [[NSArray alloc] initWithObjects:
                                       @"read_stream", @"publish_stream", @"email", @"offline_access",@"friends_checkins",@"friends_about_me",@"user_games_activity",nil];
        
        [[appDelegate facebook] authorize:appDelegate.userPermissions];
        // [[appDelegate facebook] authorize:permissions];
    } 
    else {
        [self showLoggedIn];
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



-(void)viewWillDisappear:(BOOL)animated
{
    [myView setHidden:YES];
}

-(void)invitefriend:(UIButton *)tag
{
    
    //ht tp://humsomething.netsmartz.us/HumServices.svc/addfriend/UserID=1,FriendID=20
    // Create the Request.
   
    NSString *strFBID=[[NSString alloc]init];
    //NSLog(@"==>%@",resultArrayFinal);
    for (int i=0; i<[resultArrayFinal count]; i++)
    {
       if([[ [arrayFBActiveUser objectAtIndex:tag.tag]valueForKey:@"id"] isEqualToString:[[resultArrayFinal objectAtIndex:i]valueForKey:@"vchFBID"]])
       {
           strFBID=[[resultArrayFinal objectAtIndex:i]valueForKey:@"intID"];
           break;
       }
    }
   
  //  ht tp://humsomething.netsmartz.us/HumServices.svc/sendfriendrequest/intFromID=84,intToID=100
    
    
   // NSLog(@"user id=%@ friendId=%@",[[myGlobalArray objectAtIndex:0]valueForKey:@"intID"],strFBID);
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/sendfriendrequest/intFromID=%@,intToID=%@",[[myGlobalArray objectAtIndex:0]valueForKey:@"intID"],strFBID]]
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


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
