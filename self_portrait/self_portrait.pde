/*

Self-Portrait
Lia Martinez
10172011

*/


import proxml.*; 

proxml.XMLInOut xmlIO; 
proxml.XMLElement xml; 
proxml.XMLElement effect; 
proxml.XMLElement value; 
proxml.XMLElement parameter; 

int startTime, endTime; 

String [] words; 
int counter = 0; 

String delimiters = " ,.?!;:";

//parameters
float maxSync, minSync;
float maxAudio, minAudio;
float maxWavy, minWavy; 


//-----------------------------------------------------------------------------------------------------------------------
void setup () {

  xmlIO = new XMLInOut (this);

  try {
    xmlIO.loadElement ("xmltest3.xml");
  }
  catch(Exception e) {
    //if the xml file could not be loaded it has to be created
    xmlEvent(new proxml.XMLElement("effect"));
  }

  size (200, 200); 

  String file = "dadletter.txt";
  String []rawtext = loadStrings (file); 
  String everything = join (rawtext, " "); 
  words = splitTokens (everything, delimiters);
  
  startTime = 4213;
  endTime = 5938;
  
  maxSync = 0;
  minSync = 0.5;
  maxWavy = 30;
  minWavy = 0; 
 
  writeXML(maxWavy,minWavy); 

}


//---------------------------------------------------------------------------------------------------------------------
void draw () {
}

//-----------------------------------------------------------------------------------------------------------------------

void xmlEvent(proxml.XMLElement element) {
  effect = element;
}

//----------------------------------------------------------------------------------------------------------------------

void writeXML (float maxValue, float minValue) {

    for (int i = 0; i < words.length; i++) {

    //print number of characters per word
    int lettercount = 0; 

    lettercount = words[i].length();
    float distort = map (lettercount, 0, 10, maxValue, minValue);
    println (words[i] + " " + lettercount + " mapped is: " + distort );
    
    float mapTime = map (i, 0, words.length, startTime, endTime);
    int timing = int(mapTime); 

    //keyframe element
    proxml.XMLElement keyframe = new proxml.XMLElement("keyframe");
    effect.addChild(keyframe);

      //when element
      proxml.XMLElement when = new proxml.XMLElement("when");
      when.addChild(new proxml.XMLElement("" + timing, true));
      keyframe.addChild (when); 

      //value element
      proxml.XMLElement value = new proxml.XMLElement("value");
      value.addChild(new proxml.XMLElement("" + distort, true));
      keyframe.addChild (value); 

  }
      xmlIO.saveElement(effect, "value.xml");
      println("saved");
}

