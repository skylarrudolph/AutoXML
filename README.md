<h1><u>Auto(matic)XML</u></h1>
<h6>A tool to streamline XML parsing in Objective-C</h6>

<p>The inspiration for AutoXML was caused by the repetitive code that I <b>needed</b> to write to parse XML on several projects. This caused a lot of headaches and ate up a lot of time on my expense. To counteract this, I have a solution that can streamline the XML parsing process.

The idea is to create an NSMutableDictionary that will hold all of the keys for each starting element. As the elements begin to nest, you are able to add a key-value pair to the parent node. I am doing this as a project to save many people the headaches of working with either Mac OS X or iOS applications that rely on web services to use their data. 

<li>I ask that you please add to this idea and make this easy for EVERYBODY to use. 

<i>Remember, life should not be spent rewriting code.
-skylarrudolph.