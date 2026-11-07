#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
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

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="miproduct_pudding-user 17 CP2A.260605.016 OS3.0.335.0.XPCEUXM release-keys" \
    BuildFingerprint=Android/generic_system/generic:17/CP2A.260605.016/17OS3.3.260922.170915209.QCPEGL.S:user/release-keys
