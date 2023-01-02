// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract NFTPiece {
    uint256 public immutable i_content;
    address public s_owner;

    constructor(uint256 content) {
        i_content = content;
        s_owner = msg.sender;
    }

    function get_nft() public view returns (uint256) {
        return 4321;
    }
}
