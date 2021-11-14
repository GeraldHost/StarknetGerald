# https://www.cairo-lang.org/docs/hello_starknet/intro.html#your-first-contract
# Declare this file as a StarkNet contract and set the required
# builtins.
%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin

# Define a storage variable.
@storage_var
func balance(user : felt) -> (res : felt):
end

# Increases the balance by the given amount.
@external
func increase_balance{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        user : felt, amount : felt):
    let (res) = balance.read(user)
    balance.write(user, res + amount)
    return ()
end

# Returns the current balance.
@view
func get_balance{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        user : felt) -> (res : felt):
    let (res) = balance.read(user)
    return (res)
end
