#!/bin/bash
echo "================== llvm =================="
mkdir llvm && tar -xvf llvm-7.0.0.tar.xz --directory=llvm --strip-components=1
rm llvm-7.0.0.tar.xz
echo "================== llvm/tools/clang =================="
mkdir llvm/tools/clang && tar -xvf cfe-7.0.0.tar.xz --directory=llvm/tools/clang --strip-components=1
rm cfe-7.0.0.tar.xz
echo "================== llvm/tools/clang/tools/extra =================="
mkdir llvm/tools/clang/tools && tar -xvf clang-tools-extra-7.0.0.tar.xz --directory=llvm/tools/clang/tools --strip-components=1
rm clang-tools-extra-7.0.0.tar.xz
echo "================== llvm/tools/lld =================="
mkdir llvm/tools/lld && tar -xvf lld-7.0.0.tar.xz --directory=llvm/tools/lld --strip-components=1
rm lld-7.0.0.tar.xz
echo "================== llvm/tools/lldb =================="
mkdir llvm/tools/lldb && tar -xvf lldb-7.0.0.tar.xz --directory=llvm/tools/lldb --strip-components=1
rm lldb-7.0.0.tar.xz
echo "================== llvm/tools/polly =================="
mkdir llvm/tools/polly && tar -xvf polly-7.0.0.tar.xz --directory=llvm/tools/polly --strip-components=1
rm polly-7.0.0.tar.xz
echo "================== llvm/projects/compiler-rt =================="
mkdir llvm/projects/compiler-rt && tar -xvf compiler-rt-7.0.0.tar.xz --directory=llvm/projects/compiler-rt --strip-components=1
rm compiler-rt-7.0.0.tar.xz
echo "================== llvm/projects/openmp =================="
mkdir llvm/projects/openmp && tar -xvf openmp-7.0.0.tar.xz --directory=llvm/projects/openmp --strip-components=1
rm openmp-7.0.0.tar.xz
echo "================== llvm/projects/libcxx =================="
mkdir llvm/projects/libcxx && tar -xvf libcxx-7.0.0.tar.xz --directory=llvm/projects/libcxx --strip-components=1
rm libcxx-7.0.0.tar.xz
echo "================== llvm/projects/libcxxabi =================="
mkdir llvm/projects/libcxxabi && tar -xvf libcxxabi-7.0.0.tar.xz --directory=llvm/projects/libcxxabi --strip-components=1
rm libcxxabi-7.0.0.tar.xz
echo "================== llvm/projects/libunwind =================="
mkdir llvm/projects/libunwind && tar -xvf libunwind-7.0.0.tar.xz --directory=llvm/projects/libunwind --strip-components=1
rm libunwind-7.0.0.tar.xz
read -p "Appuyez sur [Entree] pour continuer..."
