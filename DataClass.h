//
//  DataClass.h
//  PhotoShare3
//
//  Created by J K  MENON on 29/03/12.
//  Copyright (c) 2012 INTERWORLD COMMNET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface DataClass : NSObject {    
    
    
   // NSString *globleUrl;
    NSString *checkSetting;
    UIImage *userImage;
// CLLocation *UserCurrentLocation;
} 
@property(nonatomic,retain) NSString *checkSetting;
//@property(nonatomic,retain) CLLocation *UserCurrentLocation;
@property(nonatomic,retain)UIImage *userImage;

+(DataClass*)getInstance;    
@end  