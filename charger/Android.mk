# Copyright 2005 The Android Open Source Project

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	alarm.c \
	draw.c \
	events.c \
	hardware.c \
	screen.c \
	main.c

LOCAL_STATIC_LIBRARIES := libunz libcutils libc

# LOCAL_SHARED_LIBRARIES := libhardware libpower

LOCAL_C_INCLUDES := external/zlib
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE:= anicharger
LOCAL_MODULE_STEM := anicharger
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT_SBIN)
LOCAL_UNSTRIPPED_PATH := $(TARGET_ROOT_OUT_SBIN_UNSTRIPPED)
LOCAL_FORCE_STATIC_EXECUTABLE := true

include $(BUILD_EXECUTABLE)
