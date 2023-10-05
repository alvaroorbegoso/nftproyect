// SPDX-License-Identifier: MIT

// Importar la librería ERC721
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Definir un contrato NFT que hereda de ERC721 y Ownable
contract MyNFT is ERC721Enumerable, Ownable {
    constructor() ERC721("MyNFT", "MNFT") {}

    // Estructura para almacenar información del NFT
    struct NFTMetadata {
        string name;
        string description;
    }

    // Mapeo para asignar cada token a su información
    mapping(uint256 => NFTMetadata) private _tokenInfo;

    // Función para crear un nuevo NFT
    function mintNFT(address recipient, uint256 tokenId, string memory name, string memory description)
        public
        onlyOwner
    {
        _mint(recipient, tokenId);
        _tokenInfo[tokenId] = NFTMetadata(name, description);
    }

    // Función para obtener información de un NFT
    function getNFTInfo(uint256 tokenId) public view returns (string memory name, string memory description) {
        require(_exists(tokenId), "Token no existe");
        NFTMetadata memory info = _tokenInfo[tokenId];
        return (info.name, info.description);
    }
}
