#!/usr/bin/env bash
# Test: Decrypting with wrong key produces garbage

set -euo pipefail

# Build
make -C ..

PLAINTEXT="0011001100110011001100110011001100110011001100110011001100110011"
KEY1="1111000011110000111100001111000011110000111100001111000011110000"
KEY2="0000111100001111000011110000111100001111000011110000111100001111"

# Encrypt with KEY1 (mode 1)
CIPHERTEXT=$(echo -e "1\n${PLAINTEXT}\n${KEY1}" | ../des)

# Decrypt with WRONG KEY2 (mode 2)
RECOVERED=$(echo -e "2\n${CIPHERTEXT}\n${KEY2}" | ../des)

echo "Wrong Key Negative Test"
echo "======================="
echo "Original:  ${PLAINTEXT}"
echo "Recovered: ${RECOVERED}"

if [ "${PLAINTEXT}" != "${RECOVERED}" ]; then
    echo "✓ Wrong key detection: decrypted data is garbage as expected"
else
    echo "✗ Wrong key not detected (unexpected)"
    exit 1
fi
