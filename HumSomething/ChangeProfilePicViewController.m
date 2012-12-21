//
//  ChangeProfilePicViewController.m
//  HumSomething
//
//  Created by Mohit Bisht on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChangeProfilePicViewController.h"
#import "ASIFormDataRequest.h"
#import"GlobalVars.h"
#import <QuartzCore/QuartzCore.h>
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "MainHeaderFile.h"
@interface ChangeProfilePicViewController ()

@end

@implementation ChangeProfilePicViewController
@synthesize imgUpdatePicture;

@synthesize sw,privacyStatus;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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

    
    // Do any additional setup after loading the view from its nib.
     cameraImageView =[[UIImageView alloc]init];
    DataClass *obj=[DataClass getInstance];  
    //obj.str;  
   
    
    UIView *registerView=[[UIView alloc]initWithFrame:CGRectMake(10, 40,300,295)];//315
    registerView.backgroundColor=[UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
    registerView.userInteractionEnabled=YES;
    registerView.layer.cornerRadius =6.0;
    registerView.layer.borderColor = [UIColor whiteColor].CGColor;
	registerView.layer.borderWidth = 1.0; //#import <QuartzCore/QuartzCore.h>
    [self.view addSubview:registerView];
    

    updateButton = [[UIButton alloc] initWithFrame:CGRectMake(36, 280, 99, 28)];
	[updateButton setBackgroundImage:[UIImage imageNamed:@"update@2x.png"] forState:UIControlStateNormal];
	[updateButton addTarget:self action:@selector(updateButtonClicked4) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:updateButton];
	[updateButton release];
    
    img_UserPic=[[UIImageView alloc]initWithFrame:CGRectMake(110, 100, 80,80)];
    [img_UserPic setImage:[UIImage imageNamed:@"defaultImage@2x"]];
    [registerView addSubview:img_UserPic];
    [img_UserPic setImageWithURL:[NSURL URLWithString:[[myGlobalArray objectAtIndex:0]valueForKey:@"vchImage"]] placeholderImage:[UIImage imageNamed:@"defaultSmall@2x.png"]];

    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(179, 280, 99, 28)];
	[cancelButton setBackgroundImage:[UIImage imageNamed:@"cacel@2x.png"] forState:UIControlStateNormal];
	[cancelButton addTarget:self action:@selector(cancelbtnClicked) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:cancelButton];
    [cancelButton release];
    
    btn_Browse = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Browse.frame = CGRectMake(110,180,80,26);
    [btn_Browse setImage:[UIImage imageNamed:@"Browse@2x.png"] forState:UIControlStateNormal]; 
    [btn_Browse addTarget:self action:@selector(browseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [registerView addSubview:btn_Browse];
    
     

}
-(void)cancelbtnClicked
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    
        
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)updateButtonClicked4
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }

    [self callImagesendParsing:[[myGlobalArray objectAtIndex:0]valueForKey:@"intID"]];

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
    [label setText:@"Change Profile Pic"];
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

    
//    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Hole_Punch-Simon_Craggs-1910998415" ofType:@"mp3"];
//    SystemSoundID soundID;
//    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
//    AudioServicesPlaySystemSound (soundID);
//    //[soundPath release];
//    NSLog(@"soundpath retain count: %d", [soundPath retainCount]);
    
    
    
}
-(void)browseBtnClick
{
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus"] isEqualToString:@"ON"])
    {
        [self playSound]; 
    }
    
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
            // [self.view addSubview:picker.view];
            
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
	}
       
    else 
    {
        [self callAlertView:@"Message" message:@"Device doesn't support camera"];
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
		
	}
	else {
		
	}
	
    [picker dismissModalViewControllerAnimated:YES];
    //[picker.view removeFromSuperview];
    img_UserPic.image=cameraImageView.image;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker1
{
    [picker dismissModalViewControllerAnimated:YES];
    //[picker.view removeFromSuperview];
    
}

#pragma mark --------------------------------------------------------------------------------------------
#pragma mark ------------------------------   Call Alert Method Methods  --------------------------------
#pragma mark --------------------------------------------------------------------------------------------

-(void)callImagesendParsing:(NSString *)strID
{
    NSString *urlString =[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/updateimage/intUserID=%@",strID];
    
    
    NSURL *url = [NSURL URLWithString: urlString];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setUseKeychainPersistence:YES];
  //  NSLog(@"%@ %@",imgProfile.image,strID);
    //  UIImage * image = [[UIImage imageNamed:@"SelectImage.png"] autorelease];
    NSData *imageData = UIImageJPEGRepresentation(img_UserPic.image, 90);
    [request setPostBody:imageData];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestFinished:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    
    [request startAsynchronous];
    
    
    
}
- (void)requestFinished:(ASIHTTPRequest *)request {
	
	NSString *receivedString = [request responseString];
    	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Message!" message:@"Image successfully uploaded" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        
    	[alertView show];
    	[alertView release];
    //    
    //NSLog(@"response %@",receivedString);
}   


- (void)requestFailed:(ASIHTTPRequest *)request 
{
	
    receivedString = [request responseString];
    //	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Message" message:receivedString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    //	[alertView show];
    //	[alertView release];
   // NSLog(@"response %@",receivedString);
    
    //NSLog(@"failed");
}


-(void) callAlertView :(NSString *)titlemessage message:(NSString *)msg
{
	UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:titlemessage message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[errorAlert show];
	[errorAlert release];
    
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
    [self setImgUpdatePicture:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [imgUpdatePicture release];
    [super dealloc];
}
@end
