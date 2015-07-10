/*
	To enable DEBUGMODE
	Simply run

	make CPPFLAGS=-DDEBUGMODE


	Alunos:
		Luiz Renno Costa
		Rennan Emanuelli Rotunno
	Prof:
		Miguel Elias

	Segundo trabalho de Linguagens de
	Programacao 2015.1

*/
#include "files.h"
#include "error.h"
#include "filedir.h"
#include <limits>

using namespace std;

int main(int argc, char *argv[], char **env)
{
	PERL_SYS_INIT3(&argc, &argv, &env);

	int option = 0;
	int removeID =0;
	int ID = 0;
	FileDir file("./email/");

	int totalEmails = file.searchDir("txt");

	Files f(EMAIL_ELEMENTS, totalEmails);

	cout << "Menu: " << endl;
	cout << "1. Remove Email By ID"		<< endl
		 << "2. Show All Emails"		<< endl
		 << "3. Classify Emails"		<< endl
		 << "4. Count All Emails"		<< endl
		 << "5. Count All Spams"		<< endl
		 << "6. Show Email Info By ID"	<< endl
		 << "7. Show Menu"				<< endl
		 << "8. Exit"					<< endl;

	f.setEmail(file.getEmailFile(false));

	while (option != 8){
		cout << "Choose a Menu Option: ";
		while (!(cin >> option)) { cin.clear(); cin.ignore(numeric_limits<streamsize>::max(), '\n'); cout << "Invalid Input"<<endl;}
		switch(option) {
			case(1):
				cout << "Choose the ID of the email to be removed" << endl;
				while (!(cin >> removeID) || removeID < 1 || removeID > f.getTotal()) { cin.clear(); cin.ignore(numeric_limits<streamsize>::max(), '\n'); cout << "Enter only with an integer from 1 to " << f.getTotal()-1 <<endl;}
				if(remove(f.getPath(removeID).c_str()) != 0){
					cout << "Error deleting file" << endl;
				}
				else {
					cout << "File deleted Succefully" << endl;
					f.setTotal(f.getTotal()-1);
					FileDir file2("./email/");
					file2.searchDir("txt");
					f.setEmail(file2.getEmailFile(false));
				}
				break;
			case(2):
				f.printTable();
				break;
			case(3):
				f.classifyEmail();
				break;
			case(4):
				cout << "The total amount of emails in this directory is : "
					 << f.getTotal () << endl;
				break;
			case(5):
				cout << "The total amount of spams in this directory is : "
					 << f.getSpamCount () << endl;
				break;
			case(6):
				cout << "Please Select Your Desired Email: ";
				cin	 >> ID;
				while (ID < 1 || ID > f.getTotal()) {
					cout << "Please Enter a Valid ID" << endl;
					cin >> ID;
				}
				f.printEmail (EMAIL_ELEMENTS, ID-1);
				break;
			case(7):
				cout << "Menu: " << endl;
				cout << "1. Remove Email By ID"		<< endl
					 << "2. Show All Emails"		<< endl
					 << "3. Classify Emails"		<< endl
					 << "4. Count All Emails"		<< endl
					 << "5. Count All Spams"		<< endl
					 << "6. Show Email Info By ID"	<< endl
					 << "7. Show Menu"				<< endl
					 << "8. Exit"					<< endl;
				break;
			case(8):
				cout << "Ending Program" << endl;
				return EXIT_FROM_USER;
			default:
				cout << "Please Enter an Integer from 1 to 8." << endl;
				break;
		}

	}
	return 0;
}
