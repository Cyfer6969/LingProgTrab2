#ifndef ERROR_H
#define ERROR_H


#ifdef DEBUGMODE
#define DEBUG_MSG(str) do { std::cout << str << std::endl; } while(false)
#else
#define	DEBUG_MSG(str) do {} while(false)
#endif


#define	EXIT_FROM_USER		1

#endif // ERROR

