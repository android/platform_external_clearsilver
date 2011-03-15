LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	neo_err.c \
	neo_files.c \
	neo_misc.c \
	neo_rand.c \
	ulist.c \
	neo_hdf.c \
	neo_str.c \
	neo_date.c \
	wildmat.c \
	ulocks.c \
	neo_hash.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)/..
LOCAL_CFLAGS := -fPIC

ifneq (64,$(findstring 64,$(UNAME)))
LOCAL_CFLAGS += -m32
LOCAL_LDFLAGS += -m32
else
# This forces a 64-bit build for Java6
LOCAL_CFLAGS += -m64
LOCAL_LDFLAGS += -m64
endif
# We use the host compilers because the Linux SDK build
# uses a 32-bit toolchain that can't handle -m64
LOCAL_CC := $(CC)
LOCAL_CXX := $(CXX)

LOCAL_NO_DEFAULT_COMPILER_FLAGS := true

LOCAL_MODULE:= libneo_util

include $(BUILD_HOST_SHARED_LIBRARY)
