# ADD OR REMOVE STRING FROM THE ARRAY
## Assesment.sol
This Solidity program is a simple smart contract that demonstrates basic array manipulation. The contract allows users to add and remove strings from an array. The purpose of this program is to serve as a starting point for those who are new to Solidity and want to get a feel for how it works.

## Description
This program is a smart contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. The contract has functions to add and remove strings from an array, as well as a function to retrieve the current state of the array. This program serves as a simple introduction to Solidity programming, specifically focusing on array manipulation.

Getting Started
## Executing Program
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., Assessment.sol). Copy and paste the following code into the file:

``` solidity

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Assessment {
    
    string[] public array;

    constructor() payable {
        array = ["Cat", "Mouse", "Rat", "Dog"];
    }

    function getArray() public view returns (string[] memory) {
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
```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.9" (or another compatible version), and then click on the "Compile Assessment.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "Assessment" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the getArray, addString, and removeString functions.


## index.js
This JavaScript program is a simple React application that interacts with a Solidity smart contract to manage an array of strings. The purpose of this program is to serve as a starting point for those who are new to using React with Ethereum smart contracts.

# Description
This program is a React front-end application that connects to a deployed Solidity smart contract using ethers.js. It allows users to connect their MetaMask wallet, view the current state of the array, and add or remove strings from the array. This program serves as a simple and straightforward introduction to integrating React with Ethereum smart contracts.

# Getting Started
Executing Program
To run this program, you need to set up a React application and install the necessary dependencies.


```javascript

 import { useState, useEffect } from "react";
import { ethers } from "ethers";
import atm_abi from "../artifacts/contracts/Assessment.sol/Assessment.json";

export default function HomePage() {
  const [ethWallet, setEthWallet] = useState(undefined);
  const [account, setAccount] = useState(undefined);
  const [atm, setATM] = useState(undefined);
  const [balance, setBalance] = useState(undefined);

  const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
  const atmABI = atm_abi.abi;

  const getWallet = async () => {
    if (window.ethereum) {
      setEthWallet(window.ethereum);
    }

    if (ethWallet) {
      const accounts = await ethWallet.request({ method: "eth_accounts" });
      handleAccount(accounts);
    }
  };

  const handleAccount = (accounts) => {
    if (accounts && accounts.length > 0) {
      console.log("Account connected: ", accounts[0]);
      setAccount(accounts[0]);
    } else {
      console.log("No account found");
    }
  };

  const connectAccount = async () => {
    if (!ethWallet) {
      alert("MetaMask wallet is required to connect");
      return;
    }

    const accounts = await ethWallet.request({ method: "eth_requestAccounts" });
    handleAccount(accounts);

    // Once wallet is set, get a reference to our deployed contract
    getATMContract();
  };

  const getATMContract = () => {
    const provider = new ethers.providers.Web3Provider(ethWallet, "any");
    const signer = provider.getSigner();
    const atmContract = new ethers.Contract(contractAddress, atmABI, signer);

    setATM(atmContract);
  };

  const getBalance = async () => {
    if (atm) {
      setBalance((await atm.getArray()).toString());
    }
  };

  const add = async () => {
    if (atm) {
      let word = prompt("Enter the word you want to push to array");
      if (word) {
        let tx = await atm.addString(word);
        await tx.wait();
        getBalance();
      }
    }
  };

  const remove = async () => {
    if (atm) {
      let word = prompt("Enter the word you want to pop from array");
      if (word) {
        let tx = await atm.removeString(word);
        await tx.wait();
        getBalance();
      }
    }
  };

  const initUser = () => {
    // Check if user has MetaMask
    if (!ethWallet) {
      return <p>Please install MetaMask in order to use this ATM.</p>;
    }

    // Check if user is connected. If not, connect to their account
    if (!account) {
      return <button onClick={connectAccount}>Please connect your MetaMask wallet</button>;
    }

    if (balance === undefined) {
      getBalance();
    }

    return (
      <div>
        <p>Your Account: {account}</p>
        <p>Your Balance: {balance}</p>
        <button onClick={add}>Add String</button>
        <button onClick={remove}>Remove String</button>
      </div>
    );
  };

  useEffect(() => {
    getWallet();
  }, []);

  return (
    <main className="container">
      <header>
        <h1><u>Add or Remove String from Array</u></h1>
      </header>
      {initUser()}
      <style jsx>{`
        .container {
          text-align: center;
          color: red;
          background-color: lightgray;
        }
      `}</style>
    </main>
  );
}
```
## Run the React Application:

- npm run dev
## Interact with the Application:

- Open your browser and go to http://localhost:3000.
- Connect your MetaMask wallet.
- Use the interface to add or remove strings from the array.

## Authors
M.Prithvin
[prithvin04@gmail.com]

License
This project is licensed under the MIT License - see the LICENSE.md file for details.
