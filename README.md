# Static Analysis of Code using Clang
This repository is build to implement a static analysis using Clang (https://clang.llvm.org/) that warns the developer if they have any method in their C++ code that has more than 3 parameters.

Clone this directory.
% cd llvm/llvm
% mkdir build && cd build/
% cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ..
% make check-clang-tools
% export PATH=$PWD/bin:$PATH
% cd ../..
% clang-tidy -checks='-*,misc-attr-checker' code.cpp --
