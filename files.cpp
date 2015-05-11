#include "files.h"
#include "error.h"
#include <cstddef>

Files::Files(int topics, int total_){

	FULL = false;
	TRANSPOST = false;
	Files::setTotal(total_);

	email.resize(total);
	for (int i = 0; i < total; ++i)
		email[i].resize(topics);

	for(int i = 0; i < total; i++){
		for(int j = 0; j < topics; j++)
			email[i][j] = "0";
	}


	emailTopic.resize (EMAIL_ELEMENTS);
	emailTopic[0] = "RDATE";
	emailTopic[1] = "RDATE_HOUR";
	emailTopic[2] = "SDATE";
	emailTopic[3] = "SDATE_HOUR";
	emailTopic[4] = "FROM";
	emailTopic[5] = "SUBJECT";
	emailTopic[6] = "BODY";
	emailTopic[7] = "SPAM";
	emailTopic[8] = "PATH";


}

Files::~Files(){
}

void Files::printTable(){

	if(!FULL){
		if(!TRANSPOST){
			std::cout << "Id \t From \t Subject \t "
						 "R.Date \t R.Hour \t Spam"
					  << std::endl;
			for (int i = 1; i <= total; i++) {

				std::cout << i << "\t"
						  << email[i-1][FROM] << "\t"
						  << email[i-1][SUBJECT] << "\t\t"
						  << email[i-1][RDATE] << "\t\t"
						  << email[i-1][RDATE_HOUR] << "\t\t"
						  << email[i-1][SPAM] << "\t"
						  << std::endl << std::endl;
			}
		} else{
				super_Table(column); std::cout<<std::endl;
				super_Table(email[column-1][FROM]); std::cout<<std::endl;
				super_Table(email[column-1][SUBJECT]); std::cout<<std::endl;
				super_Table(email[column-1][RDATE]); std::cout<<std::endl;
				super_Table(email[column-1][RDATE_HOUR]); std::cout<<std::endl;
				super_Table(email[column-1][SPAM]); std::cout<<std::endl;
		  }
	}
}

int Files::getTotal(){
	return total;
}

void Files::setEmail(vector<string> filename){

	string line;
	int counter = 0;

//	std::cout << filename.size() << std::endl;
	for(int i = 0; i < filename.size(); i++){
	std::ifstream file(filename[i].c_str());
	if ( file.is_open() ) {
		while( getline(file,line) ) {
	//		std::cout << line << std::endl;
			if (counter < 4){
				if (line.find("Date:") != -1 && counter == 0){
					email[i][RDATE] = line.erase (0, 4+2+3);
				//	std::cout << email[i][RDATE];
					counter = 1;
				}else if(line.find("Date:") != -1 && counter == 1){
					email[i][SDATE] = line.erase (0, 4+2);
					counter = 2;
				}else if(line.find("From:") != -1 && counter == 2){
					email[i][FROM] = line.erase (0, 4+2);
					counter = 3;
				}else if(line.find("Subject:") != -1 && counter == 3){
					email[i][SUBJECT] = line.erase (0, 7+2);
					counter = 4;
				}
			}else
			email[i][BODY] += line;
		}
	} else {
		std::cout << "Problem opening file" << std::endl << std::endl;
	}

	email[i][SPAM] = "Not Classified Yet";
	email[i][PATH] = filename[i];
	setHour(i);

	DEBUG_MSG(email[i][RDATE]);
	DEBUG_MSG(email[i][SDATE]);
	DEBUG_MSG(email[i][FROM]);
	DEBUG_MSG(email[i][SUBJECT]);
	DEBUG_MSG(email[i][BODY]);
	DEBUG_MSG(email[i][SPAM]);
	DEBUG_MSG(email[i][PATH]);

	file.close ();
	counter = 0;
	}
}

void Files::setTotal(int T){
	total = T;
}

void Files::printEmail(int topics, int ID){

	for(int j=0; j < topics; j++){
		std::cout << emailTopic[j] << ": " << email[ID][j] << " ";
		std::cout << std::endl;
	}

}

void Files::printAllEmails(int topics){

	for (int i=0; i < total; i++){
		for(int j=0; j < topics; j++){
			std::cout << email[i][j] << std::endl;
		}
		std::cout << std::endl;
	}

}

int Files::getSpamCount(){

	spamCounter = 0;
	string aux;
	for(int i = 0; i < total; i++){
		aux = email[i][SPAM];
		if(aux.find("S") != -1){
			spamCounter++;
		}
	}
	return spamCounter;
}

void Files::setSpam (string spam, int ID){
	email[ID][SPAM] = spam;
}

void Files::classifyEmail(){
	int result =0;

	//this->setEmail(filename);
	for (int i = 0; i < total; i++){
		DEBUG_MSG(email[i][PATH]);
		result = getSpam(email[i][PATH]);
		/// int result = 0;
		if (result >= SPAM_LIMIT)
			this->setSpam("Yes", i);
		else
			this->setSpam("No", i);
	}
}

string Files::getPath(int ID){
	return email[ID-1][PATH];
}

void Files::setHour(int ID){

	std::size_t position = email[ID][SDATE].find_first_of("1234567890");

	if(position != std::string::npos){

		email[ID][SDATE_HOUR] = email[ID][SDATE].substr((position + (2+1+2+1+4)));
		email[ID][SDATE] = email[ID][SDATE].substr(position, (2+1+2+1+4));
	}	

	position = email[ID][RDATE].find_first_of("1234567890");
	if(position != std::string::npos){

		email[ID][RDATE_HOUR] = email[ID][RDATE].substr((position + (2+1+2+1+4)));
		email[ID][RDATE] = email[ID][RDATE].substr(position, (2+1+2+1+4));
	}



}
