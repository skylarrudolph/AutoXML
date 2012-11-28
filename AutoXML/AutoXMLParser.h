//
//  AutoXMLParser.h
//  AutoXML
//
//  Created by Skylar Rudolph on 11/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoXMLParser : NSObject <NSXMLParserDelegate>{
    NSXMLParser* myParser;
    NSMutableDictionary* dictionaryAfterParsing;
    NSMutableArray* arrayOfCurrent;
}

-(void)parseXMLFile:(NSString*)pathToFile;
@end
