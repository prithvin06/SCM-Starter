// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Assessment {
    
    string[] public array;

    constructor() payable {
        array = ["Cat", "Mouse", "Rat", "Dog"];
    }

    function getArray() public view returns(string[] memory) {
        return array;
    }

    function addString(string memory _word) public payable {
        array.push(_word);
    }

    function removeString(string memory _word) public {
        for (uint i = 0; i < array.length; i++) {
            if (keccak256(bytes(array[i])) == keccak256(bytes(_word))) {
                for (uint j = i; j < array.length - 1; j++) {
                    array[j] = array[j + 1];
                }
                array.pop();
                break;
            }
        }
    }
}
