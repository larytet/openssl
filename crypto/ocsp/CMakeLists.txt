CYREN_INSTALL_HEADERS(ocsp.h PREFIX openssl)

OPENSSL_ADD_CRYPTO_SOURCES(
    ocsp_asn.c
    ocsp_ext.c
    ocsp_ht.c
    ocsp_lib.c
    ocsp_cl.c
    ocsp_srv.c
    ocsp_prn.c
    ocsp_vfy.c
    ocsp_err.c
    PARENT_SCOPE)
