import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/request_manager.dart';

import 'mart_widget.dart' show MartWidget;
import 'package:flutter/material.dart';

class MartModel extends FlutterFlowModel<MartWidget> {
  ///  Local state fields for this page.

  List<GoodsRecord> cart = [];
  void addToCart(GoodsRecord item) => cart.add(item);
  void removeFromCart(GoodsRecord item) => cart.remove(item);
  void removeAtIndexFromCart(int index) => cart.removeAt(index);
  void insertAtIndexInCart(int index, GoodsRecord item) =>
      cart.insert(index, item);
  void updateCartAtIndex(int index, Function(GoodsRecord) updateFn) =>
      cart[index] = updateFn(cart[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for categories widget.
  FormFieldController<List<String>>? categoriesValueController;
  String? get categoriesValue => categoriesValueController?.value?.firstOrNull;
  set categoriesValue(String? val) =>
      categoriesValueController?.value = val != null ? [val] : [];

  /// Query cache managers for this widget.

  final _goodsOfHotelManager = StreamRequestManager<List<GoodsRecord>>();
  Stream<List<GoodsRecord>> goodsOfHotel({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<GoodsRecord>> Function() requestFn,
  }) =>
      _goodsOfHotelManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGoodsOfHotelCache() => _goodsOfHotelManager.clear();
  void clearGoodsOfHotelCacheKey(String? uniqueKey) =>
      _goodsOfHotelManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    /// Dispose query cache managers for this widget.

    clearGoodsOfHotelCache();
  }
}
