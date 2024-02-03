import 'bloc/login_bloc.dart';
import 'models/login_model.dart';
import 'package:aniket_s_application1/core/app_export.dart';
import 'package:aniket_s_application1/core/utils/validation_functions.dart';
import 'package:aniket_s_application1/widgets/custom_elevated_button.dart';
import 'package:aniket_s_application1/widgets/custom_icon_button.dart';
import 'package:aniket_s_application1/widgets/custom_outlined_button.dart';
import 'package:aniket_s_application1/widgets/custom_text_form_field.dart';
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
    NetworkInfo nfo = NetworkInfo();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity, // Full width
        height: double.infinity, // Full height
        padding: EdgeInsets.only(left: 16.h, top: 68.v, right: 16.h),
        child: Column(
          children: [
            _buildPageHeader(context),
            _buildOrLine(context),
            SizedBox(height: 16.v),
            SizedBox(height: 16.v),
            ConnectWallet(),
            ElevatedButton(
                onPressed: () => onTapSignIn(context), child: Text("hi")),
            FutureBuilder<String>(
              future: nfo.isConnected(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // The Future is complete.
                  return Text(snapshot.data.toString());
                } else {
                  // The Future is still running.
                  return Text('Loading...');
                }
              },
            )
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
    debugPrint('CONNECTEDaaabc abc [$runtimeType] _onSessionEvent');
    NavigatorService.pushNamed(
      AppRoutes.dashboardContainerScreen,
    );
  }
}

class ConnectWallet extends StatefulWidget {
  // const ConnectWallet({super.key});

  @override
  State<ConnectWallet> createState() => _ConnectWalletState();
}

class _ConnectWalletState extends State<ConnectWallet> {
  late W3MService _w3mService;

  onTapSignIn(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.dashboardContainerScreen,
    );
  }

  // Event handler for session events
  void _onSessionEvent(SessionEvent? args) {
    debugPrint('CONNECTED abc abc [$runtimeType] _onSessionEvent $args');
    onTapSignIn(context);
  }

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  void initializeState() async {
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
    _w3mService.onSessionEventEvent.subscribe(_onSessionEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        W3MConnectWalletButton(service: _w3mService),
        const SizedBox(height: 16),
        W3MNetworkSelectButton(service: _w3mService),
        const SizedBox(height: 16),
        W3MAccountButton(service: _w3mService),
      ],
    );
  }
}
