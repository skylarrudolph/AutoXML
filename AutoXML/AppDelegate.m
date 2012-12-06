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
    
    
    //Array notation to cycle through array.
    for(NSMutableDictionary* dictionariesInsideResult2 in result2){
        NSLog(@"Title: %@", [dictionariesInsideResult2 valueForKey:@"title"]);
        NSLog(@"Author: %@", [dictionariesInsideResult2 valueForKey:@"author"]);
        NSLog(@"\n");
    }
}

@end
