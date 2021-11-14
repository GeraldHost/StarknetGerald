address=$(cat deployments/gerald_deployment.txt | xargs -n1 | grep -ow -m1 '\0x.*\b');

starknet call \
    --address $address \
    --abi out/gerald_abi.json \
    --function get_balance
