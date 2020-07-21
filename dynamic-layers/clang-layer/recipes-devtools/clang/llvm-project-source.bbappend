FILESEXTRAPATHS_prepend_intel-x86-common := "${THISDIR}/files:"

SPIRV_BRANCH = "${@bb.utils.contains('LLVMVERSION', '9.0.1', 'llvm_release_90', 'llvm_release_100', d)}"

SPIRV9_SRCREV = "70420631144a6a25613ae37178f2cc1d3607b65b"
SPIRV10_SRCREV = "4d43f68a30a510b4e7607351caab3df8e7426a6b"
SPIRV_SRCREV = "${@bb.utils.contains('LLVMVERSION', '9.0.1', '${SPIRV9_SRCREV}', '${SPIRV10_SRCREV}', d)}"

LLVM_RECOMMENDED_PATCHES = " file://BasicBlockUtils-Add-metadata-fixing-in-SplitBlockPre.patch;patchdir=llvm \
                    file://IndVarSimplify-Do-not-use-SCEV-expander-for-IVCount-.patch;patchdir=llvm \
                    "

LLVM9_PATCH_LIST = " file://0001-dont-export-targets-for-binaries.patch \
                    file://llvm9-skip-building-tests.patch;patchdir=llvm/projects/llvm-spirv \
                    ${LLVM_RECOMMENDED_PATCHES} \
                    "
LLVM10_PATCH_LIST = " file://llvm10-skip-building-tests.patch;patchdir=llvm/projects/llvm-spirv \
                    file://fix-shared-libs.patch;patchdir=llvm/projects/llvm-spirv \
                    ${LLVM_RECOMMENDED_PATCHES} \
                    "

SRC_URI_append_intel-x86-common = " \
                                    git://github.com/KhronosGroup/SPIRV-LLVM-Translator.git;protocol=https;branch=${SPIRV_BRANCH};destsuffix=git/llvm/projects/llvm-spirv;name=spirv \
                                    "
SRC_URI_append_intel-x86-common = "${@bb.utils.contains('LLVMVERSION', '9.0.1', '${LLVM9_PATCH_LIST}', '${LLVM10_PATCH_LIST}', d)}"

SRCREV_spirv = "${SPIRV_SRCREV}"
