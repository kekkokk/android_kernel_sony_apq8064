KERNEL_OUT_DIR=/home/duri/lineage_dev/kernel_out
TOOLCHAIN_PATH=/home/duri/lineage_dev/gcc-linaro-5.5.0-2017.10-x86_64_arm-eabi/bin
BOOTIMAGE_TOOLS_PATH=/home/duri/lineage_dev/bootimage_tools
KERNEL_OUT_FILE=${KERNEL_OUT_DIR}/arch/arm/boot/zImage

export ARCH=arm
export CROSS_COMPILE=${TOOLCHAIN_PATH}/arm-eabi-

# make O=${KERNEL_OUT_DIR} clean
make O=${KERNEL_OUT_DIR} fusion3_pollux_defconfig
make O=${KERNEL_OUT_DIR} -j12

${BOOTIMAGE_TOOLS_PATH}/mkbootimg \
--kernel ${KERNEL_OUT_FILE} \
--ramdisk ${BOOTIMAGE_TOOLS_PATH}/initramfs.cpio.gz \
--base 0x80200000 \
--ramdisk_offset 0x02000000 \
--cmdline 'androidboot.hardware=qcom msm_rtb.filter=0x3F ehci-hcd.park=3' \
-o ${BOOTIMAGE_TOOLS_PATH}/new_boot.img

# https://github.com/LineageOS/android_kernel_htc_msm8960/pull/2/files
