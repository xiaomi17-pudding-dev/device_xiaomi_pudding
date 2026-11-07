#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sm8850-common
$(call inherit-product, device/xiaomi/sm8850-common/common.mk)

# Inherit the proprietary files
$(call inherit-product, vendor/xiaomi/pudding/pudding-vendor.mk)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
