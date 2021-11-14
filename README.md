# Starknet Gerald

Messing around with startnet test net ideally build some simple
bridge. Starknet doesn't support ETH signing as of writing this
so will need to perform to jiggery pockery to get something working

# Scripts

```
export STARKNET_NETWORK=alpha
```

```
./scripts/compile.sh
```

```
./scripts/deploy.sh
```

```
./scripts/getBalance.sh 12345
```

```
./scripts/increaseBalance.sh 12345 6969
```

# References

[starknet intro](https://www.cairo-lang.org/docs/hello_starknet/intro.html)
[starknet user auth](https://www.cairo-lang.org/docs/hello_starknet/user_auth.html)
