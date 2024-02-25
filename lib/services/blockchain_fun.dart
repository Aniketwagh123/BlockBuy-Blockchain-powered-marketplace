import 'dart:convert';

import 'package:aniket_s_application1/services/locator.dart';
import 'package:aniket_s_application1/services/walletConnectServices.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';



final _sepolia = W3MChainInfo(
    chainName: 'Sepolia Testnet',
    chainId: '11155111',
    namespace: 'eip155:11155111',
    tokenName: 'ETH',
    rpcUrl: 'https://ethereum-sepolia.publicnode.com',
    blockExplorer: W3MBlockExplorer(
      name: 'Sepolia Etherscan',
      url: 'https://sepolia.etherscan.io/',
    ),
  );

W3MService _w3mService = getIt<WalletServices>().ge_w3mService();
// Future<void> hi() async{
//   W3MChainPresets.chains.putIfAbsent(_sepolia.chainId, () => _sepolia);
// }


final deployedContract = DeployedContract(
    ContractAbi.fromJson(
      jsonEncode(abi), // ABI object
      'demo',
    ),
    EthereumAddress.fromHex('0x3487b8b1AEA585E0e84E9E7BB7D30f4d7E7Fbb38'),
  );

Future<void> getValue() async {
  var response =  await _w3mService.requestReadContract(
    deployedContract: deployedContract,
    functionName: 'getValue',
    rpcUrl: 'https://sepolia.infura.io/v3/e987555c33e24e92b0de71ca98408cd1',
    parameters: [],
  );
  print('Value retrieved from smart contract: $response');

}

Future<void> setValue() async {
  final newValue = BigInt.from(123);
  // final data = deployedContract.function('setValue').encodeCall([
  //   newValue,
  // ]);
  return await _w3mService.requestWriteContract(
    topic: _w3mService.session?.topic ?? 'default',
    chainId: 'eip155:11155111',
    rpcUrl: 'https://sepolia.infura.io/v3/e987555c33e24e92b0de71ca98408cd1',
    deployedContract: deployedContract,
    functionName: 'setValue',
    transaction: Transaction(
      from: EthereumAddress.fromHex(_w3mService.session?.address?.toString() ?? "N/A"),
      // to: deployedContract.address,
      // data: data
      // value: EtherAmount.zero(),
    ),
    parameters: [newValue],
  );
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

Future<void> transferEther() async {
  // Define the receiver address and amount
  final receiverAddress = EthereumAddress.fromHex('0x3462C18e6C1267923ABABF4D2862d10771fA08a3');
  final transferAmount = BigInt.from(10000000000000000); // 0.01 Ether in Wei

  // Encode the function call data with parameters
  final data = deployedContract.function('transferEther').encodeCall([
    receiverAddress,
    transferAmount,
  ]);

  // Send the transaction
  return await _w3mService.requestWriteContract(
    topic: _w3mService.session?.topic ?? "",
    chainId: 'eip155:11155111',
    rpcUrl: 'https://sepolia.infura.io/v3/e987555c33e24e92b0de71ca98408cd1',
    deployedContract: deployedContract,
    functionName: 'transferEther',
    transaction: Transaction(
      from: EthereumAddress.fromHex(_w3mService.session?.address?.toString() ?? "N/A"),
      to: deployedContract.address,
      value: EtherAmount.fromInt(EtherUnit.finney, 1), // Value to transfer (0.01 Ether)
      maxGas: 300000,
      maxFeePerGas: EtherAmount.fromInt(EtherUnit.gwei, 45),
      data: data, // Pass the encoded function call data
    ),
  );
}


const abi = [
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "newValue",
				"type": "uint256"
			}
		],
		"name": "setValue",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address payable",
				"name": "receiver",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "amount",
				"type": "uint256"
			}
		],
		"name": "transferEther",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getValue",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "storedValue",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
];