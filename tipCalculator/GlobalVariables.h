//
//  GlobalVariables.h
//  tipCalculator
//
//  Created by Alberto Campos on 12/14/13.
//  Copyright (c) 2013 CampOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVariables : NSObject{
    
    NSString *globalStr;
    
}

@property(nonatomic, strong) NSString *globalStr;

+(GlobalVariables *) singleObj;

@end
