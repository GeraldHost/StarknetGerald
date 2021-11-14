privateKey=$1;
amount=$2;

signatureResp=$(./scripts/generateSignature.py $privateKey $amount)

get_key() {
  echo $signatureResp | jq .$1 | sed 's/\"//g'
}

publicKey=$(get_key "public_key")
sig0=$(get_key "sig0")
sig1=$(get_key "sig1")

address=$(cat deployments/gerald_deployment.txt | xargs -n1 | grep -ow -m1 '\0x.*\b');

starknet invoke \
    --address $address \
    --abi out/gerald_abi.json \
    --function increase_balance \
    --inputs $publicKey $amount \
    --signature $sig0 $sig1
