// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVotingDAO {
    // --- Structs ---
    struct Proposal {
        uint256 id;
        string description;
        uint256 voteCountFor;
        uint256 voteCountAgainst;
        // Removed: bool executed, bool ended, uint256 creationTimestamp
        mapping(address => bool) hasVoted; // Tracks if a member has voted on this proposal
    }

    // --- State Variables ---
    uint256 public nextProposalId; // Auto-incrementing ID for new proposals
    mapping(address => bool) public members; // Tracks registered DAO members
    mapping(uint256 => Proposal) public proposals; // Stores all proposals by their ID
    uint256 public memberCount; // Number of registered members
    address public deployer; // The address that deployed this contract

    // --- Events ---
    event MemberRegistered(address indexed memberAddress);
    event ProposalCreated(uint256 indexed proposalId, string description); // Reduced event data
    event VoteCast(uint256 indexed proposalId, address indexed voter, bool support);
    // Removed: ProposalExecuted, ProposalEnded events

    // --- Modifiers ---
    modifier onlyMember() {
        require(members[msg.sender], "Only DAO members can call this function.");
        _;
    }

    modifier onlyDeployer() {
        require(msg.sender == deployer, "Only the deployer can perform this action.");
        _;
    }

    // --- Constructor ---
    // The deployer is automatically registered as the first member.
    constructor() {
        deployer = msg.sender;
        nextProposalId = 1;
        members[msg.sender] = true;
        memberCount = 1;
        emit MemberRegistered(msg.sender);
    }

    // --- Core Function 1: Register Member (only deployer can add) ---
    // Allows the deployer to add new members to the DAO.
    // This function can be modified to allow a more decentralized registration
    // if a vote-based registration is desired in a future iteration.
    function registerMember(address _newMember) public onlyDeployer {
        require(_newMember != address(0), "Invalid address.");
        require(!members[_newMember], "Address is already a member.");

        members[_newMember] = true;
        memberCount++;
        emit MemberRegistered(_newMember);
    }

    // --- Core Function 2: Create Proposal ---
    // Allows any member to propose a new idea for voting.
    // @param _description A string describing the proposal.
    // @return The ID of the newly created proposal.
    function createProposal(string memory _description) public onlyMember returns (uint256) {
        require(bytes(_description).length > 0, "Proposal description cannot be empty.");

        uint256 proposalId = nextProposalId;
        proposals[proposalId].id = proposalId;
        proposals[proposalId].description = _description;
        proposals[proposalId].voteCountFor = 0;
        proposals[proposalId].voteCountAgainst = 0;
        // No creationTimestamp, so no time-bound voting in this simplified version

        nextProposalId++;

        emit ProposalCreated(proposalId, _description);
        return proposalId;
    }

    // --- Core Function 3: Vote on Proposal ---
    // Allows members to cast their vote (for or against) on any existing proposal.
    // Voting is always open in this simplified version.
    // @param _proposalId The ID of the proposal to vote on.
    // @param _support True for a 'for' vote, false for an 'against' vote.
    function vote(uint256 _proposalId, bool _support) public onlyMember {
        Proposal storage proposal = proposals[_proposalId];

        require(proposal.id != 0, "Proposal does not exist.");
        require(!proposal.hasVoted[msg.sender], "You have already voted on this proposal.");
        // Removed time-bound voting check

        if (_support) {
            proposal.voteCountFor++;
        } else {
            proposal.voteCountAgainst++;
        }
        proposal.hasVoted[msg.sender] = true;

        emit VoteCast(_proposalId, msg.sender, _support);
    }

    // --- Helper Function: Get Proposal Details ---
    // Gets a specific proposal's details.
    // @param _proposalId The ID of the proposal to retrieve.
    // @return id The proposal's ID.
    // @return description The proposal's description.
    // @return voteCountFor The number of 'for' votes.
    // @return voteCountAgainst The number of 'against' votes.
    function getProposal(uint256 _proposalId)
        public
        view
        returns (
            uint256 id,
            string memory description,
            uint256 voteCountFor,
            uint256 voteCountAgainst
        )
    {
        Proposal storage proposal = proposals[_proposalId];
        require(proposal.id != 0, "Proposal does not exist.");

        return (
            proposal.id,
            proposal.description,
            proposal.voteCountFor,
            proposal.voteCountAgainst
        );
    }

    // Gets the current member status of an address.
    // @param _memberAddress The address to check.
    // @return True if the address is a registered member, false otherwise.
    function isMember(address _memberAddress) public view returns (bool) {
        return members[_memberAddress];
    }
}
