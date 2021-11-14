# https://www.cairo-lang.org/docs/hello_starknet/intro.html#your-first-contract
# https://www.cairo-lang.org/docs/hello_starknet/user_auth.html#
#
# Declare this file as a StarkNet contract and set the required
# builtins.
%lang starknet
%builtins pedersen range_check ecdsa

from starkware.cairo.common.cairo_builtins import (HashBuiltin, SignatureBuiltin)
from starkware.cairo.common.hash import hash2
from starkware.cairo.common.signature import (verify_ecdsa_signature)
from starkware.starknet.common.syscalls import get_tx_signature

const L1_CONTRACT_ADDRESS = ()

# Define a storage variable.
@storage_var
func balance(user : felt) -> (res : felt):
end

# deposit funds
@l1_handler
func deposit{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}(
        from_address : felt, user : felt, amount : felt):
    # Make sure the message was sent by the intended L1 contract.
    assert from_address = L1_CONTRACT_ADDRESS

    # Read the current balance.
    let (res) = balance.read(user=user)

    # Compute and update the new balance.
    tempvar new_balance = res + amount
    balance.write(user, new_balance)

    return ()
end

# Increases the balance of the given user by the given amount.
@external
func transfer{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*,
        range_check_ptr, ecdsa_ptr : SignatureBuiltin*}(
        user : felt, amount : felt, to : felt):
    # Fetch the signature.
    let (sig_len : felt, sig : felt*) = get_tx_signature()

    # Verify the signature length.
    assert sig_len = 2

    # Compute the hash of the message.
    # The hash of (x, 0) is equivalent to the hash of (x).
    let (amount_hash) = hash2{hash_ptr=pedersen_ptr}(amount, 0)

    # Verify the user's signature.
    verify_ecdsa_signature(
        message=amount_hash,
        public_key=user,
        signature_r=sig[0],
        signature_s=sig[1])

    let (res) = balance.read(user=user)
    balance.write(user, res - amount)
    balance.write(to, amount)
    return ()
end

# Returns the current balance.
@view
func get_balance{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        user : felt) -> (res : felt):
    let (res) = balance.read(user)
    return (res)
end
