// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";

interface IERC20 {
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function withdraw(uint256 wad) external;
    function deposit(uint256 wad) external returns (bool);
    function owner() external view returns (address);
}

contract foundryDemo is Test {
    address _USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    address user = 0xF977814e90dA44bFA03b6295A0616a897441aceC;
    IERC20 USDT = IERC20(_USDT);

    receive() external payable {}

    function setUp() public {
        vm.createSelectFork("mainnet", 20272996);
    }

    function testTransfer() public {
        vm.prank(user);
        uint balanceBefore = USDT.balanceOf(user);
        uint amount = 10_000_000;
        USDT.transfer(address(this), amount);
        uint balanceAfter = USDT.balanceOf(user);
        require(balanceBefore - balanceAfter  == amount, "Test fail01!");
        require(USDT.balanceOf(address(this)) == amount, "Test fail02!");
    }
}