#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/custom_pudding.mk \
    $(LOCAL_DIR)/lineage_pudding.mk

COMMON_LUNCH_CHOICES := \
    custom_pudding-eng \
    custom_pudding-user \
    custom_pudding-userdebug \
    lineage_pudding-eng \
    lineage_pudding-user \
    lineage_pudding-userdebug
