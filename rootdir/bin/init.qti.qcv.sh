#! /vendor/bin/sh
#=============================================================================
# Copyright (c) 2020, 2021 Qualcomm Technologies, Inc.
# All Rights Reserved.
# Confidential and Proprietary - Qualcomm Technologies, Inc.
#=============================================================================

if [ -f /sys/devices/soc1/soc_id ]; then
    soc_id=`cat /sys/devices/soc1/soc_id` 2> /dev/null
else
    soc_id=`cat /sys/devices/soc0/soc_id` 2> /dev/null
fi

if [ -f /sys/devices/soc1/chip_id ]; then
    chip_id=`cat /sys/devices/soc1/chip_id` 2> /dev/null
else
    chip_id=`cat /sys/devices/soc0/chip_id` 2> /dev/null
fi

# Store soc_id in ro.vendor.qti.soc_id
setprop ro.vendor.qti.soc_id $soc_id

# Store chip_id in ro.vendor.qti.soc_model
setprop ro.vendor.qti.soc_model $chip_id

# For chipsets in QCV family, convert soc_id to soc_name
# and store it in ro.vendor.qti.soc_name.
if [ "$soc_id" -eq 707 ] || [ "$soc_id" -eq 708 ] ; then
    setprop ro.vendor.qti.soc_name art
elif [ "$soc_id" -eq 660 ] || [ "$soc_id" -eq 661 ] || [ "$soc_id" -eq 704 ] || [ "$soc_id" -eq 743 ]; then
    setprop ro.vendor.qti.soc_name canoe
    setprop ro.vendor.media_performance_class 35
elif [ "$soc_id" -eq 722 ] || [ "$soc_id" -eq 723 ]; then
    setprop ro.vendor.qti.soc_name whale
    setprop ro.vendor.media_performance_class 35
elif [ "$soc_id" -eq 724 ] || [ "$soc_id" -eq 744 ]; then
    setprop ro.vendor.qti.soc_name chora
elif [ "$soc_id" -eq 733 ] || [ "$soc_id" -eq 757 ]; then
    setprop ro.vendor.qti.soc_name malabar
elif [ "$soc_id" -eq 685 ] || [ "$soc_id" -eq 727 ] || [ "$soc_id" -eq 764 ]; then
    setprop ro.vendor.qti.soc_name alor
    setprop ro.vendor.media_performance_class 35
elif [ "$soc_id" -eq 618 ] || [ "$soc_id" -eq 639 ]; then
    setprop ro.vendor.qti.soc_name sun
    setprop ro.vendor.media_performance_class 35
elif [ "$soc_id" -eq 557 ] || [ "$soc_id" -eq 577 ]; then
    setprop ro.vendor.qti.soc_name pineapple
    setprop ro.vendor.media_performance_class 34
elif [ "$soc_id" -eq 475 ] || [ "$soc_id" -eq 499 ] ||
     [ "$soc_id" -eq 497 ] || [ "$soc_id" -eq 498 ] ||
     [ "$soc_id" -eq 515 ]; then
    setprop ro.vendor.qti.soc_name yupik
    setprop ro.vendor.qti.soc_model SM7325
elif [ "$soc_id" -eq 575 ]; then
    setprop ro.vendor.qti.soc_name yupik
    setprop ro.vendor.qti.soc_model QCS5430
elif [ "$soc_id" -eq 576 ]; then
    setprop ro.vendor.qti.soc_name yupik
    setprop ro.vendor.qti.soc_model QCM5430
elif [ "$soc_id" -eq 555 ]; then
    setprop ro.vendor.qti.soc_name hamoa
elif [ "$soc_id" -eq 673 ]; then
    setprop ro.vendor.qti.soc_name seraph
    setprop ro.vendor.qti.soc_model SAR2230P
elif [ "$soc_id" -eq 672 ]; then
    setprop ro.vendor.qti.soc_name seraph
    setprop ro.vendor.qti.soc_model SAR1250P
elif [ "$soc_id" -eq 415 ] || [ "$soc_id" -eq 439 ]; then
    setprop ro.vendor.qti.soc_name lahaina
    setprop ro.vendor.qti.soc_model SM8350
elif [ "$soc_id" -eq 756 ]; then
    setprop ro.vendor.qti.soc_name shikra
fi
