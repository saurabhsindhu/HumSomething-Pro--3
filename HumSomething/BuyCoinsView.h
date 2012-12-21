//
//  BuyCoinsView.h
//  HumSomething
//
//  Created by Pravesh Uniyal on 12/07/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalVars.h"
#import "MainHeaderFile.h"
#import"DataClass.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"


#import "StoreKit/StoreKit.h"

#define kProductsLoadedNotification         @"ProductsLoaded"
#define kProductPurchasedNotification       @"ProductPurchased"
#define kProductPurchaseFailedNotification  @"ProductPurchaseFailed"


@interface BuyCoinsView : UIViewController <UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate,SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    
     UITableView *tvBuyCoins;
    NSString *userIdString;
    NSMutableArray *resultArray;
    NSMutableString *capturedCharacters;
    BOOL inItemElement;
    NSMutableArray *resultArrayFinal;
    NSMutableArray * saveresult;
    NSString *firstcoinValue;
    NSString *firstbuttonValue;
      AVAudioPlayer*  audioPlayer;
    float p,q,r,s,m,n,o;
    int z;
    //setting button////
    UIWindow *keyValue;
    UISwitch *sw;
    NSString *privacyStatus;
    UIView *myView;
	UITableView *table;
    UIView *myview;
    UILabel *lblCoins;
    UILabel *lblDinamite;
    NSArray *iapBuyCoin;
     MBProgressHUD *HUD;
   
    UIImageView *coinImage;
    ////
    NSSet * _productIdentifiers;    
    NSArray * _products;
    NSMutableSet * _purchasedProducts;
    SKProductsRequest * _request;
    
}
@property(nonatomic,retain) UILabel *lblCoins;

@property(nonatomic,retain) NSString *userIdString;
@property (nonatomic,retain) NSMutableData *responseData;
@property(nonatomic,retain) NSMutableArray *resultArrayFinal;

@property (nonatomic, retain) NSString *privacyStatus;
@property (nonatomic, retain) UISwitch *sw;
CGPoint vectorBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);
CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) ;
CGFloat angleBetweenCGPoints(CGPoint firstPoint, CGPoint secondPoint);


- (void) parseXML;
-(void)playSound;



@property (retain) NSSet *productIdentifiers;
@property (retain) NSArray * products;
@property (retain) NSMutableSet *purchasedProducts;
@property (retain) SKProductsRequest *request;

- (void)requestProducts;
- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;
- (void)buyProductIdentifier:(NSString *)productIdentifier;


@end
