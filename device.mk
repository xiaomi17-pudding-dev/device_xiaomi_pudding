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
    PuddingEuiccOverlay \
    SystemUIResPudding \
    WifiResPudding

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Vendor variants of the libraries that stock vendor and odm blobs link. Blobs with
# DISABLE_DEPS only list them in REQUIRED, which installs the system variant, and the
# vendor linker namespace cannot load those.
PRODUCT_PACKAGES += \
    android.hardware.biometrics.common.thread.vendor \
    android.hardware.biometrics.common.util.vendor \
    android.hardware.biometrics.face-V4-ndk.vendor \
    android.hardware.camera.device-V3-ndk.vendor \
    android.hardware.camera.metadata-V3-ndk.vendor \
    android.hardware.camera.provider-V3-ndk.vendor \
    android.hardware.light-V2-ndk.vendor \
    android.hardware.security.keymint-V3-ndk.vendor \
    android.hardware.security.keymint-V4-ndk.vendor \
    android.hardware.security.rkp-V3-ndk.vendor \
    android.hardware.security.sharedsecret-V1-ndk.vendor \
    android.hardware.vibrator-V2-ndk.vendor \
    android.hardware.weaver-V2-ndk.vendor \
    android.se.omapi-V1-ndk.vendor \
    lib_android_keymaster_keymint_utils_V3.vendor \
    libcppbor_external.vendor \
    libkeymaster_messages.vendor \
    libkeymaster_portable.vendor \
    libkeymint_support.vendor \
    libsoft_attestation_cert.vendor \
    vendor.qti.hardware.camera.offlinecamera-V2-ndk.vendor
