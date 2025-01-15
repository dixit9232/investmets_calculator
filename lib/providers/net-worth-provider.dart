import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final netWorthProvider = StateNotifierProvider<NetWorthNotifier, NetWorthModel>((ref) {
  return NetWorthNotifier();
});

class NetWorthNotifier extends StateNotifier<NetWorthModel> {
  NetWorthNotifier() : super(NetWorthModel());

  void calculateNetWorth({required String totalAssets, required String totalLiabilities}) {
    double assets = double.parse(totalAssets);
    double liabilities = double.parse(totalLiabilities);

    NumberFormat numberFormat = NumberFormat("#,##,###");
    double netWorth = assets - liabilities;
    String formattedAssets = numberFormat.format(assets.roundToDouble().toInt());
    String formattedLiabilities = numberFormat.format(liabilities.roundToDouble().toInt());
    String formattedNetWorth = numberFormat.format(netWorth.roundToDouble().toInt());

    state = NetWorthModel(totalAssets: formattedAssets, totalLiabilities: formattedLiabilities, netWorth: formattedNetWorth);
  }
}

class NetWorthModel {
  final String totalAssets;
  final String totalLiabilities;
  final String netWorth;

  NetWorthModel({
    this.totalAssets = "",
    this.totalLiabilities = "",
    this.netWorth = "",
  });

  NetWorthModel copyWith({
    String? totalAssets,
    String? totalLiabilities,
    String? netWorth,
  }) {
    return NetWorthModel(netWorth: netWorth ?? this.netWorth, totalAssets: totalAssets ?? this.totalAssets, totalLiabilities: totalLiabilities ?? this.totalLiabilities);
  }
}
