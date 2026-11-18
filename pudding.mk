#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Neoteric-OS product. The device configuration is shared with lineage_pudding.mk; only the ROM
# configuration differs.

# The Neoteric-OS product layer adds the QTI telephony framework to the boot jars itself
TARGET_ROM_PROVIDES_TELEPHONY_EXT_BOOT_JAR := true

# Stock is 64-bit only (ro.*.product.cpu.abilist32 is empty).
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from pudding device
$(call inherit-product, device/xiaomi/pudding/device.mk)

# Inherit some common Neoteric-OS stuff.
$(call inherit-product, vendor/neoteric/target/product/neoteric-target.mk)

# System side of the Qualcomm perf component (QPerformance/UxPerformance, libqti_performance, perfservice):
# the framework's BoostFramework sends its touch, scroll and app launch boosts through it. The vendor side
# stays the stock perf HAL and its configurations
QCOM_COMMON_PATH ?= device/qcom/common
$(call inherit-product, device/qcom/common/system/perf/qti-perf.mk)
# TensorFlow Lite for its workload classifier model (libqti_workloadclassifiermodel); the perf component lists it
# only on its vendor side
PRODUCT_PACKAGES += \
    libtflite

# Scudo with zero-filled allocations like AOSP (Neoteric-OS defaults to jemalloc): stock blobs such as the
# odm touchfeature service (which runs the THP touch pipeline) read freshly allocated memory as zero
PRODUCT_USE_SCUDO := true

# Qualcomm source namespaces of the device: the Neoteric-OS Qualcomm common layer only adds
# hardware/qcom-caf/sm8850. The Wi-Fi HAL is Neoteric-OS's hardware/qcom/wlan, which matches its
# wpa_supplicant
PRODUCT_SOONG_NAMESPACES += \
    hardware/qcom-caf/sm8850/data-ipa-cfg-mgr \
    hardware/qcom-caf/thermal \
    hardware/qcom/wlan/qcwcn \
    hardware/qcom/wlan/qcwcn/wpa_supplicant_8_lib \
    vendor/qcom/opensource/dataservices

PRODUCT_DEVICE := pudding
PRODUCT_NAME := pudding
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := 25113PN0EG
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
