<h1><u>Auto(matic)XML</u></h1>
<h6>A tool to streamline XML parsing in Objective-C</h6>

<p>The inspiration for AutoXML was caused by the repetitive code that I <b>needed</b> to write to parse XML on several projects. To counteract this, I have a solution that can streamline the XML parsing process.

The idea is to create an NSMutableDictionary that will hold all of the keys for each starting element. As the elements begin to nest, you are able to add a key-value pair to the parent node. I am doing this as a project to save many people the headaches of working with either Mac OS X or iOS applications that rely on web services to use their data. 

<li>I ask that you please add to this idea and make this easy for EVERYBODY to use. 

<b>How it works.</b>

First we will instantiate an AutoXMLParser object and parse it. 

```objective-c
    NSMutableDictionary* resultingDictionary;
    AutoXMLParser* myParser = [AutoXMLParser new];
    resultingDictionary = [myParser parseXMLFile:[[NSBundle mainBundle]pathForResource:@"test" ofType:@"xml"]];
```
This resulting dictionary (resultingDictionary) will contain all of our key-value pairs of our XML file.

And our test.xml

```xml
    <?xml version="1.0"?>
    <note>
        <to>Tove</to>
        <from>Jani</from>
        <heading>Reminder</heading>
        <body>Don't forget me this weekend!</body>
    </note>
```

Therefore, our "note" tag should contain all of the key-value pairs before the ending "note" tag. 

To access this, we will use the NSMutableDictionary+DictionaryManipulation.h getObjectForKey:(NSString*) function which will return us an id type (will explain later) for the value that the key is pointing to or NULL if it is non-existent. 

```smalltalk
    id result = [resultingDictionary getObjectForKey:@"note"];
```

Result will now contain all of our values and we will use the standard NSDictionary valueForKey:(NSString*) method to return our value. 
By typing in: 

```smalltalk
    NSLog(@"%@", [result valueForKey:@"to"]);
```
We get
    2012-12-05 17:39:08.476 AutoXML[6768:707] Tove

Now we will have a nested XML file.

Example:
```xml
<catalog>
    <book id="bk101">
        <author>Gambardella, Matthew</author>
        <title>XML Developer's Guide</title>
        <genre>Computer</genre>
        <price>44.95</price>
        <publish_date>2000-10-01</publish_date>
        <description>An in-depth look at creating applications 
            with XML.</description>
    </book>
    <book id="bk102">
        <author>Ralls, Kim</author>
        <title>Midnight Rain</title>
        <genre>Fantasy</genre>
        <price>5.95</price>
        <publish_date>2000-12-16</publish_date>
        <description>A former architect battles corporate zombies, 
            an evil sorceress, and her own childhood to become queen 
            of the world.</description>
    </book>
    <book id="bk103">
        <author>Corets, Eva</author>
        <title>Maeve Ascendant</title>
        <genre>Fantasy</genre>
        <price>5.95</price>
        <publish_date>2000-11-17</publish_date>
        <description>After the collapse of a nanotechnology society in England, the young survivors lay the 
            foundation for a new society.</description>
    </book>
    <book id="bk104">
        <author>Corets, Eva</author>
        <title>Oberon's Legacy</title>
        <genre>Fantasy</genre>
        <price>5.95</price>
        <publish_date>2001-03-10</publish_date>
        <description>In post-apocalypse England, the mysterious 
            agent known only as Oberon helps to create a new life 
            for the inhabitants of London. Sequel to Maeve 
            Ascendant.</description>
    </book>
</catalog>
```

Now we have multiple <b>book</b> tags. Because these all map to the catalog tag, we need to have multiple entries for one key (book). As of right now, we save all of these NSDictionary's into an NSArray.

Initialization is the same as before, but to enter and retrieve all of the results this time, we will do this.

```smalltalk
    id result = [resultingDictionary getObjectForKey:@"catalog"];
    id result2 = [result getObjectForKey:@"book"];
    
    //\ notation to cycle through array.
    for(NSMutableDictionary* dictionariesInsideResult2 in result2){
        NSLog(@"Title: %@", [dictionariesInsideResult2 valueForKey:@"title"]);
        NSLog(@"Author: %@", [dictionariesInsideResult2 valueForKey:@"author"]);
        NSLog(@"\n");
    }
```

And we get 

```
Title: XML Developer's Guide
Author: Gambardella, Matthew

Title: Midnight Rain
Author: Ralls, Kim

Title: Maeve Ascendant
Author: Corets, Eva

Title: Oberon's Legacy
Author: Corets, Eva

```
as the output of the code. As you can see, accessing nested data structures is as easy as cycling through the array that it points to and pulling out the tag that you need, in our case, "title" and "author". 


<i>Remember, life should not be spent rewriting code.
-skylarrudolph.