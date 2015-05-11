#include "PerlInterpreter.h"


PerlInterpreter *my_perl;

using namespace std;

int getSpam(std::string email) {

	char* my_argv[] = { "", "Email.pl"};

	my_perl = perl_alloc();
	perl_construct(my_perl);
	PL_exit_flags |= PERL_EXIT_DESTRUCT_END;

	perl_parse(my_perl, NULL, 2, my_argv, (char**)NULL);
	perl_run(my_perl);

	dSP; 

	ENTER;
	SAVETMPS;

	PUSHMARK(SP);
	XPUSHs(sv_2mortal(newSVpv(email.c_str(), 0)));
	PUTBACK;

	call_pv("Main", G_SCALAR);

	SPAGAIN;

	int resultado = POPi;

	PUTBACK;
	FREETMPS;
	LEAVE;


	perl_destruct(my_perl);
	perl_free(my_perl);

	return resultado;
}
