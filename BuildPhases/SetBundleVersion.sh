#!/bin/sh
# -----------------------------------------------------------------------------
# This script generates two types of versions for your iOS project:
#
# 1. A dotted version string (VERSION_STRING_BASE) in the format:
#    YY.M.D (e.g., 25.4.23)
#
# 2. An integer version code (VERSION_CODE) formatted as:
#    YYMMDD (e.g., 250423)
#
# The script then sets:
#   CFBundleShortVersionString	= VERSION_STRING_BASE + VERSION_STRING_SUFFIX
#   CFBundleVersion				= VERSION_CODE
#
# INFOPLIST_FILE must be set to the path of your Info.plist file.
# -----------------------------------------------------------------------------

# Generate date components: Short Year (25), Month (1-12), Day (1-31)
read SHORT_YEAR MONTH DAY <<< $(date +"%y %-m %-d")

# 1. Generate VERSION_STRING_BASE (e.g., 25.4.23)
VERSION_STRING_BASE="${SHORT_YEAR}.${MONTH}.${DAY}"

# Suffix is kept empty for production builds.
VERSION_STRING_SUFFIX=""

# Compose the full version string.
FULL_VERSION_STRING="${VERSION_STRING_BASE}${VERSION_STRING_SUFFIX}"

# 2. Generate VERSION_CODE (e.g., 250423)
VERSION_CODE=$(printf "%02d%02d%02d" $SHORT_YEAR $MONTH $DAY)

echo "ℹ️ Full Version String (CFBundleShortVersionString): $FULL_VERSION_STRING"
echo "ℹ️ Using VERSION_CODE (CFBundleVersion): $VERSION_CODE"

# Update build number in created binary's Info.plist
if [ -f "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}" ]; then
	echo "ℹ️ Updating Info.plist at ${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
	
	if /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $VERSION_CODE" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}" && \
	   /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $FULL_VERSION_STRING" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"; then
		echo "✅ Binary Info.plist updated successfully"
	else
		echo "❌ Error: Failed to update Binary Info.plist."
		exit 1
	fi
else
	echo "❌ Error: TARGET_BUILD_DIR/INFOPLIST_PATH environment variable is not set"
	exit 2
fi

# Update build number in original plist so it is consistent
if [ -n "$INFOPLIST_FILE" ]; then
	echo "ℹ️ Updating Info.plist at ${INFOPLIST_FILE}"

	if /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $VERSION_CODE" "$INFOPLIST_FILE" && \
	   /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $FULL_VERSION_STRING" "$INFOPLIST_FILE"; then
		echo "✅ Original Info.plist updated successfully"
	else
		echo "❌ Error: Failed to update Original Info.plist."
		exit 3
	fi
else
	echo "❌ Error: INFOPLIST_FILE environment variable is not set"
	exit 4
fi
