//
//  InAppRageIAPHelper.m
//  InAppRage
//
//  Created by Ray Wenderlich on 2/28/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//

#import "InAppRageIAPHelper.h"

@implementation InAppRageIAPHelper

static InAppRageIAPHelper * _sharedHelper;

+ (InAppRageIAPHelper *) sharedHelper {
    
    if (_sharedHelper != nil) {
        return _sharedHelper;
    }
    _sharedHelper = [[InAppRageIAPHelper alloc] init];
    return _sharedHelper;
    
}

- (id)init {
    
   // NSSet *productIdentifiers = [NSSet setWithObjects:
                                // @"com.innovative.demoIAPTest.DemoPrice",@"com.innovative.demoIAPTest.DemoPrice2",@"com.innovative.demoIAPTest.DemoPrice3",@"com.innovative.demoIAPTest.DemoPrice4",nil];
    
    
    NSLog(@"%@ sharelaa",lblCoins.text);
    NSSet *productIdentifiers = [NSSet setWithObjects:
                                 @"com.shindler.testiapdemo.coindemo1",@"com.shindler.testiapdemo.coindemo2",nil];
//    com.shindler.testiapdemo.coindemo1
//    com.shindler.testiapdemo.coindemo2
    
    if ((self = [super initWithProductIdentifiers:productIdentifiers])) {                
        
    }
    return self;
    
}

@end
