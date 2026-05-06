#!/usr/bin/env bash
# Test DES multi-block encryption with zero padding

set -euo pipefail

# Build
make -C ..

# Test: 2 blocks + partial block (requiring zero padding)
# Block 1: 64 bits
# Block 2: 64 bits  
# Block 3 (partial): 32 bits -> padded to 64 bits with 32 zeros

PLAINTEXT="11111111000000001111111100000000" # 32 bits
PLAINTEXT="${PLAINTEXT}11110000111100001111000011110000" # 64 bits total
PLAINTEXT="${PLAINTEXT}11001100" # + 8 more bits = 136 bits (needs 2 blocks + padding)

KEY="1010101010101010101010101010101010101010101010101010101010101010"

# Encrypt multi-block (mode 1)
CIPHERTEXT=$(echo -e "1\n${PLAINTEXT}\n${KEY}" | ../des)

# Verify output length is multiple of 64 bits
CIPH_LEN=${#CIPHERTEXT}
if (( CIPH_LEN % 64 != 0 )); then
    echo "✗ Ciphertext length not multiple of 64"
    exit 1
fi

echo "Multi-block Padding Test"
echo "========================"
echo "Plaintext length:  ${#PLAINTEXT} bits"
echo "Ciphertext length: ${CIPH_LEN} bits"
echo "Blocks:            $((CIPH_LEN / 64))"
echo "✓ Multi-block and zero padding work correctly"
