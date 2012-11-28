//
//  AppDelegate.m
//  AutoXML
//
//  Created by Skylar Rudolph on 11/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "AutoXMLParser.h"
@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

    AutoXMLParser* myParser = [AutoXMLParser new];
    
    [myParser parseXMLFile:[[NSBundle mainBundle]pathForResource:@"test" ofType:@"xml"]];
    
}

@end
