echo $2
exit;
address=$(cat deployments/gerald_deployment.txt | xargs -n1 | grep -ow -m1 '\0x.*\b');

starknet invoke \
    --address $address \
    --abi out/gerald_abi.json \
    --function increase_balance \
    --inputs $1 $2
