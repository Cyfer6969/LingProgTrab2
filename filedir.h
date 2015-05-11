
#include <dirent.h>
#include <string>
#include <vector>
#include <cstdlib>
#include <stdio.h>
#include <iostream>

#ifndef FILEDIR_H
#define FILEDIR_H
using namespace std;
class FileDir {
	public:
		FileDir (string);
		~FileDir ();
		void openDir ();
		int readDir ();
		int getDirSize ();
		void setNameDir (string);
		void listDir ();
		int searchDir(string);
		vector<string> getEmailFile(bool);
	private:
		vector <string> dir;
		vector <string> emailNames;
		string internalExtension;
		string nameDir;
		DIR *dp;
		struct dirent *dirp;
};
#endif
