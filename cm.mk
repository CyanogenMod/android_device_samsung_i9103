#
# Copyright (C) 2012 The CyanogenMod Project
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
#

## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := GT-I9103

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/i9103/full_i9103.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := i9103
PRODUCT_NAME := cm_i9103
PRODUCT_BRAND := Samsung
PRODUCT_MODEL := GT-I9103

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=GT-I9103 TARGET_DEVICE=GT-I9103

# Allow ADB (to access dev settings)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.debuggable=1 persist.sys.usb.config=mtp persist.service.adb.enable=1
