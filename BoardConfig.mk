#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/pudding

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    dtbo \
    product \
    boot \
    init_boot \
    vendor \
    vendor_boot \
    vendor_dlkm \
    system_dlkm \
    system_ext \
    system \
    recovery \
    odm
# Dedicated A/B recovery partition (stock recovery.img: header v4, ramdisk only)
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := oryon

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := canoe
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 520
TARGET_USES_VULKAN := true

# Kernel
# Stock boot images (OS3.0.335.0.XPCEUXM): header v4, page size 4096, LZ4 (legacy)
# ramdisks; the cmdline below is the stock vendor_boot cmdline.
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := video=vfb:640x400,bpp=32,memsize=3072000 erofs.reserved_pages=64 swinfo.fingerprint=pudding:16/OS3.0.335.0.XPCMI:user bootconfig
BOARD_KERNEL_PAGESIZE := 4096
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_RAMDISK_USE_LZ4 := true

# Kernel - prebuilt stock GKI, DTBs and DTBO from device/xiaomi/pudding-kernel
KERNEL_PATH := device/xiaomi/pudding-kernel
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/kernel
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PATH)/dtbs
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbs/dtbo.img

# Kernel modules: stock vendor_boot ramdisk, vendor_dlkm and system_dlkm sets with their
# stock load and block lists. Stock load lists repeat entries; keep the first occurrence.
KERNEL_MODULES_LOAD = $(strip $(shell awk '!seen[$$0]++' $(1)))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(KERNEL_PATH)/vendor_ramdisk/*.ko)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(call KERNEL_MODULES_LOAD,$(KERNEL_PATH)/vendor_ramdisk/modules.load)
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(call KERNEL_MODULES_LOAD,$(KERNEL_PATH)/vendor_ramdisk/modules.load.recovery)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(KERNEL_PATH)/vendor_ramdisk/modules.blocklist
BOARD_USES_VENDOR_DLKMIMAGE := true
BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(KERNEL_PATH)/vendor_dlkm/*.ko)
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(call KERNEL_MODULES_LOAD,$(KERNEL_PATH)/vendor_dlkm/modules.load)
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(KERNEL_PATH)/vendor_dlkm/modules.blocklist
BOARD_USES_SYSTEM_DLKMIMAGE := true
BOARD_SYSTEM_KERNEL_MODULES := $(wildcard $(KERNEL_PATH)/system_dlkm/*.ko)
BOARD_SYSTEM_KERNEL_MODULES_LOAD := $(call KERNEL_MODULES_LOAD,$(KERNEL_PATH)/system_dlkm/modules.load)
BOARD_SYSTEM_KERNEL_MODULES_BLOCKLIST_FILE := $(KERNEL_PATH)/vendor_dlkm/system_dlkm.modules.blocklist

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 33554432
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
# Super partition (stock lpdump: 13421772800 bytes; groups qti_dynamic_partitions_a/_b,
# maximum 13411287040 each). mi_ext (Xiaomi-only) is not built.
BOARD_SUPER_PARTITION_SIZE := 13421772800
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 13411287040
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    odm \
    product \
    system \
    system_dlkm \
    system_ext \
    vendor \
    vendor_dlkm

# Filesystems: all stock logical partitions are EROFS; userdata is f2fs
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

BOARD_USES_METADATA_PARTITION := true

# Platform
TARGET_BOARD_PLATFORM := canoe

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_SYSTEM_DLKM_PROP += $(DEVICE_PATH)/system_dlkm.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_ODM_DLKM_PROP += $(DEVICE_PATH)/odm_dlkm.prop
TARGET_VENDOR_DLKM_PROP += $(DEVICE_PATH)/vendor_dlkm.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2026-09-01

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_VENDOR_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := 1
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 1

# VINTF
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

# Inherit the proprietary files
include vendor/xiaomi/pudding/BoardConfigVendor.mk
