#ifndef MK1MF_BUILD
  #define CFLAGS "compiler: @CMAKE_C_COMPILER@ @CMAKE_C_FLAGS@"
  #define PLATFORM "platform: @CMAKE_SYSTEM_NAME@"
  #define DATE "built on: @OPENSSL_BUILD_DATE@"
#endif
