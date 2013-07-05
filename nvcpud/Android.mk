LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	INvCpuService.cpp \
	NvCpuClient.cpp

LOCAL_SHARED_LIBRARIES := \
	libcutils \
	libutils \
	libbinder \

LOCAL_MODULE:= libnvcpud_client

LOCAL_MODULE_TAGS:= optional

ifeq ($(TARGET_SIMULATOR),true)
    LOCAL_LDLIBS += -lpthread
endif

LOCAL_PRELINK_MODULE:= false

include $(BUILD_SHARED_LIBRARY)
