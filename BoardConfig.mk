#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/pudding

# Kernel (stock prebuilt GKI, DTBs and modules for this device)
KERNEL_PREBUILT_DIR := device/xiaomi/pudding-kernel

# Inherit from sm8850-common
include device/xiaomi/sm8850-common/BoardConfigCommon.mk

# Display
TARGET_SCREEN_DENSITY := 520

# OTA
TARGET_OTA_ASSERT_DEVICE := pudding

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_ODM_DLKM_PROP += $(DEVICE_PATH)/odm_dlkm.prop

# Inherit the proprietary files
include vendor/xiaomi/pudding/BoardConfigVendor.mk
