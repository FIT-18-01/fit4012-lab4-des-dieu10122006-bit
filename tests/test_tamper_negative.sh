#!/usr/bin/env bash
# Test: Decrypting tampered ciphertext produces garbage / different result

set -euo pipefail

# Build
make -C ..

PLAINTEXT="1010101010101010101010101010101010101010101010101010101010101010"
KEY="0101010101010101010101010101010101010101010101010101010101010101"

# Encrypt (mode 1)
CIPHERTEXT=$(echo -e "1\n${PLAINTEXT}\n${KEY}" | ../des)

# Tamper: flip first bit of ciphertext
TAMPERED="${CIPHERTEXT:0:1}"
if [ "${TAMPERED}" = "0" ]; then
    TAMPERED_CIPHERTEXT="1${CIPHERTEXT:1}"
else
    TAMPERED_CIPHERTEXT="0${CIPHERTEXT:1}"
fi

# Decrypt tampered ciphertext (mode 2)
RECOVERED=$(echo -e "2\n${TAMPERED_CIPHERTEXT}\n${KEY}" | ../des)

echo "Tamper Negative Test"
echo "===================="
echo "Original:  ${PLAINTEXT}"
echo "Recovered: ${RECOVERED}"

if [ "${PLAINTEXT}" != "${RECOVERED}" ]; then
    echo "✓ Tamper detection: decrypted data is corrupted as expected"
else
    echo "✗ Tamper not detected (unexpected result)"
    exit 1
fi
