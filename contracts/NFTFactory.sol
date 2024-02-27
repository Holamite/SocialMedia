// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract NFTFactory is ERC721URIStorage {
    uint256 private _nextTokenId;

    event NFTCreated(
        address indexed recipient,
        uint256 indexed tokenId,
        string uri
    );

    constructor(
        string memory _tokenName,
        string memory _tokenSymbol
    ) ERC721(_tokenName, _tokenSymbol) {}

    function createNFT(string memory tokenURI) external returns (uint256) {
        uint256 tokenId = _nextTokenId++;

        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);

        emit NFTCreated(msg.sender, tokenId, tokenURI);

        return tokenId;
    }
}
