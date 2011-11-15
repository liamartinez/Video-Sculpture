import proxml.*;

proxml.XMLInOut xmlIO; 
proxml.XMLElement xml; 
proxml.XMLElement effect; 

void setup () {

  xmlIO = new XMLInOut (this);
  
  try {
  xmlIO.loadElement ("xmltest3.xml");
  }
  catch(Exception e){
    //if the xml file could not be loaded it has to be created
    xmlEvent(new proxmlXMLElement("parameters"));
  }
  
}


void xmlEvent(proxml.XMLElement element) {

  effect = element;
  element.printElementTree(" ");
  proxml.XMLElement[] children = element.getChildren();

  proxml.XMLElement effect;
  proxml.XMLElement parameter;
  

  for (int i = 0; i < effect.countChildren(); i++) {
    parameter = effect.getChild (i); 
  }


  parameter = new proxml.XMLElement("parameter");
  parameter.addAttribute ("liatest", "anothertest");
  effect.addChild(parameter);
  //xmlIO.saveElement(parameter,"xmltest3.xml");
  //println("saved");
}

void mousePressed() {

  proxml.XMLElement parameter = new proxml.XMLElement("parameter");
  parameter.addAttribute ("liatest", "anothertest");
  effect.addChild(parameter);
  //proxml.XMLElement position = new XMLElement("position");
  //position.addAttribute("xPos",xPos);
  //position.addAttribute("yPos",yPos);
  //ellipse.addChild(position);
  //XMLElement size = new XMLElement("size");
  //size.addAttribute("Xsize",abs(xPos-mouseX));
  //size.addAttribute("Ysize",abs(yPos-mouseY));
  //ellipse.addChild(size);
  xmlIO.saveElement(parameter, "xmltest3.xml");
  println("saved"); 
  //loadPixels();
  //back.pixels = pixels;
}





/*
void xmlEvent(proxml.XMLElement element){
 proxml.XMLElement[] children = element.getChildren();
 
 for(int i = 0; i < children.length;i++){
 proxml.XMLElement child = children[i];
 println(child);
 }
 }
 
 
 
 void xmlEvent(proxml.XMLElement element){
 String[] attributes = element.getAttributes();
 for(int i = 0; i < attributes.length; i++){
 println(attributes[i]+":"+
 element.getAttribute(attributes[i]));
 }
 }
 */
