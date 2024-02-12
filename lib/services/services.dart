import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class WalletServices {
  late W3MService _w3mService;

  WalletServices() {
    initializeState();
  }
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


  void initializeState() async {
    W3MChainPresets.chains.putIfAbsent(_sepolia.chainId, () => _sepolia);
    _w3mService = W3MService(
      projectId: 'f41e096ce41e7dd4f463537c57b52f89',
      metadata: const PairingMetadata(
        name: 'Web3Modal Flutter Example',
        description: 'Web3Modal Flutter Example',
        url: 'https://www.walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'w3m://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );
    await _w3mService.init();
    // print();
    // _w3mService.onSessionEventEvent.subscribe(_onSessionEvent);
    // _w3mService.onSessionUpdateEvent.subscribe(_onSessionUpdate);
    // _w3mService.onSessionConnectEvent.subscribe(_onSessionConnect);
    // _w3mService.onSessionDeleteEvent.subscribe(_onSessionDelete);
  }

  // @override
  // void dispose() {
  //   _w3mService.onSessionEventEvent.unsubscribe(_onSessionEvent);
  //   _w3mService.onSessionUpdateEvent.unsubscribe(_onSessionUpdate);
  //   _w3mService.onSessionConnectEvent.unsubscribe(_onSessionConnect);
  //   _w3mService.onSessionDeleteEvent.unsubscribe(_onSessionDelete);
  // }

  // void _onSessionEvent(SessionEvent? args) {
  //   debugPrint('_onSessionEvent $args');
  // }

  // void _onSessionUpdate(SessionUpdate? args) {
  //   debugPrint('_onSessionUpdate $args');
  // }

  // void _onSessionConnect(SessionConnect? args) {
  //   debugPrint(' _onSessionConnect $args');
  //   debugPrint("qsdfgrexcv");

  // }
  // void redirectss(){
  //   // NavigatorService.pushNamed(
  //   //   AppRoutes.loginScreen,
  //   // );
  // }

  // void _onSessionDelete(SessionDelete? args) {
  //   debugPrint(' _onSessionDelete $args');
  // }

  void printInfo() {
    // _w3mService.session.topic
    debugPrint(_w3mService.status.toString());
    debugPrint(_w3mService.session.toString());
    debugPrint(_w3mService.selectedWallet.toString());
    debugPrint(_w3mService.selectedChain.toString());
    debugPrint(_w3mService.isConnected.toString());
    debugPrint(_w3mService.chainBalance.toString());
    debugPrint(_w3mService.session?.address!.toString());
    debugPrint(_w3mService.session?.connectedWalletName.toString());
    debugPrint(_w3mService.session?.chainId.toString());
    debugPrint(_w3mService.session?.topic);
  }

// 0xe4d5feedd7369dbb3b2ca8693fdfc6e9d6507353
  W3MService ge_w3mService() {
    return _w3mService;
  }
}
