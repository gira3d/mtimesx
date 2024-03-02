cmake_minimum_required(VERSION 2.8.3)
project(mtimesx)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DDEFINEUNIX -largeArrayDims -lopenblas")

if(NOT DEFINED CMAKE_SUPPRESS_DEVELOPER_WARNINGS)
     set(CMAKE_SUPPRESS_DEVELOPER_WARNINGS 1 CACHE INTERNAL "No dev warnings")
endif()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_LIST_DIR}/cmake")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17")

find_package(OpenBLAS REQUIRED)

find_package(MATLAB QUIET)

if (MATLAB_FOUND)

  # MATLAB Macro definitions
  add_definitions(/DMATLAB_MEX_FILE)
  add_definitions(/DMX_COMPAT_32)

  add_library(${PROJECT_NAME} SHARED
    src/${PROJECT_NAME}.c
  )

  target_link_libraries(${PROJECT_NAME}
    ${MATLAB_LIBRARIES}
    ${OPENBLAS_LIBRARIES}
  )

  if (UNIX AND APPLE)
    set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX .mexmaci64 PREFIX "")
  elseif (UNIX)
    set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX .mexa64 PREFIX "")
  endif()

  install(TARGETS ${PROJECT_NAME}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_PREFIX}
    LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}
    RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}
  )

  install(DIRECTORY cmake/
    DESTINATION "share/${PROJECT_NAME}"
    FILES_MATCHING PATTERN "*.cmake"
  )

endif()
