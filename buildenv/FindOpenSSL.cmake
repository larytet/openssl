SET(OPENSSL_FOUND True)
CYREN_GET_INCLUDE_DIRECTORY(OPENSSL_INCLUDE_DIR openssl)
SET(OPENSSL_CRYPTO_LIBRARY crypto)
SET(OPENSSL_SSL_LIBRARY ssl)
SET(OPENSSL_LIBRARIES ${OPENSSL_SSL_LIBRARY} ${OPENSSL_CRYPTO_LIBRARY})
SET(OPENSSL_VERSION "1.0.2t")
