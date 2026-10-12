import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxury_wheel_client/luxury_wheel_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import '../utils/booking_dates.dart';
import '../widgets/booking_qr_code.dart';
import 'management_export.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  static const _ink = Color(0xFF181916);
  static const _paper = Color(0xFFF7F6F1);
  static const _brass = Color(0xFFB79A62);
  static const _muted = Color(0xFF77786F);
  static const _sections = [
    ('Overview', Icons.space_dashboard_outlined),
    ('Branches', Icons.location_city_outlined),
    ('Cars', Icons.directions_car_outlined),
    ('Companies', Icons.business_outlined),
    ('Bookings', Icons.event_note_outlined),
    ('Offers', Icons.local_offer_outlined),
    ('Users', Icons.people_outline),
    ('Backups', Icons.archive_outlined),
    ('Feedback', Icons.rate_review_outlined),
  ];

  int _selectedSection = 0;
  bool _loading = false;
  bool _isAdmin = false;
  Timer? _dashboardRefreshTimer;
  String? _loadError;
  List<RentalCompany> _companies = [];
  List<Branch> _branches = [];
  List<ManagedCar> _cars = [];
  List<CarImage> _images = [];
  List<AdminUser> _users = [];
  List<CompanyMember> _members = [];
  List<ManagedOffer> _offers = [];
  List<RentalReservation> _reservations = [];
  List<RentalSurvey> _surveyFeedback = [];
  String? _accessMessage;
  StreamSubscription<MarketplaceUpdate>? _marketplaceSubscription;

  bool get _isReadOnlyCompanyUser =>
      !_isAdmin &&
      _members.isNotEmpty &&
      _members.every((member) => member.role == 'viewer');

  bool get _canManageCompany => !_isReadOnlyCompanyUser;

  bool _canManageCompanyId(int companyId) =>
      _isAdmin ||
      _members.any(
        (member) => member.companyId == companyId && member.role != 'viewer',
      );

  bool _canAdministerCompanyId(int companyId) =>
      _isAdmin ||
      _members.any(
        (member) =>
            member.companyId == companyId && member.role == 'company_admin',
      );

  List<int> get _visibleSectionIndexes => [
    for (var index = 0; index < _sections.length; index++)
      if (index == 8
          ? _isAdmin
          : _isAdmin
          ? true
          : _isReadOnlyCompanyUser
          ? index <= 4
          : (index != 6 && index != 7))
        index,
  ];

  @override
  void initState() {
    super.initState();
    if (client.auth.isAuthenticated) {
      _watchMarketplaceUpdates();
      _dashboardRefreshTimer = Timer.periodic(
        const Duration(seconds: 30),
        (_) {
          if (!mounted || _loading) return;
          if (_marketplaceSubscription == null) _watchMarketplaceUpdates();
          _loadData();
        },
      );
      _prepareAdminAccess();
    }
  }

  @override
  void dispose() {
    _marketplaceSubscription?.cancel();
    _dashboardRefreshTimer?.cancel();
    super.dispose();
  }

  void _watchMarketplaceUpdates() {
    _marketplaceSubscription ??= client.rental.watchMarketplaceChanges().listen(
      (_) {
        if (mounted && !_loading) _loadData();
      },
      onError: (Object error, StackTrace stackTrace) {
        debugPrint('Admin dashboard live updates disconnected: $error');
        _marketplaceSubscription = null;
      },
      onDone: () => _marketplaceSubscription = null,
    );
  }

  Future<void> _prepareAdminAccess() async {
    try {
      final result = await client.adminBootstrap.claimFirstAdmin();
      if (!mounted) return;
      if (result == 'granted') {
        setState(() {
          _accessMessage =
              'First administrator access has been granted to this account. '
              'Sign out and sign in again to activate it.';
          _loadError = 'Administrator access needs a fresh sign-in.';
        });
        return;
      }
      if (result == 'notEligible') {
        final isAdmin = await client.admin.isAdministrator();
        final hasCompanyAccess = await client.admin.hasCompanyAccess();
        if (!mounted) return;
        if (isAdmin || hasCompanyAccess) {
          _isAdmin = isAdmin;
          await _loadData();
        } else {
          setState(() {
            _accessMessage = 'Sign in with an authorized account to continue.';
            _loadError = 'Administrator or company access required.';
          });
        }
        return;
      }
      _isAdmin = await client.admin.isAdministrator();
      await _loadData();
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _loadError = error.toString();
        _accessMessage = null;
      });
    }
  }

  Future<void> _loadData() async {
    if (!client.auth.isAuthenticated) return;
    setState(() {
      _loading = true;
      _loadError = null;
    });
    try {
      final companies = await client.admin.listCompanies();
      final branches = await client.admin.listBranches();
      final cars = await client.admin.listCars();
      final images = await client.admin.listCarImages();
      final offers = await client.admin.listOffers();
      final reservations = await client.admin.listReservations();
      final users = _isAdmin ? await client.admin.listUsers() : <AdminUser>[];
      final surveyFeedback = _isAdmin
          ? await client.admin.listSurveyFeedback()
          : <RentalSurvey>[];
      final memberGroups = await Future.wait(
        companies.map(
          (company) => client.admin.listCompanyMembers(company.id!),
        ),
      );
      final members = memberGroups.expand((group) => group).toList();
      if (!mounted) return;
      setState(() {
        _companies = companies;
        _branches = branches;
        _cars = cars;
        _images = images;
        _offers = offers;
        _reservations = reservations;
        _surveyFeedback = surveyFeedback;
        _users = users;
        _members = members;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _loadError = error.toString();
      });
    }
  }

  Future<void> _run(Future<void> Function() action) async {
    try {
      await action();
      if (mounted) await _loadData();
    } catch (error) {
      _showMessage(error.toString());
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    if (!client.auth.isAuthenticated) return _buildSignIn();
    if (_loadError != null) return _buildAccessError();
    if (_loading && _companies.isEmpty && _branches.isEmpty && _cars.isEmpty) {
      return const Scaffold(
        backgroundColor: _paper,
        body: Center(child: CircularProgressIndicator(color: _brass)),
      );
    }

    return Scaffold(
      backgroundColor: _paper,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 900;
            return Row(
              children: [
                if (wide) _buildSidebar(),
                Expanded(
                  child: Column(
                    children: [
                      _buildTopBar(wide),
                      if (!wide) _buildCompactNavigation(),
                      Expanded(
                        child: Stack(
                          children: [
                            _buildSection(),
                            if (_loading)
                              const LinearProgressIndicator(
                                minHeight: 2,
                                color: _brass,
                                backgroundColor: Colors.transparent,
                              ),
                            if (_accessMessage != null) ...[
                              const SizedBox(height: 10),
                              Text(
                                _accessMessage!,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.manrope(
                                  color: _ink,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSignIn() {
    return Scaffold(
      backgroundColor: _paper,
      appBar: AppBar(
        backgroundColor: _paper,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _brandMark(),
                const SizedBox(height: 26),
                Text(
                  'Admin sign in',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 38,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Sign in with an account that has the Serverpod admin scope. '
                  'The configured first administrator can claim access after signing in.',
                  style: TextStyle(color: _muted, height: 1.5),
                ),
                const SizedBox(height: 24),
                SignInWidget(
                  client: client,
                  onAuthenticated: _prepareAdminAccess,
                  onError: (error) => _showMessage('Sign in failed: $error'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccessError() {
    return Scaffold(
      backgroundColor: _paper,
      appBar: AppBar(
        backgroundColor: _paper,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Admin workspace'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline, color: _brass, size: 42),
                const SizedBox(height: 14),
                Text(
                  'Administrator access required',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'This account needs the Serverpod admin scope. '
                  'Ask your system administrator to grant access.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _muted, height: 1.5),
                ),
                const SizedBox(height: 8),
                Text(
                  _loadError ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: _muted, fontSize: 11),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _loadData,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try again'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await client.auth.signOutAllDevices();
                        if (mounted) setState(() => _loadError = null);
                      },
                      child: const Text('Sign out'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: _ink,
      padding: const EdgeInsets.fromLTRB(18, 24, 14, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _brandMark(dark: true),
          const SizedBox(height: 44),
          for (final index in _visibleSectionIndexes)
            _sectionNavigation(index, expanded: true),
          const Spacer(),
          const Divider(color: Colors.white24),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: const Icon(Icons.logout, color: Colors.white70, size: 19),
            title: Text(
              'Sign out',
              style: GoogleFonts.manrope(color: Colors.white70, fontSize: 12),
            ),
            onTap: () async {
              await client.auth.signOutAllDevices();
              if (mounted) Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(bool wide) {
    return Padding(
      padding: EdgeInsets.fromLTRB(wide ? 34 : 20, 21, 20, 14),
      child: Row(
        children: [
          if (!wide) ...[
            _brandMark(),
            const SizedBox(width: 14),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _sections[_selectedSection].$1,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 31,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'LUXURY WHEEL  /  OPERATIONS',
                  style: GoogleFonts.manrope(
                    color: _muted,
                    fontSize: 9,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Refresh data',
            onPressed: _loading ? null : _loadData,
            icon: const Icon(Icons.refresh, color: _muted),
          ),
          if (wide)
            IconButton(
              tooltip: 'Sign out',
              onPressed: () async {
                await client.auth.signOutAllDevices();
                if (mounted) Navigator.of(context).pop();
              },
              icon: const Icon(Icons.logout, color: _muted),
            ),
        ],
      ),
    );
  }

  Widget _buildCompactNavigation() {
    return SizedBox(
      height: 51,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        itemCount: _visibleSectionIndexes.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) =>
            _sectionNavigation(_visibleSectionIndexes[index]),
      ),
    );
  }

  Widget _sectionNavigation(int index, {bool expanded = false}) {
    final selected = _selectedSection == index;
    final icon = _sections[index].$2;
    final label = _sections[index].$1;
    return Padding(
      padding: EdgeInsets.only(bottom: expanded ? 7 : 0),
      child: Material(
        color: selected
            ? (expanded ? Colors.white.withValues(alpha: .12) : _ink)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(13),
        child: InkWell(
          borderRadius: BorderRadius.circular(13),
          onTap: () => setState(() => _selectedSection = index),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: expanded ? 12 : 14,
              vertical: expanded ? 13 : 10,
            ),
            child: Row(
              mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 17,
                  color: selected
                      ? (expanded ? _brass : Colors.white)
                      : (expanded ? Colors.white60 : _muted),
                ),
                const SizedBox(width: 9),
                Text(
                  label,
                  style: GoogleFonts.manrope(
                    color: selected
                        ? (expanded ? Colors.white : Colors.white)
                        : (expanded ? Colors.white70 : _muted),
                    fontSize: 11,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection() {
    return switch (_selectedSection) {
      0 => _buildOverview(),
      1 => _buildBranches(),
      2 => _buildCars(),
      3 => _buildCompanies(),
      4 => _buildBookings(),
      5 => _buildOffers(),
      6 => _buildUsers(),
      7 => _buildBackups(),
      _ => _buildSurveyFeedback(),
    };
  }

  Widget _buildOverview() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
      children: [
        Text(
          'A clear view of your rental network.',
          style: GoogleFonts.manrope(color: _muted, fontSize: 12),
        ),
        const SizedBox(height: 21),
        Wrap(
          spacing: 13,
          runSpacing: 13,
          children: [
            _metricCard(
              'Vehicles',
              _cars.length,
              Icons.directions_car_outlined,
              'Across your fleet',
            ),
            _metricCard(
              'Branches',
              _branches.length,
              Icons.location_city_outlined,
              'Rental locations',
            ),
            _metricCard(
              'Companies',
              _companies.length,
              Icons.business_outlined,
              'Rental partners',
            ),
            _metricCard(
              'Users',
              _users.length,
              Icons.people_outline,
              'Registered accounts',
            ),
            _metricCard(
              'Bookings',
              _reservations.length,
              Icons.event_note_outlined,
              'Requests to review',
            ),
            _metricCard(
              'Offers',
              _offers.length,
              Icons.local_offer_outlined,
              'Discounts and partners',
            ),
          ],
        ),
        const SizedBox(height: 25),
        _sectionHeading('Fleet status', 'Manage your cars', () {
          setState(() => _selectedSection = 2);
        }),
        const SizedBox(height: 10),
        if (_cars.isEmpty)
          _emptyCard(
            'Your fleet is ready to take shape.',
            'Add a rental company and start registering vehicles.',
            Icons.directions_car_outlined,
          )
        else
          ..._cars.take(5).map(_carCard),
      ],
    );
  }

  Widget _metricCard(String label, int value, IconData icon, String caption) {
    return Container(
      width: 230,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 17, color: _brass),
              const Spacer(),
              Text(
                label.toUpperCase(),
                style: GoogleFonts.manrope(
                  color: _muted,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            '$value',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 39,
              height: 1,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            caption,
            style: GoogleFonts.manrope(color: _muted, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanies() {
    return _managementList(
      title: 'Rental partners',
      detail: 'Manage the companies operating vehicles and branches.',
      actionLabel: 'Add company',
      secondaryAction:
          _companies.any(
            (company) => _canAdministerCompanyId(company.id!),
          )
          ? OutlinedButton.icon(
              onPressed: _selectCompanyForTeamManagement,
              icon: const Icon(Icons.groups_outlined, size: 16),
              label: const Text('Manage team access'),
            )
          : null,
      showAddAction: _isAdmin,
      onAdd: _editCompany,
      children: _companies.isEmpty
          ? [
              _emptyCard(
                'No rental companies yet.',
                'Create a company to get started.',
                Icons.business_outlined,
              ),
            ]
          : _companies.map(_companyCard).toList(),
    );
  }

  Widget _buildBranches() {
    return _managementList(
      title: 'Locations',
      detail: 'Set up branch addresses and operating status.',
      actionLabel: 'Add branch',
      showAddAction: _canManageCompany,
      onAdd: _companies.isEmpty
          ? () => _showMessage('Add a rental company before creating a branch.')
          : _editBranch,
      children: _branches.isEmpty
          ? [
              _emptyCard(
                'No branches yet.',
                'Branch locations will appear here.',
                Icons.location_city_outlined,
              ),
            ]
          : _branches.map(_branchCard).toList(),
    );
  }

  Widget _buildCars() {
    return _managementList(
      title: 'Vehicle inventory',
      detail: 'Manage vehicles, photos, fleet rates, and branch assignment.',
      actionLabel: 'Add car',
      secondaryAction: _canManageCompany
          ? Wrap(
              spacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: _companies.isEmpty || _branches.isEmpty
                      ? null
                      : _bulkImportCars,
                  icon: const Icon(Icons.upload_file_outlined, size: 16),
                  label: const Text('Import CSV'),
                ),
                OutlinedButton.icon(
                  onPressed: _downloadCarCsvTemplate,
                  icon: const Icon(Icons.download_outlined, size: 16),
                  label: const Text('CSV template'),
                ),
              ],
            )
          : null,
      showAddAction: _canManageCompany,
      onAdd: _companies.isEmpty
          ? () => _showMessage('Add a rental company before registering a car.')
          : _editCar,
      children: _cars.isEmpty
          ? [
              _emptyCard(
                'No cars in your fleet yet.',
                'Add a company, then register its vehicles.',
                Icons.directions_car_outlined,
              ),
            ]
          : _cars.map(_carCard).toList(),
    );
  }

  Widget _buildBookings() {
    final pending = _reservations
        .where((reservation) => reservation.status == 'requested')
        .length;
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
      children: [
        Text(
          _isReadOnlyCompanyUser
              ? 'Bookings for your assigned companies · viewing only'
              : '$pending booking${pending == 1 ? '' : 's'} need review',
          style: GoogleFonts.manrope(color: _muted, fontSize: 11),
        ),
        const SizedBox(height: 15),
        if (_reservations.isEmpty)
          _emptyCard(
            'No booking requests yet.',
            'Customer requests will appear here for approval.',
            Icons.event_note_outlined,
          )
        else
          ..._reservations.map(_bookingCard),
      ],
    );
  }

  Widget _buildSurveyFeedback() {
    final averageRating = _surveyFeedback.isEmpty
        ? 0.0
        : _surveyFeedback.fold<int>(
                0,
                (total, survey) => total + survey.rating,
              ) /
              _surveyFeedback.length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
      children: [
        Text(
          'Customer feedback',
          style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 5),
        Text(
          _surveyFeedback.isEmpty
              ? 'No feedback has been submitted yet.'
              : '${_surveyFeedback.length} response${_surveyFeedback.length == 1 ? '' : 's'} · ${averageRating.toStringAsFixed(1)} average rating',
          style: GoogleFonts.manrope(color: _muted, fontSize: 10),
        ),
        const SizedBox(height: 16),
        if (_surveyFeedback.isEmpty)
          _emptyCard(
            'No customer feedback yet.',
            'Ratings and comments submitted by customers will appear here.',
            Icons.rate_review_outlined,
          )
        else
          ..._surveyFeedback.map(
            (survey) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(17),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Icon(
                          index < survey.rating
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color: _brass,
                          size: 19,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${survey.rating}/5',
                        style: GoogleFonts.manrope(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        survey.createdAt.toLocal().toString().split('.').first,
                        style: GoogleFonts.manrope(
                          color: _muted,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Text(
                    survey.feedback?.trim().isNotEmpty == true
                        ? survey.feedback!.trim()
                        : 'No written comment.',
                    style: GoogleFonts.manrope(
                      color: survey.feedback?.trim().isNotEmpty == true
                          ? _ink
                          : _muted,
                      fontSize: 11,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _bookingCard(RentalReservation reservation) {
    final pending = reservation.status == 'requested';
    final approved = reservation.status == 'approved';
    final canManage =
        reservation.companyId != null &&
        _canManageCompanyId(reservation.companyId!);
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(17),
          onTap: approved ? () => _showReservationQr(reservation) : null,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        reservation.carName,
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    _statusPill(reservation.status),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  '${reservation.companyName ?? ''} · ${reservation.branchName ?? ''} · ${reservation.city}',
                  style: GoogleFonts.manrope(color: _muted, fontSize: 10),
                ),
                Text(
                  '${reservation.customerName ?? 'Customer'} · ${reservation.customerEmail ?? 'No email'}',
                  style: GoogleFonts.manrope(color: _muted, fontSize: 10),
                ),
                Text(
                  '${reservation.bookingReference} · ${reservation.totalPrice} SAR · ${reservation.pickupDate.toLocal().toString().split(' ').first} to ${reservation.returnDate.toLocal().toString().split(' ').first}',
                  style: GoogleFonts.manrope(color: _muted, fontSize: 10),
                ),
                if (reservation.pointsDiscount > 0)
                  Text(
                    '${reservation.pointsRedeemed} points redeemed · ${reservation.pointsDiscount} SAR off',
                    style: GoogleFonts.manrope(
                      color: _brass,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                if (pending && canManage) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      FilledButton.icon(
                        onPressed: () =>
                            _setBookingStatus(reservation, 'approved'),
                        icon: const Icon(Icons.check, size: 16),
                        label: const Text('Approve'),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => _rejectBooking(reservation),
                        icon: const Icon(Icons.close, size: 16),
                        label: const Text('Reject'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red.shade700,
                        ),
                      ),
                    ],
                  ),
                ] else if (approved) ...[
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.end,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => _showReservationQr(reservation),
                        icon: const Icon(Icons.qr_code_2, size: 17),
                        label: const Text('Show booking QR'),
                      ),
                      if (canManage) ...[
                        OutlinedButton.icon(
                          onPressed: () => _proposeBookingChange(reservation),
                          icon: const Icon(
                            Icons.edit_calendar_outlined,
                            size: 17,
                          ),
                          label: const Text('Propose adjustment'),
                        ),
                        TextButton.icon(
                          onPressed: () => _cancelBooking(reservation),
                          icon: const Icon(Icons.cancel_outlined, size: 17),
                          label: const Text('Cancel booking'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ],
                  ),
                ] else if (reservation.status == 'cancelled' ||
                    reservation.status == 'rejected') ...[
                  const SizedBox(height: 7),
                  Text(
                    'Reason: ${reservation.statusReason ?? 'No reason provided.'}',
                    style: GoogleFonts.manrope(
                      color: _muted,
                      fontSize: 10,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showReservationQr(RentalReservation reservation) {
    showDialog<void>(
      context: context,
      builder: (_) => BookingQrDialog(
        title: 'Approved booking',
        bookingReference: reservation.bookingReference,
      ),
    );
  }

  Future<void> _setBookingStatus(
    RentalReservation reservation,
    String status, {
    String? reason,
  }) async {
    await _run(() async {
      await client.admin.updateReservationStatus(
        id: reservation.id!,
        status: status,
        reason: reason,
      );
    });
  }

  Future<void> _rejectBooking(RentalReservation reservation) async {
    final reason = await _askBookingReason(
      title: 'Reject booking',
      actionLabel: 'Reject booking',
    );
    if (reason == null) return;
    await _setBookingStatus(reservation, 'rejected', reason: reason);
  }

  Future<void> _cancelBooking(RentalReservation reservation) async {
    final reason = await _askBookingReason(
      title: 'Cancel booking',
      actionLabel: 'Cancel booking',
    );
    if (reason == null) return;
    await _run(() async {
      await client.admin.cancelReservation(
        id: reservation.id!,
        reason: reason,
      );
    });
  }

  Future<String?> _askBookingReason({
    required String title,
    required String actionLabel,
  }) async {
    final controller = TextEditingController();
    final reason = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          minLines: 2,
          maxLines: 4,
          maxLength: 1000,
          decoration: const InputDecoration(
            labelText: 'Reason shown to the booker',
            hintText: 'Explain why this booking was rejected or canceled.',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Keep booking'),
          ),
          FilledButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isEmpty) {
                ScaffoldMessenger.of(dialogContext).showSnackBar(
                  const SnackBar(content: Text('Please enter a reason.')),
                );
                return;
              }
              Navigator.pop(dialogContext, value);
            },
            child: Text(actionLabel),
          ),
        ],
      ),
    );
    controller.dispose();
    return reason;
  }

  Future<void> _proposeBookingChange(RentalReservation reservation) async {
    final priceController = TextEditingController(
      text: '${reservation.totalPrice}',
    );
    final reasonController = TextEditingController();
    final today = BookingDates.dateOnly(DateTime.now());
    var pickupDate = BookingDates.dateOnly(reservation.pickupDate.toLocal());
    if (pickupDate.isBefore(today)) pickupDate = today;
    var returnDate = BookingDates.adjustReturnDate(
      reservation.returnDate.toLocal(),
      pickupDate,
      today: today,
    );

    try {
      final proposal =
          await showDialog<
            ({DateTime pickup, DateTime returnAt, int price, String reason})
          >(
            context: context,
            builder: (dialogContext) => StatefulBuilder(
              builder: (context, setDialogState) => AlertDialog(
                title: const Text('Propose booking adjustment'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () async {
                          final selected = await showDatePicker(
                            context: context,
                            initialDate: BookingDates.clampDate(
                              pickupDate,
                              today,
                              today.add(const Duration(days: 365)),
                            ),
                            firstDate: today,
                            lastDate: today.add(
                              const Duration(days: 365),
                            ),
                          );
                          if (selected != null) {
                            setDialogState(() {
                              pickupDate = BookingDates.dateOnly(selected);
                              returnDate = BookingDates.adjustReturnDate(
                                returnDate,
                                pickupDate,
                                today: today,
                              );
                            });
                          }
                        },
                        icon: const Icon(Icons.flight_takeoff),
                        label: Text(
                          'Pick-up: ${pickupDate.toString().split(' ').first}',
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () async {
                          final selected = await showDatePicker(
                            context: context,
                            initialDate: BookingDates.clampDate(
                              returnDate,
                              BookingDates.earliestReturnDate(
                                pickupDate,
                                today: today,
                              ),
                              BookingDates.latestReturnDate(
                                pickupDate,
                                today: today,
                              ),
                            ),
                            firstDate: BookingDates.earliestReturnDate(
                              pickupDate,
                              today: today,
                            ),
                            lastDate: BookingDates.latestReturnDate(
                              pickupDate,
                              today: today,
                            ),
                          );
                          if (selected != null) {
                            setDialogState(
                              () => returnDate = BookingDates.dateOnly(
                                selected,
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.flight_land),
                        label: Text(
                          'Return: ${returnDate.toString().split(' ').first}',
                        ),
                      ),
                      TextField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Proposed total price (SAR)',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: reasonController,
                        minLines: 2,
                        maxLines: 4,
                        maxLength: 1000,
                        decoration: const InputDecoration(
                          labelText: 'Reason shown to the booker',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('Back'),
                  ),
                  FilledButton(
                    onPressed: () {
                      final price = int.tryParse(priceController.text.trim());
                      final reason = reasonController.text.trim();
                      final rentalDays = BookingDates.daysBetween(
                        pickupDate,
                        returnDate,
                      );
                      if (price == null ||
                          price < 1 ||
                          reason.isEmpty ||
                          rentalDays < 1 ||
                          rentalDays > BookingDates.maxRentalDays) {
                        ScaffoldMessenger.of(dialogContext).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Enter valid dates, a positive price, and a reason.',
                            ),
                          ),
                        );
                        return;
                      }
                      Navigator.pop(
                        dialogContext,
                        (
                          pickup: pickupDate,
                          returnAt: returnDate,
                          price: price,
                          reason: reason,
                        ),
                      );
                    },
                    child: const Text('Send proposal'),
                  ),
                ],
              ),
            ),
          );
      if (proposal == null) return;
      await _run(() async {
        await client.admin.proposeReservationChange(
          id: reservation.id!,
          pickupDate: proposal.pickup,
          returnDate: proposal.returnAt,
          totalPrice: proposal.price,
          reason: proposal.reason,
        );
      });
    } finally {
      priceController.dispose();
      reasonController.dispose();
    }
  }

  Widget _buildOffers() {
    return _managementList(
      title: 'Discounts & partner offers',
      detail:
          'Publish sponsor promotions with artwork, discount, city, and validity dates.',
      actionLabel: 'Add offer',
      showAddAction:
          _isAdmin ||
          _companies.any((company) => _canManageCompanyId(company.id!)),
      onAdd: () {
        if (!_isAdmin &&
            !_companies.any((company) => _canManageCompanyId(company.id!))) {
          _showMessage('Your account is not assigned to a rental company.');
          return;
        }
        _editOffer();
      },
      children: _offers.isEmpty
          ? [
              _emptyCard(
                'No active offers yet.',
                'Create partner discounts to display them on the customer home page.',
                Icons.local_offer_outlined,
              ),
            ]
          : _offers.map(_offerCard).toList(),
    );
  }

  Widget _offerCard(ManagedOffer offer) {
    final discount = offer.discountType == 'percent'
        ? '${offer.discountValue}% off'
        : '${offer.discountValue} SAR off';
    return _recordCard(
      icon: Icons.local_offer_outlined,
      imageUrl: offer.sponsorImageUrl,
      title: offer.title,
      subtitle:
          '${offer.sponsorName} · $discount · ${offer.city ?? 'All cities'}',
      status: offer.status,
      onEdit: () => _editOffer(offer),
      onDelete: () => _confirmDelete(
        'Delete ${offer.title}?',
        'This offer will no longer appear in the app.',
        () => client.admin.deleteOffer(offer.id!),
      ),
      showActions: offer.companyId == null
          ? _isAdmin
          : _canManageCompanyId(offer.companyId!),
    );
  }

  Widget _managementList({
    required String title,
    required String detail,
    required String actionLabel,
    required VoidCallback onAdd,
    bool showAddAction = true,
    Widget? secondaryAction,
    required List<Widget> children,
  }) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    detail,
                    style: GoogleFonts.manrope(color: _muted, fontSize: 10),
                  ),
                ],
              ),
            ),
            if (showAddAction) ...[
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add, size: 17),
                label: Text(actionLabel),
                style: FilledButton.styleFrom(
                  backgroundColor: _ink,
                  foregroundColor: Colors.white,
                  textStyle: GoogleFonts.manrope(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
            if (secondaryAction != null) ...[
              const SizedBox(width: 5),
              secondaryAction,
            ],
          ],
        ),
        const SizedBox(height: 17),
        ...children,
      ],
    );
  }

  Widget _companyCard(RentalCompany company) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _recordCard(
          icon: Icons.business_outlined,
          imageUrl: company.logoUrl,
          title: company.name,
          subtitle: [
            if (company.email?.isNotEmpty == true) company.email!,
            if (company.phone?.isNotEmpty == true) company.phone!,
          ].join(' · '),
          status: company.status,
          onEdit: () => _editCompany(company),
          showActions: _canAdministerCompanyId(company.id!),
          showDeleteAction: _isAdmin,
          onDelete: () => _confirmDelete(
            'Delete ${company.name}?',
            'Companies with branches or cars cannot be deleted.',
            () => client.admin.deleteCompany(company.id!),
          ),
        ),
      ],
    );
  }

  Widget _branchCard(Branch branch) {
    return _recordCard(
      icon: Icons.location_city_outlined,
      title: branch.name,
      subtitle:
          '${branch.city} · ${_companyName(branch.companyId)} · ${branch.address}',
      status: branch.status,
      onEdit: () => _editBranch(branch),
      onDelete: () => _confirmDelete(
        'Delete ${branch.name}?',
        'Move any vehicles assigned to this branch first.',
        () => client.admin.deleteBranch(branch.id!),
      ),
      showActions: _canManageCompanyId(branch.companyId),
    );
  }

  Widget _carCard(ManagedCar car) {
    final carImages = _images.where((image) => image.carId == car.id).toList();
    final image = carImages.isEmpty ? null : carImages.first.url;
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 78,
              height: 61,
              child: image == null
                  ? const ColoredBox(
                      color: _paper,
                      child: Icon(Icons.directions_car, color: _brass),
                    )
                  : Image.network(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const ColoredBox(
                        color: _paper,
                        child: Icon(Icons.broken_image_outlined, color: _muted),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${car.make} ${car.model}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${car.year} · ${car.plateNumber} · ${_companyName(car.companyId)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(color: _muted, fontSize: 9),
                ),
                const SizedBox(height: 5),
                Text(
                  'SAR ${car.dailyRate} / day',
                  style: GoogleFonts.manrope(
                    color: _brass,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          _statusPill(car.status),
          if (_canManageCompanyId(car.companyId))
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'images':
                    _manageImages(car);
                  case 'edit':
                    _editCar(car);
                  case 'delete':
                    _confirmDelete(
                      'Delete ${car.make} ${car.model}?',
                      'This also removes its image references.',
                      () => client.admin.deleteCar(car.id!),
                    );
                }
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'images', child: Text('Manage images')),
                PopupMenuItem(value: 'edit', child: Text('Edit car')),
                PopupMenuItem(value: 'delete', child: Text('Delete car')),
              ],
            ),
        ],
      ),
    );
  }

  Widget _recordCard({
    required IconData icon,
    String? imageUrl,
    required String title,
    required String subtitle,
    required String status,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    bool showActions = true,
    bool showDeleteAction = true,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 7, 5),
        leading: CircleAvatar(
          backgroundColor: _paper,
          foregroundColor: _brass,
          backgroundImage: imageUrl?.isNotEmpty == true
              ? NetworkImage(imageUrl!)
              : null,
          child: imageUrl?.isNotEmpty == true ? null : Icon(icon, size: 19),
        ),
        title: Text(
          title,
          style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w800),
        ),
        subtitle: Text(
          subtitle.isEmpty ? 'No contact details' : subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.manrope(color: _muted, fontSize: 9),
        ),
        trailing: showActions
            ? Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 1,
                children: [
                  _statusPill(status),
                  IconButton(
                    tooltip: 'Edit',
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit_outlined, size: 17),
                  ),
                  if (showDeleteAction)
                    IconButton(
                      tooltip: 'Delete',
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline, size: 17),
                    ),
                ],
              )
            : _statusPill(status),
      ),
    );
  }

  Widget _buildUsers() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
      children: [
        Text(
          'Access and account controls',
          style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 5),
        Text(
          'Grant or remove dashboard access, or block an account from signing in.',
          style: GoogleFonts.manrope(color: _muted, fontSize: 10),
        ),
        const SizedBox(height: 17),
        if (_users.isEmpty)
          _emptyCard(
            'No user accounts yet.',
            'Registered accounts will appear here.',
            Icons.people_outline,
          )
        else
          ..._users.map(_userCard),
      ],
    );
  }

  Widget _userCard(AdminUser user) {
    final title = user.fullName?.trim().isNotEmpty == true
        ? user.fullName!
        : (user.email ?? 'Unnamed user');
    final companyMemberships = _members
        .where(
          (member) => member.email?.toLowerCase() == user.email?.toLowerCase(),
        )
        .toList();
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(14, 10, 12, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: _paper,
                child: Icon(Icons.person_outline, color: _brass, size: 19),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      user.email ?? 'No email on profile',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(color: _muted, fontSize: 9),
                    ),
                    Text(
                      user.blocked
                          ? 'Blocked'
                          : user.isAdmin
                          ? 'Administrator'
                          : companyMemberships.any(
                              (member) => member.role == 'company_admin',
                            )
                          ? 'Company administrator'
                          : companyMemberships.any(
                              (member) => member.role == 'viewer',
                            )
                          ? 'Company viewer'
                          : 'Standard user',
                      style: GoogleFonts.manrope(
                        color: user.blocked ? Colors.red.shade700 : _brass,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (companyMemberships.isNotEmpty)
                      Text(
                        companyMemberships
                            .map((member) => member.companyName)
                            .join(', '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.manrope(
                          color: _muted,
                          fontSize: 9,
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text('ADMIN', style: GoogleFonts.manrope(fontSize: 8)),
                  Switch.adaptive(
                    value: user.isAdmin,
                    activeTrackColor: _brass,
                    onChanged: (value) => _updateUser(
                      user,
                      isAdmin: value,
                      blocked: user.blocked,
                    ),
                  ),
                ],
              ),
              IconButton(
                tooltip: user.blocked ? 'Unblock user' : 'Block user',
                onPressed: () => _updateUser(
                  user,
                  isAdmin: user.isAdmin,
                  blocked: !user.blocked,
                ),
                icon: Icon(
                  user.blocked
                      ? Icons.lock_open_outlined
                      : Icons.block_outlined,
                  color: user.blocked ? _brass : _muted,
                  size: 19,
                ),
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton.icon(
              onPressed: user.email == null || user.isAdmin
                  ? null
                  : () => _assignUserAsCompanyViewer(user),
              icon: const Icon(Icons.business_outlined, size: 16),
              label: Text(
                companyMemberships.any((member) => member.role == 'viewer')
                    ? 'Change company access'
                    : 'Assign as company viewer',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _assignUserAsCompanyViewer(AdminUser user) async {
    if (_companies.isEmpty || user.email == null) {
      _showMessage(
        'Add a company and register the user before assigning access.',
      );
      return;
    }
    final currentMembership = _members
        .where(
          (member) => member.email?.toLowerCase() == user.email!.toLowerCase(),
        )
        .firstOrNull;
    var companyId = currentMembership?.companyId ?? _companies.first.id!;
    var selectedCompanyId = companyId;
    final selectedCompany = await showDialog<int>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Assign ${user.fullName ?? user.email}'),
          content: DropdownButtonFormField<int>(
            initialValue: companyId,
            decoration: const InputDecoration(
              labelText: 'Company',
              border: OutlineInputBorder(),
            ),
            items: _companies
                .map(
                  (company) => DropdownMenuItem(
                    value: company.id!,
                    child: Text(company.name),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setDialogState(() => selectedCompanyId = value);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, selectedCompanyId),
              child: const Text('Assign read-only access'),
            ),
          ],
        ),
      ),
    );
    if (selectedCompany == null) return;
    await _run(() async {
      await client.admin.assignCompanyUser(
        companyId: selectedCompany,
        email: user.email!,
        role: 'viewer',
      );
    });
  }

  Future<void> _updateUser(
    AdminUser user, {
    required bool isAdmin,
    required bool blocked,
  }) {
    return _run(
      () async {
        await client.admin.updateUserAccess(
          authUserId: user.authUserId,
          isAdmin: isAdmin,
          blocked: blocked,
        );
      },
    );
  }

  Future<void> _restoreManagementBackup() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['json'],
      );
      if (result.isEmpty) return;
      final bytes = await result.single.readAsBytes();
      final accepted = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Replace rental app data?'),
          content: const Text(
            'Restoring replaces current companies, branches, cars, offers, bookings, and company assignments with the selected backup. This cannot be undone. Sign-in accounts and hosted image files are not replaced.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red.shade700,
              ),
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Replace app data'),
            ),
          ],
        ),
      );
      if (accepted != true) return;
      final restored = await client.admin.restoreManagementData(
        utf8.decode(bytes),
      );
      await _loadData();
      _showMessage('Restored $restored rental records from the backup.');
    } catch (error) {
      _showMessage('Backup restore failed: $error');
    }
  }

  Widget _buildBackups() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
      children: [
        Container(
          padding: const EdgeInsets.all(19),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.archive_outlined, size: 23, color: _brass),
              const SizedBox(height: 14),
              Text(
                'Back up rental data',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'Save companies, branches, cars, image links, offers, bookings, and company assignments in one JSON file.',
                style: GoogleFonts.manrope(
                  color: _muted,
                  fontSize: 10,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.icon(
                    onPressed: _loading
                        ? null
                        : () async {
                            try {
                              final contents = await client.admin
                                  .exportManagementData();
                              await downloadManagementFile(
                                contents: contents,
                                fileName:
                                    'luxury-wheel-management-${DateTime.now().toUtc().toIso8601String().substring(0, 10)}.json',
                                mimeType: 'application/json',
                              );
                              if (mounted) {
                                _showMessage(
                                  'Management backup is ready. Keep it somewhere safe.',
                                );
                              }
                            } catch (error) {
                              _showMessage(error.toString());
                            }
                          },
                    icon: const Icon(Icons.download_outlined, size: 18),
                    label: const Text('Download backup file'),
                    style: FilledButton.styleFrom(
                      backgroundColor: _ink,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: _restoreManagementBackup,
                    icon: const Icon(Icons.upload_file_outlined, size: 18),
                    label: const Text('Restore from backup file'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 13),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFF1EDE2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, size: 17, color: _brass),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Restore replaces rental records and bookings in this app. It does not replace sign-in accounts or database system data, and it cannot bundle images hosted at external URLs. Keep a separate Serverpod/hosting backup for the full database.',
                  style: GoogleFonts.manrope(
                    color: _ink,
                    fontSize: 10,
                    height: 1.55,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _emptyCard(String title, String detail, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon, color: _brass, size: 27),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            detail,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(color: _muted, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeading(String title, String action, VoidCallback onTap) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        TextButton(onPressed: onTap, child: Text(action)),
      ],
    );
  }

  Widget _statusPill(String status) {
    final isGood =
        status == 'active' || status == 'open' || status == 'available';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: isGood ? const Color(0xFFE8F1E9) : const Color(0xFFF1EDE2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status.toUpperCase(),
        style: GoogleFonts.manrope(
          color: isGood ? const Color(0xFF41654A) : _muted,
          fontSize: 8,
          fontWeight: FontWeight.w800,
          letterSpacing: .4,
        ),
      ),
    );
  }

  Widget _brandMark({bool dark = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 37,
          height: 37,
          decoration: BoxDecoration(
            color: dark ? Colors.white.withValues(alpha: .1) : _ink,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            'LW',
            style: GoogleFonts.cormorantGaramond(
              color: _brass,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 9),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LUXURY WHEEL',
              style: GoogleFonts.manrope(
                color: dark ? Colors.white : _ink,
                fontSize: 9,
                letterSpacing: 1.25,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'ADMINISTRATION',
              style: GoogleFonts.manrope(
                color: dark ? Colors.white54 : _muted,
                fontSize: 7,
                letterSpacing: 1.1,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _companyName(int id) {
    for (final company in _companies) {
      if (company.id == id) return company.name;
    }
    return 'Company #$id';
  }

  Future<void> _confirmDelete(
    String title,
    String detail,
    Future<void> Function() onDelete,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(detail),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade700),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) await _run(onDelete);
  }

  Future<void> _showEditor({
    required String title,
    required Widget Function(StateSetter setDialogState) buildFields,
    required Future<void> Function() onSave,
    String? Function()? validate,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(title),
          content: SizedBox(
            width: 460,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildFields(setDialogState),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final validationMessage = validate?.call();
                if (validationMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(validationMessage)),
                  );
                  return;
                }
                Navigator.pop(dialogContext);
                _run(onSave);
              },
              style: FilledButton.styleFrom(backgroundColor: _ink),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
    int? maxLength,
    int? maxLines,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          counterText: '',
        ),
      ),
    );
  }

  Widget _statusDropdown(
    String value,
    List<String> values,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: const InputDecoration(
          labelText: 'Status',
          border: OutlineInputBorder(),
        ),
        items: values
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Future<void> _editCompany([RentalCompany? company]) async {
    final name = TextEditingController(text: company?.name ?? '');
    final logoUrl = TextEditingController(text: company?.logoUrl ?? '');
    final email = TextEditingController(text: company?.email ?? '');
    final phone = TextEditingController(text: company?.phone ?? '');
    var status = company?.status ?? 'active';
    await _showEditor(
      title: company == null ? 'Add rental company' : 'Edit rental company',
      buildFields: (setDialogState) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _textField(name, 'Company name'),
          _textField(logoUrl, 'Company logo image URL'),
          _textField(email, 'Email', keyboardType: TextInputType.emailAddress),
          _textField(phone, 'Phone', keyboardType: TextInputType.phone),
          _statusDropdown(status, const ['active', 'paused', 'inactive'], (v) {
            if (v != null) setDialogState(() => status = v);
          }),
        ],
      ),
      onSave: () async {
        await client.admin.saveCompany(
          id: company?.id,
          name: name.text,
          logoUrl: logoUrl.text,
          email: email.text,
          phone: phone.text,
          status: status,
        );
      },
    );
  }

  Future<void> _editOffer([ManagedOffer? offer]) async {
    final sponsor = TextEditingController(text: offer?.sponsorName ?? '');
    final sponsorImage = TextEditingController(
      text: offer?.sponsorImageUrl ?? '',
    );
    final title = TextEditingController(text: offer?.title ?? '');
    final description = TextEditingController(
      text: offer?.description ?? '',
    );
    final city = TextEditingController(text: offer?.city ?? '');
    final discountValue = TextEditingController(
      text: '${offer?.discountValue ?? 10}',
    );
    final startDate = TextEditingController(
      text: offer?.startsAt?.toLocal().toIso8601String().split('T').first ?? '',
    );
    final endDate = TextEditingController(
      text: offer?.endsAt?.toLocal().toIso8601String().split('T').first ?? '',
    );
    var companyId =
        offer?.companyId ??
        (_isAdmin
            ? null
            : _companies
                  .where((company) => _canManageCompanyId(company.id!))
                  .firstOrNull
                  ?.id);
    var discountType = offer?.discountType ?? 'percent';
    var status = offer?.status ?? 'active';
    await _showEditor(
      title: offer == null ? 'Create partner offer' : 'Edit partner offer',
      buildFields: (setDialogState) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isAdmin)
            DropdownButtonFormField<int?>(
              initialValue: companyId,
              decoration: const InputDecoration(
                labelText: 'Partner company (optional)',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem<int?>(
                  value: null,
                  child: Text('Independent sponsor'),
                ),
                ..._companies.map(
                  (item) => DropdownMenuItem<int?>(
                    value: item.id,
                    child: Text(item.name),
                  ),
                ),
              ],
              onChanged: (value) => setDialogState(() => companyId = value),
            ),
          _textField(sponsor, 'Sponsor name'),
          _textField(sponsorImage, 'Sponsor image URL'),
          _textField(title, 'Offer title'),
          _textField(description, 'Offer description', maxLines: 3),
          _textField(city, 'City (leave blank for all cities)'),
          DropdownButtonFormField<String>(
            initialValue: discountType,
            decoration: const InputDecoration(
              labelText: 'Discount type',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'percent', child: Text('Percentage')),
              DropdownMenuItem(
                value: 'amount',
                child: Text('Fixed SAR amount'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setDialogState(() => discountType = value);
              }
            },
          ),
          _textField(
            discountValue,
            discountType == 'percent'
                ? 'Discount percent (1–100)'
                : 'Discount (SAR)',
            keyboardType: TextInputType.number,
          ),
          _textField(startDate, 'Start date (YYYY-MM-DD, optional)'),
          _textField(endDate, 'End date (YYYY-MM-DD, optional)'),
          _statusDropdown(status, const ['active', 'paused', 'draft'], (value) {
            if (value != null) setDialogState(() => status = value);
          }),
        ],
      ),
      validate: () => description.text.trim().isEmpty
          ? 'Enter an offer description.'
          : null,
      onSave: () async {
        DateTime? parseDate(String text, String label) {
          if (text.trim().isEmpty) return null;
          final parsed = DateTime.tryParse(text.trim());
          if (parsed == null) {
            throw FormatException('Enter $label as YYYY-MM-DD.');
          }
          return parsed.toUtc();
        }

        await client.admin.saveOffer(
          id: offer?.id,
          companyId: companyId,
          sponsorName: sponsor.text,
          sponsorImageUrl: sponsorImage.text,
          title: title.text,
          description: description.text,
          city: city.text,
          discountType: discountType,
          discountValue: int.tryParse(discountValue.text) ?? 0,
          status: status,
          startsAt: parseDate(startDate.text, 'a valid start date'),
          endsAt: parseDate(endDate.text, 'a valid end date'),
        );
      },
    );
  }

  Future<void> _selectCompanyForTeamManagement() async {
    final availableCompanies = _companies
        .where((company) => _canAdministerCompanyId(company.id!))
        .toList();
    if (availableCompanies.isEmpty) return;

    var companyId = availableCompanies.first.id!;
    if (availableCompanies.length > 1) {
      final selectedCompanyId = await showDialog<int>(
        context: context,
        builder: (dialogContext) => StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: const Text('Choose a company'),
            content: DropdownButtonFormField<int>(
              initialValue: companyId,
              decoration: const InputDecoration(
                labelText: 'Company',
                border: OutlineInputBorder(),
              ),
              items: availableCompanies
                  .map(
                    (company) => DropdownMenuItem(
                      value: company.id!,
                      child: Text(company.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setDialogState(() => companyId = value);
                }
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(dialogContext, companyId),
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      );
      if (selectedCompanyId == null) return;
      companyId = selectedCompanyId;
    }

    final company = availableCompanies.firstWhere(
      (item) => item.id == companyId,
    );
    await _manageCompanyTeam(company);
  }

  Future<void> _manageCompanyTeam(RentalCompany company) async {
    final email = TextEditingController();
    var role = 'company_admin';
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          final members = _members
              .where((member) => member.companyId == company.id)
              .toList();
          return AlertDialog(
            title: Text('${company.name} team'),
            content: SizedBox(
              width: 480,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final member in members)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          member.fullName?.isNotEmpty == true
                              ? member.fullName!
                              : member.email ?? member.authUserId.toString(),
                        ),
                        subtitle: Text(
                          member.email ?? member.authUserId.toString(),
                        ),
                        trailing: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 2,
                          children: [
                            DropdownButton<String>(
                              value: member.role,
                              underline: const SizedBox.shrink(),
                              items: const [
                                DropdownMenuItem(
                                  value: 'company_admin',
                                  child: Text('Company admin'),
                                ),
                                DropdownMenuItem(
                                  value: 'manager',
                                  child: Text('Manager'),
                                ),
                                DropdownMenuItem(
                                  value: 'staff',
                                  child: Text('Staff'),
                                ),
                                DropdownMenuItem(
                                  value: 'viewer',
                                  child: Text('Viewer'),
                                ),
                              ],
                              onChanged: member.email == null
                                  ? null
                                  : (value) async {
                                      if (value == null ||
                                          value == member.role) {
                                        return;
                                      }
                                      try {
                                        await client.admin.assignCompanyUser(
                                          companyId: company.id!,
                                          email: member.email!,
                                          role: value,
                                        );
                                        await _loadData();
                                        setDialogState(() {});
                                      } catch (error) {
                                        _showMessage(
                                          'Could not change company role: $error',
                                        );
                                      }
                                    },
                            ),
                            IconButton(
                              tooltip: 'Remove company access',
                              icon: const Icon(
                                Icons.person_remove_outlined,
                                size: 19,
                              ),
                              onPressed: () async {
                                try {
                                  await client.admin.removeCompanyUser(
                                    companyId: company.id!,
                                    authUserId: member.authUserId,
                                  );
                                  await _loadData();
                                  setDialogState(() {});
                                } catch (error) {
                                  _showMessage(
                                    'Could not remove user: $error',
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    const Divider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Assign a registered user by email. Choose a role for this company only.',
                        style: GoogleFonts.manrope(
                          color: _muted,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _textField(
                      email,
                      'User account email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: role,
                      decoration: const InputDecoration(
                        labelText: 'Company access level',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'company_admin',
                          child: Text(
                            'Company admin — manage this company and its team',
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'manager',
                          child: Text('Manager — manage company operations'),
                        ),
                        DropdownMenuItem(
                          value: 'staff',
                          child: Text('Staff — manage company operations'),
                        ),
                        DropdownMenuItem(
                          value: 'viewer',
                          child: Text('Viewer — view fleet and dashboard only'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) setDialogState(() => role = value);
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Close'),
              ),
              FilledButton(
                onPressed: () async {
                  if (email.text.trim().isEmpty) {
                    _showMessage('Enter the user’s account email first.');
                    return;
                  }
                  try {
                    await client.admin.assignCompanyUser(
                      companyId: company.id!,
                      email: email.text,
                      role: role,
                    );
                    email.clear();
                    await _loadData();
                    setDialogState(() {});
                  } catch (error) {
                    _showMessage('Could not assign user: $error');
                  }
                },
                child: const Text('Assign to company'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _bulkImportCars() async {
    final companiesWithBranches = _companies
        .where(
          (company) =>
              _canManageCompanyId(company.id!) &&
              _branches.any((branch) => branch.companyId == company.id),
        )
        .toList();
    if (companiesWithBranches.isEmpty) {
      _showMessage('No company branches are available for your account.');
      return;
    }
    var companyId = companiesWithBranches.first.id!;
    var branchId = _branches
        .firstWhere((branch) => branch.companyId == companyId)
        .id!;
    final selection = await showDialog<(int, int, String)>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Import cars from CSV'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                initialValue: companyId,
                decoration: const InputDecoration(
                  labelText: 'Rental company',
                  border: OutlineInputBorder(),
                ),
                items: companiesWithBranches
                    .map(
                      (company) => DropdownMenuItem(
                        value: company.id!,
                        child: Text(company.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setDialogState(() {
                    companyId = value;
                    branchId = _branches
                        .firstWhere((branch) => branch.companyId == value)
                        .id!;
                  });
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                key: ValueKey(companyId),
                initialValue: branchId,
                decoration: const InputDecoration(
                  labelText: 'Target branch',
                  border: OutlineInputBorder(),
                ),
                items: _branches
                    .where((branch) => branch.companyId == companyId)
                    .map(
                      (branch) => DropdownMenuItem(
                        value: branch.id!,
                        child: Text('${branch.name} · ${branch.city}'),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) setDialogState(() => branchId = value);
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Required columns: make, model, year, category, plateNumber, seats, dailyRate. Optional: color, description, imageUrl. Duplicate plates are skipped. Up to 500 cars per upload.',
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton.icon(
              onPressed: () async {
                try {
                  final result = await FilePicker.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: const ['csv'],
                  );
                  if (result.isEmpty) return;
                  final bytes = await result.single.readAsBytes();
                  if (dialogContext.mounted) {
                    Navigator.pop(
                      dialogContext,
                      (companyId, branchId, utf8.decode(bytes)),
                    );
                  }
                } catch (error) {
                  _showMessage('Could not read CSV file: $error');
                }
              },
              icon: const Icon(Icons.upload_file),
              label: const Text('Choose CSV'),
            ),
          ],
        ),
      ),
    );
    if (selection == null) return;
    try {
      final report = await client.admin.bulkImportCarsWithReport(
        companyId: selection.$1,
        branchId: selection.$2,
        csvContents: selection.$3,
      );
      await _loadData();
      final imported = report['imported'] ?? 0;
      final skipped = report['skippedDuplicates'] ?? 0;
      _showMessage(
        skipped == 0
            ? 'Imported $imported cars into the selected branch.'
            : 'Imported $imported cars. Skipped $skipped duplicate plate${skipped == 1 ? '' : 's'}.',
      );
    } catch (error) {
      _showMessage('CSV import failed: $error');
    }
  }

  Future<void> _downloadCarCsvTemplate() async {
    const template =
        'make,model,year,category,plateNumber,color,seats,dailyRate,description,imageUrl\n'
        'Toyota,Camry,2025,Sedan,ABC1234,White,5,250,Comfortable sedan,https://example.com/camry.jpg\n';
    try {
      await downloadManagementFile(
        contents: template,
        fileName: 'luxury-wheel-car-import-template.csv',
        mimeType: 'text/csv',
      );
    } catch (error) {
      _showMessage('Could not download CSV template: $error');
    }
  }

  Future<void> _editBranch([Branch? branch]) async {
    final name = TextEditingController(text: branch?.name ?? '');
    final city = TextEditingController(text: branch?.city ?? '');
    final address = TextEditingController(text: branch?.address ?? '');
    final phone = TextEditingController(text: branch?.phone ?? '');
    final editableCompanies = _companies
        .where((company) => _canManageCompanyId(company.id!))
        .toList();
    if (editableCompanies.isEmpty) return;
    var companyId = branch?.companyId ?? editableCompanies.first.id!;
    var status = branch?.status ?? 'open';
    await _showEditor(
      title: branch == null ? 'Add branch' : 'Edit branch',
      buildFields: (setDialogState) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<int>(
            initialValue: companyId,
            decoration: const InputDecoration(
              labelText: 'Rental company',
              border: OutlineInputBorder(),
            ),
            items: editableCompanies
                .map(
                  (item) => DropdownMenuItem(
                    value: item.id!,
                    child: Text(item.name),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) setDialogState(() => companyId = value);
            },
          ),
          const SizedBox(height: 12),
          _textField(name, 'Branch name'),
          _textField(city, 'City'),
          _textField(address, 'Street address'),
          _textField(phone, 'Phone', keyboardType: TextInputType.phone),
          _statusDropdown(status, const ['open', 'closed', 'inactive'], (v) {
            if (v != null) setDialogState(() => status = v);
          }),
        ],
      ),
      onSave: () async {
        await client.admin.saveBranch(
          id: branch?.id,
          companyId: companyId,
          name: name.text,
          city: city.text,
          address: address.text,
          phone: phone.text,
          status: status,
        );
      },
    );
  }

  Future<void> _editCar([ManagedCar? car]) async {
    final make = TextEditingController(text: car?.make ?? '');
    final model = TextEditingController(text: car?.model ?? '');
    final year = TextEditingController(
      text: '${car?.year ?? DateTime.now().year}',
    );
    final category = TextEditingController(text: car?.category ?? '');
    final plate = TextEditingController(text: car?.plateNumber ?? '');
    final color = TextEditingController(text: car?.color ?? '');
    final seats = TextEditingController(text: '${car?.seats ?? 5}');
    final rate = TextEditingController(text: '${car?.dailyRate ?? 0}');
    final editableCompanies = _companies
        .where((company) => _canManageCompanyId(company.id!))
        .toList();
    if (editableCompanies.isEmpty) return;
    var companyId = car?.companyId ?? editableCompanies.first.id!;
    var branchId = car?.branchId ?? 0;
    var status = car?.status ?? 'available';
    await _showEditor(
      title: car == null ? 'Add car' : 'Edit car',
      buildFields: (setDialogState) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<int>(
            initialValue: companyId,
            decoration: const InputDecoration(
              labelText: 'Rental company',
              border: OutlineInputBorder(),
            ),
            items: editableCompanies
                .map(
                  (item) => DropdownMenuItem(
                    value: item.id!,
                    child: Text(item.name),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setDialogState(() {
                  companyId = value;
                  if (!_branches.any(
                    (branch) =>
                        branch.id == branchId && branch.companyId == value,
                  )) {
                    branchId = 0;
                  }
                });
              }
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            initialValue: branchId,
            decoration: const InputDecoration(
              labelText: 'Branch (optional)',
              border: OutlineInputBorder(),
            ),
            items: [
              const DropdownMenuItem(value: 0, child: Text('Unassigned')),
              ..._branches
                  .where((branch) => branch.companyId == companyId)
                  .map(
                    (branch) => DropdownMenuItem(
                      value: branch.id!,
                      child: Text(branch.name),
                    ),
                  ),
            ],
            onChanged: (value) {
              if (value != null) setDialogState(() => branchId = value);
            },
          ),
          const SizedBox(height: 12),
          _textField(make, 'Make'),
          _textField(model, 'Model'),
          _textField(year, 'Year', keyboardType: TextInputType.number),
          _textField(category, 'Category'),
          _textField(plate, 'Plate number'),
          _textField(color, 'Color'),
          _textField(seats, 'Seats', keyboardType: TextInputType.number),
          _textField(
            rate,
            'Daily rate (SAR)',
            keyboardType: TextInputType.number,
          ),
          _statusDropdown(
            status,
            const ['available', 'rented', 'maintenance', 'inactive'],
            (v) {
              if (v != null) setDialogState(() => status = v);
            },
          ),
        ],
      ),
      onSave: () async {
        await client.admin.saveCar(
          id: car?.id,
          companyId: companyId,
          branchId: branchId == 0 ? null : branchId,
          make: make.text,
          model: model.text,
          year: int.tryParse(year.text) ?? 0,
          category: category.text,
          plateNumber: plate.text,
          color: color.text,
          seats: int.tryParse(seats.text) ?? 0,
          dailyRate: int.tryParse(rate.text) ?? 0,
          status: status,
        );
      },
    );
  }

  Future<void> _manageImages(ManagedCar car) async {
    final url = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          final images = _images
              .where((image) => image.carId == car.id)
              .toList();
          return AlertDialog(
            title: Text('${car.make} ${car.model} images'),
            content: SizedBox(
              width: 480,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final image in images)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: 54,
                            height: 42,
                            child: Image.network(
                              image.url,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => const ColoredBox(
                                color: _paper,
                                child: Icon(Icons.broken_image_outlined),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          image.url,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 10),
                        ),
                        trailing: IconButton(
                          tooltip: 'Remove image',
                          onPressed: () async {
                            await _run(
                              () => client.admin.deleteCarImage(image.id!),
                            );
                            if (mounted) setDialogState(() {});
                          },
                          icon: const Icon(Icons.delete_outline, size: 18),
                        ),
                      ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: url,
                      decoration: const InputDecoration(
                        labelText: 'Image URL',
                        hintText: 'https://…',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.url,
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FilledButton.icon(
                        onPressed: () async {
                          try {
                            await client.admin.addCarImage(
                              carId: car.id!,
                              url: url.text,
                            );
                            url.clear();
                            await _loadData();
                            if (mounted) setDialogState(() {});
                          } catch (error) {
                            _showMessage(error.toString());
                          }
                        },
                        icon: const Icon(Icons.add_photo_alternate_outlined),
                        label: const Text('Add image link'),
                        style: FilledButton.styleFrom(
                          backgroundColor: _ink,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Done'),
              ),
            ],
          );
        },
      ),
    );
  }
}
