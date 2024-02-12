// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:web3modal_flutter/web3modal_flutter.dart';

// Future<void> testTetherTokenContract() async {
//   // Create a Web3Client by passing a chain rpcUrl and an http client
//   final ethClient = Web3Client('https://sepolia.drpc.org', http.Client());

//   // Create DeployedContract object using contract's ABI and address
//   final deployedContract = DeployedContract(
//     ContractAbi.fromJson(
//       jsonEncode(ContractDetails.readContractAbi),
//       'TetherToken',
//     ),
//     EthereumAddress.fromHex(ContractDetails.contractAddress),
//   );

//   // Query contract's functions
//   final nameFunction = deployedContract.function('name');
//   final totalSupplyFunction = deployedContract.function('totalSupply');
//   final balanceFunction = deployedContract.function('balanceOf');

//   final nameResult = await ethClient.call(
//     contract: deployedContract,
//     function: nameFunction,
//     params: [],
//   );
//   debugPrint('name: ${nameResult.first}');

//   final totalSupply = await ethClient.call(
//     contract: deployedContract,
//     function: totalSupplyFunction,
//     params: [],
//   );
//   debugPrint('totalSupply: ${totalSupply.first}');

//   final balanceOf = await ethClient.call(
//     contract: deployedContract,
//     function: balanceFunction,
//     params: [
//       // Vitalik address as an example
//       EthereumAddress.fromHex('0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045'),
//     ],
//   );
//   debugPrint('balanceOf: ${balanceOf.first}');
// }