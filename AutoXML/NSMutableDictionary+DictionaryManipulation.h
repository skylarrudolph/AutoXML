//
//  NSMutableDictionary+DictionaryManipulation.h
//  AutoXML
//
//  Created by Skylar Rudolph on 12/5/12.
//  Copyright (c) 2012 Temple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (DictionaryManipulation)
// For this function, all I want to be able to do is return a data type for a given key in the dictionary. Whether this value is a NSMutableArray or NSMutableDictionary is still unknown.
-(id)getObjectForKey:(NSString*)key;
@end
