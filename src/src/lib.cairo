#[starknet::contract]
mod Counter {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    #[storage]
    struct Storage {
        value: u128,
    }

    #[abi(embed_v0)]
    impl CounterImpl of super::ICounter<ContractState> {
        fn get(self: @ContractState) -> u128 {
            self.value.read()
        }

        fn increment(ref self: ContractState) {
            let current = self.value.read();
            self.value.write(current + 1);
        }

        fn set(ref self: ContractState, new_value: u128) {
            self.value.write(new_value);
        }
    }
}

#[starknet::interface]
trait ICounter<TContractState> {
    fn get(self: @TContractState) -> u128;
    fn increment(ref self: TContractState);
    fn set(ref self: TContractState, new_value: u128);
}
