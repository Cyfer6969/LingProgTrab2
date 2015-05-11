(ONLY WORKS ON UNIX DISTRIBUTIONS)
------
This project consists of an email (file) manager, once you execute trab2,
The following menu will appear :

		"Menu: " 
		  "1. Remove Email By ID"	
		  "2. Show All Emails"		
		  "3. Classify Emails"		
		  "4. Count All Emails"		
		  "5. Count All Spams"		
		  "6. Show Email Info By ID"	
		  "7. Show Menu"		
		  "8. Exit"			

Each of the options above yields the following :

1. Remove an email based on his ID that appears in the table.

2. This option calls the table below (end of README), which show the e-mail info alongside the Spam column that receives one of the three folowing tags:

  * "Not Classified" - > The email has not yet been classified.
  * "Yes" - > The email IS a spam.
  * "No" - > The email is NOT a spam.
 
3. This input classifies all emails in the ./emails/ folder, while seemingly not showing an 
immediate response, all the user has to do is input (2) again, so that the table get's reprinted on the screen.

4. Simply prints the number of emails inside the ./emails/ folder.

5. Simply prints the number of emails classified as Spam, "Non Classified" does NOT count as spam. So in order to
make this option return useful information, option (3) must be selected beforehand.

6. Select an email by his ID and all the info regarding him will be printed on the screen.

7. Show the menu again at (almost) any time

8. Exits the program.

Table
----------


| Id    | From   | Subject | Receive Date | Receive Hour | Spam |
| :----- |:------:| :-------:|:--------------:|:--------------:|:------:|
| 1     | ex	 | S1 	   |   24/4/2013  |  14 30     |    Non Classified  |
| 2     | ex2    | S2 	   |   15/5/2009  |   15 14    |   Yes  	    |
| 3 	| ex3    | S3 	   |   14/7/2005  |     16 16  |   N	            |


