import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'add_edit_salary_model.dart';
export 'add_edit_salary_model.dart';

class AddEditSalaryWidget extends StatefulWidget {
  const AddEditSalaryWidget({
    super.key,
    required this.payrollRef,
    this.staffsForSelection,
    this.salaryDoc,
    this.staffDoc,
    bool? edit,
  }) : edit = edit ?? false;

  final DocumentReference? payrollRef;
  final List<StaffsRecord>? staffsForSelection;
  final SalariesRecord? salaryDoc;
  final StaffsRecord? staffDoc;
  final bool edit;

  @override
  State<AddEditSalaryWidget> createState() => _AddEditSalaryWidgetState();
}

class _AddEditSalaryWidgetState extends State<AddEditSalaryWidget> {
  late AddEditSalaryModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddEditSalaryModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.edit) {
        // set rate
        safeSetState(() {
          _model.rateTextController?.text = widget.salaryDoc!.rate.toString();
          _model.rateFocusNode?.requestFocus();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _model.rateTextController?.selection = TextSelection.collapsed(
              offset: _model.rateTextController!.text.length,
            );
          });
        });
        // set sss
        safeSetState(() {
          _model.sssTextController?.text = widget.salaryDoc!.sss.toString();
          _model.sssFocusNode?.requestFocus();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _model.sssTextController?.selection = TextSelection.collapsed(
              offset: _model.sssTextController!.text.length,
            );
          });
        });
        // set ca
        safeSetState(() {
          _model.caTextController?.text =
              widget.salaryDoc!.cashAdvance.toString();
          _model.caFocusNode?.requestFocus();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _model.caTextController?.selection = TextSelection.collapsed(
              offset: _model.caTextController!.text.length,
            );
          });
        });
        if (widget.salaryDoc?.absences != null) {
          // set absences
          safeSetState(() {
            _model.absencesTextController?.text =
                widget.salaryDoc!.absences.toString();
            _model.absencesFocusNode?.requestFocus();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _model.absencesTextController?.selection =
                  TextSelection.collapsed(
                offset: _model.absencesTextController!.text.length,
              );
            });
          });
        } else {
          // set to 0
          safeSetState(() {
            _model.absencesTextController?.text = '0';
            _model.absencesFocusNode?.requestFocus();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _model.absencesTextController?.selection =
                  TextSelection.collapsed(
                offset: _model.absencesTextController!.text.length,
              );
            });
          });
        }

        // absences
        _model.occuringAbsences = await queryAbsencesRecordOnce(
          parent: widget.staffDoc?.reference,
        );
        // add absences to list
        _model.absencesList =
            _model.occuringAbsences!.toList().cast<AbsencesRecord>();
        safeSetState(() {});
        // fill total
        _model.total = (double.parse(_model.rateTextController.text) -
            double.parse(_model.sssTextController.text) -
            double.parse(_model.caTextController.text) -
            double.parse(_model.absencesTextController.text));
        safeSetState(() {});
      } else {
        _model.staffs = await queryStaffsRecordOnce(
          queryBuilder: (staffsRecord) => staffsRecord.where(
            'hotel',
            isEqualTo: FFAppState().hotel,
          ),
        );
        _model.selectedStaff = widget.staffDoc;
        safeSetState(() {});
      }
    });

    _model.rateTextController ??= TextEditingController(
        text: _model.edit ? widget.salaryDoc?.rate.toString() : '0');
    _model.rateFocusNode ??= FocusNode();

    _model.sssTextController ??= TextEditingController(
        text: _model.edit ? widget.salaryDoc?.sss.toString() : '0');
    _model.sssFocusNode ??= FocusNode();

    _model.caTextController ??= TextEditingController(
        text: _model.edit ? widget.salaryDoc?.cashAdvance.toString() : '0');
    _model.caFocusNode ??= FocusNode();

    _model.absencesTextController ??= TextEditingController(
        text: _model.edit ? widget.salaryDoc?.absences.toString() : '0');
    _model.absencesFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(),
      child: Align(
        alignment: const AlignmentDirectional(0.0, 1.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: const AlignmentDirectional(1.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 16.0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 44.0,
                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                    icon: Icon(
                      Icons.close_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                elevation: 5.0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  widget.edit ? 'Edit Salary' : 'New Salary',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: 'Outfit',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                            if (!widget.edit)
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 16.0, 0.0),
                                  child: FlutterFlowDropDown<String>(
                                    controller:
                                        _model.dropDownValueController ??=
                                            FormFieldController<String>(null),
                                    options: widget.staffsForSelection!
                                        .map((e) => e.name)
                                        .toList(),
                                    onChanged: (val) async {
                                      safeSetState(
                                          () => _model.dropDownValue = val);
                                      var shouldSetState = false;
                                      if (!widget.edit) {
                                        // reset values and set staff
                                        _model.selectedStaff = widget
                                            .staffsForSelection
                                            ?.where((e) =>
                                                e.name == _model.dropDownValue)
                                            .toList()
                                            .first;
                                        _model.cashAdvanceTotal = 0.0;
                                        _model.loopAdvancesCounter = 0;
                                        _model.cashAdvancesList = [];
                                        safeSetState(() {});
                                        // set sss
                                        safeSetState(() {
                                          _model.sssTextController?.text =
                                              widget.staffsForSelection!
                                                  .where((e) =>
                                                      e.name ==
                                                      _model.dropDownValue)
                                                  .toList()
                                                  .first
                                                  .sssRate
                                                  .toString();
                                          _model.sssFocusNode?.requestFocus();
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            _model.sssTextController
                                                    ?.selection =
                                                TextSelection.collapsed(
                                              offset: _model.sssTextController!
                                                  .text.length,
                                            );
                                          });
                                        });
                                        // set rate
                                        safeSetState(() {
                                          _model.rateTextController?.text =
                                              widget.staffsForSelection!
                                                  .where((e) =>
                                                      e.name ==
                                                      _model.dropDownValue)
                                                  .toList()
                                                  .first
                                                  .weeklyRate
                                                  .toString();
                                          _model.rateFocusNode?.requestFocus();
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            _model.rateTextController
                                                    ?.selection =
                                                TextSelection.collapsed(
                                              offset: _model.rateTextController!
                                                  .text.length,
                                            );
                                          });
                                        });
                                        // advances
                                        _model.cashAdvances =
                                            await queryAdvancesRecordOnce(
                                          parent:
                                              _model.selectedStaff?.reference,
                                          queryBuilder: (advancesRecord) =>
                                              advancesRecord.where(
                                            'settled',
                                            isEqualTo: false,
                                          ),
                                        );
                                        shouldSetState = true;
                                        if (_model.cashAdvances!.isNotEmpty) {
                                          while (_model.loopAdvancesCounter !=
                                              _model.cashAdvances?.length) {
                                            // add ca to list
                                            _model.cashAdvanceTotal = _model
                                                    .cashAdvanceTotal +
                                                _model
                                                    .cashAdvances![_model
                                                        .loopAdvancesCounter]
                                                    .amount;
                                            _model.addToCashAdvancesList(_model
                                                    .cashAdvances![
                                                _model.loopAdvancesCounter]);
                                            safeSetState(() {});
                                            // increment loop
                                            _model.loopAdvancesCounter =
                                                _model.loopAdvancesCounter + 1;
                                            safeSetState(() {});
                                          }
                                          // set CAs
                                          safeSetState(() {
                                            _model.caTextController?.text =
                                                _model.cashAdvanceTotal
                                                    .toString();
                                            _model.caFocusNode?.requestFocus();
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              _model.caTextController
                                                      ?.selection =
                                                  TextSelection.collapsed(
                                                offset: _model.caTextController!
                                                    .text.length,
                                              );
                                            });
                                          });
                                        } else {
                                          if (shouldSetState) {
                                            safeSetState(() {});
                                          }
                                          return;
                                        }

                                        // absences
                                        _model.absences =
                                            await queryAbsencesRecordOnce(
                                          parent:
                                              _model.selectedStaff?.reference,
                                          queryBuilder: (absencesRecord) =>
                                              absencesRecord.where(
                                            'settled',
                                            isEqualTo: false,
                                          ),
                                        );
                                        shouldSetState = true;
                                        if (_model.absences!.isNotEmpty) {
                                          while (_model.loopAdvancesCounter !=
                                              _model.absences?.length) {
                                            // add absences to list
                                            _model.absencesTotal = _model
                                                    .absencesTotal +
                                                _model
                                                    .absences![_model
                                                        .loopAbsencesCounter]
                                                    .amount;
                                            _model.addToAbsencesList(_model
                                                    .absences![
                                                _model.loopAbsencesCounter]);
                                            safeSetState(() {});
                                            // increment loop
                                            _model.loopAbsencesCounter =
                                                _model.loopAbsencesCounter + 1;
                                            safeSetState(() {});
                                          }
                                          // set absences in form
                                          safeSetState(() {
                                            _model.absencesTextController
                                                    ?.text =
                                                _model.absencesTotal.toString();
                                            _model.absencesFocusNode
                                                ?.requestFocus();
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              _model.absencesTextController
                                                      ?.selection =
                                                  TextSelection.collapsed(
                                                offset: _model
                                                    .absencesTextController!
                                                    .text
                                                    .length,
                                              );
                                            });
                                          });
                                        }
                                      }
                                      if (shouldSetState) safeSetState(() {});
                                    },
                                    width: 160.0,
                                    height: 40.0,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'Select Name',
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 15.0,
                                    ),
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    elevation: 2.0,
                                    borderColor: const Color(0xFFE0E3E7),
                                    borderWidth: 2.0,
                                    borderRadius: 8.0,
                                    margin: const EdgeInsetsDirectional.fromSTEB(
                                        12.0, 4.0, 12.0, 4.0),
                                    hidesUnderline: true,
                                    isSearchable: false,
                                    isMultiSelect: false,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 4.0,
                        thickness: 1.0,
                        color: Color(0xFFE0E3E7),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextFormField(
                              controller: _model.rateTextController,
                              focusNode: _model.rateFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.rateTextController',
                                const Duration(milliseconds: 2000),
                                () async {
                                  _model.total = (double.parse(
                                          _model.rateTextController.text) -
                                      double.parse(
                                          _model.sssTextController.text) -
                                      double.parse(
                                          _model.caTextController.text) -
                                      double.parse(
                                          _model.absencesTextController.text));
                                  safeSetState(() {});
                                },
                              ),
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: false,
                                labelText: 'Fortnight Rate',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Fortnight Rate',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 28.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 24.0, 20.0, 24.0),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 28.0,
                                    letterSpacing: 0.0,
                                  ),
                              minLines: 1,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              validator: _model.rateTextControllerValidator
                                  .asValidator(context),
                            ),
                            const Divider(
                              height: 4.0,
                              thickness: 1.0,
                              color: Color(0xFFE0E3E7),
                            ),
                            TextFormField(
                              controller: _model.sssTextController,
                              focusNode: _model.sssFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.sssTextController',
                                const Duration(milliseconds: 2000),
                                () async {
                                  _model.total = (double.parse(
                                          _model.rateTextController.text) -
                                      double.parse(
                                          _model.sssTextController.text) -
                                      double.parse(
                                          _model.caTextController.text) -
                                      double.parse(
                                          _model.absencesTextController.text));
                                  safeSetState(() {});
                                },
                              ),
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'SSS',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'SSS',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 28.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 24.0, 20.0, 24.0),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 28.0,
                                    letterSpacing: 0.0,
                                  ),
                              minLines: 1,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              validator: _model.sssTextControllerValidator
                                  .asValidator(context),
                            ),
                            const Divider(
                              height: 4.0,
                              thickness: 1.0,
                              color: Color(0xFFE0E3E7),
                            ),
                            TextFormField(
                              controller: _model.caTextController,
                              focusNode: _model.caFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.caTextController',
                                const Duration(milliseconds: 2000),
                                () async {
                                  _model.total = (double.parse(
                                          _model.rateTextController.text) -
                                      double.parse(
                                          _model.sssTextController.text) -
                                      double.parse(
                                          _model.caTextController.text) -
                                      double.parse(
                                          _model.absencesTextController.text));
                                  safeSetState(() {});
                                },
                              ),
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Cash Advance',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Cash Advance',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 28.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 24.0, 20.0, 24.0),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 28.0,
                                    letterSpacing: 0.0,
                                  ),
                              minLines: 1,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              validator: _model.caTextControllerValidator
                                  .asValidator(context),
                            ),
                            const Divider(
                              height: 4.0,
                              thickness: 1.0,
                              color: Color(0xFFE0E3E7),
                            ),
                            TextFormField(
                              controller: _model.absencesTextController,
                              focusNode: _model.absencesFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.absencesTextController',
                                const Duration(milliseconds: 2000),
                                () async {
                                  _model.total = (double.parse(
                                          _model.rateTextController.text) -
                                      double.parse(
                                          _model.sssTextController.text) -
                                      double.parse(
                                          _model.caTextController.text) -
                                      double.parse(
                                          _model.absencesTextController.text));
                                  safeSetState(() {});
                                },
                              ),
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Absences',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Absences',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 28.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 24.0, 20.0, 24.0),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 28.0,
                                    letterSpacing: 0.0,
                                  ),
                              minLines: 1,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              validator: _model.absencesTextControllerValidator
                                  .asValidator(context),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 4.0,
                        thickness: 1.0,
                        color: Color(0xFFE0E3E7),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            8.0, 4.0, 16.0, 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Total: ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    TextSpan(
                                      text: formatNumber(
                                        _model.total,
                                        formatType: FormatType.decimal,
                                        decimalType: DecimalType.automatic,
                                        currency: 'Php ',
                                      ),
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                            Container(
                              width: 150.0,
                              height: 44.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Visibility(
                                visible: (_model.selectedStaff != null) ||
                                    widget.edit,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (FFAppState().role != 'demo') {
                                      if (widget.edit) {
                                        // update values from form

                                        await widget.salaryDoc!.reference
                                            .update({
                                          ...createSalariesRecordData(
                                            sss: double.tryParse(
                                                _model.sssTextController.text),
                                            cashAdvance: double.tryParse(
                                                _model.caTextController.text),
                                            total: (double.parse(_model
                                                    .rateTextController.text) -
                                                double.parse(_model
                                                    .sssTextController.text) -
                                                double.parse(_model
                                                    .caTextController.text) -
                                                double.parse(_model
                                                    .absencesTextController
                                                    .text)),
                                            rate: double.tryParse(
                                                _model.rateTextController.text),
                                            absences: double.tryParse(_model
                                                .absencesTextController.text),
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'absencesRefs': _model
                                                  .absencesList
                                                  .map((e) => e.reference)
                                                  .toList(),
                                            },
                                          ),
                                        });
                                        // read updated salary
                                        _model.updatedSalary =
                                            await SalariesRecord
                                                .getDocumentOnce(widget
                                                    .salaryDoc!.reference);
                                        // return salary
                                        Navigator.pop(
                                            context, _model.updatedSalary);
                                      } else {
                                        // create salary

                                        var salariesRecordReference2 =
                                            SalariesRecord.createDoc(
                                                widget.payrollRef!);
                                        await salariesRecordReference2.set({
                                          ...createSalariesRecordData(
                                            sss: double.parse(
                                                _model.sssTextController.text),
                                            cashAdvance: double.parse(
                                                _model.caTextController.text),
                                            total: (double.parse(_model
                                                    .rateTextController.text) -
                                                double.parse(_model
                                                    .sssTextController.text) -
                                                double.parse(_model
                                                    .caTextController.text) -
                                                double.parse(_model
                                                    .absencesTextController
                                                    .text)),
                                            staff:
                                                _model.selectedStaff?.reference,
                                            rate: double.parse(
                                                _model.rateTextController.text),
                                            absences: double.parse(_model
                                                .absencesTextController.text),
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'date':
                                                  FieldValue.serverTimestamp(),
                                              'caRefs': _model.cashAdvancesList
                                                  .map((e) => e.reference)
                                                  .toList(),
                                              'absencesRefs': _model
                                                  .absencesList
                                                  .map((e) => e.reference)
                                                  .toList(),
                                            },
                                          ),
                                        });
                                        _model.newSalary =
                                            SalariesRecord.getDocumentFromData({
                                          ...createSalariesRecordData(
                                            sss: double.parse(
                                                _model.sssTextController.text),
                                            cashAdvance: double.parse(
                                                _model.caTextController.text),
                                            total: (double.parse(_model
                                                    .rateTextController.text) -
                                                double.parse(_model
                                                    .sssTextController.text) -
                                                double.parse(_model
                                                    .caTextController.text) -
                                                double.parse(_model
                                                    .absencesTextController
                                                    .text)),
                                            staff:
                                                _model.selectedStaff?.reference,
                                            rate: double.parse(
                                                _model.rateTextController.text),
                                            absences: double.parse(_model
                                                .absencesTextController.text),
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'date': DateTime.now(),
                                              'caRefs': _model.cashAdvancesList
                                                  .map((e) => e.reference)
                                                  .toList(),
                                              'absencesRefs': _model
                                                  .absencesList
                                                  .map((e) => e.reference)
                                                  .toList(),
                                            },
                                          ),
                                        }, salariesRecordReference2);
                                        // return salary
                                        Navigator.pop(
                                            context, _model.newSalary);
                                      }
                                    } else {
                                      // inaccessible
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Inaccessible To Test User',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                          ),
                                          duration:
                                              const Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                        ),
                                      );
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Saved!',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: const Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );

                                    safeSetState(() {});
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 12.0, 0.0),
                                        child: Text(
                                          'Save',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.send_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 28.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
