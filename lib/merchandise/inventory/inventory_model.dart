import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/item_add_edit/item_add_edit_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/request_manager.dart';

import 'inventory_widget.dart' show InventoryWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InventoryModel extends FlutterFlowModel<InventoryWidget> {
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

  // State field(s) for categories widget.
  FormFieldController<List<String>>? categoriesValueController;
  String? get categoriesValue => categoriesValueController?.value?.firstOrNull;
  set categoriesValue(String? val) =>
      categoriesValueController?.value = val != null ? [val] : [];

  /// Query cache managers for this widget.

  final _inventoryGoodsManager = FutureRequestManager<List<GoodsRecord>>();
  Future<List<GoodsRecord>> inventoryGoods({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<GoodsRecord>> Function() requestFn,
  }) =>
      _inventoryGoodsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearInventoryGoodsCache() => _inventoryGoodsManager.clear();
  void clearInventoryGoodsCacheKey(String? uniqueKey) =>
      _inventoryGoodsManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    /// Dispose query cache managers for this widget.

    clearInventoryGoodsCache();
  }
}
