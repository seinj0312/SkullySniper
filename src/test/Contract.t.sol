// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {DSTest} from "ds-test/test.sol";
import {Utilities} from "./utils/Utilities.sol";
import {console} from "./utils/Console.sol";
import {Hevm} from "./utils/Hevm.sol";

import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {MockERC721} from "./mock-ercs/ERC721.sol";
import {MockERC20} from "./mock-ercs/ERC20.sol";

contract ContractTest is DSTest {
    Hevm internal immutable hevm = Hevm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D); // HEVM-ADDRESS

    Utilities internal utils;
    address payable[] internal users;
    address internal deployer;

    MockERC20 internal weth;

    function setUp() public {
        utils = new Utilities();
        users = utils.createUsers(5);

        weth = new MockERC20("Wrapped Eth", "WETH", 18);
    }

    /**
        @dev Test for things that are meant to work correctly.
     */
    function testExample() public {
        address payable alice = users[0];
        console.log("alice's address", alice);
        address payable bob = users[1];
        hevm.prank(alice);
        (bool sent, ) = bob.call{value: 10 ether}("");
        assertTrue(sent);
        assertGt(bob.balance, alice.balance);
    }

    /**
        @dev Test for failures.
     */
    function testFailExample() public {
        uint256 bal = 1;
        uint256 notBal = 2;
        assertEq(bal, notBal);
    }
}
