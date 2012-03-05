# Install script for directory: C:/Users/Admin/TrinityCore/src/tools/map_extractor

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "C:/Program Files/TrinityCore")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "Release")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  IF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
     "C:/Program Files/TrinityCore/mapextractor.exe")
FILE(INSTALL DESTINATION "C:/Program Files/TrinityCore" TYPE EXECUTABLE FILES "C:/Users/Admin/TrinityCore/bin/Debug/mapextractor.exe")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
     "C:/Program Files/TrinityCore/mapextractor.exe")
FILE(INSTALL DESTINATION "C:/Program Files/TrinityCore" TYPE EXECUTABLE FILES "C:/Users/Admin/TrinityCore/bin/Release/mapextractor.exe")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
    list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
     "C:/Program Files/TrinityCore/mapextractor.exe")
FILE(INSTALL DESTINATION "C:/Program Files/TrinityCore" TYPE EXECUTABLE FILES "C:/Users/Admin/TrinityCore/bin/MinSizeRel/mapextractor.exe")
  ELSEIF("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
     "C:/Program Files/TrinityCore/mapextractor.exe")
FILE(INSTALL DESTINATION "C:/Program Files/TrinityCore" TYPE EXECUTABLE FILES "C:/Users/Admin/TrinityCore/bin/RelWithDebInfo/mapextractor.exe")
  ENDIF()
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

