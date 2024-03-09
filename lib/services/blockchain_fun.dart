import 'package:convert/convert.dart';
import 'dart:typed_data';

import 'package:aniket_s_application1/contracts/Store.dart';
import 'package:aniket_s_application1/model/product.dart';
import 'package:aniket_s_application1/services/locator.dart';
import 'package:aniket_s_application1/services/walletConnectServices.dart';
import 'package:http/http.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

// ignore: constant_identifier_names
const String RPC_URL =
    'https://sepolia.infura.io/v3/e987555c33e24e92b0de71ca98408cd1';
W3MService _w3mService = getIt<WalletServices>().ge_w3mService();
final client = Web3Client(
    'https://sepolia.infura.io/v3/e987555c33e24e92b0de71ca98408cd1', Client());

Future<dynamic> addProduct(String name, String category, String imageLink,
    String descLink, BigInt price) async {
  _w3mService.launchConnectedWallet();
  final parameters = [
    name,
    category,
    imageLink,
    descLink,
    price,
  ];
  return await _w3mService.requestWriteContract(
    topic: _w3mService.session?.topic ?? 'default',
    chainId: 'eip155:11155111',
    rpcUrl: RPC_URL,
    deployedContract: storeContract,
    functionName: 'addProduct',
    transaction: Transaction(
      from: EthereumAddress.fromHex(
          _w3mService.session?.address?.toString() ?? "N/A"),
    ),
    parameters: parameters,
  );
}

// Function to retrieve all products from the smart contract
Future<List<String>> getAllProducts() async {
  // Call the smart contract function to get the number of products
  var productCount = await _w3mService.requestReadContract(
    deployedContract: storeContract,
    functionName: 'getProductCount',
    rpcUrl: RPC_URL,
    parameters: [],
  );
  productCount = int.parse(productCount.toString());
  final List<String> productHashes = [];

  for (var i = 2; i < productCount; i++) {
    final productId = await _w3mService.requestReadContract(
      deployedContract: storeContract,
      functionName: 'getProductIdAt',
      rpcUrl: RPC_URL,
      parameters: [BigInt.from(i)],
    );
    
    final productDetails = await _w3mService.requestReadContract(
      deployedContract: storeContract,
      functionName: 'getProduct',
      rpcUrl: RPC_URL,
      parameters: [productId],
      
    );
    productHashes.add(productDetails);

    // print("Debug ==> ${productDetails.runtimeType}");
  }
  return productHashes;
}

// final deployedContract = DeployedContract(
//   ContractAbi.fromJson(
//     jsonEncode(abi), // ABI object
//     'demo',
//   ),
//   EthereumAddress.fromHex('0x3487b8b1AEA585E0e84E9E7BB7D30f4d7E7Fbb38'),
// );

// Future<void> getValue() async {
//   var response = await _w3mService.requestReadContract(
//     deployedContract: deployedContract,
//     functionName: 'getValue',
//     rpcUrl: 'https://sepolia.infura.io/v3/e987555c33e24e92b0de71ca98408cd1',
//     parameters: [],
//   );
//   print('Value retrieved from smart contract: $response');
// }

// Future<dynamic> setValue(int value) async {
//   _w3mService.launchConnectedWallet();
//   final newValue = BigInt.from(value);
//   // final data = deployedContract.function('setValue').encodeCall([
//   //   newValue,
//   // ]);
//   return await _w3mService.requestWriteContract(
//     topic: _w3mService.session?.topic ?? 'default',
//     chainId: 'eip155:11155111',
//     rpcUrl: 'https://sepolia.infura.io/v3/e987555c33e24e92b0de71ca98408cd1',
//     deployedContract: deployedContract,
//     functionName: 'setValue',
//     transaction: Transaction(
//       from: EthereumAddress.fromHex(
//           _w3mService.session?.address?.toString() ?? "N/A"),
//       // to: deployedContract.address,
//       // data: data
//       // value: EtherAmount.zero(),
//     ),
//     parameters: [newValue],
//   );
// }

Future<TransactionReceipt?> checkTransactionStatus(String txHash) async {
  try {
    // Get transaction receipt
    final receipt = await client.getTransactionReceipt(txHash);
    return receipt;
  } catch (e) {
    // Handle errors
    print('Error while checking transaction status: $e');
    return null;
  }
}

Future<TransactionReceipt?> getTransactionReceipt(String txHash) async {
  try {
    // Get transaction receipt
    final receipt = await client.getTransactionReceipt(txHash);
    return receipt;
  } catch (e) {
    // Handle errors
    print('Error while retrieving transaction receipt: $e');
    return null;
  }
}

// Future<void> transferEther() async {
//   // print('hiiiii');
//   // hi();
//   // print('doneee');
//   return await _w3mService.requestWriteContract(
//     topic: _w3mService.session?.topic?? "",
//     chainId: 'eip155:11155111',
//     rpcUrl: 'https://sepolia.infura.io/v3/e987555c33e24e92b0de71ca98408cd1',
//     deployedContract: deployedContract,
//     functionName: 'transferEther',
//     transaction: Transaction(
//       from: EthereumAddress.fromHex(_w3mService.session?.address?.toString() ?? "N/A"),
//       to: EthereumAddress.fromHex('0x3462C18e6C1267923ABABF4D2862d10771fA08a3'),
//       value: EtherAmount.fromInt(EtherUnit.finney, 1), // == 0.010
//       maxGas: 30000,
//       maxFeePerGas: EtherAmount.fromInt(EtherUnit.gwei, 45),
//     ),
//   );
// }

// Future<void> transferEther() async {
//   // Define the receiver address and amount
//   final receiverAddress =
//       EthereumAddress.fromHex('0x3462C18e6C1267923ABABF4D2862d10771fA08a3');
//   final transferAmount = BigInt.from(10000000000000000); // 0.01 Ether in Wei

//   // Encode the function call data with parameters
//   final data = deployedContract.function('transferEther').encodeCall([
//     receiverAddress,
//     transferAmount,
//   ]);

//   // Send the transaction
//   return await _w3mService.requestWriteContract(
//     topic: _w3mService.session?.topic ?? "",
//     chainId: 'eip155:11155111',
//     rpcUrl: 'https://sepolia.infura.io/v3/e987555c33e24e92b0de71ca98408cd1',
//     deployedContract: deployedContract,
//     functionName: 'transferEther',
//     transaction: Transaction(
//       from: EthereumAddress.fromHex(
//           _w3mService.session?.address?.toString() ?? "N/A"),
//       to: deployedContract.address,
//       value: EtherAmount.fromInt(
//           EtherUnit.finney, 1), // Value to transfer (0.01 Ether)
//       maxGas: 300000,
//       maxFeePerGas: EtherAmount.fromInt(EtherUnit.gwei, 45),
//       data: data, // Pass the encoded function call data
//     ),
//   );
// }

// const abi = [
//   {
//     "inputs": [
//       {"internalType": "uint256", "name": "newValue", "type": "uint256"}
//     ],
//     "name": "setValue",
//     "outputs": [],
//     "stateMutability": "nonpayable",
//     "type": "function"
//   },
//   {
//     "inputs": [
//       {
//         "internalType": "address payable",
//         "name": "receiver",
//         "type": "address"
//       },
//       {"internalType": "uint256", "name": "amount", "type": "uint256"}
//     ],
//     "name": "transferEther",
//     "outputs": [],
//     "stateMutability": "payable",
//     "type": "function"
//   },
//   {
//     "inputs": [],
//     "name": "getValue",
//     "outputs": [
//       {"internalType": "uint256", "name": "", "type": "uint256"}
//     ],
//     "stateMutability": "view",
//     "type": "function"
//   },
//   {
//     "inputs": [],
//     "name": "storedValue",
//     "outputs": [
//       {"internalType": "uint256", "name": "", "type": "uint256"}
//     ],
//     "stateMutability": "view",
//     "type": "function"
//   }
// ];
