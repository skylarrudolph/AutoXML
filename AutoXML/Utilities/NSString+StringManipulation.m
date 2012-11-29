//
//  NSString+StringManipulation.m
//  AutoXML
//
//  Created by Skylar Rudolph on 11/28/12.
//  Copyright (c) 2012 Temple. All rights reserved.
//

#import "NSString+StringManipulation.h"

@implementation NSString (StringManipulation)
-(BOOL)isEmptyOrWhiteSpace{
    if ([self length]==0) {
        return YES;
    }
    if([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0){
        return YES;
    }
    return NO;
}
@end
