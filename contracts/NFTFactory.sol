// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "./NftToken.sol";

contract NFTFactory {
    NftToken[] NftTokenClones;

    function createNftToken(
        string memory _tokenName,
        string memory _tokenSymbol
    ) external {
        NftToken newNftToken_ = new NftToken(_tokenName, _tokenSymbol);

        NftTokenClones.push(newNftToken_);
    }
}
