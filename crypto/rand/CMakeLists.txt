CYREN_INSTALL_HEADERS(rand.h PREFIX openssl)

OPENSSL_ADD_CRYPTO_SOURCES(
    md_rand.c
    randfile.c
    rand_lib.c
    rand_err.c
    rand_egd.c
    rand_win.c
    rand_unix.c
    rand_os2.c
    rand_nw.c
    PARENT_SCOPE)

OPENSSL_ADD_CRYPTO_TESTS(
    randtest.c
    PARENT_SCOPE)
