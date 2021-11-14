require("@nomiclabs/hardhat-waffle");

const fs = require("fs");
const home = require("os").homedir();
const keyfile = require("path").join(home, process.env.KEY_FILE);
const key = fs.readFileSync(keyfile, { encoding: "utf8" });

module.exports = {
  paths: {
    sources: "./contracts/L1",
  },
  networks: {
    goerli: {
      url: "https://goerli.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161",
      accounts: [key],
    },
  },
  solidity: "0.8.0",
};
