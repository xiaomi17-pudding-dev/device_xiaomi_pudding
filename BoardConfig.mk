#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/pudding

# Kernel (stock prebuilt GKI, DTBs and modules for this device)
KERNEL_PREBUILT_DIR := device/xiaomi/pudding-kernel

# Inherit from sm8850-common
include device/xiaomi/sm8850-common/BoardConfigCommon.mk

# Filesystem
TARGET_FS_CONFIG_GEN += $(DEVICE_PATH)/config.fs

# VINTF
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(DEVICE_PATH)/device_framework_matrix.xml

# Display
TARGET_SCREEN_DENSITY := 520

# Kernel (stock vendor_boot cmdline, device-specific part)
BOARD_KERNEL_CMDLINE += swinfo.fingerprint=pudding:16/OS3.0.335.0.XPCMI:user

# OTA
TARGET_OTA_ASSERT_DEVICE := pudding

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop

# Inherit the proprietary files
include vendor/xiaomi/pudding/BoardConfigVendor.mk
