ADD_SUBDIRECTORY(ccgost)

SET(ENGINES
    4758cca
    aep
    atalla
    capi
    chil
    cswift
    gmp
    nuron
    padlock
    sureware
    ubsec)

FOREACH(ENGINE ${ENGINES})
    ADD_LIBRARY(${ENGINE} SHARED e_${ENGINE}.c)

    SET_TARGET_PROPERTIES(${ENGINE} PROPERTIES
	VERSION "1.0.0"
	SOVERSION "1")

    TARGET_LINK_LIBRARIES(${ENGINE} crypto)
ENDFOREACH()
