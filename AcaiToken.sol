// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract AcaiToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    // price = 0.002 eth
    uint priceInWei = 2 * 10 ** 15;

    event AcaiPurchased(address indexed acaiReceiver, address indexed AcaiPayer);

    constructor() ERC20("AcaiToken", "ACAI") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount * priceInWei);
    }

    function buyOneAcai() public {
        _burn(_msgSender(), 1);
        emit AcaiPurchased(_msgSender(), _msgSender());
    }

    function buyOneAcaiFrom(address payer) public {
         _spendAllowance(payer, _msgSender(), 1 * priceInWei);
         _burn(_msgSender(), 1 * priceInWei);
         emit AcaiPurchased(_msgSender(), payer);
    }


}