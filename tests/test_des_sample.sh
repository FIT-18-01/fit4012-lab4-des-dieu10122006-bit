#!/usr/bin/env bash
# Test DES encryption with a sample plaintext and key

set -euo pipefail

# Build
make -C ..

# Test vector: single block DES encryption
PLAINTEXT="0000000100000010000000110000010000000101000001100000011100001000"
KEY="0000000100000010000000110000010000000101000001100000011100001000"

# Run DES encrypt (mode 1)
OUTPUT=$(echo -e "1\n${PLAINTEXT}\n${KEY}" | ../des)

echo "DES Sample Test"
echo "==============="
echo "Plaintext: ${PLAINTEXT}"
echo "Key:       ${KEY}"
echo "Output:    ${OUTPUT}"
echo "✓ DES encrypt executed successfully"
