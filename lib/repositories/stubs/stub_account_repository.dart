import 'package:pispapp/models/account.dart';
import 'package:pispapp/models/fsp.dart';
import 'package:pispapp/models/party.dart';
import 'package:pispapp/repositories/interfaces/i_account_repository.dart';

final List<Account> accounts = <Account>[
  Account(
    alias: 'Personal',
    partyInfo: PartyIdInfo(
      fspId: 'DJCICFQ1919',
      partyIdentifier: 'IN1233323987',
    ),
    fspInfo: Fsp(id: 'DJCICFQ1919', name: 'Bank of India'),
    consentId: '555',
    userId: 'vXiSsQglsFYXqVkOHNKKFhnuAAI2',
    sourceAccountId: 'bob.fspA',
  ),
  Account(
    alias: 'Business',
    partyInfo: PartyIdInfo(
      fspId: 'AJCICFQ1919',
      partyIdentifier: 'IN1233323987',
    ),
    fspInfo: Fsp(id: 'AJCICFQ1919', name: 'Axis Bank'),
    consentId: '985',
    userId: 'vXiSsQglsFYXqVkOHNKKFhnuAAI2',
    sourceAccountId: 'bob.fspB',
  ),
];

class StubAccountRepository implements IAccountRepository {
  @override
  Future<List<Account>> getUserAccounts(String userId) {
    return Future.value(accounts);
  }
}
