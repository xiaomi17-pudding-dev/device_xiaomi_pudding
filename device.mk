#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sm8850-common
$(call inherit-product, device/xiaomi/sm8850-common/common.mk)

# Inherit the proprietary files
$(call inherit-product, vendor/xiaomi/pudding/pudding-vendor.mk)

# Kernel - stock prebuilt image from the kernel repo (the common tree sets
# TARGET_NO_KERNEL_OVERRIDE, so it is not installed by the LineageOS kernel build)
PRODUCT_COPY_FILES += \
    device/xiaomi/pudding-kernel/kernel:kernel

# KeyMint: the Thales StrongBox KeyMint (odm) implements KeyMint V3
PRODUCT_PACKAGES += \
    android.hardware.security.keymint-V3-ndk

# Overlays
PRODUCT_PACKAGES += \
    FrameworksResPudding \
    WifiResPudding

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

