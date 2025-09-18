# Challenge Rewards Smart Contract

A simple Move smart contract for the Aptos blockchain that enables token rewards for completing challenges. Users can complete challenges and earn reward points tracked on-chain.

## 🚀 Features

- **Challenge Creation**: Admin can create new challenges with associated reward points
- **Challenge Completion**: Users can complete challenges and earn points
- **Duplicate Prevention**: Prevents users from claiming rewards for the same challenge twice
- **Admin Control**: Only designated admin can create new challenges
- **On-chain Tracking**: All completions and rewards are recorded on the blockchain

## 📋 Prerequisites

- [Aptos CLI](https://aptos.dev/cli-tools/aptos-cli-tool/install-aptos-cli/) installed
- Basic understanding of Move programming language
- Aptos testnet/devnet account with sufficient funds

## 🛠️ Setup & Installation

1. **Clone or create the project directory**:
   ```bash
   mkdir token-reward-blockchain
   cd token-reward-blockchain
   ```

2. **Initialize Aptos project**:
   ```bash
   aptos init
   ```
   Choose `devnet` when prompted for network selection.

3. **Create the contract file**:
   ```bash
   mkdir -p sources
   # Copy the contract code into sources/project.move
   ```

4. **Compile the contract**:
   ```bash
   aptos move compile
   ```

## 📄 Contract Structure

### Data Structures

- **Challenge**: Main resource containing:
  - `rewards`: Table mapping challenge IDs to reward points
  - `completions`: Table tracking user completions
  - `admin`: Address of the contract administrator

### Functions

#### `initialize(admin: &signer)`
- Initializes the reward system
- Sets the admin for the contract
- Must be called once before using other functions

#### `create_challenge(admin: &signer, challenge_id: u64, reward_points: u64)`
- Creates a new challenge with specified reward points
- Only callable by the admin
- Each challenge has a unique ID

#### `complete_challenge(user: &signer, challenge_id: u64)`
- Records challenge completion for a user
- Prevents duplicate completions
- Awards points (tracked on-chain)

## 🔧 Usage Examples

### Deploy the Contract

1. **Compile**:
   ```bash
   aptos move compile
   ```

2. **Deploy to testnet**:
   ```bash
   aptos move publish --named-addresses challenge_rewards=<YOUR_ADDRESS>
   ```

### Initialize the System

```bash
aptos move run \
  --function-id '<DEPLOYED_ADDRESS>::rewards::initialize'
```

### Create a Challenge

```bash
aptos move run \
  --function-id '<DEPLOYED_ADDRESS>::rewards::create_challenge' \
  --args u64:1 u64:100
```
*Creates challenge ID 1 with 100 reward points*

### Complete a Challenge

```bash
aptos move run \
  --function-id '<DEPLOYED_ADDRESS>::rewards::complete_challenge' \
  --args u64:1
```
*User completes challenge ID 1*

## 🔐 Security Features

- **Admin-only challenge creation**: Only the designated admin can create new challenges
- **Duplicate prevention**: Users cannot complete the same challenge multiple times
- **Input validation**: Checks for valid challenge IDs and proper permissions

## 🚨 Error Codes

- `E_NOT_ADMIN (1)`: Caller is not the admin
- `E_CHALLENGE_NOT_EXISTS (2)`: Challenge ID doesn't exist
- `E_ALREADY_COMPLETED (3)`: User has already completed this challenge

## 🔄 Future Enhancements

This basic implementation can be extended with:

- **Token Integration**: Add actual token transfers for rewards
- **Challenge Metadata**: Store challenge descriptions and requirements
- **Leaderboards**: Track top performers across challenges
- **Time-based Challenges**: Add expiration dates for challenges
- **Tiered Rewards**: Different reward amounts based on performance
- **Challenge Categories**: Group challenges by type or difficulty

## 📝 Contract Specifications

- **Language**: Move
- **Blockchain**: Aptos
- **Lines of Code**: ~56 lines
- **Gas Efficient**: Minimal storage and computation overhead
- **Modular Design**: Easy to extend and modify

## Transaction Hash

`0xa5cd59fc94eaa3c41d71e8b11f7708269dd7f082dc2afbbed6bc3b645f0ec13c`

## Transaction Proof

./txn-ref.png

---


