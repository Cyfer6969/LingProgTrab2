#ifndef FILES_H
#define FILES_H

#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include "PerlInterpreter.h"

#define EMAIL_ELEMENTS          9

#define RDATE                   0
#define RDATE_HOUR              1
#define SDATE                   2
#define SDATE_HOUR              3
#define FROM                    4
#define SUBJECT                 5
#define BODY                    6

#define SPAM                    7
#define PATH					8

#define SPAM_LIMIT				45

#define super_Table(argument)	for(int column = 1; column <= total; column++){ std::cout << argument << "\t";}

using std::vector;
using std::string;

class Files {

	static const vector<string> NAME_VECTOR[];
	public:
		Files(int, int);
		~Files();
		void printTable();
		void printEmail(int, int);
		void printAllEmails(int);
		void classifyEmail();
		void setHour(int);

		int getTotal();
		void setEmail(vector<string>);
		void setTotal(int);
		void setSpam(string, int);
		int getSpamCount();
		string getPath(int ID);

	private:
		int total;
		int spamCounter;
		bool FULL;
		vector<vector<string> > email;
		vector<string> emailTopic;
};

#endif
