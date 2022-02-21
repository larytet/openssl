CYREN_INSTALL_HEADERS(
    ssl.h
    ssl2.h
    ssl3.h
    ssl23.h
    tls1.h
    dtls1.h
    kssl.h
    srtp.h
    PREFIX openssl)

CYREN_INSTALL_HEADERS(
    ssl_locl.h
    kssl_lcl.h
    INTERNAL)

SET(SOURCES
    s2_meth.c
    s2_srvr.c
    s2_clnt.c
    s2_lib.c
    s2_enc.c
    s2_pkt.c
    s3_meth.c
    s3_srvr.c
    s3_clnt.c
    s3_lib.c
    s3_enc.c
    s3_pkt.c
    s3_both.c
    s3_cbc.c
    s23_meth.c
    s23_srvr.c
    s23_clnt.c
    s23_lib.c
    s23_pkt.c
    t1_meth.c
    t1_srvr.c
    t1_clnt.c
    t1_lib.c
    t1_enc.c
    t1_ext.c
    d1_meth.c
    d1_srvr.c
    d1_clnt.c
    d1_lib.c
    d1_pkt.c
    d1_both.c
    d1_srtp.c
    ssl_lib.c
    ssl_err2.c
    ssl_cert.c
    ssl_sess.c
    ssl_ciph.c
    ssl_stat.c
    ssl_rsa.c
    ssl_asn1.c
    ssl_txt.c
    ssl_algs.c
    ssl_conf.c
    bio_ssl.c
    ssl_err.c
    kssl.c
    tls_srp.c
    t1_trce.c
    t1_reneg.c
    ssl_utst.c)

ADD_LIBRARY(ssl ${SOURCES})
TARGET_LINK_LIBRARIES(ssl crypto)
TARGET_INCLUDE_DIRECTORIES(ssl PUBLIC ${openssl_BINARY_DIR}/include)

IF(CYREN_OS_IS_WINDOWS)
    SET_TARGET_PROPERTIES(ssl PROPERTIES OUTPUT_NAME "ssleay32")
ELSE()
    ADD_LIBRARY(ssl-shared SHARED ${SOURCES})
    SET_TARGET_PROPERTIES(ssl-shared PROPERTIES
        OUTPUT_NAME "ssl"
        VERSION "1.0.0"
        SOVERSION "1")
    TARGET_LINK_LIBRARIES(ssl-shared crypto-shared)
ENDIF()

OPENSSL_ADD_TESTS_FOR(ssl
    ssltest.c
    heartbeat_test.c
    clienthellotest.c
    sslv2conftest.c
    bad_dtls_test.c)

ADD_LIBRARY(ssltestlib ../test/ssltestlib.c)
TARGET_LINK_LIBRARIES(ssltestlib ssl)

OPENSSL_ADD_TEST(dtlstest.c ssltestlib ../apps/server.pem ../apps/server.pem)

FILE(COPY ../apps DESTINATION .. FILES_MATCHING PATTERN *.pem)
