import proxml.*;

proxml.XMLInOut xmlIO; 
proxml.XMLElement xml; 





void setup () {
  
  xmlIO = new XMLInOut (this);
  xmlIO.loadElement ("xmltest3.xml"); 

  
}


void xmlEvent(proxml.XMLElement element){
  proxml.XMLElement[] children = element.getChildren();

  for(int i = 0; i < children.length;i++){
    proxml.XMLElement child = children[i];
    println(child);
  }
}

