#include "filedir.h"

using namespace std;

FileDir::FileDir (string n) {
	setNameDir (n);
	openDir ();
}
FileDir::~FileDir () {
	if (dp != NULL) closedir (dp);

}

void FileDir::openDir () {
	if((dp = opendir(nameDir.c_str())) == NULL) {
		cout << "Error opening " << nameDir << endl;
		exit (1);
	}

}

int FileDir::readDir () {
	dir.clear ();

	while ((dirp = readdir(dp)) != NULL) {
		dir.push_back(string(dirp->d_name));
	}

	rewinddir (dp);
	return dir.size ();
}

void FileDir::listDir () {
	for (unsigned i = 0; i < dir.size (); i++) {
		cout << dir.at (i) << endl;
	}

}
void FileDir::setNameDir (string n) { nameDir = n;}

int FileDir::searchDir (string extension){
	
	internalExtension = extension;
	int emailCounter = 0;
	dir.clear ();
	emailNames.clear();

	while ((dirp = readdir(dp)) != NULL) {

		if(dirp->d_type == DT_REG){

			string filename = dirp->d_name;

			if(filename.find(extension, (filename.length() - extension.length()) ) != string::npos ){
				emailCounter++;

				string directory = nameDir;
				directory.append (string(dirp->d_name));
				//std::cout << directory.c_str() << std::endl;
				//emailNames.resize(emailCounter);
				emailNames.push_back(directory);
			}

		}

	}
	return emailCounter;

}

vector <string> FileDir::getEmailFile(bool deleted){
	if(deleted){
		this->searchDir(internalExtension);
		return emailNames;
	}
	else
		return emailNames;

}
