//
//  AppDelegate.m
//  AutoXML
//
//  Created by Skylar Rudolph on 11/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "AutoXMLParser.h"
#import "NSMutableDictionary+DictionaryManipulation.h"
@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSMutableDictionary* resultingDictionary;
    AutoXMLParser* myParser = [AutoXMLParser new];
    resultingDictionary = [myParser parseXMLFile:[[NSBundle mainBundle]pathForResource:@"test" ofType:@"xml"]];
    
    id result = [resultingDictionary getObjectForKey:@"catalog"];
    id result2 = [result getObjectForKey:@"book"];
    for(NSMutableDictionary* x in result2){
        NSLog(@"%@", [x valueForKey:@"description"]);
//        NSLog(@"%@", (NSString*)[x valueForKey:@"title"]);
    }
}

@end
