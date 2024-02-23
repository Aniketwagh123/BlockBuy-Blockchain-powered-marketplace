import 'package:aniket_s_application1/services/locator.dart';
import 'package:aniket_s_application1/services/walletConnectServices.dart';
import 'package:web3modal_flutter/widgets/web3modal.dart';

import 'bloc/login_bloc.dart';
import 'models/login_model.dart';
import 'package:aniket_s_application1/core/app_export.dart';

import 'package:aniket_s_application1/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

import 'package:web3modal_flutter/web3modal_flutter.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(LoginState(loginModelObj: LoginModel()))
        ..add(LoginInitialEvent()),
      child: LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    // NetworkInfo nfo = NetworkInfo();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(left: 16.h, top: 68.v, right: 16.h),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPageHeader(context),
                  _buildOrLine(context),
                  SizedBox(height: 16.v),
                  SizedBox(height: 16.v),
                  const SingleChildScrollView(child: ConnectWallet()),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 17.0, // Adjust the font size as needed
                  ),
                ),
                const SizedBox(
                    width:
                        8.0), // Adjust the width between the text and icon as needed
                IconButton(
                  onPressed: () => onTapSignIn(context),
                  icon: const Icon(
                    Icons.forward_outlined,
                    size: 60, // Increase the size as needed
                    color: Colors.green, // Change the color as needed
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // )

            // FutureBuilder<String>(
            //   future: nfo.isConnected(),
            //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       return Text(snapshot.data.toString());
            //     } else {
            //       return Text('Loading...');
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Column(
      children: [
        CustomIconButton(
          height: 72.adaptSize,
          width: 72.adaptSize,
          padding: EdgeInsets.all(20.h),
          decoration: IconButtonStyleHelper.fillPrimary,
          child: CustomImageView(imagePath: ImageConstant.imgClose),
        ),
        SizedBox(height: 16.v),
        Text("msg_welcome_to_blockbuy".tr, style: theme.textTheme.titleMedium),
        SizedBox(height: 10.v),
        Text("connect_wallet_to_continue".tr, style: theme.textTheme.bodySmall),
      ],
    );
  }

  /// Section Widget
  Widget _buildOrLine(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.v, bottom: 9.v),
          child: SizedBox(width: 130.h, child: Divider()),
        ),
        Text("CONNECT".tr, style: CustomTextStyles.titleSmallBluegray300_1),
        Padding(
          padding: EdgeInsets.only(top: 10.v, bottom: 9.v),
          child: SizedBox(width: 130.h, child: Divider()),
        ),
      ],
    );
  }

  onTapSignIn(BuildContext context) {
    getIt<WalletServices>().printInfo();
    if (getIt<WalletServices>().ge_w3mService().isConnected) {
      NavigatorService.pushNamed(
        AppRoutes.dashboardContainerScreen,
      );
    } else {
      // Show alert to connect wallet
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Connect Wallet',
              style: TextStyle(color: Colors.black), // Set custom text color
            ),
            content: const Text(
              'Please connect your wallet to proceed.',
              style: TextStyle(color: Colors.black87), // Set custom text color
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.blue), // Set custom text color
                ),
              ),
            ],
          );
        },
      );
    }
  }
}

class ConnectWallet extends StatefulWidget {
  const ConnectWallet({super.key});

  // const ConnectWallet({super.key});

  @override
  State<ConnectWallet> createState() => _ConnectWalletState();
}

class _ConnectWalletState extends State<ConnectWallet> {
  late W3MService _w3mService;
  int a = 3;
  @override
  void initState() {
    super.initState();
    registorLocators();
    _w3mService = getIt<WalletServices>().ge_w3mService();
    _w3mService.onSessionConnectEvent.subscribe(_onSessionConnect);
    _w3mService.onSessionDeleteEvent.subscribe(_onSessionDelete);
    _w3mService.onSessionUpdateEvent.subscribe(_onSessionUpdate);
    print("sdfgh $_w3mService.isConnected");
  }

  void _onSessionConnect(SessionConnect? args) {
    debugPrint(' _onSessionConnect $args');
    debugPrint("qsdfgrexcv");
    setState(() {});
  }

  void _onSessionDelete(SessionDelete? args) {
    debugPrint(' _onSessionDelete $args');
    setState(() {});
  }

  void _onSessionUpdate(SessionUpdate? args) {
    debugPrint('_onSessionUpdate $args');
    setState(() {});
  }

  Future<bool> _isConnected() async {
    await Future.delayed(const Duration(milliseconds: 10000));
    print("034==================================================");

    return await _w3mService.isConnected;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              W3MConnectWalletButton(service: _w3mService),
              const SizedBox(width: 16),
              W3MNetworkSelectButton(service: _w3mService),
            ],
          ),
          Column(
            children: [
              FutureBuilder<bool>(
                future: _isConnected(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final isConnected = snapshot.data ?? false;
                    if (isConnected) {
                      return Column(
                        children: [
                          W3MAccountButton(service: _w3mService),
                          const SizedBox(height: 16),
                          Table(
                            border: TableBorder.all(),
                            children: [
                              _buildTableRow(
                                  "status", _w3mService.status.toString()),
                              // _buildTableRow(
                              //     "session", _w3mService.session.toString()),
                              // _buildTableRow("selectedWallet",
                              //     _w3mService.selectedWallet.toString()),
                              // _buildTableRow("selectedChain", _w3mService.selectedChain.toString()),
                              _buildTableRow("isConnected",
                                  _w3mService.isConnected.toString()),
                              _buildTableRow("chainBalance",
                                  _w3mService.chainBalance.toString()),
                              _buildTableRow(
                                  "public address",
                                  _w3mService.session?.address?.toString() ??
                                      "N/A"),
                              _buildTableRow(
                                  "connectedWalletName",
                                  _w3mService.session?.connectedWalletName
                                          ?.toString() ??
                                      "N/A"),
                              _buildTableRow(
                                  "chainId",
                                  _w3mService.session?.chainId.toString() ??
                                      "N/A"),
                              // _buildTableRow(
                              //     "topic",
                              //     _w3mService.session?.topic?.toString() ??
                              //         "N/A"),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Container(); // Widget when connected
                    }
                  } else {
                    return CircularProgressIndicator(); // Loading indicator
                  }
                },
              ),
            ],
          ),
          ElevatedButton(
              onPressed: _onPressedSign, child: const Text("Personal Sign"))
        ],
      ),
    );
  }

  TableRow _buildTableRow(String column1, String column2) {
    return TableRow(
      children: [
        TableCell(
            child: Padding(
                padding: const EdgeInsets.all(8.0), child: Text(column1))),
        TableCell(
            child: Padding(
                padding: const EdgeInsets.all(8.0), child: Text(column2))),
      ],
    );
  }

  
  void _onPressedSign() async {

    await _w3mService.launchConnectedWallet();
    String sss = _w3mService.session?.address?.toString() ?? "N/A";

    // Set params outside the constant list
    List<dynamic> _params = [
      'this is a message from BlockBuy to see digital signature demo',
      sss
    ];
    print(_params);

    await _w3mService.web3App!.request(
      topic: _w3mService.session!.topic.toString(),
      chainId: 'eip155:11155111',
      request: SessionRequestParams(
        method: 'personal_sign',
        params: _params,
      ),
    );
    
  }


}
