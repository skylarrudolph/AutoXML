//
//  AutoXMLParser.h
//  AutoXML
//
//  Created by Skylar Rudolph on 11/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+StringManipulation.h"

@interface AutoXMLParser : NSObject <NSXMLParserDelegate>{
    NSXMLParser* myParser;
    NSMutableDictionary* dictionaryAfterParsing;
    NSMutableArray* arrayOfCurrent;
    int nestTest;
}

-(NSMutableDictionary*)parseXMLFile:(NSString*)pathToFile;
@property (nonatomic, retain) NSString* currentString;
@end
