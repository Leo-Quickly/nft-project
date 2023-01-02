// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract NFTRepo {
    uint256 private s_hello = 1234;

    constructor() {}

    function getHello() public view returns (uint256) {
        return s_hello;
    }
}
