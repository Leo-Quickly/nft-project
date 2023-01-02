// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./NFTOwner.sol";
import "./NFTPiece.sol";

contract NFTRepo {
    mapping(address => bool) private s_nftPiecesMap;
    address[] s_nftPieces;
    mapping(address => address) private s_nftOwners;

    constructor() {}

    function getHello() public view returns (uint256) {
        return 1234;
    }

    function createOwner() public returns (address) {
        if (s_nftOwners[msg.sender] != address(0)) {
            return s_nftOwners[msg.sender];
        }
        // need to create a new one
        NFTOwner newOwner = new NFTOwner();
        address newAddr = address(newOwner);
        s_nftOwners[msg.sender] = newAddr;
        return newAddr;

        // TODO, since this is write operation, return
        // value is not available
        // call getOwner again after couple block
        // confirmations
    }

    function getOwner() public view returns (address) {
        return s_nftOwners[msg.sender];
    }

    function getNFTPieces(
        uint256 start, // 0-indexed
        uint256 end // exclusive
    ) public view returns (address[] memory) {
        require(start <= end, "Start cannot be larger than End");

        uint256 actualStart = start >= 0 ? start : 0;
        uint256 actualEnd = end <= s_nftPieces.length
            ? end
            : s_nftPieces.length;
        uint256 size = actualEnd - actualStart;
        address[] memory retVal = new address[](size);
        for (uint256 i = 0; i < size; i++) {
            retVal[i] = s_nftPieces[i + actualStart];
        }
        return retVal;
    }

    function createNFTPiece(uint256 content) public {
        NFTPiece piece = new NFTPiece(content);
        address pieceAddr = address(piece);
        s_nftPieces.push(pieceAddr);
        s_nftPiecesMap[pieceAddr] = true;
    }
}
