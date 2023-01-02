// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract NFTPiece {
    uint256 private s_nft_piece = 4321;

    constructor() {}

    function get_nft() public view returns (uint256) {
        return s_nft_piece;
    }
}
