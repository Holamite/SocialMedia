// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "./NFTFactory.sol";

contract Social {
    address owner;

    struct Group {
        uint256 id;
        string title;
        string description;
        address[] members;
        mapping(address => bool) isMember;
        mapping(uint256 => bool) nfts;
    }

    mapping(uint256 => Group) public groups;

    NFTFactory public nftFactoryContract;
    uint256 public nextGroupId = 1;

    constructor(address _nftFactoryAddress) {
        owner = msg.sender;
        nftFactoryContract = NFTFactory(_nftFactoryAddress);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier onlyMember(uint256 _groupId) {
        require(
            groups[_groupId].isMember[msg.sender],
            "Not a member of the group"
        );
        _;
    }

    function createGroup(
        string memory _title,
        string memory _description
    ) external {
        Group storage newGroup = groups[nextGroupId];
        newGroup.id = nextGroupId;
        newGroup.title = _title;
        newGroup.description = _description;
        newGroup.members.push(msg.sender);
        nextGroupId++;
    }
}
