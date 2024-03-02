# - this module looks for OpenBLAS
# Defines:
#  OPENBLAS_INCLUDE_DIR: include path for header files
#  OPENBLAS_LIBRARIES:   required libraries: libopenblas

# Check if environment variable OPENBLAS_ROOT is set
IF( "$ENV{OPENBLAS_ROOT}" STREQUAL "" )
  set(ENV{OPENBLAS_ROOT} "/usr/local/opt/openblas")
endif()

SET(OPENBLAS_FOUND 0)
if ( "$ENV{OPENBLAS_ROOT}" STREQUAL "" )
  MESSAGE(STATUS "OPENBLAS_ROOT environment variable not set." )
  MESSAGE(STATUS "In Linux this can be done in your user .bashrc file by appending the corresponding line, e.g:" )
  MESSAGE(STATUS "export OPENBLAS_ROOT=/usr/local/opt/openblas/R2012b" )
  MESSAGE(STATUS "In Windows this can be done by adding system variable, e.g:" )
  MESSAGE(STATUS "OPENBLAS_ROOT=D:\\Program Files\\OPENBLAS\\R2011a" )
else()
  set(OPENBLAS_INCLUDE_DIR $ENV{OPENBLAS_ROOT}/include)
  INCLUDE_DIRECTORIES(${OPENBLAS_INCLUDE_DIR})

  FIND_LIBRARY( OPENBLAS_BLAS_LIBRARY
    NAMES blas openblas lapack
    PATHS $ENV{OPENBLAS_ROOT}/lib
    PATH_SUFFIXES maci64 glnxa64 glnx86 win64/microsoft win32/microsoft)

  if (APPLE)
    set(blas "$ENV{OPENBLAS_ROOT}/lib")
    set(OPENBLAS_BLAS_LIBRARY "${blas}/libblas.dylib")
  endif()

ENDIF()

# This is common to UNIX and Win32:
SET(OPENBLAS_LIBRARIES
  ${OPENBLAS_BLAS_LIBRARY}
  )

IF(OPENBLAS_INCLUDE_DIR AND OPENBLAS_LIBRARIES)
  SET(OPENBLAS_FOUND 1)
ENDIF(OPENBLAS_INCLUDE_DIR AND OPENBLAS_LIBRARIES)

MARK_AS_ADVANCED(
  OPENBLAS_LIBRARIES
  OPENBLAS_BLAS_LIBRARY
  OPENBLAS_INCLUDE_DIR
  OPENBLAS_FOUND
  OPENBLAS_ROOT
  )
