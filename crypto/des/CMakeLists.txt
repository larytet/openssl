CYREN_INSTALL_HEADERS(des.h des_old.h PREFIX openssl)
CYREN_INSTALL_HEADERS(des_locl.h rpc_des.h spr.h des_ver.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    set_key.c
    ecb_enc.c
    cbc_enc.c
    ecb3_enc.c
    cfb64enc.c
    cfb64ede.c
    cfb_enc.c
    ofb64ede.c
    enc_read.c
    enc_writ.c
    ofb64enc.c
    ofb_enc.c
    str2key.c
    pcbc_enc.c
    qud_cksm.c
    rand_key.c
    fcrypt.c
    xcbc_enc.c
    rpc_enc.c
    cbc_cksm.c
    ede_cbcm_enc.c
    des_old.c
    des_old2.c
    read2pwd.c
    PARENT_SCOPE)

IF(CYREN_ARCH_IS_AMD64)
    OPENSSL_ADD_CRYPTO_SOURCES(
        des_enc.c
        fcrypt_b.c
        PARENT_SCOPE)

ELSEIF(CYREN_ARCH_IS_I386)
    OPENSSL_ADD_CRYPTO_SOURCES(
        asm/crypt586.pl
        asm/des-586.pl
        PARENT_SCOPE PERLASM)

ELSEIF(CYREN_ARCH_IS_PPC OR CYREN_ARCH_IS_PPC64)
    OPENSSL_ADD_CRYPTO_SOURCES(
        des_enc.c
        fcrypt_b.c
        PARENT_SCOPE)

ELSE()
    MESSAGE(FATAL_ERROR "Unknown architecture")
ENDIF()

OPENSSL_ADD_CRYPTO_TESTS(
    destest.c
    PARENT_SCOPE)
