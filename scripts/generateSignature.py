#!/usr/bin/env python
import json
import sys
from starkware.crypto.signature.signature import (pedersen_hash, private_to_stark_key, sign)

private_key = int(sys.argv[1])

amount = int(sys.argv[2])

message_hash = pedersen_hash(amount)

public_key = private_to_stark_key(private_key)

signature = sign(msg_hash=message_hash, priv_key=private_key)

resp = {"public_key": str(public_key),
        "sig0": str(signature[0]),
        "sig1": str(signature[1])}

print(json.dumps(resp))
