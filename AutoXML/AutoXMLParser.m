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
@synthesize currentString;

-(NSMutableDictionary*)parseXMLFile:(NSString *)pathToFile{
    arrayOfCurrent = [[NSMutableArray alloc]init];
    NSURL* myURL = [NSURL fileURLWithPath:pathToFile];
    myParser = [[NSXMLParser alloc]initWithContentsOfURL:myURL];
    [myParser setDelegate:self];
    [myParser parse];
    return dictionaryAfterParsing;

}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(![string isEmptyOrWhiteSpace]){
        currentString = string;
    } else{
        currentString = nil;
    }
        
}

-(void)parserDidStartDocument:(NSXMLParser *)parser{
//    NSLog(@"Starting Document");
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
//    [arrayOfCurrent addObject:[NSMutableDictionary new]];
    NSDictionary* newTag = [[NSMutableDictionary alloc]init];
    NSDictionary* pointerToNewTag = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObject:newTag] forKeys:[NSArray arrayWithObject:elementName]];
    [arrayOfCurrent addObject:pointerToNewTag];
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if([arrayOfCurrent count]>=2){

//        NSLog(@"Trying to find out where this is screwing up. %@", currentString);
        
        int indexOfChild = [arrayOfCurrent indexOfObject:[arrayOfCurrent lastObject]];
        int indexOfParent = indexOfChild-1;
        NSString* parentNodeKey = [[[arrayOfCurrent objectAtIndex:indexOfParent]allKeys]objectAtIndex:0];
        NSString* childNodeKey = [[[arrayOfCurrent objectAtIndex:indexOfChild]allKeys]objectAtIndex:0];

        
        if([arrayOfCurrent count]==2 && [childNodeKey isEqualTo:elementName]){
            NSDictionary* childDict = [[NSMutableDictionary alloc]initWithDictionary:[arrayOfCurrent lastObject]];
            

            NSMutableDictionary* x = [arrayOfCurrent objectAtIndex:indexOfParent];
            
            
            if([[x objectForKey:parentNodeKey]objectForKey:elementName] != nil){
                NSMutableArray* newDataHold = [[NSMutableArray alloc]init];
                if([[[x objectForKey:parentNodeKey]objectForKey:elementName]isKindOfClass:[NSDictionary class]]){
                    NSMutableDictionary* currentDictToArray = [[x objectForKey:parentNodeKey]objectForKey:elementName];
                    [newDataHold addObject:currentDictToArray];
                    [newDataHold addObject:[childDict allValues]];                    
//                    NSLog(@"Description : %@", [x objectForKey:parentNodeKey]);
                    
                } else{
                    newDataHold = [[x objectForKey:parentNodeKey]objectForKey:elementName];
                    [newDataHold addObject:[childDict allValues]];
                }
                [[x objectForKey:parentNodeKey] setObject:newDataHold forKey:elementName];
            }
            
            else {
                [[x objectForKey:parentNodeKey] addEntriesFromDictionary:childDict];
                [arrayOfCurrent replaceObjectAtIndex:indexOfParent withObject:x];
            }
            [arrayOfCurrent removeLastObject];
            
            
        }else{
            [[arrayOfCurrent lastObject]setValue:currentString forKey:elementName];
            NSDictionary* childDict = [[NSMutableDictionary alloc]initWithDictionary:[arrayOfCurrent lastObject]];

//            NSLog(@"Parent Node Key Where we will be inserting: %@", parentNodeKey);
            
            NSMutableDictionary* x = [arrayOfCurrent objectAtIndex:indexOfParent];
            [[x objectForKey:parentNodeKey]addEntriesFromDictionary:childDict];
            [arrayOfCurrent replaceObjectAtIndex:indexOfParent withObject:x];
            //        if([arrayOfCurrent count]==2){
            //            dictionaryAfterParsing = [arrayOfCurrent lastObject];
            //        }
            
            [arrayOfCurrent removeLastObject];

        }

    }

}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    dictionaryAfterParsing = [arrayOfCurrent lastObject];
    NSLog(@"%@", dictionaryAfterParsing);
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"Error: %@", [parseError description]);
}

@end
