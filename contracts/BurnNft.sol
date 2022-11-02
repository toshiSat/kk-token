// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract BurnNft is ERC721URIStorage {
    using SafeERC20 for ERC20Burnable;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address public immutable KEEP_KEY_TOKEN;
    mapping(uint256 => Attr) public attributes;

    struct Attr {
        uint256 amountVoted;
        string coinGeckoIdentifier;
    }

    constructor(address _keepKeyToken) ERC721("Proof of Burn", "KKPoB") {
        KEEP_KEY_TOKEN = _keepKeyToken;
    }

    function uint2str(uint256 _i)
        internal
        pure
        returns (string memory _uintAsString)
    {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - (_i / 10) * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }


    function addressToString(address _address)
        public
        pure
        returns (string memory)
    {
        bytes32 _bytes = bytes32(uint256(uint160(_address)));
        bytes memory HEX = "0123456789abcdef";
        bytes memory _string = new bytes(42);
        _string[0] = "0";
        _string[1] = "x";
        for (uint256 i = 0; i < 20; i++) {
            _string[2 + i * 2] = HEX[uint8(_bytes[i + 12] >> 4)];
            _string[3 + i * 2] = HEX[uint8(_bytes[i + 12] & 0x0f)];
        }
        return string(_string);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721URIStorage)
        returns (string memory)
    {
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        attributes[tokenId].coinGeckoIdentifier,
                        '",',
                        '"image": "',
                        "https://gateway.pinata.cloud/ipfs/QmViWLnKer8WxH99Bv32yiNKJNQWHzhujwUguKVsr5ohDF/chain/address",
                        '",',
                        '"attributes": [{"trait_type": "Token To Implement", "value": "',
                        attributes[tokenId].coinGeckoIdentifier,
                        '"',
                        "},",
                        '{"trait_type": "Amount Voted", "value": "',
                        uint2str(attributes[tokenId].amountVoted),
                        '"',
                        "}",
                        "]}"
                    )
                )
            )
        );
        return string(abi.encodePacked("data:application/json;base64,", json));
    }

    function mintNFT(
        uint256 _amountVoted,
        string memory _coinGeckoIdentifier
    ) public returns (uint256) {
        ERC20Burnable(KEEP_KEY_TOKEN).burnFrom(msg.sender, _amountVoted);
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        attributes[newItemId] = Attr(_amountVoted, _coinGeckoIdentifier);
        _tokenIds.increment();
        return newItemId;
    }
}
