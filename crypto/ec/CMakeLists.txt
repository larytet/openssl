CYREN_INSTALL_HEADERS(ec.h PREFIX openssl)
CYREN_INSTALL_HEADERS(ec_lcl.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    ec_lib.c
    ecp_smpl.c
    ecp_mont.c
    ecp_nist.c
    ec_cvt.c
    ec_mult.c
    ec_err.c
    ec_curve.c
    ec_check.c
    ec_print.c
    ec_asn1.c
    ec_key.c
    ec2_smpl.c
    ec2_mult.c
    ec_ameth.c
    ec_pmeth.c
    eck_prn.c
    ecp_nistp224.c
    ecp_nistp256.c
    ecp_nistp521.c
    ecp_nistputil.c
    ecp_oct.c
    ec2_oct.c
    ec_oct.c
    PARENT_SCOPE)

IF(EXPENSIVE_TESTS)
    OPENSSL_ADD_CRYPTO_TESTS(
        ectest.c
        PARENT_SCOPE)
ENDIF()

IF(CYREN_ARCH_IS_AMD64)
    OPENSSL_ADD_CRYPTO_SOURCES(
        ecp_nistz256.c
        PARENT_SCOPE)

    OPENSSL_ADD_CRYPTO_SOURCES(
        asm/ecp_nistz256-x86_64.pl
        PARENT_SCOPE PERLASM)

    OPENSSL_ADD_CRYPTO_DEFINITIONS(
        -DECP_NISTZ256_ASM
        PARENT_SCOPE)
ENDIF()
