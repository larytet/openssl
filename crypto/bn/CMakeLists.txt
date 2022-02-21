CYREN_INSTALL_HEADERS(bn.h PREFIX openssl)
CYREN_INSTALL_HEADERS(bn_lcl.h bn_prime.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    bn_add.c
    bn_div.c
    bn_exp.c
    bn_lib.c
    bn_ctx.c
    bn_mul.c
    bn_mod.c
    bn_print.c
    bn_rand.c
    bn_shift.c
    bn_word.c
    bn_blind.c
    bn_kron.c
    bn_sqrt.c
    bn_gcd.c
    bn_prime.c
    bn_err.c
    bn_sqr.c
    bn_recp.c
    bn_mont.c
    bn_mpi.c
    bn_exp2.c
    bn_gf2m.c
    bn_nist.c
    bn_depr.c
    bn_const.c
    bn_x931p.c
    PARENT_SCOPE)

OPENSSL_ADD_CRYPTO_DEFINITIONS(
    -DOPENSSL_IA32_SSE2
    PARENT_SCOPE)

IF(CYREN_ARCH_IS_AMD64)
    IF(CYREN_OS_IS_WINDOWS)
	OPENSSL_ADD_CRYPTO_SOURCES(
	    bn_asm.c
        rsaz_exp.c
	    PARENT_SCOPE)
    ELSE()
	OPENSSL_ADD_CRYPTO_SOURCES(
	    asm/x86_64-gcc.c
            rsaz_exp.c
	    PARENT_SCOPE)
    ENDIF()

    OPENSSL_ADD_CRYPTO_SOURCES(
        asm/rsaz-x86_64.pl
        asm/rsaz-avx2.pl
        asm/x86_64-gf2m.pl
        asm/x86_64-mont.pl
        asm/x86_64-mont5.pl
        PARENT_SCOPE PERLASM)

    OPENSSL_ADD_CRYPTO_DEFINITIONS(
        -DOPENSSL_BN_ASM_GF2m
        -DOPENSSL_BN_ASM_MONT
        -DOPENSSL_BN_ASM_MONT5
        PARENT_SCOPE)

ELSEIF(CYREN_ARCH_IS_I386)
    OPENSSL_ADD_CRYPTO_SOURCES(
        asm/bn-586.pl
        asm/co-586.pl
        asm/x86-gf2m.pl
        asm/x86-mont.pl
        PARENT_SCOPE PERLASM)

    OPENSSL_ADD_CRYPTO_DEFINITIONS(
        -DOPENSSL_BN_ASM_PART_WORDS
        -DOPENSSL_BN_ASM_GF2m
        -DOPENSSL_BN_ASM_MONT
        PARENT_SCOPE)

ELSEIF(CYREN_ARCH_IS_PPC OR CYREN_ARCH_IS_PPC64)
    OPENSSL_ADD_CRYPTO_SOURCES(
        asm/ppc.pl
        asm/ppc-mont.pl
        PARENT_SCOPE PERLASM)

ELSE()
    MESSAGE(FATAL_ERROR "Unknown architecture")
ENDIF()

OPENSSL_ADD_CRYPTO_TESTS(
    bntest.c
    divtest.c
    exptest.c
    PARENT_SCOPE)
