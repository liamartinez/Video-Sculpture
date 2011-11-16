 
 //Function to get an Array of integers from a Google Spreadsheet
  String[] getNumbers(String row) {
      println("Asking Google for numbers...");
      sm = new SimpleSpreadsheetManager();
      sm.init("biozuchi", googleUser, googlePass);
      sm.fetchSheetByKey(sUrl, 0);
      
      int n = sm.currentListEntries.size();
      String [] returnArray = new String [n];
      for (int i = 0; i < n; i++) {
         returnArray[i] = (sm.getCellValue(row, i));
      };
      println("Got " + n + " numbers.");
      return(returnArray);
  };
  

