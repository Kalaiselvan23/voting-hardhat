// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IoTVotingSystem {
    
    address public admin;
    bool public votingOpen = true;
    
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    struct Voter {
        bool hasVoted;
        uint candidateId;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => Voter) public voters;
    uint public candidatesCount;
    
    uint[] public candidateIds;

    event VoteCast(address voter, uint candidateId);

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier voteOpen() {
        require(votingOpen, "Voting is closed");
        _;
    }

    function addCandidate(string memory _name) public onlyAdmin {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        candidateIds.push(candidatesCount); // Add candidate ID to the array
    }

    function vote(uint _candidateId) public voteOpen {
        require(!voters[msg.sender].hasVoted, "You have already voted");

        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");

        voters[msg.sender] = Voter(true, _candidateId);

        candidates[_candidateId].voteCount++;

        emit VoteCast(msg.sender, _candidateId);
    }

    function closeVoting() public onlyAdmin {
        votingOpen = false;
    }

    function openVoting() public onlyAdmin {
        votingOpen = true;
    }

    function getCandidateVoteCount(uint _candidateId) public view returns (uint) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");
        return candidates[_candidateId].voteCount;
    }

    function getTotalCandidates() public view returns (uint) {
        return candidatesCount;
    }

    function getAllCandidates() public view returns (Candidate[] memory) {
        Candidate[] memory allCandidates = new Candidate[](candidateIds.length);
        for (uint i = 0; i < candidateIds.length; i++) {
            allCandidates[i] = candidates[candidateIds[i]];
        }
        return allCandidates;
    }
}
