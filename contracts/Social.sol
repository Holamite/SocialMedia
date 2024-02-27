// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "./NFTFactory.sol";

contract Social {
    address owner;

    NFTFactory public nftFactoryContract;

    struct User {
        bool isRegistered;
        string role;
    }

    mapping(address => User) users;

    struct Group {
        uint256 id;
        string title;
        string description;
        address[] members;
        // mapping(uint256 => bool) nfts;
    }
    Group[] groupMembers;

    mapping(uint256 => Group) public groups;
    mapping(uint256 => bool) public flaggedContent;

    uint256 public nextGroupId = 1;

    constructor(address _nftFactoryAddress) {
        owner = msg.sender;
        nftFactoryContract = NFTFactory(_nftFactoryAddress);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function authenticateUser(string memory _role) external {
        require(!users[msg.sender].isRegistered, "User already exist");

        users[msg.sender] = User(true, _role);
    }

    function viewAuthenticationStatus(
        address _userAddress
    ) external view returns (bool isRegistered, string memory role) {
        User memory user = users[_userAddress];
        return (user.isRegistered, user.role);
    }

    function createGroup(
        string memory _title,
        string memory _description
    ) external {
        Group storage newGroup = groups[nextGroupId];
        newGroup.id = nextGroupId;
        newGroup.title = _title;
        newGroup.description = _description;
        groupMembers.push(newGroup);
        nextGroupId++;
    }

    function viewGroup(
        uint256 _groupId
    )
        external
        view
        returns (
            uint256 id,
            string memory title,
            string memory description,
            address[] memory members
        )
    {
        require(_groupId < nextGroupId, "Group does not exist");

        Group storage group = groups[_groupId];
        return (group.id, group.title, group.description, group.members);
    }

    function flagContent(uint256 _groupId) external onlyOwner {
        flaggedContent[_groupId] = true;
    }
}
