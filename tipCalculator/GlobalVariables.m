//
//  GlobalVariables.m
//  tipCalculator
//
//  Created by Alberto Campos on 12/14/13.
//  Copyright (c) 2013 CampOS. All rights reserved.
//

#import "GlobalVariables.h"

@implementation GlobalVariables

@synthesize globalStr;


static GlobalVariables *singleObj = nil;

+ (GlobalVariables *) singleObj{
    @synchronized(self){
        if (singleObj==nil){
            singleObj = [[self alloc]init];
        }
    }
    return singleObj;
}
@end
