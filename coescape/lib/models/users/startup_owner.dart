import 'package:ascent/models/user.dart';

class StartupOwner extends AppUser {
  final bool hasInvestor;
  final String? financeStrategy;
  final String marketingStrategyAndBMC;
  StartupOwner({
    required super.uid,
    required super.username,
    required super.email,
    required super.photoURL,
    required super.domain,
    required super.googleId,
    required super.token,
    required this.hasInvestor,
    required this.financeStrategy,
    required this.marketingStrategyAndBMC,
  });
}
