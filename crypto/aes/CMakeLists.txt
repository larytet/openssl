CYREN_INSTALL_HEADERS(aes.h PREFIX openssl)
CYREN_INSTALL_HEADERS(aes_locl.h INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    aes_misc.c
    aes_ecb.c
    aes_cfb.c
    aes_ofb.c
    aes_ctr.c
    aes_ige.c
    aes_wrap.c
    PARENT_SCOPE)

IF(CYREN_ARCH_IS_AMD64)
    OPENSSL_ADD_CRYPTO_SOURCES(
        asm/aes-x86_64.pl
        asm/aesni-mb-x86_64.pl
        asm/aesni-sha1-x86_64.pl
        asm/aesni-sha256-x86_64.pl
        asm/aesni-x86_64.pl
        asm/bsaes-x86_64.pl
        asm/vpaes-x86_64.pl
        PARENT_SCOPE PERLASM)

    OPENSSL_ADD_CRYPTO_DEFINITIONS(
        -DAES_ASM
        -DBSAES_ASM
        -DVPAES_ASM
        PARENT_SCOPE)

ELSEIF(CYREN_ARCH_IS_I386)
    OPENSSL_ADD_CRYPTO_SOURCES(
        asm/aes-586.pl
        asm/aesni-x86.pl
        asm/vpaes-x86.pl
        PARENT_SCOPE PERLASM)

    OPENSSL_ADD_CRYPTO_DEFINITIONS(
        -DAES_ASM
        -DVPAES_ASM
        PARENT_SCOPE)

ELSEIF(CYREN_ARCH_IS_PPC OR CYREN_ARCH_IS_PPC64)
    OPENSSL_ADD_CRYPTO_SOURCES(
        aes_core.c
        aes_cbc.c
        PARENT_SCOPE)

    OPENSSL_ADD_CRYPTO_SOURCES(
        asm/aes-ppc.pl
        asm/aesp8-ppc.pl
        asm/vpaes-ppc.pl
        PARENT_SCOPE PERLASM)

    OPENSSL_ADD_CRYPTO_DEFINITIONS(
        -DAES_ASM
        -DAESP8_ASM
        -DVPAES_ASM
        PARENT_SCOPE)

ELSE()
    MESSAGE(FATAL_ERROR "Unknown architecture")
ENDIF()
