# basic-dao-voting-system

## Project Title
Basic Decentralized Autonomous Organization (DAO) Voting System (Simplified)

## Project Description
This Solidity smart contract implements a very basic DAO voting system on the Ethereum blockchain, optimized for minimal gas consumption by stripping down complex features. It allows for the registration of members by the deployer, creation of proposals, and a simple mechanism for members to cast votes. The system tracks votes for and against each proposal without time-bound voting periods or on-chain execution logic. It's designed as a bare-bones example for understanding fundamental on-chain voting.

## Project Vision
To provide the simplest possible secure and transparent on-chain voting mechanism. The vision is to enable a group of individuals (DAO members) to collectively express their preferences on proposals, with the understanding that complex execution or time management will be handled off-chain or in a more advanced system.

## Key Features
- **Deployer-Controlled Member Registration:** The address that deploys the contract is automatically the first member and can register additional members.
- **Proposal Creation:** Registered members can create new proposals by providing a description. Each proposal receives a unique ID.
- **Secure Voting:** Members can vote "for" or "against" a proposal. Each member can only vote once per proposal.
- **Vote Counting:** The system automatically tallies votes for and against each proposal.
- **View Proposals:** A function to retrieve detailed information about any proposal, including its ID, description, and current vote counts.
- **Event Logging:** Key actions (member registration, proposal creation, vote casting) are logged as events for off-chain monitoring.

## Future Scope
- **Time-bound Voting:** Reintroduce explicit start and end times for voting periods if on-chain timing is required.
- **Executable Proposals:** Add logic for proposals to trigger actual on-chain actions (e.g., sending Ether, calling functions on other contracts) upon successful "passing" (which would require additional logic for voting thresholds and execution triggers).
- **Token-based Voting:** Allow voting power to be proportional to a member's token holdings within the DAO.
- **Delegated Voting:** Enable members to delegate their voting power to another member.
- **Decentralized Member Registration:** Implement a voting mechanism for existing members to approve new members, instead of relying solely on the deployer.
- **Front-end DApp:** Develop a user-friendly decentralized application (DApp) interface for easier interaction with the smart contract, displaying proposal lists, voting forms, and results.
- **Advanced Voting Logic:** Implement quorum requirements, majority thresholds, or different voting strategies (e.g., quadratic voting).

## Contract Address: 0xd9145CCE52D386f254917e481eB44e9943F39138
![image](https://github.com/user-attachments/assets/2df57d3c-d434-42d7-9d4a-ed378784847b)
