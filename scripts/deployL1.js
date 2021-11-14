async function main() {
  const starknetCore = "0x67D629978274b4E1e07256Ec2ef39185bb3d4D0d";

  // We get the contract to deploy
  const Gerald = await ethers.getContractFactory("Gerald");
  const gerald = await Gerald.deploy(starknetCore);
  console.log("Gerald deployed to:", gerald.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
