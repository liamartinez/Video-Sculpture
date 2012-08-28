//--------------------------------------------------------------------------------
void displayState () {

  startSectionOne = 0;
  startSectionTwo = height/5;
  startSectionThree = height - ((height/5)*2); 

  int startInfoText = int(boxes.infoBoxStart) + 20; 

  textFont (futuraMedium); 

  switch (state) {

  case 0: 
    // display welcome
    image (welcomePage, 0, 0, width, height);
    textAlign (CENTER);
    //textSize (30); 
    fill (255); 
    textFont(futuraMedium, 50); 

    if (frameCount % 20 < 10) {
      if (!mouseOnly) {
        text ("Hit The Lever To Continue", width/2, height-50);
      } 
      else {
        text ("Hit The Mouse To Continue", width/2, height-50);
      }
    }
    break; 

  case 1:  
    //choose the first

    alphabet.drawAlphabet(dial, startSectionTwo);
    stripeBorder.drawStripeBorder(height - stripeBorder.boxHeight); 
    boxes.drawBoxes(state); 

    textAlign (CENTER);
    textSize (50); 
    fill (255, 0, 0); 
    text (alphabet.alphabet[dial], width/2, (startSectionTwo+alphabet.boxHeight) + 60); 
    textSize (20); 
    imageMode (CORNER);  
    image (logo, width/2 - (logo.width/2), 0); 

    imageMode (CORNER); 
    items[dial].displayPicTop (width/2 - ((items[dial].picSizeX)/2), startSectionThree-items[dial].picSizeY, true); 
    textAlign (CORNER); 
    fill (255); 
    textSize (30); 
    text ("1/2 = ", startInfoText, (startSectionTwo+alphabet.boxHeight) + 60); 
    fill (255, 0, 0); 
    items[dial].displayName (startInfoText + 100, (startSectionTwo+alphabet.boxHeight) + 60, false); 
    fill (255); 
    textSize (20); 
    text ("good at: " + items[dial].action, startInfoText, (startSectionTwo+alphabet.boxHeight) + 60 + 40); 
    text ("expect: " + items[dial].description, startInfoText, (startSectionTwo+alphabet.boxHeight) + 60 + 40 + 30); 
    text ("you pay: $" + items[dial].price, startInfoText, (startSectionTwo+alphabet.boxHeight) + 60 + 40 + 30 + 60); 

    break; 

  case 2:

    alphabet.drawAlphabet(dial, height - alphabet.boxHeight);
    stripeBorder.drawStripeBorder(startSectionTwo); 
    boxes.drawBoxes(state); 

    textAlign (CENTER);
    textSize (50); 
    fill (255, 0, 0); 
    text (alphabet.alphabet[dial], width/2, startSectionThree + (startSectionThree-startSectionTwo-alphabet.boxHeight) - 30); 
    textSize (20); 
    imageMode (CORNER);
    image (logo, width/2 - (logo.width/2), 0); 

    imageMode (CORNER);
    items[chosenOne].displayPicTop (width/2 - ((items[chosenOne].picSizeX)/2), startSectionThree-items[chosenOne].picSizeY, false); 
    textAlign (CORNER); 
    fill (0); 
    textSize (30); 
    text ("1/2 = ", startInfoText, (startSectionTwo+alphabet.boxHeight) + 60); 
    items[chosenOne].displayName (startInfoText + 100, (startSectionTwo+alphabet.boxHeight) + 60, false); 

    items[dial].displayPicBot (width/2- ((items[dial].picSizeX)/2), startSectionThree, true); 
    textAlign (CORNER); 
    fill (255); 
    textSize (30); 
    text ("1/2 = ", startInfoText, startSectionThree + 60); 
    fill (255, 0, 0); 
    items[dial].displayName (startInfoText + 100, startSectionThree + 60, false); 
    fill (255); 
    textSize (20); 
    text ("good at: " + items[dial].action, startInfoText, startSectionThree + 60 + 40); 
    text ("expect: " + items[dial].description, startInfoText, startSectionThree + 60 + 40 + 30); 
    text ("you pay: $" + items[dial].price, startInfoText, startSectionThree + 60 + 40 + 30 + 60); 

    break; 

  case 3: 

    stripeBorder.drawStripeBorder(startSectionTwo); 
    stripeBorder.drawStripeBorder(height - stripeBorder.boxHeight); 
    boxes.drawBoxes(state); 
    
    textAlign (CORNER); 
    fill (0); 
    textSize (30); 
    text ("1/2 = ", startInfoText, (startSectionTwo+alphabet.boxHeight) + 60); 
    items[chosenOne].displayName (startInfoText + 100, (startSectionTwo+alphabet.boxHeight) + 60, false); 
    
    textSize (30); 
    text ("1/2 = ", startInfoText, startSectionThree + 60); 
    items[chosenTwo].displayName (startInfoText + 100, startSectionThree + 60, false); 

    stroke (0); 
    strokeWeight (2); 
    line (0, startSectionThree, width, startSectionThree); 
    noStroke(); 

    textAlign (CENTER);
    textSize (20); 
    imageMode (CORNER);
    image (logo, width/2 - (logo.width/2), 0); 

    imageMode (CORNER);
    items[chosenOne].displayPicTop (width/2 - ((items[dial].picSizeX)/2), startSectionThree-items[dial].picSizeY, false); 
    items[chosenTwo].displayPicBot (width/2- ((items[dial].picSizeX)/2), startSectionThree, false); 


    textAlign (LEFT); 
    textSize (55); 
    text ("Great! Its a " + items[chosenOne].prefix + items[chosenTwo].suffix + " !", 30, startSectionTwo + height/8); 
    textAlign (CENTER); 
    textSize (45); 
    if (!mouseOnly) {
      text ("HIT THE LEVER AGAIN FOR YOUR RECEIPT", width/2 - 130, height - height/8 + 30);
    } 
    else {
      text ("HIT THE MOUSE AGAIN FOR YOUR RECEIPT", width/2 - 130, height - height/8 + 30);
    }

    break;

  case 4:
    //last page
    //dottedStartX = 210; 
    dottedStartX = (width/2 - receipt.width/2) + receipt.width/3 + 5;
    //dottedStartY = 110; 
    dottedStartY = (height/4); 
    wordSize = 15; 
    wordLeading = 18; 
    wordDist = 20; 

    textAlign (LEFT);
    textFont (didotBold, 14); 

    imageMode (CORNER);
    image (receipt, width/2 - receipt.width/2, 0);
    textSize (wordSize); 

    text (items[chosenOne].name, dottedStartX, dottedStartY);
    text (items[chosenTwo].name, dottedStartX, dottedStartY + wordDist); 
    text ("Style Fee", dottedStartX, dottedStartY + wordDist*2); 

    text ("Coupon Code", dottedStartX, dottedStartY + (wordDist*4)); 
    imageMode (CENTER);
    image (coupon, dottedStartX + 160, dottedStartY + (wordDist*4)-5); 
    imageMode (CORNER);

    textFont(didotItalic, wordSize); 
    textLeading (wordLeading); 
    textAlign (CENTER);
    text ("..................................", dottedStartX, dottedStartY + wordDist*5, 240, 500);
    textAlign (LEFT);
    textFont(didotBold, wordSize); 
    text ("Our deepest Congratulations!", dottedStartX, dottedStartY + wordDist*7, 240, 500); 
    text ("It’s a " + items[chosenOne].prefix + items[chosenTwo].suffix + "!", dottedStartX, dottedStartY + wordDist*8, 300, 500); 
    textFont(didotItalic, wordSize); 
    textLeading (wordLeading-3); 
    text ("It is " + items[chosenOne].description + " and " + items[chosenTwo].description + ", and will probably " + verbs[0] + " " + items[chosenOne].action + " and " + items[chosenTwo].action + " with you.", dottedStartX, dottedStartY + wordDist*10, 320, 500); 

    textFont(didotItalic, wordSize - 3); 
    textLeading (wordLeading-5);
    text (" Your pup will arrive in approx. 5 minutes in your local bio tube repository.", dottedStartX, dottedStartY + wordDist*13, 320, 500); 

    text (" Need faster imprinting? Register today with our DNA play for quick impression between pup & parent. Also look for our new intelligence plus GenoTypewriter coming out next fall with a full featured intelligence augmenter! Upload your intelligence into your next " + items[chosenOne].prefix + items[chosenTwo].suffix + "!", dottedStartX, dottedStartY + wordDist*15, 320, 500); 
    textAlign(RIGHT); 
    textFont(didotItalic, wordSize); 
    text ( " ..........................................                  $ " + items[chosenOne].price, dottedStartX + 430, dottedStartY);
    text ( " ..........................................                  $ " + items[chosenTwo].price, dottedStartX + 430, dottedStartY + wordDist); 
    text ( " ......................................                   $ " + "% 10.00", dottedStartX + 430, dottedStartY  + wordDist*2); 
    text ("Total $" + ((items[chosenOne].price + items[chosenTwo].price) - ((items[chosenOne].price + items[chosenTwo].price)*.10) ), dottedStartX + 430, dottedStartY + wordDist*5); 

    textFont (futuraMedium); 
    textSize (45); 
    if (frameCount % 20 < 10) {
      textAlign (CENTER); 
      text ("DONT FORGET TO GET YOUR RECEIPT", width/2, height - height/8); 
    }

    dial = int(random (0, items.length)); 

    
    //prepare the text for the printer
     header = "******GENOTYPEWRITER*********"; 
     congrats = "Our deepest Congratulations!"; 
     combo = "It’s a " + items[chosenOne].prefix + items[chosenTwo].suffix + "!"; 
     product1 = items[chosenOne].name + " .........  $ " + items[chosenOne].price;
     product2 = items[chosenTwo].name + " .........  $ " + items[chosenTwo].price;
     total = " ....... Total $" + (items[chosenOne].price + items[chosenTwo].price); 
     description = "     It is " + items[chosenOne].description + " and " + items[chosenTwo].description + "." ;
     verbage = "It will enjoy " + items[chosenOne].action + " and " + items[chosenTwo].action + " with you.";
     thanks = " Your pup will arrive in approx. 5 minutes in your local bio tube repository.";
     
     if (printed) {
     printed = false; 
     thermalPrintString(header + (char)'\n' + (char)'\n' + congrats + (char)'\n' + combo + (char)'\n'+ (char)'\n'  + product1 + (char)'\n' + product2 + (char)'\n' + (char)'\n'+description + (char)'\n' + verbage + (char)'\n'+ (char)'\n' + thanks);
     }
   

    break;
  }
}

