LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	cgiwrap.c \
	cgi.c \
	html.c \
	date.c \
	rfc2388.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)/..

LOCAL_CFLAGS := -fPIC

# This forces a 64-bit build for Java6
LOCAL_CFLAGS += -m64
LOCAL_LDFLAGS += -m64
# We use the host compilers because the Linux SDK build
# uses a 32-bit toolchain that can't handle -m64
LOCAL_CC := $(CC)
LOCAL_CXX := $(CXX)

LOCAL_NO_DEFAULT_COMPILER_FLAGS := true

LOCAL_MODULE:= libneo_cgi

LOCAL_SHARED_LIBRARIES := libneo_util libneo_cs

LOCAL_LDLIBS += -lz

include $(BUILD_HOST_SHARED_LIBRARY)
