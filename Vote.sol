// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Voting {
    string[] private validCandidates;
    mapping(string => bool) public isCandidateValid;

    string private CandidateOne = 'Jin';
    string private CandidateTwo = 'James';
    string private CandidateThree = 'John';

    uint256 public JinVoteCount;
    uint256 public JamesVoteCount;
    uint256 public JohnVoteCount;

    string[] public Voters;
    mapping(string => string) private VotingMap;

    constructor() {
        validCandidates = ['Jin', 'James', 'John'];
        for (uint256 i = 0; i < validCandidates.length; i++) {
            isCandidateValid[validCandidates[i]] = true;
        }
    }

    function hasVoted(string memory _Voter) public view returns (bool) {
        bool votedStatus = false;

        for (uint256 i = 0; i < Voters.length; i++) {
            if (keccak256(bytes(Voters[i])) == keccak256(bytes(_Voter))) {
                votedStatus = true;
                break;
            }
        }

        return votedStatus;
    }

    function Vote(string memory _Voter, string memory _Candidate) public onlyValidCandidate(_Candidate) {
        VotingMap[_Voter] = _Candidate;

        if (keccak256(bytes(_Candidate)) == keccak256(bytes(CandidateOne))) {
            JinVoteCount = JinVoteCount + 1;
        } else if (keccak256(bytes(_Candidate)) == keccak256(bytes(CandidateTwo))) {
            JamesVoteCount = JamesVoteCount + 1;
        } else {
            JohnVoteCount = JohnVoteCount + 1;
        }

        Voters.push(_Voter);
    }

    function getCandidateForVoter(string memory _voter) view public returns(string memory){
        return VotingMap[_voter];
    }

    modifier onlyValidCandidate(string memory _candidateName) {
        require(isCandidateValid[_candidateName], "Invalid candidate");
        _;
    }
}
