#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# PixelOS product. The device configuration is shared with lineage_pudding.mk; only the ROM
# configuration differs.

# Stock is 64-bit only (ro.*.product.cpu.abilist32 is empty).
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from pudding device
$(call inherit-product, device/xiaomi/pudding/device.mk)

# Inherit some common PixelOS stuff.
$(call inherit-product, vendor/custom/config/common_full_phone.mk)

# Boot animation: the closest width PixelOS ships (720, 1080, 1440) for the 1220 px panel
TARGET_SCREEN_WIDTH := 1080

# Face unlock comes from the Xiaomi face HAL, not from PixelOS's own implementation
TARGET_PROVIDES_FACE_UNLOCK_HAL := true

# eSIM: Google's eSIM manager (from the stock firmware), which needs the Google apps PixelOS ships
PRODUCT_PACKAGES += \
    EuiccGoogle

PRODUCT_DEVICE := pudding
PRODUCT_NAME := custom_pudding
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := 25113PN0EG
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
