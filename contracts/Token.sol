// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";


contract Token is ERC20, ERC20Burnable {
    constructor(uint256 _supply) ERC20("Token Test", "Test Burn ERC20") {
        _mint(msg.sender, _supply);
    }
}
