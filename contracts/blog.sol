// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract wryteXYZ is ERC721 {


    mapping (uint256 => string) private _tokenURIs;
    
   constructor(
    string memory name,
    string memory symbol
   ) ERC721(name, symbol){
   }

   function mint(string memory _tokenURI, uint256 uniq) public {
    _safeMint(msg.sender, uniq);
    _setTokenURI(uniq, _tokenURI);

   }

   function _setTokenURI(uint256 _tokenId, string memory _tokenURI) internal virtual {
    require(
        _exists(_tokenId),
        "ERC721Metadata: URI set of nonexistent token"
    );
    _tokenURIs[_tokenId] = _tokenURI;
   }

   function tokenURI(uint256 _tokenId) public view virtual override returns(string memory){
    require(
        _exists(_tokenId),
        "ERC721Metadata: URI set of nonexistent token"
    );
    return _tokenURIs[_tokenId];
   }

   function _beforeTokenTransfer(
    address from, 
    address to, 
    uint256 tokenId) internal override {
        super._beforeTokenTransfer(from, to, tokenId);
        if(from != address(0)){
            address owner = ownerOf(tokenId);
            require(owner == msg.sender, "Only owner can burn or transfer");
        }
    }

    function burn(uint256 tokenId) public {
        super._burn(tokenId);
    }

}
