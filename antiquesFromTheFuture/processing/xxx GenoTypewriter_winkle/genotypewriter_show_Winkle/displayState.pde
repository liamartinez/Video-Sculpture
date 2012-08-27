//--------------------------------------------------------------------------------
void displayState () {

  startSectionOne = 0;
  startSectionTwo = height/5;
  startSectionThree = height - ((height/5)*2); 
  
  switch (state) {

  case 0: 
    // display welcome
    image (welcomePage, 0, 0, width, height);
    textAlign (CENTER);
    //textSize (30); 
    fill (255); 
    textFont(didotBold, 30); 

    if (frameCount % 100 < 75) {
      if (!mouseOnly) {
        text ("Hit The Lever To Continue", width/2, height-50);
      } 
      else {
        text ("Hit The Lever To Continue", width/2, height-50);
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
    textFont(didot, 48); 
    imageMode (CORNER);  
    image (logo, width/2 - (logo.width/2), 0); 

    imageMode (CENTER); 
    items[dial].displayPicTop (width/2, (height/2 - heightFactor) +60, true); 
    items[dial].displayName (width/2 - 200, (height/2-5) +60, true); 

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

    imageMode (CENTER);
    items[chosenOne].displayPicTop (width/2, (height/2 - heightFactor) +60, false); 
    items[chosenOne].displayName (width/2 - 200, (height/2-5) +60, false); 

    items[dial].displayPicBot (width/2, (height/2 + heightFactor) + 60, true); 
    items[dial].displayName (width/2 + 200, (height/2+30) + 60, true); 

    break; 

  case 3: 

    stripeBorder.drawStripeBorder(startSectionTwo); 
    stripeBorder.drawStripeBorder(height - stripeBorder.boxHeight); 
    boxes.drawBoxes(state); 
  
    stroke (0); 
    strokeWeight (2); 
    line (0, startSectionThree, width, startSectionThree); 
    noStroke(); 

    textAlign (CENTER);
    textSize (20); 
    imageMode (CORNER);
    image (logo, width/2 - (logo.width/2), 0); 

    imageMode (CENTER);
    items[chosenOne].displayPicTop (width/2, (height/2 - heightFactor) +60, false); 
    items[chosenOne].displayName (width/2 - 200, (height/2-5) +60, false); 

    items[chosenTwo].displayPicBot (width/2, (height/2 + heightFactor) + 60, false); 
    items[chosenTwo].displayName (width/2 + 200, (height/2+30) + 60, false); 

    textAlign (LEFT); 
    textSize (25); 
    text ("Great! Its a " + items[chosenOne].prefix + items[chosenTwo].suffix + " !", locOneX-50, locOneY + 200); 
    if (!mouseOnly) {
      text ("Hit the lever again for your receipt", locOneX-50, locOneY + 230);
    } 
    else {
      text ("Hit the lever again for your receipt", locOneX-50, locOneY + 230);
    }

    break;

  case 4:
    //last page
    dottedStartX = 210; 
    dottedStartY = 110; 
    dottedEndX = 560; 
    wordSize = 15; 
    wordLeading = 18; 
    wordDist = 20; 

    textAlign (LEFT);

    imageMode (CORNER);
    image (receipt, 0, 0);
    textSize (wordSize); 

    text (items[chosenOne].name, dottedStartX, dottedStartY);
    text (items[chosenTwo].name, dottedStartX, dottedStartY + wordDist); 
    text ("Style Fee", dottedStartX, dottedStartY + wordDist*2); 

    text ("Coupon Code", dottedStartX, dottedStartY + wordDist*4); 
    imageMode (CENTER);
    image (coupon, dottedStartX + 140, dottedStartY + (wordDist*4)-15); 
    imageMode (CORNER);

    textFont(didotItalic, wordSize); 
    textLeading (wordLeading); 
    textAlign (CENTER);
    text ("..................................", dottedStartX, dottedStartY + wordDist*5, 240, 500);
    textAlign (LEFT);
    textFont(didotBold, 14); 
    text ("Our deepest Congratulations!", dottedStartX, dottedStartY + wordDist*7, 240, 500); 
    text ("It’s a " + items[chosenOne].prefix + items[chosenTwo].suffix + "!", dottedStartX, dottedStartY + wordDist*8, 240, 500); 
    //textFont(didotItalic, wordSize); 
    // text ("     It is " + items[chosenOne].description + " and " + items[chosenTwo].description + ", and will probably " + verbs[0] + " " + items[chosenOne].action + " and " + items[chosenTwo].action + " with you.", dottedStartX,  dottedStartY + wordDist*8, 240, 500); 
    text ("It is " + items[chosenOne].description + " and " + items[chosenTwo].description, dottedStartX, dottedStartY + wordDist*9, 240, 500); 

    textFont(didotItalic, wordSize - 3); 
    //text (" Your pup will arrive in approx. 5 minutes in your local bio tube repository.", dottedStartX, dottedStartY + wordDist*13, 240, 500); 

    //textLeading (wordLeading-5); 
    //text (" Need faster imprinting? Register today with our DNA play for quick impression between pup & parent. Also look for our new intelligence plus GenoTypewriter coming out next fall with a full featured intelligence augmenter! Upload your intelligence into your next " + items[chosenOne].prefix + items[chosenTwo].suffix + "!", dottedStartX, dottedStartY + wordDist*13, 240, 500); 
    textAlign(RIGHT); 
    textFont(didotItalic, wordSize); 
    text ( " ...........................  $ " + items[chosenOne].price, dottedStartX + 250, dottedStartY);
    text ( " ...........................  $ " + items[chosenTwo].price, dottedStartX + 250, dottedStartY + wordDist); 
    text (  " ..........................  $ " + "% 10.00", dottedStartX + 250, dottedStartY  + wordDist*2); 
    text ("Total $" + ((items[chosenOne].price + items[chosenTwo].price) - ((items[chosenOne].price + items[chosenTwo].price)*.10) ), dottedStartX + 260, dottedStartY + wordDist*5); 

    dial = int(random (0, items.length)); 

    /*
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
     */

    break;
  }
}

