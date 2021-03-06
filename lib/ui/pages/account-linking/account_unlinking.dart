import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/account-linking/account_unlinking_controller.dart';
import 'package:pispapp/models/consent.dart';
import 'package:pispapp/models/currency.dart';
import 'package:pispapp/repositories/firebase/consent_repository.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class AccountUnlinking extends StatelessWidget {
  final AccountUnlinkingController _accountUnlinkingController =
      AccountUnlinkingController(Get.find<ConsentRepository>());

  // For when there are no accounts associated with the opaque id
  Widget _buildEmptyDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(Icons.warning, size: 80, color: LightColor.lightNavyBlue),
          TitleText(
            'Oops...there are no accounts associated with your ID!',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSpinner() {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(LightColor.lightNavyBlue),
    );
  }

  Widget _buildListItem(Account acc) {
    final String accId = acc?.id ?? 'Unknown Account';
    final String currencyStr =
        acc?.currency?.toJsonString() ?? 'Unknown Currency';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ShadowBox(
        color: LightColor.navyBlue1,
        child: ListTile(
          leading: const Icon(Icons.account_circle,
              size: 50, color: LightColor.navyBlue1),
          trailing: Obx(() =>
              _accountUnlinkingController.isAwaitingUpdate.value &&
                      _accountUnlinkingController.selectedAccountId == accId
                  ? Container(child: _buildSpinner(), height: 25, width: 25)
                  : const Icon(Icons.remove_circle_outline,
                      color: Colors.red, size: 25)),
          title: Text(accId),
          subtitle: Text(currencyStr),
          onTap: () => _onTap(accId),
        ),
      ),
    );
  }

  // Handles onTap for an account
  Future<void> _onTap(String accId) async {
    // If there is another account was selected for unlinking
    // (and still in the process of unlinking), do not initiate
    // another unlinking
    if (_accountUnlinkingController.selectedAccountId != null) {
      return;
    }

    final Consent toRevoke =
        _accountUnlinkingController.findConsentToRevoke(accId);

    // Used to keep track of whether or not the user wishes to continue with
    // the consent revocation
    bool userConfirmed = false;

    // Display dialog for confirmation
    await Get.defaultDialog<dynamic>(
      title: 'Remove Account?',
      confirmTextColor: Colors.white,
      cancelTextColor: LightColor.navyBlue1,
      textCancel: 'No',
      textConfirm: 'Yes',
      content: Padding(
        child: _buildDialogContent(toRevoke),
        padding: const EdgeInsets.all(10),
      ),
      onConfirm: () {
        userConfirmed = true;
        _accountUnlinkingController.selectedAccountId = accId;
        _accountUnlinkingController.initiateRevocation(toRevoke);
        Get.back();
      },
    );

    // When dialog closes and it is not because user confirmed,
    // selected account id should be set to null
    if (!userConfirmed) {
      _accountUnlinkingController.selectedAccountId = null;
    }
  }

  Widget _buildDialogContent(Consent toRevoke) {
    // If the consent is associated with multiple accounts
    // inform the user that other accounts will be deleted
    // along with this one.
    // Since we revoke the consent, we revoke the consent for all the accounts.
    Widget content =
        const Text('Are you sure you wish to unlink this account?');
    if (toRevoke.accounts.length > 1) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          content,
          const SizedBox(height: 10),
          const Text(
              'Please note that the following accounts will be removed:'),
          const SizedBox(height: 10),
          // Add list of accounts that will be removed
          ...toRevoke.accounts
              .map((acc) => Text('• ${acc.id}', textAlign: TextAlign.left)),
        ],
      );
    }
    return content;
  }

  // Shown when an account is being removed
  Widget _buildBlurOverlay() {
    const double _sigmaX = 0.2;
    const double _sigmaY = 0.2;
    const double _opacity = 0.5;

    return Container(
      width: Get.width,
      height: Get.height,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
        child: Container(
          color: Colors.black.withOpacity(_opacity),
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Text('Please tap on the account you would like to remove:',
          textAlign: TextAlign.left),
    );
  }

  Widget _buildList() {
    return Obx(() {
      final List<Account> associatedAccounts =
          _accountUnlinkingController.accounts;
      if (associatedAccounts.isEmpty) {
        return _buildEmptyDisplay();
      }

      final int listLength = associatedAccounts.length + 1;
      return ListView.builder(
        itemCount: listLength,
        itemBuilder: (BuildContext ctxt, int index) {
          // Top shows a description
          if (index == 0) {
            return _buildInstructions();
          } else {
            return _buildListItem(associatedAccounts[index - 1]);
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remove Account'),
      ),
      body: Obx(() {
        final Widget expandedList = SizedBox.expand(
          child: _buildList(),
        );
        if (_accountUnlinkingController.isAwaitingUpdate.value) {
          // Have an overlay on top of the list when revocation is in progress
          return Stack(children: [
            expandedList,
            _buildBlurOverlay(),
          ]);
        } else {
          return expandedList;
        }
      }),
    );
  }
}
