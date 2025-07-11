#!/bin/sh

echo "Updating build number"

cd "$SRCROOT"

COMMITS=$((`git rev-list HEAD --count`))

if [ $? -ne 0 ]; then
    echo "error: Unable to get commits count"
    exit 1
else 
    echo "Number of commits $COMMITS"
fi

# Update build number in created binary's Info.plist
if [ -f "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}" ]; then
    echo "Updating Info.plist at ${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $COMMITS" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"

    if [ $? -ne 0 ]; then
        echo "error: Unable to write Info.plist"
        exit 2
    else 
        echo "Binary plist written"
    fi
fi

echo "Updating Info.plist at ${INFOPLIST_FILE}"

# Update build number in original plist so it is consistent
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $COMMITS" "$INFOPLIST_FILE"

if [ $? -ne 0 ]; then
    echo "error: Unable to write local plist"
    exit 3
else 
    echo "Local plist written"
fi

echo "Updating build finished"