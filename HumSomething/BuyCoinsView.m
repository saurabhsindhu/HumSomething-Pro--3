//
//  BuyCoinsView.m
//  HumSomething
//
//  Created by Pravesh Uniyal on 12/07/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BuyCoinsView.h"
#import <QuartzCore/QuartzCore.h>
#import "ChangeProfilePicViewController.h"
#import "MainHeaderFile.h"
#import "InAppRageIAPHelper.h"
#import "Reachability.h"

static bool hasAddObserver=NO;
@implementation BuyCoinsView
@synthesize userIdString;
@synthesize responseData,resultArrayFinal;
@synthesize sw,privacyStatus;
@synthesize lblCoins;



@synthesize productIdentifiers = _productIdentifiers;
@synthesize products = _products;
@synthesize purchasedProducts = _purchasedProducts;
@synthesize request = _request;


- (void)dismissHUD:(id)arg {
    
     [HUD hide:YES];
     [HUD removeFromSuperview];
     HUD=nil;

    
}

- (void)timeout:(id)arg {
    
        [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:3.0];
    
}

- (void)updateInterfaceWithReachability: (Reachability*) curReach {
    
    
    
}
- (void)productsLoaded:(NSNotification *)notification {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
   // [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    tvBuyCoins.hidden = FALSE;    
    [HUD hide:YES];
    [HUD removeFromSuperview];
    HUD=nil;
    [tvBuyCoins reloadData];
    
}

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    saveresult =[[NSMutableArray alloc]init];
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
 coinImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,44)];
    coinImage.backgroundColor = [UIColor clearColor];
    [coinImage setImage:[UIImage imageNamed:@"coinImg@2x.png"]];
    [self.view addSubview:coinImage];
    
    // add a label on imageview
    lblCoins=[[UILabel alloc]init];
    lblCoins.frame=CGRectMake(35, 10,80, 25);
    
    lblCoins.textColor=[UIColor blackColor];
    lblCoins.backgroundColor=[UIColor clearColor];
    [self.view addSubview:lblCoins];
    //[self.view bringSubviewToFront:lblCoins];
    
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
    
    // Create tableview
    
    tvBuyCoins = [[UITableView alloc]initWithFrame:CGRectMake(20, 109, 280, 250) style:UITableViewStylePlain];
    tvBuyCoins.layer.cornerRadius =10.0;
    tvBuyCoins.backgroundColor =[UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:187.0f/255.0f alpha:1.0f];
  
    tvBuyCoins.tag=1;
    tvBuyCoins.delegate=self;
    tvBuyCoins.dataSource=self;
    [tvBuyCoins setScrollEnabled:NO];
    [self.view addSubview:tvBuyCoins];
    [tvBuyCoins release];
    
    
    
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



#pragma mark - TableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag==1) {
        
        if (indexPath.row==0) {
            return 62.5f;
        }
        else if(indexPath.row==1){
            return 62.5f;
        }
        
        else if(indexPath.row==2){
            return 62.5f;
        }
        else if(indexPath.row==3){
            return 62.5f;
        }

    }
    
    else if (tableView.tag==185)
    {
        return 40;
        
    }

    return 0;
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    
    
    if (tableView.tag==1) {
        return [[InAppRageIAPHelper sharedHelper].products count];
        
    }
    
    
    else if (tableView.tag==185) {
        return 5;
        
    }
    return 0;
}


                
                
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
    

    
    if (tableView.tag==1) {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
               
    }
    else
    {
        UIView *subview;
		while ((subview= [[[cell contentView]subviews]lastObject])!=nil) 		
            [subview removeFromSuperview];
        
    } 
        if ([resultArrayFinal count])
        {
          
       
        if(indexPath.row==0){
            
            UILabel*topLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(55 ,15 ,70, 15)];
            topLabel1.font = [UIFont fontWithName:@"Helvetica-bold" size:12.0];
            topLabel1.textColor = [UIColor blackColor];
            topLabel1.backgroundColor=[UIColor clearColor];
            topLabel1.text=[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:indexPath.row]valueForKey:@"intCoins"]];
            [cell.contentView addSubview:topLabel1];
   
            UIImageView *cellCoinsImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15,30, 30)];
            cellCoinsImage.image=[UIImage imageNamed:@"coins_all.png"];
            [cell addSubview:cellCoinsImage];
            // Configure the cell.
            SKProduct *product = [[InAppRageIAPHelper sharedHelper].products objectAtIndex:indexPath.row];
 
                UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
                buyButton.frame = CGRectMake(202,15,61,30);
            [buyButton setBackgroundImage:[UIImage imageNamed:@"btn_button@2x.png"] forState: UIControlStateNormal] ;
            //            btnStore1.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:14]; 
                [buyButton setTitle:[NSString stringWithFormat:@"$%@",product.price] forState:UIControlStateNormal];
                buyButton.tag = indexPath.row;
            [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [buyButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
               [cell.contentView addSubview:buyButton];    
               

        }

            
        else if(indexPath.row==1)
        {
          
    UILabel*topLabel = [[UILabel alloc]initWithFrame:CGRectMake(55 ,15 ,70, 15)];
    topLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:12.0];
    topLabel.textColor = [UIColor blackColor];
    topLabel.backgroundColor=[UIColor clearColor];
    topLabel.text=[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:indexPath.row]valueForKey:@"intCoins"] ];
    [cell.contentView addSubview:topLabel];
    
    UILabel*topLabel10 = [[UILabel alloc]initWithFrame:CGRectMake(57 ,32 ,70, 15)];
    topLabel10.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    topLabel10.textColor = [UIColor blackColor];
    topLabel10.backgroundColor=[UIColor clearColor];
    topLabel10.text=[NSString stringWithFormat:@"Save %@%@",[saveresult objectAtIndex:indexPath.row-1],@"%"] ;
    [cell.contentView addSubview:topLabel10];
  
            SKProduct *product = [[InAppRageIAPHelper sharedHelper].products objectAtIndex:indexPath.row];
            
            UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
            buyButton.frame = CGRectMake(202,15,61,30);
            [buyButton setBackgroundImage:[UIImage imageNamed:@"btn_button@2x.png"] forState: UIControlStateNormal] ;
            //            btnStore1.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:14]; 
            [buyButton setTitle:[NSString stringWithFormat:@"$%@",product.price] forState:UIControlStateNormal];
            buyButton.tag = indexPath.row;
            [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

            [buyButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
             [cell.contentView addSubview:buyButton];    
            
      
       UIImageView *cellCoinsImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15,30, 30)];
    cellCoinsImage.image=[UIImage imageNamed:@"coins_all.png"];
    [cell addSubview:cellCoinsImage];

        } 
        else if(indexPath.row==2)
        {
            
            UILabel*topLabel = [[UILabel alloc]initWithFrame:CGRectMake(55 ,15 ,70, 15)];
            topLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:12.0];
            topLabel.textColor = [UIColor blackColor];
            topLabel.backgroundColor=[UIColor clearColor];
            topLabel.text=[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:indexPath.row]valueForKey:@"intCoins"] ];
            [cell.contentView addSubview:topLabel];
            
            UILabel*topLabel10 = [[UILabel alloc]initWithFrame:CGRectMake(57 ,32 ,70, 15)];
            topLabel10.font = [UIFont fontWithName:@"Helvetica" size:12.0];
            topLabel10.textColor = [UIColor blackColor];
            topLabel10.backgroundColor=[UIColor clearColor];
            topLabel10.text=[NSString stringWithFormat:@"Save %@%@",[saveresult objectAtIndex:indexPath.row-1],@"%"] ;
            [cell.contentView addSubview:topLabel10];
            
            SKProduct *product = [[InAppRageIAPHelper sharedHelper].products objectAtIndex:indexPath.row];
            
            UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
            buyButton.frame = CGRectMake(202,15,61,30);
            [buyButton setBackgroundImage:[UIImage imageNamed:@"btn_button@2x.png"] forState: UIControlStateNormal] ;
            //            btnStore1.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:14]; 
            [buyButton setTitle:[NSString stringWithFormat:@"$%@",product.price] forState:UIControlStateNormal];
            buyButton.tag = indexPath.row;
            [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

            [buyButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
             [cell.contentView addSubview:buyButton];
            
            
            UIImageView *cellCoinsImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15,30, 30)];
            cellCoinsImage.image=[UIImage imageNamed:@"coins_all.png"];
            [cell addSubview:cellCoinsImage];
            
        } 
        else if(indexPath.row==3)
        {
            
            UILabel*topLabel = [[UILabel alloc]initWithFrame:CGRectMake(55 ,15 ,70, 15)];
            topLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:12.0];
            topLabel.textColor = [UIColor blackColor];
            topLabel.backgroundColor=[UIColor clearColor];
            topLabel.text=[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:indexPath.row]valueForKey:@"intCoins"] ];
            [cell.contentView addSubview:topLabel];
            
            UILabel*topLabel10 = [[UILabel alloc]initWithFrame:CGRectMake(57 ,32 ,70, 15)];
            topLabel10.font = [UIFont fontWithName:@"Helvetica" size:12.0];
            topLabel10.textColor = [UIColor blackColor];
            topLabel10.backgroundColor=[UIColor clearColor];
            topLabel10.text=[NSString stringWithFormat:@"Save %@%@",[saveresult objectAtIndex:indexPath.row-1],@"%"] ;
            [cell.contentView addSubview:topLabel10];
            
            SKProduct *product = [[InAppRageIAPHelper sharedHelper].products objectAtIndex:indexPath.row];
            
            UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
            buyButton.frame = CGRectMake(202,15,61,30);
            [buyButton setBackgroundImage:[UIImage imageNamed:@"btn_button@2x.png"] forState: UIControlStateNormal] ;
            //            btnStore1.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:14]; 
            [buyButton setTitle:[NSString stringWithFormat:@"$%@",product.price] forState:UIControlStateNormal];
            buyButton.tag = indexPath.row;
            [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

            [buyButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:buyButton];    
            
            
            UIImageView *cellCoinsImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15,30, 30)];
            cellCoinsImage.image=[UIImage imageNamed:@"coins_all.png"];
            [cell addSubview:cellCoinsImage];
            
        } 
        }
    return  cell;
           }
    
    
}


- (IBAction)buyButtonTapped:(id)sender
{
                    
                    UIButton *buyButton = (UIButton *)sender;    
                    SKProduct *product = [[InAppRageIAPHelper sharedHelper].products objectAtIndex:buyButton.tag];
    NSLog(@"%i",buyButton.tag);
    strCoinUpdate=[[resultArrayFinal objectAtIndex:buyButton.tag]valueForKey:@"intCoins"];
                    NSLog(@"Buying %@...", product.productIdentifier);
                    [[InAppRageIAPHelper sharedHelper] buyProductIdentifier:product.productIdentifier];
             NSLog(@"%@",strCoinUpdate);        
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	HUD.labelText = @"buying...";
	[HUD show:YES];  
    [self performSelector:@selector(timeout:) withObject:nil afterDelay:5];
                    
}
                
- (void)productPurchased:(NSNotification *)notification
{
                    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
                     
                    
    NSString *productIdentifier = (NSString *) notification.object;
    NSLog(@"Purchased: %@", productIdentifier);
    
 

    
                    [tvBuyCoins reloadData];    
                    
}
                
- (void)productPurchaseFailed:(NSNotification *)notification {
                    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
                                    
    SKPaymentTransaction * transaction = (SKPaymentTransaction *) notification.object;    
    if (transaction.error.code != SKErrorPaymentCancelled) {    
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error!" 
                                                message:transaction.error.localizedDescription 
                                                delegate:nil 
                                                               cancelButtonTitle:nil 
                                                               otherButtonTitles:@"OK", nil] autorelease];
                        
                        [alert show];
        }
                    
    }


-(void)callRequestParsing
{
   // h ttp://humsomething.netsmartz.us/HumServices.svc/getCoinstobuy
    
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/getCoinstobuy"]]
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

-(void)callCoinUpdateParsing:(NSString *)strCoin
{
    NSLog(@"%@ strconds",strCoin);
    //ht tp://humsomething.netsmartz.us/HumServices.svc/updateusercoins/intUserID=117,intCoins=15
    
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"http://humsomething.netsmartz.us/HumServices.svc/updateusercoins/intUserID=%@,intCoins=%@",[[myGlobalArray objectAtIndex:0]valueForKey:@"intID"],strCoin]]
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





-(void)viewWillAppear:(BOOL)animated
{
    
     [super viewWillAppear:YES];
    
    [self.navigationItem setHidesBackButton: YES animated:NO];
    
    [lblCoins setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intCoins"]] ;
    [lblDinamite setText:[[myGlobalArray objectAtIndex:0]valueForKey:@"intSticks"]];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80.0,0.0, 180.0, 35.0)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:@"Arial" size:18.0f]];
    [label setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [label setAdjustsFontSizeToFitWidth:YES];
    [label setText:@"Buy Coins"];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor colorWithRed:166.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f]];
    [[self navigationItem] setTitleView:label];
    [label release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productsLoaded:) name:kProductsLoadedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:kProductPurchasedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(productPurchaseFailed:) name:kProductPurchaseFailedNotification object: nil];
    
    // Reachability *reach = [Reachability reachabilityForInternetConnection];	
    // NetworkStatus netStatus = [reach currentReachabilityStatus];    
    //    if (netStatus == NotReachable) {        
    //        NSLog(@"No internet connection!");        
    //    } else {        
    if ([InAppRageIAPHelper sharedHelper].products == nil) {
        
        [[InAppRageIAPHelper sharedHelper] requestProducts];
        //            
        //            HUD = [[MBProgressHUD alloc] initWithView:self.view];
        //            [self.view addSubview:HUD];
        //            HUD.labelText = @"Loading...";
        //            [HUD show:YES];  
        //            [self performSelector:@selector(timeout:) withObject:nil afterDelay:10.0];
        
        // }        
    }

    
    //[tvBuyCoins reloadData];
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
    [self.view bringSubviewToFront:HUD];
    [self.responseData setLength:0];
    
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
    
    NSLog(@"Response String: \n%@", responseString);
    
    [responseString release];
    
    // Free the connection
    [connection release];
    
    
    [HUD hide:YES];
    [HUD removeFromSuperview];
    HUD=nil;
    
    
    
    [self parseXML];
    [tvBuyCoins reloadData];
        
    
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
    // (@"didStartElement");
    
    // Check to see which element we have found
    
    
    
    if ([elementName isEqualToString:@"ArrayOfBuyCoinsTable"])
        
    {
        // We are in an item element
        
        resultArray=[[NSMutableArray alloc]init];
        
        inItemElement = YES;
    }
    if ([elementName isEqualToString:@"updateusercoinsResponse"])
        
    {
        // We are in an item element
        
     //   resultArray=[[NSMutableArray alloc]init];
        
        inItemElement = YES;
    }
    // If we are in an item and found a title
    
    if (inItemElement) {
        
        capturedCharacters = [[NSMutableString alloc]init];
    }
    if ([elementName isEqualToString:@"ArrayOftblUsers"])
        
	{
		// We are in an item element
        
        resultArray=[[NSMutableArray alloc]init];
        
		inItemElement = YES;
	}
    if ([elementName isEqualToString:@"BuyCoinsTable"])
        
    {
        
        // Initialize the capturedCharacters instance variable
        
        // capturedCharacters = [[NSMutableString alloc]init];
        
    }
    
}


// Called when the parser encounters an end element

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 

{
    // (@"didEndElement");
    
    
    
    
    
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
    

    
    if ([elementName isEqualToString:@"updateusercoinsResult"]) 
        
    {
        if ([capturedCharacters isEqualToString:@"Success"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message!" message:@"Coins update successfully" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            [alert release]; 
            
            [self callLoginParsing];
        }
        
        [capturedCharacters release];
        capturedCharacters = nil;
        
    }
    if ([elementName isEqualToString:@"updateusercoinsResponse"]) 
        
    {
   
    }
    
    
    if ([elementName isEqualToString:@"ArrayOftblUsers"])
        
	{
		// We are no longer in an item element
        NSMutableDictionary *dic;
            NSLog(@"%@",resultArray);
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

    
    
    // Check to see which element we have ended
    // If we are in an item and ended a title
    
       if (inItemElement && [elementName isEqualToString:@"dblPrice"]) 
        
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
    
    if (inItemElement && [elementName isEqualToString:@"vchText"])
        
    {
        [resultArray addObject:capturedCharacters];
        
        // Release the capturedCharacters instance variable
        
        [capturedCharacters release];
        capturedCharacters = nil;
        
    }
       
    if ([elementName isEqualToString:@"BuyCoinsTable"])
        
    {
        NSMutableDictionary *dic;
        //    NSLog(@"%@",resultArray);
        if ([resultArray count]>0) 
        {
            dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[resultArray objectAtIndex:0],@"dblPrice",[resultArray objectAtIndex:1],@"intCoins",[resultArray objectAtIndex:2],@"intID",[resultArray objectAtIndex:3],@"vchText",nil];
            //inItemElement = NO;
            [resultArray removeAllObjects];
            [resultArrayFinal addObject:dic];
            //(@"count final %i",[resultArrayFinal count]);
            
            firstcoinValue=[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:0] valueForKey:@"intCoins"]];
              p=[firstcoinValue floatValue];
            firstbuttonValue=[NSString stringWithFormat:@"%@",[[resultArrayFinal objectAtIndex:0]valueForKey:@"dblPrice"]];
            q=[firstbuttonValue floatValue];
            //(@"coins %@ price %@",firstcoinValue,firstbuttonValue);
            [tvBuyCoins reloadData];
            
        }
    }
        
        if ([elementName isEqualToString:@"ArrayOfBuyCoinsTable"])
            
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
                //(@"save %@",saveresult);
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
        //(@"%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"SoundStatus" ] );
        
	}
	else {
        [[NSUserDefaults standardUserDefaults] setObject:@"OFF"  forKey:@"SoundStatus"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
		privacyStatus = @"1";
	}    
    //[self localPrivacyChange];
}


///////iAP======


- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers {
    if ((self = [super init])) {
        
        // Store product identifiers
        _productIdentifiers = [productIdentifiers retain];
        
        //        // Check for previously purchased products
        //        NSMutableSet * purchasedProducts = [NSMutableSet set];
        //        for (NSString * productIdentifier in _productIdentifiers) {
        //            BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
        //            if (productPurchased) {
        //                [purchasedProducts addObject:productIdentifier];
        //                NSLog(@"Previously purchased: %@", productIdentifier);
        //            }
        //            NSLog(@"Not purchased: %@", productIdentifier);
        //        }
        //        self.purchasedProducts = purchasedProducts;
        //                        
    }
    return self;
}

- (void)requestProducts {
    
    self.request = [[[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers] autorelease];
    _request.delegate = self;
    [_request start];
    
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    NSLog(@"Received products results...");   
    self.products = response.products;
    self.request = nil;    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kProductsLoadedNotification object:_products];    
}

- (void)recordTransaction:(SKPaymentTransaction *)transaction {    
    // TODO: Record the transaction on the server side...   
    
    
}

- (void)provideContent:(NSString *)productIdentifier
{
    
    NSLog(@"Toggling flag for: %@", productIdentifier);
    [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:productIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_purchasedProducts addObject:productIdentifier];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kProductPurchasedNotification object:productIdentifier];
    
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"completeTransaction...");
    
    [self recordTransaction: transaction];
    [self provideContent: transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    NSLog(@"finisht");
    NSLog(@"%@ trCoinUpdate",strCoinUpdate);
    [self callCoinUpdateParsing:strCoinUpdate];
    [HUD hide:YES];
    [HUD removeFromSuperview];
    HUD=nil;
    
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"restoreTransaction...");
    
    [self recordTransaction: transaction];
    [self provideContent: transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    // [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kProductPurchaseFailedNotification object:transaction];
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
            default:
                break;
        }
    }
}

- (void)buyProductIdentifier:(NSString *)productIdentifier {
    
    NSLog(@"Buying %@...", productIdentifier);
    if (!hasAddObserver) {//flag to fix this bug
        /*=====================================*/
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        hasAddObserver=YES;
    }
    SKPayment *payment = [SKPayment paymentWithProductIdentifier:productIdentifier];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}





- (void)dealloc
{
    
    [_productIdentifiers release];
    _productIdentifiers = nil;
    [_products release];
    _products = nil;
    [_purchasedProducts release];
    _purchasedProducts = nil;
    [_request release];
    _request = nil;
    [super dealloc];
}


////////

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
