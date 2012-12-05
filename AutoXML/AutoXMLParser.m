//
//  AutoXMLParser.m
//  AutoXML
//
//  Created by Skylar Rudolph on 11/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AutoXMLParser.h"

@implementation AutoXMLParser
@synthesize currentString;
/**
 
    AutoXML is a project that I worked on to make XML deserialization possible and to provide an easy way to decrypt XML files into an object. The way that it works:
        1.) As data tags are opened, I will add them to a FILO stack. (arrayOfCurrent)
        2.) As data tags are closed, I will add these values of the previous (parent) node in our stack. 
        3.) As mutiple data tags are closed (in our example, a catalog) we have a lot of entries with the same tag name to add to a dictionary. Because one key can only point
                to one value, I decided that if there are multiple values for the same key, then simply add the concurrent values to a mutable array and use this later on. 
        4.) When the final tag is closed, we save it to a global NSDictionary and send it out to the user that wanted it. 
        
        <!--test2.xml-->
        <note>
            <to>Tove</to>
            <from>Jani</from>
            <heading>Reminder</heading>
            <body>Don't forget me this weekend!</body>
        </note>
 
        The data structure that would result from this would look like this:
        { <-- Base Dictionary
            note = <-- Key 
            {
                body = "Don't forget me this weekend!"; <-- Values for key. 
                from = Jani;
                heading = Reminder;
                to = Tove;
            }; <-- End of Values
        } <-- End of Base Dictionary.
 
        As can be seen, this is a very simple 1-1 translation. Let's add a little chaos.
 
 
        <!--test3.xml-->
        <CATALOG>
            <CD>
                <TITLE>Empire Burlesque</TITLE>
                <ARTIST>Bob Dylan</ARTIST>
                <COUNTRY>USA</COUNTRY>
                <COMPANY>Columbia</COMPANY>
                <PRICE>10.90</PRICE>
                <YEAR>1985</YEAR>
            </CD>
            <CD>
                <TITLE>Hide your heart</TITLE>
                <ARTIST>Bonnie Tyler</ARTIST>
                <COUNTRY>UK</COUNTRY>
                <COMPANY>CBS Records</COMPANY>
                <PRICE>9.90</PRICE>
                <YEAR>1988</YEAR>
            </CD>
            <CD>
                <TITLE>Greatest Hits</TITLE>
                <ARTIST>Dolly Parton</ARTIST>
                <COUNTRY>USA</COUNTRY>
                <COMPANY>RCA</COMPANY>
                <PRICE>9.90</PRICE>
                <YEAR>1982</YEAR>
            </CD>
        </CATALOG>
        
        The data structure from this would look something like:
        { <-- Base Dictionary
            CATALOG =     <-- Key
            {             <-- Begin Value Declaration.  
                CD = (    <-- Multiple Values for Same Key? Let's put that into a NSMutableArray.
                {
                    ARTIST = "Bob Dylan";
                    COMPANY = Columbia;
                    COUNTRY = USA;
                    PRICE = "10.90";
                    TITLE = "Empire Burlesque";
                    YEAR = 1985;
                }),
                (
                {
                    ARTIST = "Bonnie Tyler";
                    COMPANY = "CBS Records";
                    COUNTRY = UK;
                    PRICE = "9.90";
                    TITLE = "Hide your heart";
                    YEAR = 1988;
                }),
                (
                {
                    ARTIST = "Dolly Parton";
                    COMPANY = RCA;
                    COUNTRY = USA;
                    PRICE = "9.90";
                    TITLE = "Greatest Hits";
                    YEAR = 1982;
                }
                )
                );
                };
            }

 
 
 */






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
        int indexOfChild = [arrayOfCurrent indexOfObject:[arrayOfCurrent lastObject]];
        int indexOfParent = indexOfChild-1;
        NSString* parentNodeKey = [[[arrayOfCurrent objectAtIndex:indexOfParent]allKeys]objectAtIndex:0];
        NSString* childNodeKey = [[[arrayOfCurrent objectAtIndex:indexOfChild]allKeys]objectAtIndex:0];

        
        if([arrayOfCurrent count]<=2 && [childNodeKey isEqualTo:elementName]){
            if(currentString != nil){
                [[arrayOfCurrent lastObject]setValue:currentString forKey:elementName];
            }
            NSDictionary* childDict = [[NSMutableDictionary alloc]initWithDictionary:[arrayOfCurrent lastObject]];
            
//          Grab the object at parent (i.e. the value above the child dictionary.)
            NSMutableDictionary* x = [arrayOfCurrent objectAtIndex:indexOfParent];
            
//          This will check to make sure that we are not adding different values for the same key. If we do
//            we will add the value to a new NSMutableArray with the key pointing to the NSMutableArray. The
//            else for this if will simply add the value to the newDataHold instead of creating a whole new
//            NSMutableArray.
            if([[x objectForKey:parentNodeKey]objectForKey:elementName] != nil){
                NSMutableArray* newDataHold = [[NSMutableArray alloc]init];
                if([[[x objectForKey:parentNodeKey]objectForKey:elementName]isKindOfClass:[NSDictionary class]]){
                    NSMutableDictionary* currentDictToArray = [[x objectForKey:parentNodeKey]objectForKey:elementName];
                    [newDataHold addObject:currentDictToArray];
//                    Fix here.
                    [newDataHold addObject:[childDict valueForKey:elementName]];                                        
                } else{
                    newDataHold = [[x objectForKey:parentNodeKey]objectForKey:elementName];
                    [newDataHold addObject:[childDict valueForKey:elementName]];
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

            
            NSMutableDictionary* x = [arrayOfCurrent objectAtIndex:indexOfParent];
            [[x objectForKey:parentNodeKey]addEntriesFromDictionary:childDict];
            [arrayOfCurrent replaceObjectAtIndex:indexOfParent withObject:x];

            [arrayOfCurrent removeLastObject];

        }

    }
}

// This will save the final dictionary object to a returnable dictionary that a user can use.  
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    dictionaryAfterParsing = [arrayOfCurrent lastObject];
//    NSLog(@"%@", dictionaryAfterParsing);
}

// Generic Error Handling.
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"Error: %@", [parseError description]);
}

// End of Parser Functions. Let's get some functionality out of this.










@end
