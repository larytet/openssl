CYREN_INSTALL_HEADERS(engine.h PREFIX openssl)

OPENSSL_ADD_CRYPTO_SOURCES(
    eng_err.c
    eng_lib.c
    eng_list.c
    eng_init.c
    eng_ctrl.c
    eng_table.c
    eng_pkey.c
    eng_fat.c
    eng_all.c
    tb_rsa.c
    tb_dsa.c
    tb_ecdsa.c
    tb_dh.c
    tb_ecdh.c
    tb_rand.c
    tb_store.c
    tb_cipher.c
    tb_digest.c
    tb_pkmeth.c
    tb_asnmth.c
    eng_openssl.c
    eng_cnf.c
    eng_dyn.c
    eng_cryptodev.c
    eng_rdrand.c
    PARENT_SCOPE)

OPENSSL_ADD_CRYPTO_TESTS(
    enginetest.c
    PARENT_SCOPE)
