// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract NFTOwner {
    uint256 private s_owner = 3456;

    constructor() {}

    function getOwner() public view returns (uint256) {
        return s_owner;
    }
}
