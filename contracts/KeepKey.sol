// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";


contract KeepKey is ERC20, ERC20Burnable {
    constructor(uint256 _supply) ERC20("KeepKey Test", "KKt") {
        _mint(msg.sender, _supply);
    }
}
