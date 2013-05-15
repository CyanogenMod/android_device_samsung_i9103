# Copyright (C) 2007 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := device/samsung/i9103
TARGET_SPECIFIC_HEADER_PATH := device/samsung/i9103/overlay/include

# CPU
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a
TARGET_ARCH_VARIANT_CPU := cortex-a9
# Avoid the generation of ldrcc instructions
NEED_WORKAROUND_CORTEX_A9_745320 := true
# DO NOT change the following line to vfpv3 as it is not really supported on our device!
TARGET_ARCH_VARIANT_FPU := vfpv3-d16
ARCH_ARM_HAVE_TLS_REGISTER := true

#TARGET_HAVE_TEGRA_ERRATA_657451 := true
TARGET_BOARD_PLATFORM := tegra
TARGET_TEGRA_VERSION := ap20
TARGET_BOARD_PLATFORM_GPU := tegra
TARGET_BOOTLOADER_BOARD_NAME := n1
TARGET_USERIMAGES_USE_EXT4 := true

BOARD_NAND_PAGE_SIZE := 4096
BOARD_NAND_SPARE_SIZE := 128
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_CMDLINE := mem=511M@0M secmem=1M@511M mem=512M@512M vmalloc=256M fota_boot=false tegra_fbmem=800K@0x18012000 video=tegrafb console=ram usbcore.old_scheme_first=1 lp0_vec=8192@0x1819E000 emmc_checksum_done=true emmc_checksum_pass=true tegraboot=sdmmc gpt

#BOARD_KERNEL_CMDLINE := mem=511M@0M secmem=1M@511M mem=512M@512M vmalloc=256M fota_boot=false video=tegrafb console=ram usbcore.old_scheme_first=1 #emmc_checksum_done=true emmc_checksum_pass=true tegraboot=sdmmc gpt 

# still required for apanic_mmc, todo: should check the gpt partition labels
#BOARD_KERNEL_CMDLINE += mmcparts=mmcblk0:p1(EFS),p2(APP),p3(CAC),p4(IMS),p5(MSC),p6(UDA),p7(MDM),p8(SOS),p9(LNX),p10(OTA),p11(HID);

# no more required with tegra atag's patch (from bootloader)
# BOARD_KERNEL_CMDLINE += tegra_fbmem=800K@0x18012000 lp0_vec=8192@0x1819E000

# kernel modules location (busybox)
KERNEL_MODULES_DIR := /system/lib/modules

# Filesystem
BOARD_BOOTIMAGE_PARTITION_SIZE     := 8388608
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 5136896 # 5242880 bytes exactly
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 629145600
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2147483648
BOARD_FLASH_BLOCK_SIZE := 4096

# Use this flag if the board has a ext4 partition larger than 2gb
BOARD_HAS_LARGE_FILESYSTEM := true

TARGET_KERNEL_SOURCE := kernel/samsung/n1
TARGET_KERNEL_CONFIG := cyanogenmod_i9103_defconfig

TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := false
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Required to build a recovery image of 5MB max
ifeq ($(TARGET_NO_RECOVERY),false)
    BOARD_CUSTOM_BOOTIMG_MK := device/samsung/i9103/tools/bootimg.mk
endif

# RIL
BOARD_USES_LIBSECRIL_STUB := false

# 3G
BOARD_MOBILEDATA_INTERFACE_NAME := "rmnet0"

# Audio
BOARD_USES_GENERIC_AUDIO := false
TARGET_PROVIDES_LIBAUDIO := false

# Camera
BOARD_USES_PROPRIETARY_LIBCAMERA := true
BOARD_SECOND_CAMERA_DEVICE := true
BOARD_CAMERA_HAVE_ISO := true
COMMON_GLOBAL_CFLAGS += -DHAVE_ISO

# Graphics
BOARD_EGL_CFG := $(LOCAL_PATH)/configs/egl.cfg
BOARD_EGL_NEEDS_LEGACY_FB := true
USE_OPENGL_RENDERER := true

# Enable WEBGL in WebKit
ENABLE_WEBGL := true

# HWComposer
BOARD_USES_HWCOMPOSER := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUEDROID_VENDOR_CONF := $(LOCAL_PATH)/bluetooth/vnd_n1.txt
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth

# Wifi-related defines
WPA_BUILD_SUPPLICANT            := true
WPA_SUPPLICANT_VERSION          := VER_0_8_X
BOARD_WLAN_DEVICE               := bcmdhd
BOARD_WLAN_DEVICE_REV 	        := bcm4330_b1
BOARD_WPA_SUPPLICANT_DRIVER     := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER            := NL80211
BOARD_HOSTAPD_PRIVATE_LIB       := lib_driver_cmd_bcmdhd
WIFI_DRIVER_MODULE_PATH         := "/system/lib/modules/dhd.ko"
WIFI_DRIVER_FW_PATH_PARAM       := "/sys/module/dhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA         := "/system/etc/wifi/bcm4330_sta.bin"
WIFI_DRIVER_FW_PATH_AP          := "/system/etc/wifi/bcm4330_apsta.bin"
WIFI_DRIVER_FW_PATH_P2P         := "/system/etc/wifi/bcm4330_p2p.bin"
WIFI_DRIVER_MODULE_NAME         := "dhd"
WIFI_DRIVER_MODULE_ARG      	:= "firmware_path=/system/etc/wifi/bcm4330_sta.bin nvram_path=/system/etc/wifi/nvram_net.txt"
WIFI_DRIVER_MODULE_AP_ARG       := "firmware_path=/system/etc/wifi/bcm4330_apsta.bin nvram_path=/system/etc/wifi/nvram_net.txt"
WIFI_BAND                       := 802_11_ABG
BOARD_LEGACY_NL80211_STA_EVENTS := true
BOARD_HAVE_SAMSUNG_WIFI         := true

# Custom squisher, optional final step script (disabled in cm10.1)
# TARGET_CUSTOM_RELEASETOOL := device/samsung/i9103/tools/squisher

# Assert
TARGET_OTA_ASSERT_DEVICE := galaxyr,i9103,GT-I9103,GTI9103

# Vold
BOARD_VOLD_MAX_PARTITIONS := 12
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
BOARD_VOLD_DISC_HAS_MULTIPLE_MAJORS := true
BOARD_USE_USB_MASS_STORAGE_SWITCH := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/fsl-tegra-udc/gadget/lun%d/file"

BOARD_HAS_SDCARD_INTERNAL := true

# LPM
BOARD_CHARGING_MODE_BOOTING_LPM := "/sys/class/power_supply/battery/batt_lp_charging"
BOARD_BATTERY_DEVICE_NAME := "battery"
BOARD_CHARGER_RES := $(LOCAL_PATH)/res/charger

# EMMC brickbug is removed in the kernel, but be better safe than sorry.
BOARD_SUPPRESS_EMMC_WIPE := true

# Recovery
TARGET_RECOVERY_INITRC := $(LOCAL_PATH)/recovery.rc
BOARD_CUSTOM_RECOVERY_KEYMAPPING := ../../device/samsung/i9103/recovery/recovery_keys.c
BOARD_CUSTOM_GRAPHICS := ../../../device/samsung/i9103/recovery/graphics.c

BOARD_UMS_LUNFILE := "/sys/devices/platform/fsl-tegra-udc/gadget/lun%d/file"
BOARD_USES_MMCUTILS := true
BOARD_HAS_NO_SELECT_BUTTON := true

# TWRP
DEVICE_RESOLUTION := 480x800

TW_INTERNAL_STORAGE_PATH := "/sdcard"
TW_INTERNAL_STORAGE_MOUNT_POINT := "sdcard"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"

TW_NO_REBOOT_BOOTLOADER := true
TW_DEFAULT_EXTERNAL_STORAGE := true
TW_HAS_DOWNLOAD_MODE := true
TW_BRIGHTNESS_PATH := "/sys/class/backlight/pwm-backlight/brightness"
TW_MAX_BRIGHTNESS := 255

# Inherit from the proprietary version
-include vendor/samsung/i9103/BoardConfigVendor.mk
