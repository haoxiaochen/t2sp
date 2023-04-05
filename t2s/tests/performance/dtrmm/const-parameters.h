#ifndef TRMM_CONST_PARAMS_H
#define TRMM_CONST_PARAMS_H

// Inner loop bounds, which are static constant parameters of the design
#ifdef GPU
    #define KKK         8
    #define JJJ         8
    #define III         16
    #define JJ          2
    #define II          4
    #define KK          4
#else // FPGA
    #ifdef TINY // For verifying correctness only
        #define KKK        8
        #define JJJ        4//2 // 4
        #define III        4//2 // 4
        #define JJ         16 // 4
        #define II         16 // 4
        #define KK         8//2 // 4
    #elif S10
        #define KKK         8
        #define JJJ         4
        #define III         8
        #define JJ          32
        #define II          16
        #define KK          16
    #else   // For A10
        #define KKK         8
        #define JJJ         4
        #define III         8 
        #define KK          16
        #define JJ          32
        #define II          16
    #endif
#endif

#endif
