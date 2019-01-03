# set the resource compiler (RHBZ #652435)
set (CMAKE_RC_COMPILER @PREFIX@/bin/@TRIPLE@-windres)
set (CMAKE_MC_COMPILER @PREFIX@/bin/@TRIPLE@-windmc)

# override boost thread component suffix as mingw-w64-boost is compiled with threadapi=win32
set (Boost_THREADAPI win32)

# These are needed for compiling lapack (RHBZ #753906)
set (CMAKE_Fortran_COMPILER @PREFIX@/bin/@TRIPLE@-gfortran)
set (CMAKE_AR:FILEPATH @PREFIX@/bin/@TRIPLE@-ar)
set (CMAKE_RANLIB:FILEPATH @PREFIX@/bin/@TRIPLE@-ranlib)