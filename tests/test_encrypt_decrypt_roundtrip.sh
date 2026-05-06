#!/usr/bin/env bash
# Test DES encrypt -> decrypt roundtrip

set -euo pipefail

# Build
make -C ..

# Test vector
PLAINTEXT="1100110011110000101010101111000011110000110011001010101010101111"
KEY="0011001100110011001100110011001100110011001100110011001100110011"

# Encrypt (mode 1)
CIPHERTEXT=$(echo -e "1\n${PLAINTEXT}\n${KEY}" | ../des)

# Decrypt (mode 2)
RECOVERED=$(echo -e "2\n${CIPHERTEXT}\n${KEY}" | ../des)

echo "DES Roundtrip Test"
echo "=================="
echo "Original:  ${PLAINTEXT}"
echo "Recovered: ${RECOVERED}"

if [ "${PLAINTEXT}" = "${RECOVERED}" ]; then
    echo "✓ Roundtrip successful: plaintext == decrypted"
else
    echo "✗ Roundtrip failed"
    exit 1
fi
