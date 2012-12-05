//
//  NSMutableDictionary+DictionaryManipulation.m
//  AutoXML
//
//  Created by Skylar Rudolph on 12/5/12.
//  Copyright (c) 2012 Temple. All rights reserved.
//

#import "NSMutableDictionary+DictionaryManipulation.h"

@implementation NSMutableDictionary (DictionaryManipulation)
// For this function, all I want to be able to do is return a data type for a given key in the dictionary. Whether this value is a NSMutableArray or NSMutableDictionary is still unknown.
-(id)getObjectForKey:(NSString*)key{
//    NSLog(@"%@", [self allValues]);
    for(NSString* allKeys in [self allKeys]){
        if([allKeys isEqualToString:key]){
            return [self valueForKey:allKeys];
        }
        //        NSLog(@"%@", [self valueForKey:allKeys]);
        if([[self valueForKey:allKeys]objectForKey:key]!=nil){
            NSLog(@"I believe we found it.");
            return [[self valueForKey:allKeys]objectForKey:key];
        }
    }
    NSLog(@"I was unable to retrieve the object for key: %@", key);
    return NULL;
}
@end
