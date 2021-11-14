export STARKNET_NETWORK=alpha

deployment=$(starknet deploy --contract out/$1_compiled.json);

echo $deployment > deployments/$1_deployment.txt;

echo "Deployed";

echo $deployment;
