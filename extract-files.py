#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.file import File
from extract_utils.fixups_blob import (
    BlobFixupCtx,
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/xiaomi/pudding',
    'device/xiaomi/sm8850-common',
    'hardware/qcom-caf/sm8850',
    'hardware/qcom-caf/wlan',
    'hardware/xiaomi',
    'vendor/qcom/opensource/commonsys/display',
    'vendor/qcom/opensource/commonsys-intf/display',
    'vendor/qcom/opensource/dataservices',
    'vendor/xiaomi/sm8850-common',
]

# Stock blobs link older versions of stable AIDL interfaces than LineageOS
# builds; point them at the newest frozen version instead of shipping both.

def blob_fixup_miface_weak_nonsecure(
    ctx: BlobFixupCtx,
    file: File,
    file_path: str,
    *args,
    **kwargs,
):
    # The face HAL uses Xiaomi's secure camera path and reports STRONG strength, which the
    # AOSP face framework cannot serve: enroll and authenticate use the regular camera (the
    # secure camera flag is read as 0) and getSensorProps reports WEAK.
    patches = [
        # enroll_impl: ldrb w26, [x10, #0x59] -> mov w26, wzr
        (0x4C100, '5a654139', 'fa031f2a'),
        # authenticate_impl: ldrb w19, [x9, #0x59] -> mov w19, wzr
        (0x4C818, '33654139', 'f3031f2a'),
        # getSensorProps: ldrb w10, [sp, #4] (sensorStrength) -> mov w10, #1 (WEAK)
        (0x75F44, 'ea134039', '2a008052'),
    ]
    with open(file_path, 'rb+') as f:
        data = bytearray(f.read())
        for offset, old, new in patches:
            if data[offset : offset + 4] != bytes.fromhex(old):
                raise ValueError(f'{file_path}: unexpected code at {offset:#x}')
            data[offset : offset + 4] = bytes.fromhex(new)
        f.seek(0)
        f.write(data)


blob_fixups: blob_fixups_user_type = {
    # Xiaomi's MultiRoute port (output flag VIRTUAL_DEEP_BUFFER) and its Bluetooth codec
    # audio/vnd.mi.mihc are only known to HyperOS's audio framework: the AIDL module config
    # then fails to convert (BAD_VALUE), audioserver finds no primary output and has no
    # audio at all. Remove the MultiRoute mix port, device port and routes, and the codec.
    'odm/etc/audio/audio_module_config_primary.xml': blob_fixup()
        .regex_replace(r'(?s)\n[ \t]*<!-- MIUI ADD: Audio_MultiRoute -->\n[ \t]*<mixPort name="virtual_deep_buffer".*?<!-- END Audio_MultiRoute -->', '')
        .regex_replace(r'(?s)\n[ \t]*<!-- MIUI ADD: Audio_MultiRoute -->\n[ \t]*<devicePort tagName="Multiroute".*?<!-- END Audio_MultiRoute -->', '')
        .regex_replace(r'\n[ \t]*<route type="mix" sink="Multiroute"\s+sources="virtual_deep_buffer"/>', '')
        .regex_replace(r',virtual_deep_buffer', '')
        .regex_replace(r' audio/vnd\.mi\.mihc', ''),
    # Stock XML declaration is malformed ("<?xml=version"), which the build's xmllint check rejects
    (
        'odm/etc/camera/snsc_bokeh_motiontuning.xml',
        'odm/etc/camera/snsc_enhance_motiontuning.xml',
        'odm/etc/camera/snsc_motiontuning.xml',
        'odm/etc/camera/snsc_noface_motiontuning.xml',
    ): blob_fixup()
        .regex_replace(r'<\?xml=version=', '<?xml version='),
    (
        'odm/bin/hw/vendor.qti.camera.provider-service_64',
        'odm/lib64/camera/components/com.mi.node.fd.so',
        'odm/lib64/camera/components/com.qti.node.fd.so',
        'odm/lib64/camera/dynamicplugins/com.xiaomi.plugin.mialgoallinone.so',
        'odm/lib64/camera/plugins/com.xiaomi.plugin.anchor.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.asd.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offcamb2y.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlineawbideal.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlineb2y.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlineehdr.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlineformatconvertor.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlinehdrraw2y.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlineheic.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlinei2y.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlinejpeg.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlinemfnr.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlinemlawb.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlinetintless.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlinetintlesshdr.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlineyuveis.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlineyuvreprocess.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlineyuvsplit.so',
        'odm/lib64/camera/preloadplugins/com.xiaomi.plugin.offlineyuvwarp.so',
        'odm/lib64/com.xiaomi.plugin.ecdengine.so',
        'odm/lib64/com.xiaomi.stubv1.camx.so',
        'odm/lib64/hw/camera.qcom.core.so',
        'odm/lib64/libcamxdumpinforecorder.so',
        'odm/lib64/libmiXmlParser.so',
        'odm/lib64/libmicamera_aidl_provider.so',
        'odm/lib64/libmicamera_hal_core.so',
        'odm/lib64/libsimulation.so',
    ): blob_fixup()
        .replace_needed('libtinyxml2.so', 'libtinyxml2-v36.so'),
    'odm/bin/hw/vendor.xiaomi.sensor.citsensorservice.aidl': blob_fixup()
        .replace_needed('android.hardware.graphics.common-V6-ndk.so', 'android.hardware.graphics.common-V7-ndk.so')
        .replace_needed('vendor.qti.hardware.display.config-V12-ndk.so', 'vendor.qti.hardware.display.config-V18-ndk.so')
        .replace_needed('libtinyxml2.so', 'libtinyxml2-v36.so'),
    (
        'odm/lib64/camera/components/com.qti.node.dewarp.so',
        'odm/lib64/vendor.qti.hardware.camera.offlinecamera-service-impl.so',
    ): blob_fixup()
        .replace_needed('android.hardware.graphics.allocator-V1-ndk.so', 'android.hardware.graphics.allocator-V2-ndk.so'),
    'odm/lib64/camx.device-impl.so': blob_fixup()
        .replace_needed('vendor.qti.hardware.display.config-V2-ndk.so', 'vendor.qti.hardware.display.config-V18-ndk.so'),
    'odm/lib64/libmiface.so': blob_fixup()
        .call(blob_fixup_miface_weak_nonsecure),
    # libkeymint and libkeymint_remote_prov_support are linked but none of their symbols is used
    'odm/lib64/libmt_keysoter.so': blob_fixup()
        .remove_needed('libkeymint.so')
        .remove_needed('libkeymint_remote_prov_support.so'),
    (
        'odm/lib64/hw/displayfeature.default.so',
        'odm/lib64/libadaptivehdr.so',
        'odm/lib64/libcolortempmode.so',
        'odm/lib64/libdither.so',
        'odm/lib64/libdynamicelvss.so',
        'odm/lib64/libhistprocess.so',
        'odm/lib64/libmiBrightness.so',
        'odm/lib64/libmiSensorCtrl.so',
        'odm/lib64/libpaperMode.so',
        'odm/lib64/librhytheyecare.so',
        'odm/lib64/libsdr2hdr.so',
        'odm/lib64/libsre.so',
        'odm/lib64/libtruetone.so',
        'odm/lib64/libvideomode.so',
    ): blob_fixup()
        .replace_needed('android.hardware.sensors-V2-ndk.so', 'android.hardware.sensors-V3-ndk.so'),
}  # fmt: skip

module = ExtractUtilsModule(
    'pudding',
    'xiaomi',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(
        module, 'sm8850-common', module.vendor
    )
    utils.run()
