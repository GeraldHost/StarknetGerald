privateKey=$1
address=$(cat deployments/gerald_deployment.txt | xargs -n1 | grep -ow -m1 '\0x.*\b');
signatureResp=$(./scripts/generateSignature.py $privateKey 0)
publicKey=$(echo $signatureResp | jq .public_key | sed 's/\"//g')

starknet call \
    --address $address \
    --abi out/gerald_abi.json \
    --function get_balance \
    --inputs $publicKey
