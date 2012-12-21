//
//  DataClass.m
//  PhotoShare3
//
//  Created by J K  MENON on 29/03/12.
//  Copyright (c) 2012 INTERWORLD COMMNET. All rights reserved.
//

#import "DataClass.h"

@implementation DataClass    
@synthesize checkSetting,userImage;    
static DataClass *instance =nil;    
+(DataClass *)getInstance    
{    
    @synchronized(self)    
    {    
        if(instance==nil)    
        {    
            
            instance= [DataClass new];    
        }    
    }    
    return instance;    
}  
@end
