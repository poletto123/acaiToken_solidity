//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import './AcaiToken.sol';

contract TokenSale {
    uint constant public priceInWei = 2 * 10 ** 15;

    AcaiToken token;
    address tokenSaleOwner;

    constructor(address tokenAddress) {
        tokenSaleOwner = msg.sender;
        token = AcaiToken(tokenAddress);
    }

    function purchase() public payable {
        require(msg.value >= priceInWei, "Not enough funds sent");
        uint tokensToTransfer = msg.value / priceInWei;
        uint remainder = msg.value - tokensToTransfer * priceInWei;
        token.transferFrom(tokenSaleOwner, msg.sender, tokensToTransfer * priceInWei);
        payable(msg.sender).transfer(remainder);
    }

}