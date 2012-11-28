//
//  AutoXMLParser.m
//  AutoXML
//
//  Created by Skylar Rudolph on 11/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AutoXMLParser.h"

@implementation AutoXMLParser
//@synthesize arrayOfCurrent;


-(void)parseXMLFile:(NSString *)pathToFile{
    arrayOfCurrent = [[NSMutableArray alloc]init];
//    autoParser = [[AutoXMLParser alloc]init];
    NSURL* myURL = [NSURL fileURLWithPath:pathToFile];
    NSLog(@"myURL: %@", myURL);
    myParser = [[NSXMLParser alloc]initWithContentsOfURL:myURL];
    [myParser setDelegate:self];
    [myParser parse];
    
//    [autoParser parse];

}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
//    NSLog(@"%@", string);
}

-(void)parserDidStartDocument:(NSXMLParser *)parser{
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    [arrayOfCurrent addObject:elementName];
    NSLog(@"Added Object: %u", [arrayOfCurrent count]);

}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    [arrayOfCurrent removeLastObject];
    NSLog(@"Removed Object: %u", [arrayOfCurrent count]);
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"Error: %@", [parseError description]);
}

@end
