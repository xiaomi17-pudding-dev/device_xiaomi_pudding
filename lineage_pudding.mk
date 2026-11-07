#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Stock is 64-bit only (ro.*.product.cpu.abilist32 is empty).
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from pudding device
$(call inherit-product, device/xiaomi/pudding/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_DEVICE := pudding
PRODUCT_NAME := lineage_pudding
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := 25113PN0EG
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
