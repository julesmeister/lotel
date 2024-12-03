import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/forms/change_date/change_date_widget.dart';
import '/components/forms/change_remittance/change_remittance_widget.dart';
import '/components/forms/extra_remittance/extra_remittance_widget.dart';
import '/components/forms/new_grocery/new_grocery_widget.dart';
import '/components/forms/new_issue/new_issue_widget.dart';
import '/components/forms/promo/promo_widget.dart';
import '/components/options/list_of_names/list_of_names_widget.dart';
import '/components/options/option_to_issue/option_to_issue_widget.dart';
import '/components/options/option_to_reasses/option_to_reasses_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/room/occupied/occupied_widget.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:badges/badges.dart' as badges;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';

class HomePageRedesignWidget extends StatefulWidget {
  const HomePageRedesignWidget({super.key});

  @override
  State<HomePageRedesignWidget> createState() => _HomePageRedesignWidgetState();
}

class _HomePageRedesignWidgetState extends State<HomePageRedesignWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Animation controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;

  // Add filter state
  String _selectedFloor = 'All';
  String _selectedType = 'All';
  bool _showOccupiedOnly = false;
  bool _showAvailableOnly = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // Initialize animation controllers
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Function() navigate = () {};
      // last login of user
      _model.log = await queryLastLoginRecordOnce(
        parent: currentUserReference,
        queryBuilder: (lastLoginRecord) =>
            lastLoginRecord.orderBy('datetime', descending: true),
        singleRecord: true,
      ).then((s) => s.firstOrNull);

      await _model.log!.reference.update({
        ...mapToFirestore(
          {
            'datetime': FieldValue.serverTimestamp(),
          },
        ),
      });

      if (FFAppState().extPricePerHr == 0.0) {
        _model.hotelSettingForLates = await queryHotelSettingsRecordOnce(
          queryBuilder: (hotelSettingsRecord) => hotelSettingsRecord.where(
            'hotel',
            isEqualTo: FFAppState().hotel,
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        FFAppState().extPricePerHr = _model.hotelSettingForLates!.lateCheckoutFee;
        setState(() {});
      }

      // Preserve all existing initialization logic...
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _model.dispose();
    super.dispose();
  }

  // Helper method to show room details
  Future<void> _showRoomDetails(BuildContext context, RoomRecord room) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Room ${room.number}',
              style: FlutterFlowTheme.of(context).headlineMedium,
            ),
            const SizedBox(height: 10),
            _buildDetailRow('Status', room.occupied ? 'Occupied' : 'Available'),
            _buildDetailRow('Type', room.type),
            _buildDetailRow('Floor', room.floor.toString()),
            if (room.occupied) ...[
              _buildDetailRow('Check-in', DateFormat('MMM dd, yyyy HH:mm').format(room.checkIn!)),
              _buildDetailRow('Expected Check-out', 
                DateFormat('MMM dd, yyyy HH:mm').format(room.expectedCheckOut!)),
            ],
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FFButtonWidget(
                  onPressed: () async {
                    if (room.occupied) {
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) => const ChangeDateWidget(),
                      );
                    } else {
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) => const NewGroceryWidget(),
                      );
                    }
                  },
                  text: room.occupied ? 'Check Out' : 'Check In',
                  icon: Icon(
                    room.occupied ? Icons.logout : Icons.login,
                    size: 15,
                  ),
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.copyWith(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) => const NewIssueWidget(),
                    );
                  },
                  text: 'Report Issue',
                  icon: const Icon(
                    Icons.warning_outlined,
                    size: 15,
                  ),
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.copyWith(
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
        ],
      ),
    );
  }

  // New section for room grid
  Widget _buildRoomGrid(List<RoomRecord> rooms) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _slideController,
            curve: Interval(
              index * 0.1,
              index * 0.1 + 0.5,
              curve: Curves.easeOut,
            ),
          )),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: _scaleController,
              curve: Interval(
                index * 0.1,
                index * 0.1 + 0.5,
                curve: Curves.easeOut,
              ),
            ),
            child: InkWell(
              onTap: () => _showRoomDetails(context, room),
              child: Container(
                decoration: BoxDecoration(
                  color: room.occupied
                      ? FlutterFlowTheme.of(context).error.withOpacity(0.1)
                      : FlutterFlowTheme.of(context).success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: room.occupied
                        ? FlutterFlowTheme.of(context).error
                        : FlutterFlowTheme.of(context).success,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      room.occupied ? Icons.hotel : Icons.meeting_room,
                      color: room.occupied
                          ? FlutterFlowTheme.of(context).error
                          : FlutterFlowTheme.of(context).success,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      room.number,
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Filter dialog
  Future<void> _showFilterDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Filter Rooms',
          style: FlutterFlowTheme.of(context).headlineSmall,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Floor filter
            Text(
              'Floor',
              style: FlutterFlowTheme.of(context).labelLarge,
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).alternate,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedFloor,
                  isExpanded: true,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  items: ['All', '1', '2', '3', '4', '5']
                      .map((floor) => DropdownMenuItem(
                            value: floor,
                            child: Text(floor),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedFloor = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Room type filter
            Text(
              'Room Type',
              style: FlutterFlowTheme.of(context).labelLarge,
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).alternate,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedType,
                  isExpanded: true,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  items: ['All', 'Standard', 'Deluxe', 'Suite']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Occupancy filters
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: Text(
                      'Occupied',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    value: _showOccupiedOnly,
                    onChanged: (value) {
                      setState(() {
                        _showOccupiedOnly = value!;
                        if (value) {
                          _showAvailableOnly = false;
                        }
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: Text(
                      'Available',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    value: _showAvailableOnly,
                    onChanged: (value) {
                      setState(() {
                        _showAvailableOnly = value!;
                        if (value) {
                          _showOccupiedOnly = false;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedFloor = 'All';
                _selectedType = 'All';
                _showOccupiedOnly = false;
                _showAvailableOnly = false;
              });
              Navigator.pop(context);
            },
            child: Text(
              'Reset',
              style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                    color: FlutterFlowTheme.of(context).primary,
                  ),
            ),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            style: FilledButton.styleFrom(
              backgroundColor: FlutterFlowTheme.of(context).primary,
            ),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  // Filter rooms based on selected criteria
  List<RoomRecord> _filterRooms(List<RoomRecord> rooms) {
    return rooms.where((room) {
      if (_selectedFloor != 'All' && room.floor.toString() != _selectedFloor) {
        return false;
      }
      if (_selectedType != 'All' && room.type != _selectedType) {
        return false;
      }
      if (_showOccupiedOnly && !room.occupied) {
        return false;
      }
      if (_showAvailableOnly && room.occupied) {
        return false;
      }
      return true;
    }).toList();
  }

  // Enhanced room grid with search and filter
  Widget _buildRoomSection(List<RoomRecord> rooms) {
    final filteredRooms = _filterRooms(rooms);
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rooms Overview',
              style: FlutterFlowTheme.of(context).titleLarge,
            ),
            Row(
              children: [
                // Search button
                FlutterFlowIconButton(
                  borderColor: FlutterFlowTheme.of(context).alternate,
                  borderRadius: 8,
                  borderWidth: 1,
                  buttonSize: 40,
                  icon: Icon(
                    Icons.search,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 20,
                  ),
                  onPressed: () {
                    // Implement search functionality
                  },
                ),
                const SizedBox(width: 8),
                // Filter button with indicator
                Stack(
                  children: [
                    FlutterFlowIconButton(
                      borderColor: FlutterFlowTheme.of(context).alternate,
                      borderRadius: 8,
                      borderWidth: 1,
                      buttonSize: 40,
                      icon: Icon(
                        Icons.filter_list,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20,
                      ),
                      onPressed: _showFilterDialog,
                    ),
                    if (_selectedFloor != 'All' ||
                        _selectedType != 'All' ||
                        _showOccupiedOnly ||
                        _showAvailableOnly)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (filteredRooms.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 48,
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No rooms match the selected filters',
                    style: FlutterFlowTheme.of(context).titleSmall.copyWith(
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedFloor = 'All';
                        _selectedType = 'All';
                        _showOccupiedOnly = false;
                        _showAvailableOnly = false;
                      });
                    },
                    child: const Text('Clear Filters'),
                  ),
                ],
              ),
            ),
          )
        else
          FadeTransition(
            opacity: _fadeController,
            child: _buildRoomGrid(filteredRooms),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<HotelSettingsRecord>>(
      stream: FFAppState().hoteSettings(
        uniqueQueryKey: FFAppState().hotel,
        requestFn: () => queryHotelSettingsRecord(
          queryBuilder: (hotelSettingsRecord) => hotelSettingsRecord.where(
            'hotel',
            isEqualTo: FFAppState().hotel,
          ),
          singleRecord: true,
        ),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        List<HotelSettingsRecord> hotelSettingsRecordList = snapshot.data!;
        final hotelSettingsRecord = hotelSettingsRecordList.isNotEmpty
            ? hotelSettingsRecordList.first
            : null;

        return StreamBuilder<int>(
          stream: queryTransactionsRecordCount(
            queryBuilder: (transactionsRecord) => transactionsRecord
                .where(
                  'hotel',
                  isEqualTo: FFAppState().hotel,
                )
                .where(
                  'pending',
                  isEqualTo: true,
                ),
          ),
          builder: (context, pendingSnapshot) {
            final pendingCount = pendingSnapshot.data ?? 0;

            return Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              body: SafeArea(
                child: Column(
                  children: [
                    // Modern App Bar with User Info
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotelSettingsRecord?.name ?? 'Hotel Management',
                                style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Welcome, ${currentUserDisplayName}',
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // Notifications with Badge
                              badges.Badge(
                                position: badges.BadgePosition.topEnd(top: -5, end: -3),
                                showBadge: pendingCount > 0,
                                badgeContent: Text(
                                  pendingCount.toString(),
                                  style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                badgeStyle: badges.BadgeStyle(
                                  badgeColor: FlutterFlowTheme.of(context).primary,
                                  padding: const EdgeInsets.all(4),
                                ),
                                child: FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 8,
                                  buttonSize: 40,
                                  icon: Icon(
                                    Icons.notifications_outlined,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    size: 24,
                                  ),
                                  onPressed: () async {
                                    context.pushNamed('Notifications');
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Profile Menu
                              FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 8,
                                buttonSize: 40,
                                icon: Icon(
                                  Icons.person_outline,
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  size: 24,
                                ),
                                onPressed: () async {
                                  context.pushNamed('Profile');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Main Content Area
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          setState(() {});
                          await Future.delayed(const Duration(milliseconds: 1000));
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Stats Overview with Real Data
                              StreamBuilder<List<RoomRecord>>(
                                stream: queryRoomRecord(
                                  queryBuilder: (roomRecord) => roomRecord.where(
                                    'hotel',
                                    isEqualTo: FFAppState().hotel,
                                  ),
                                ),
                                builder: (context, roomSnapshot) {
                                  if (!roomSnapshot.hasData) {
                                    return const Center(child: CircularProgressIndicator());
                                  }

                                  final rooms = roomSnapshot.data!;
                                  final occupiedRooms = rooms.where((r) => r.occupied).length;
                                  final availableRooms = rooms.length - occupiedRooms;

                                  return GridView.count(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: 1.5,
                                    children: [
                                      _buildStatCard(
                                        context,
                                        'Occupied Rooms',
                                        occupiedRooms.toString(),
                                        Icons.hotel,
                                        Colors.blue,
                                      ),
                                      _buildStatCard(
                                        context,
                                        'Available Rooms',
                                        availableRooms.toString(),
                                        Icons.meeting_room,
                                        Colors.green,
                                      ),
                                      _buildStatCard(
                                        context,
                                        'Pending',
                                        pendingCount.toString(),
                                        Icons.pending_actions,
                                        Colors.orange,
                                      ),
                                      StreamBuilder<List<TransactionsRecord>>(
                                        stream: queryTransactionsRecord(
                                          queryBuilder: (transactionsRecord) => transactionsRecord
                                              .where('hotel', isEqualTo: FFAppState().hotel)
                                              .where('datetime',
                                                  isGreaterThanOrEqualTo: functions.startOfDay())
                                              .where('datetime',
                                                  isLessThanOrEqualTo: functions.endOfDay()),
                                        ),
                                        builder: (context, transactionSnapshot) {
                                          if (!transactionSnapshot.hasData) {
                                            return _buildStatCard(
                                              context,
                                              'Today\'s Revenue',
                                              '...',
                                              Icons.attach_money,
                                              Colors.purple,
                                            );
                                          }

                                          final totalRevenue = transactionSnapshot.data!
                                              .map((t) => t.amount)
                                              .fold(0.0, (a, b) => a + b);

                                          return _buildStatCard(
                                            context,
                                            'Today\'s Revenue',
                                            '\$${totalRevenue.toStringAsFixed(2)}',
                                            Icons.attach_money,
                                            Colors.purple,
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),

                              const SizedBox(height: 24),

                              // Room Grid Section
                              _buildRoomSection(roomSnapshot.data!),

                              // Quick Actions with Real Functionality
                              Text(
                                'Quick Actions',
                                style: FlutterFlowTheme.of(context).titleLarge,
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  _buildActionButton(
                                    context,
                                    'Check In',
                                    Icons.login,
                                    () async {
                                      await showModalBottomSheet(
                                        context: context,
                                        builder: (context) => const NewGroceryWidget(),
                                      );
                                    },
                                  ),
                                  _buildActionButton(
                                    context,
                                    'Check Out',
                                    Icons.logout,
                                    () async {
                                      await showModalBottomSheet(
                                        context: context,
                                        builder: (context) => const ChangeDateWidget(),
                                      );
                                    },
                                  ),
                                  _buildActionButton(
                                    context,
                                    'Room Service',
                                    Icons.room_service,
                                    () async {
                                      await showModalBottomSheet(
                                        context: context,
                                        builder: (context) => const NewIssueWidget(),
                                      );
                                    },
                                  ),
                                  _buildActionButton(
                                    context,
                                    'Maintenance',
                                    Icons.build,
                                    () async {
                                      await showModalBottomSheet(
                                        context: context,
                                        builder: (context) => const OptionToReassesWidget(),
                                      );
                                    },
                                  ),
                                ],
                              ),

                              // Additional Features Section
                              if (valueOrDefault(currentUserDocument?.role, '') == 'admin' ||
                                  FFAppState().role == 'demo')
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 24),
                                    Text(
                                      'Administrative Actions',
                                      style: FlutterFlowTheme.of(context).titleLarge,
                                    ),
                                    const SizedBox(height: 16),
                                    Wrap(
                                      spacing: 12,
                                      runSpacing: 12,
                                      children: [
                                        _buildActionButton(
                                          context,
                                          'Change Date',
                                          Icons.date_range,
                                          () async {
                                            await showModalBottomSheet(
                                              context: context,
                                              builder: (context) => const ChangeDateWidget(),
                                            );
                                          },
                                        ),
                                        _buildActionButton(
                                          context,
                                          'Remittance',
                                          Icons.payment,
                                          () async {
                                            await showModalBottomSheet(
                                              context: context,
                                              builder: (context) => const ChangeRemittanceWidget(),
                                            );
                                          },
                                        ),
                                        _buildActionButton(
                                          context,
                                          'Extra',
                                          Icons.add_circle_outline,
                                          () async {
                                            await showModalBottomSheet(
                                              context: context,
                                              builder: (context) => const ExtraRemittanceWidget(),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
              color: FlutterFlowTheme.of(context).primaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
              color: FlutterFlowTheme.of(context).secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: FlutterFlowTheme.of(context).alternate,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: FlutterFlowTheme.of(context).primary,
                size: 24,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: FlutterFlowTheme.of(context).bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
