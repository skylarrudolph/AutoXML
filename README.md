<h1><u>Auto(matic)XML</u></h1>
<h6>A tool to streamline XML parsing in Objective-C</h6>

<p>The inspiration for AutoXML was caused by the repetitive code that I <b>needed</b> to write to parse XML on several projects. This caused a lot of headaches and ate up a lot of time on my expense. To counteract this, I have a solution that can streamline the XML parsing process.

The idea is to create an NSMutableDictionary that will hold all of the keys for each starting element. As the elements begin to nest, you are able to add a key-value pair to the parent node. I am doing this as a project to save many people the headaches of working with either Mac OS X or iOS applications that rely on web services to use their data. 

<li>I ask that you please add to this idea and make this easy for EVERYBODY to use. 

<b>How it works.</b>

First we will instantiate an AutoXMLParser object and parse it. 

```smalltalk
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

Therefore, our <note> tag should contain all of the key-value pairs before the ending </note> tag. 

To access this, we will use the NSMutableDictionary+DictionaryManipulation.h getObjectForKey:(NSString*) function which will return us an id type (will explain later) for the value that the key is pointing to or NULL if it is non-existent. 

```smalltalk
    id result = [resultingDictionary getObjectForKey:@"note"];
```

Result will now contain all of our values and we will use the standard NSDictionary valueForKey:(NSString*) method to return our value. 
By typing in 

```smalltalk
    NSLog(@"%@", [result valueForKey:@"to"]);
```
We get
    2012-12-05 17:39:08.476 AutoXML[6768:707] Tove

And so on and so forth. When objects become nested, I will explain how this is handled later on. For now this should be enough to cover for today.


<i>Remember, life should not be spent rewriting code.
-skylarrudolph.