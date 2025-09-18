module challenge_rewards::rewards {
    use std::signer;
    use std::vector;
    use aptos_std::table::{Self, Table};

    /// Error codes
    const E_NOT_ADMIN: u64 = 1;
    const E_CHALLENGE_NOT_EXISTS: u64 = 2;
    const E_ALREADY_COMPLETED: u64 = 3;

    /// Challenge reward structure
    struct Challenge has key {
        rewards: Table<u64, u64>,
        completions: Table<address, vector<u64>>,
        admin: address,
    }

    /// Initialize the reward system
    public fun initialize(admin: &signer) {
        let admin_addr = signer::address_of(admin);
        move_to(admin, Challenge {
            rewards: table::new(),
            completions: table::new(),
            admin: admin_addr,
        });
    }

    /// Create a new challenge with reward points
    public entry fun create_challenge(
        admin: &signer,
        challenge_id: u64,
        reward_points: u64
    ) acquires Challenge {
        let admin_addr = signer::address_of(admin);
        let challenge = borrow_global_mut<Challenge>(@challenge_rewards);
        
        assert!(challenge.admin == admin_addr, E_NOT_ADMIN);
        table::add(&mut challenge.rewards, challenge_id, reward_points);
    }

    /// Complete challenge and record completion
    public entry fun complete_challenge(
        user: &signer,
        challenge_id: u64
    ) acquires Challenge {
        let user_addr = signer::address_of(user);
        let challenge = borrow_global_mut<Challenge>(@challenge_rewards);
        
        assert!(table::contains(&challenge.rewards, challenge_id), E_CHALLENGE_NOT_EXISTS);
        
        if (!table::contains(&challenge.completions, user_addr)) {
            table::add(&mut challenge.completions, user_addr, vector::empty<u64>());
        };
        
        let user_completions = table::borrow_mut(&mut challenge.completions, user_addr);
        assert!(!vector::contains(user_completions, &challenge_id), E_ALREADY_COMPLETED);
        
        vector::push_back(user_completions, challenge_id);
        // Challenge completed successfully - points recorded
    }
}
