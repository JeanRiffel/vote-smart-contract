// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vote {

  struct Candidate {
    uint id;
    string name;
    uint voteCount;
  }

  mapping(uint => Candidate ) public candidates;
  mapping(address => bool) public voters;

  uint public candidatesCount;

  constructor() {
    addCandidate("John");
    addCandidate("Jack");
  } 

  function addCandidate(string memory name) private {
    candidatesCount++;
    candidates[candidatesCount] = Candidate(candidatesCount, name, 0);
  }

  function vote (uint candidateId) public {
    require(!voters[msg.sender], "You have already voted" );
    require(candidateId > 0 && candidateId  <= candidatesCount, "Invalid candidateId" );

    voters[msg.sender] = true;
    candidates[candidateId].voteCount++;
  }

  function getResults() public view returns (uint winningCandidateId) {
    uint winningVoteCount = 0;
    for(uint i= 1; i <= candidatesCount; i++){
      if(candidates[i].voteCount > winningVoteCount ){
        winningVoteCount = candidates[i].voteCount;
        winningCandidateId  = i;
      }
    }
  } 


}