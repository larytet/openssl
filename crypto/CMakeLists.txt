CYREN_INSTALL_HEADERS(
    crypto.h
    ebcdic.h
    opensslv.h
    ossl_typ.h
    symhacks.h
    PREFIX openssl)

CYREN_INSTALL_HEADERS(
    constant_time_locl.h
    cryptlib.h
    md32_common.h
    o_time.h
    o_str.h
    o_dir.h
    INTERNAL)

CYREN_CONFIGURE_HEADERS(
    buildinf.h.cmake
    INTERNAL)

OPENSSL_ADD_CRYPTO_SOURCES(
    cpt_err.c
    cryptlib.c
    cversion.c
    ebcdic.c
    ex_data.c
    fips_ers.c
    getenv.c
    mem.c
    mem_dbg.c
    o_dir.c
    o_fips.c
    o_init.c
    o_str.c
    o_time.c
    uid.c)

OPENSSL_ADD_CRYPTO_TESTS(
    constant_time_test.c)

IF(CYREN_ARCH_IS_AMD64)
    OPENSSL_ADD_CRYPTO_SOURCES(x86_64cpuid.pl PERLASM)
ELSEIF(CYREN_ARCH_IS_I386)
    OPENSSL_ADD_CRYPTO_SOURCES(x86cpuid.pl PERLASM)
ELSEIF(CYREN_ARCH_IS_PPC OR CYREN_ARCH_IS_PPC64)
    OPENSSL_ADD_CRYPTO_SOURCES(ppccpuid.pl PERLASM)
    OPENSSL_ADD_CRYPTO_SOURCES(ppccap.c)
ELSE()
    MESSAGE(FATAL_ERROR "Unknown architecture")
ENDIF()

ADD_SUBDIRECTORY(aes)
ADD_SUBDIRECTORY(asn1)
ADD_SUBDIRECTORY(bf)
ADD_SUBDIRECTORY(bio)
ADD_SUBDIRECTORY(bn)
ADD_SUBDIRECTORY(buffer)
ADD_SUBDIRECTORY(camellia)
ADD_SUBDIRECTORY(cast)
ADD_SUBDIRECTORY(cmac)
ADD_SUBDIRECTORY(cms)
ADD_SUBDIRECTORY(comp)
ADD_SUBDIRECTORY(conf)
ADD_SUBDIRECTORY(des)
ADD_SUBDIRECTORY(dh)
ADD_SUBDIRECTORY(dsa)
ADD_SUBDIRECTORY(dso)
ADD_SUBDIRECTORY(ec)
ADD_SUBDIRECTORY(ecdh)
ADD_SUBDIRECTORY(ecdsa)
ADD_SUBDIRECTORY(engine)
ADD_SUBDIRECTORY(err)
ADD_SUBDIRECTORY(evp)
ADD_SUBDIRECTORY(hmac)
ADD_SUBDIRECTORY(idea)
ADD_SUBDIRECTORY(jpake)
ADD_SUBDIRECTORY(krb5)
ADD_SUBDIRECTORY(lhash)
ADD_SUBDIRECTORY(md2)
ADD_SUBDIRECTORY(md4)
ADD_SUBDIRECTORY(md5)
ADD_SUBDIRECTORY(mdc2)
ADD_SUBDIRECTORY(modes)
ADD_SUBDIRECTORY(objects)
ADD_SUBDIRECTORY(ocsp)
ADD_SUBDIRECTORY(pem)
ADD_SUBDIRECTORY(pkcs12)
ADD_SUBDIRECTORY(pkcs7)
ADD_SUBDIRECTORY(pqueue)
ADD_SUBDIRECTORY(rand)
ADD_SUBDIRECTORY(rc2)
ADD_SUBDIRECTORY(rc4)
ADD_SUBDIRECTORY(rc5)
ADD_SUBDIRECTORY(ripemd)
ADD_SUBDIRECTORY(rsa)
ADD_SUBDIRECTORY(seed)
ADD_SUBDIRECTORY(sha)
ADD_SUBDIRECTORY(srp)
ADD_SUBDIRECTORY(stack)
ADD_SUBDIRECTORY(store)
ADD_SUBDIRECTORY(ts)
ADD_SUBDIRECTORY(txt_db)
ADD_SUBDIRECTORY(ui)
ADD_SUBDIRECTORY(whrlpool)
ADD_SUBDIRECTORY(x509)
ADD_SUBDIRECTORY(x509v3)

ADD_DEFINITIONS(${OPENSSL_CRYPTO_DEFINITIONS})

FOREACH(SCRIPT ${OPENSSL_CRYPTO_PERLASM_SOURCES})
    GET_FILENAME_COMPONENT(OUTPUT ${SCRIPT} NAME_WE)
    SET(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${OUTPUT}.${ASM_EXTENSION})

    OPENSSL_GENERATE_ASM(${SCRIPT} ${OUTPUT})
    OPENSSL_ADD_CRYPTO_SOURCES(${OUTPUT})

    IF(${SCRIPT} MATCHES "crypto/sha/asm/sha512-x86_64\\.pl$")
        # This script generates assembler for both sha256 and sha512.
        SET(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/sha256-x86_64.${ASM_EXTENSION}")

        OPENSSL_GENERATE_ASM(${SCRIPT} ${OUTPUT})
        OPENSSL_ADD_CRYPTO_SOURCES(${OUTPUT})
    ENDIF()

    IF(${SCRIPT} MATCHES "crypto/sha/asm/sha512-ppc\\.pl$")
        # This script generates assembler for both sha256 and sha512.
        SET(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/sha256-ppc.${ASM_EXTENSION}")

        OPENSSL_GENERATE_ASM(${SCRIPT} ${OUTPUT})
        OPENSSL_ADD_CRYPTO_SOURCES(${OUTPUT})
    ENDIF()

    IF(${SCRIPT} MATCHES "crypto/sha/asm/sha512p8-ppc\\.pl$")
        # This script generates assembler for both sha256 and sha512.
        SET(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/sha256p8-ppc.${ASM_EXTENSION}")

        OPENSSL_GENERATE_ASM(${SCRIPT} ${OUTPUT})
        OPENSSL_ADD_CRYPTO_SOURCES(${OUTPUT})
    ENDIF()
ENDFOREACH()

ADD_LIBRARY(crypto ${OPENSSL_CRYPTO_SOURCES})
TARGET_INCLUDE_DIRECTORIES(crypto PUBLIC ${openssl_BINARY_DIR}/include)

IF(CYREN_OS_IS_WINDOWS)
    TARGET_LINK_LIBRARIES(crypto ws2_32 gdi32 crypt32)
    SET_TARGET_PROPERTIES(crypto PROPERTIES OUTPUT_NAME "libeay32")

    # Disable warnings about:
    #  - applying unary minus operator to unsigned type
    #  - function with different const qualifiers
    #  - implicit conversion of result of 32-bit shift to 64 bits
    SET_PROPERTY(SOURCE ec/ecp_nistz256.c bio/b_print.c
                 APPEND_STRING PROPERTY COMPILE_FLAGS
                 " /wd4146 /wd4090 /wd4334")
ELSE()
    ADD_LIBRARY(crypto-shared SHARED ${OPENSSL_CRYPTO_SOURCES})
    SET_TARGET_PROPERTIES(crypto-shared PROPERTIES
        OUTPUT_NAME "crypto"
        VERSION "1.0.0"
        SOVERSION "1")
ENDIF()

INCLUDE_DIRECTORIES(. ..)

FOREACH(TEST ${OPENSSL_CRYPTO_TESTS})
    IF(${TEST} MATCHES "crypto/evp/evp_test\\.c$")
        OPENSSL_ADD_TEST(${TEST} crypto evptests.txt)
    ELSE()
        OPENSSL_ADD_TEST(${TEST} crypto)
    ENDIF()
ENDFOREACH()
