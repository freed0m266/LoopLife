set -e
cd "$SRCROOT"
pushd "${ROOT_DIR}"
mint run swiftlint
popd
