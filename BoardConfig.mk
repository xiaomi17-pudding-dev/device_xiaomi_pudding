#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/pudding

# Kernel
KERNEL_PREBUILT_DIR := device/xiaomi/pudding-kernel

# Inherit from sm8850-common
include device/xiaomi/sm8850-common/BoardConfigCommon.mk

# Filesystem
TARGET_FS_CONFIG_GEN += $(DEVICE_PATH)/configs/fs/config.fs

# VINTF
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(DEVICE_PATH)/configs/vintf/device_framework_matrix.xml

# Display
TARGET_SCREEN_DENSITY := 520

# Kernel
# swinfo.fingerprint is required for stock vendor camera/sensor components to verify build fingerprint
BOARD_KERNEL_CMDLINE += swinfo.fingerprint=pudding:16/OS3.0.335.0.XPCMI:user

# Neoteric-OS: its Qualcomm common layer creates the vendor firmware mount points from Soong
# (device/qcom/common) and from make (core-utils AndroidBoardCommon.mk), like on its own devices
BUILD_BROKEN_DUP_RULES := true
# Its Qualcomm recovery-ext (librecovery_updater) talks to UFS through the kernel's BSG interface
SOONG_CONFIG_NAMESPACES += ufsbsg
SOONG_CONFIG_ufsbsg += ufsframework
SOONG_CONFIG_ufsbsg_ufsframework := bsg
# Its platform policy labels the powercap sysfs nodes
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/neoteric
# Its board Soong variables are exported before build/make computes this default (same value)
TARGET_MAX_PAGE_SIZE_SUPPORTED := 16384

# OTA
TARGET_OTA_ASSERT_DEVICE := pudding

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/configs/props/odm.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/configs/props/product.prop

# Inherit the proprietary files
include vendor/xiaomi/pudding/BoardConfigVendor.mk
