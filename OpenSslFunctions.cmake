INCLUDE(FindPerl)

IF(NOT PERL_FOUND)
    MESSAGE(FATAL_ERROR "perl not found")
ENDIF()

INCLUDE(CyrenAsmSettings)

IF(CYREN_OS_IS_WINDOWS AND NOT CMAKE_ASM_NASM_COMPILER_LOADED)
    MESSAGE(FATAL_ERROR "nasm not found")
ENDIF()

STRING(TIMESTAMP OPENSSL_BUILD_DATE)

IF(CYREN_ARCH_IS_I386 OR CYREN_ARCH_IS_AMD64)
    IF(CYREN_OS_IS_WINDOWS)
        SET(ASM_EXTENSION "asm")
        SET(PERLASM_SCHEME win32n)
    ELSE()
        SET(ASM_EXTENSION "s")
        SET(PERLASM_SCHEME elf)
    ENDIF()
ELSEIF(CYREN_ARCH_IS_PPC)
    SET(ASM_EXTENSION "s")
    SET(PERLASM_SCHEME linux32)
ELSEIF(CYREN_ARCH_IS_PPC64)
    SET(ASM_EXTENSION "s")
    SET(PERLASM_SCHEME linux64)
ELSE()
    MESSAGE(FATAL_ERROR "Unknown architecture")
ENDIF()

SET(OPENSSL_CRYPTO_SOURCES)
SET(OPENSSL_CRYPTO_PERLASM_SOURCES)
SET(OPENSSL_CRYPTO_DEFINITIONS)
SET(OPENSSL_CRYPTO_TESTS)

MACRO(OPENSSL_DEFINE_OPTION NAME)
    SET(ARGS ${ARGN})

    CYREN_POP_KEYWORD(ARGS DESCRIPTION)

    IF(NOT DESCRIPTION)
        SET(DESCRIPTION ${NAME})
    ENDIF()

    IF(ARGS)
        SET(VALUE ${ARGS})
    ELSE()
        SET(VALUE OFF)
    ENDIF()

    SET(OPENSSL_ENABLE_${NAME} ${VALUE} CACHE BOOL
        "Enable ${DESCRIPTION}")

    IF(NOT OPENSSL_ENABLE_${NAME})
       SET(OPENSSL_NO_${NAME} TRUE)
    ENDIF()
ENDMACRO()

FUNCTION(OPENSSL_ADD_TEST FILE LIBRARY)
    GET_FILENAME_COMPONENT(FILE ${FILE} ABSOLUTE)
    GET_FILENAME_COMPONENT(NAME ${FILE} NAME_WE)
    GET_FILENAME_COMPONENT(PARENT ${FILE} DIRECTORY)
    GET_FILENAME_COMPONENT(PARENT ${PARENT} NAME)

    ADD_EXECUTABLE(${NAME} ${FILE})
    TARGET_LINK_LIBRARIES(${NAME} ${LIBRARY})

    ADD_LOCAL_OR_REMOTE_TEST(${PARENT}/${NAME} ${NAME} ${ARGN})
ENDFUNCTION()

MACRO(OPENSSL_ADD_TESTS_FOR LIBRARY)
    FOREACH(ARG ${ARGN})
        OPENSSL_ADD_TEST(${ARG} ${LIBRARY})
    ENDFOREACH()
ENDMACRO()

MACRO(OPENSSL_ADD_CRYPTO_SOURCES)
    SET(ARGS)
    LIST(APPEND ARGS ${ARGN})

    CYREN_POP_KEYWORD(ARGS PARENT_SCOPE)
    CYREN_POP_KEYWORD(ARGS PERLASM)

    IF(PERLASM)
        SET(VAR OPENSSL_CRYPTO_PERLASM_SOURCES)
    ELSE()
        SET(VAR OPENSSL_CRYPTO_SOURCES)
    ENDIF()

    FOREACH(ARG ${ARGS})
        GET_FILENAME_COMPONENT(ARG ${ARG} ABSOLUTE)
        LIST(APPEND ${VAR} ${ARG})
    ENDFOREACH()

    IF(PARENT_SCOPE)
        SET(${VAR} ${${VAR}} PARENT_SCOPE)
    ENDIF()
ENDMACRO()

MACRO(OPENSSL_ADD_CRYPTO_DEFINITIONS)
    SET(ARGS)
    LIST(APPEND ARGS ${ARGN})

    CYREN_POP_KEYWORD(ARGS PARENT_SCOPE)

    LIST(APPEND OPENSSL_CRYPTO_DEFINITIONS ${ARGS})

    IF(PARENT_SCOPE)
        SET(OPENSSL_CRYPTO_DEFINITIONS ${OPENSSL_CRYPTO_DEFINITIONS} PARENT_SCOPE)
    ENDIF()
ENDMACRO()

MACRO(OPENSSL_ADD_CRYPTO_TESTS)
    SET(ARGS)
    LIST(APPEND ARGS ${ARGN})

    CYREN_POP_KEYWORD(ARGS PARENT_SCOPE)

    FOREACH(ARG ${ARGS})
        GET_FILENAME_COMPONENT(ARG ${ARG} ABSOLUTE)
        LIST(APPEND OPENSSL_CRYPTO_TESTS ${ARG})
    ENDFOREACH()

    IF(PARENT_SCOPE)
        SET(OPENSSL_CRYPTO_TESTS ${OPENSSL_CRYPTO_TESTS} PARENT_SCOPE)
    ENDIF()
ENDMACRO()

FUNCTION(OPENSSL_GET_DIRECTORY_COMPILE_DEFINITIONS VAR)
    SET(${VAR})

    GET_PROPERTY(DEFINITIONS DIRECTORY PROPERTY COMPILE_DEFINITIONS)

    FOREACH(DEFINITION ${DEFINITIONS})
        LIST(APPEND ${VAR} "-D${DEFINITION}")
    ENDFOREACH()

    SET(${VAR} "${${VAR}}" PARENT_SCOPE)
ENDFUNCTION()

FUNCTION(OPENSSL_GENERATE_ASM PERL_SOURCE OUTPUT)
    OPENSSL_GET_DIRECTORY_COMPILE_DEFINITIONS(FLAGS)

    IF(CYREN_ARCH_IS_I386)
        SET(COMMAND
            ${PERL_EXECUTABLE} ${PERL_SOURCE} ${PERLASM_SCHEME} ${FLAGS} > ${OUTPUT})
    ELSEIF(CYREN_OS_IS_WINDOWS)
        SET(COMMAND
            ${CMAKE_COMMAND} -E env ASM="${CMAKE_ASM_NASM_COMPILER} -f win64"
            ${PERL_EXECUTABLE} ${PERL_SOURCE} ${OUTPUT})
    ELSE()
        SET(COMMAND
            ${PERL_EXECUTABLE} ${PERL_SOURCE} ${PERLASM_SCHEME} ${OUTPUT})
    ENDIF()

    IF(CYREN_OS_IS_WINDOWS)
        SET_PROPERTY(SOURCE ${OUTPUT} PROPERTY LANGUAGE ASM_NASM)
        SET_PROPERTY(SOURCE ${OUTPUT} PROPERTY COMPILE_DEFINITIONS "")
    ELSEIF(CYREN_C_COMPILER_IS_CLANG)
        # CMake does not separate compiler and assembler flags.
        SET_PROPERTY(SOURCE ${OUTPUT} PROPERTY COMPILE_FLAGS "-Qunused-arguments")
    ENDIF()

    ADD_CUSTOM_COMMAND(
        OUTPUT  ${OUTPUT}
        COMMAND ${COMMAND}
        DEPENDS ${PERL_SOURCE})
ENDFUNCTION()
