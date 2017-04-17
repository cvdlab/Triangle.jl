#ifndef COMMONDEFINE_H
    #define REAL double
    #define _NDIM 2
    #ifdef _MSC_VER
        #define CPU86 1
    #endif

    #define TRIANGULATEIO_NAME "triangulateio"
    #define CDT_ONLY 1
    #define TRILIBRARY 1
    #define REDUCED 1
    #define NO_TIMER 1
    #define ANSI_DECLARATORS 1
	#define VOID int
    #define ANSILOCALDECL 
	
    #ifdef _MSC_VER // Visual Studio specific macro
        #define DLLEXPORT __declspec(dllexport)
        #define DLLLOCAL
    #else 
        #define DLLEXPORT __attribute__ ((visibility("default")))
        #define DLLLOCAL __attribute__ ((visibility("hidden")))
    #endif 

	#define COMMONDEFINE_H
#endif