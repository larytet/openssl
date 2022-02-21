CYREN_INSTALL_HEADERS(x509.h x509_vfy.h PREFIX openssl)
CYREN_INSTALL_HEADERS(vpm_int.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    x509_def.c
    x509_d2.c
    x509_r2x.c
    x509_cmp.c
    x509_obj.c
    x509_req.c
    x509spki.c
    x509_vfy.c
    x509_set.c
    x509cset.c
    x509rset.c
    x509_err.c
    x509name.c
    x509_v3.c
    x509_ext.c
    x509_att.c
    x509type.c
    x509_lu.c
    x_all.c
    x509_txt.c
    x509_trs.c
    by_file.c
    by_dir.c
    x509_vpm.c
    PARENT_SCOPE)

OPENSSL_ADD_CRYPTO_TESTS(
    verify_extra_test.c
    PARENT_SCOPE)

FILE(COPY ../../test/certs DESTINATION ..)
