LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	csparse.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)/..

LOCAL_CFLAGS := -fPIC

LOCAL_NO_DEFAULT_COMPILER_FLAGS := true

LOCAL_MODULE:= libneo_cs

LOCAL_SHARED_LIBRARIES := libneo_util

include $(BUILD_HOST_SHARED_LIBRARY)

# this forces us into 64 bit mode, even though for the non-simulator builds we
# mostly don't do that.  Java on Hardy is 64 bit, and rather than finding a 32
# bit java build, just build this in 64 bit.
$(LOCAL_BUILT_MODULE): HOST_GLOBAL_CFLAGS:=
$(LOCAL_BUILT_MODULE): HOST_GLOBAL_CPPFLAGS:=
