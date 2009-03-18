LOCAL_PATH:= $(call my-dir)


# clearsilver java library
# ============================================================
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	CS.java \
	CSFileLoader.java \
	JNI.java \
	HDF.java

LOCAL_MODULE:= clearsilver

include $(BUILD_HOST_JAVA_LIBRARY)

our_java_lib := $(LOCAL_BUILT_MODULE)


# libclearsilver-jni.so
# ============================================================
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := docs

LOCAL_SRC_FILES:= \
	j_neo_util.c \
	j_neo_cs.c

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/..

LOCAL_CFLAGS += -fPIC

LOCAL_NO_DEFAULT_COMPILER_FLAGS := true

ifeq ($(HOST_OS),darwin)
	LOCAL_C_INCLUDES += /System/Library/Frameworks/JavaVM.framework/Headers
	LOCAL_LDLIBS := -framework JavaVM
else
	LOCAL_C_INCLUDES += $(JNI_H_INCLUDE)
endif

LOCAL_MODULE:= libclearsilver-jni

LOCAL_MODULE_SUFFIX := $(HOST_JNILIB_SUFFIX)

LOCAL_SHARED_LIBRARIES := libneo_util libneo_cs libneo_cgi

include $(BUILD_HOST_SHARED_LIBRARY)

# Use -force with javah to make sure that the output file
# gets updated.  If javah decides not to update the file,
# make gets confused.

GEN := $(intermediates)/org_clearsilver_HDF.h
$(GEN): PRIVATE_OUR_JAVA_LIB := $(our_java_lib)
$(GEN): PRIVATE_CUSTOM_TOOL = javah -classpath $(PRIVATE_OUR_JAVA_LIB) -force -o $@ -jni org.clearsilver.HDF 
$(GEN): PRIVATE_MODULE := $(LOCAL_MODULE)
$(GEN): $(our_java_lib)
	$(transform-generated-source)
$(intermediates)/j_neo_util.o : $(GEN)

GEN := $(intermediates)/org_clearsilver_CS.h
$(GEN): PRIVATE_OUR_JAVA_LIB := $(our_java_lib)
$(GEN): PRIVATE_CUSTOM_TOOL = javah -classpath $(PRIVATE_OUR_JAVA_LIB) -force -o $@ -jni org.clearsilver.CS
$(GEN): PRIVATE_MODULE := $(LOCAL_MODULE)
$(GEN): $(our_java_lib)
	$(transform-generated-source)
$(intermediates)/j_neo_cs.o : $(GEN)

# this forces us into 64 bit mode, even though for the non-simulator builds we
# mostly don't do that.  Java on Hardy is 64 bit, and rather than finding a 32
# bit java build, just build this in 64 bit.
$(LOCAL_BUILT_MODULE): HOST_GLOBAL_CFLAGS:=
$(LOCAL_BUILT_MODULE): HOST_GLOBAL_CPPFLAGS:=
