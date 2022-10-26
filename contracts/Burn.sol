// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract KeepKey is ERC721URIStorage {
    using SafeERC20 for ERC20Burnable;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address immutable KEEP_KEY_TOKEN;

    constructor(address _keepKeyToken) ERC721("Proof of Burn", "KKPoB") {
        KEEP_KEY_TOKEN = _keepKeyToken;
    }

    function mintNFT(uint256 _amount, string memory _tokenURI)
        public
        returns (uint256)
    {
        ERC20Burnable(KEEP_KEY_TOKEN).burnFrom(
            msg.sender,
            _amount
        );
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, _tokenURI);
        _tokenIds.increment();
        return newItemId;
    }
}
