//
//  DataService.m
//  Beats Chaser
//
//  Created by Jerry Lai on 2021-05-15.
//

#import "DataService.h"

@implementation DataService

+ (instancetype)sharedInstance{
    static DataService *sharedInstance = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        sharedInstance = [[DataService alloc]init];
    });
    
    return sharedInstance;
}

@end
