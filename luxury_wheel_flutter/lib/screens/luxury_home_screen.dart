import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxury_wheel_client/luxury_wheel_client.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'admin_dashboard_screen.dart';
import '../client.dart';
import '../utils/booking_dates.dart';
import '../widgets/booking_qr_code.dart';

class LuxuryHomeScreen extends StatefulWidget {
  const LuxuryHomeScreen({super.key});

  @override
  State<LuxuryHomeScreen> createState() => _LuxuryHomeScreenState();
}

class _LuxuryHomeScreenState extends State<LuxuryHomeScreen> {
  static const _ink = Color(0xFF181916);
  static const _paper = Color(0xFFF7F6F1);
  static const _muted = Color(0xFF77786F);
  static const _brass = Color(0xFFB79A62);

  int _tab = 0;
  int _points = 0;
  bool _arabic = false;
  bool _premium = false;
  String _city = 'Riyadh';
  DateTime _pickup = BookingDates.dateOnly(
    DateTime.now().add(const Duration(days: 1)),
  );
  DateTime _return = BookingDates.dateOnly(
    DateTime.now().add(const Duration(days: 4)),
  );
  List<_Car> _cars = [];
  List<RentalReservation> _reservations = [];
  List<ManagedOffer> _liveOffers = [];
  bool _catalogLoading = true;
  String? _catalogError;
  String? _bookingError;
  StreamSubscription<MarketplaceUpdate>? _marketplaceSubscription;
  Timer? _marketplaceRefreshTimer;
  bool _marketplaceRefreshInProgress = false;
  bool _marketplaceStreamActive = false;
  final List<String> _cities = const ['Riyadh', 'Jeddah', 'Dubai'];

  String _text(String english, String arabic) => _arabic ? arabic : english;

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_onAuthenticationChanged);
    _loadCatalog();
    if (client.auth.isAuthenticated) _loadCustomerData();
    _connectMarketplaceStream();
    _marketplaceRefreshTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) {
        if (!_marketplaceStreamActive) _connectMarketplaceStream();
        _refreshMarketplace();
      },
    );
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_onAuthenticationChanged);
    _marketplaceRefreshTimer?.cancel();
    _marketplaceSubscription?.cancel();
    super.dispose();
  }

  void _connectMarketplaceStream() {
    if (_marketplaceStreamActive) return;
    _marketplaceStreamActive = true;
    _marketplaceSubscription = client.rental.watchMarketplaceChanges().listen(
      (_) => _refreshMarketplace(),
      onError: (Object error, StackTrace stackTrace) {
        _marketplaceStreamActive = false;
        debugPrint('Marketplace live updates disconnected: $error');
      },
      onDone: () => _marketplaceStreamActive = false,
    );
  }

  Future<void> _refreshMarketplace() async {
    if (_marketplaceRefreshInProgress || !mounted) return;
    _marketplaceRefreshInProgress = true;
    try {
      await Future.wait([
        _loadCatalog(),
        if (client.auth.isAuthenticated) _loadCustomerData(),
      ]);
    } finally {
      _marketplaceRefreshInProgress = false;
    }
  }

  void _onAuthenticationChanged() {
    if (client.auth.isAuthenticated) {
      _loadCustomerData();
    } else if (mounted) {
      setState(() {
        _reservations = [];
        _points = 0;
      });
    }
  }

  Future<void> _loadCatalog() async {
    try {
      final catalog = await client.rental.listCatalogCars();
      final offers = await client.rental.listActiveOffers();
      if (!mounted) return;
      setState(() {
        _cars = catalog.map(_Car.fromCatalog).toList();
        _liveOffers = offers;
        _catalogError = null;
        _catalogLoading = false;
        final cities = catalog.map((car) => car.city).whereType<String>();
        if (cities.isNotEmpty &&
            !cities.any((city) => city.toLowerCase() == _city.toLowerCase())) {
          _city = cities.first;
        }
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _catalogError = error.toString();
        _catalogLoading = false;
      });
    }
  }

  Future<void> _loadCustomerData() async {
    try {
      final reservations = await client.rental.myReservations();
      final points = await client.rental.myPoints();
      if (!mounted) return;
      setState(() {
        _reservations = reservations;
        _points = points;
        _bookingError = null;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _bookingError = error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _arabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 260),
            child: switch (_tab) {
              0 => _buildDiscover(),
              1 => _buildTrips(),
              2 => _buildRewards(),
              _ => _buildProfile(),
            },
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _tab,
          onDestinationSelected: (value) => setState(() => _tab = value),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.directions_car_outlined),
              selectedIcon: const Icon(Icons.directions_car),
              label: _text('Discover', 'اكتشف'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.confirmation_number_outlined),
              selectedIcon: const Icon(Icons.confirmation_number),
              label: _text('My trips', 'رحلاتي'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.stars_outlined),
              selectedIcon: const Icon(Icons.stars),
              label: _text('Rewards', 'المكافآت'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              selectedIcon: const Icon(Icons.person),
              label: _text('Profile', 'حسابي'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscover() {
    return RefreshIndicator(
      onRefresh: _refreshMarketplace,
      child: CustomScrollView(
        key: const ValueKey('discover'),
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildHero()),
          SliverToBoxAdapter(
            child: _sectionHeading(
              _text('Find your drive', 'ابحث عن سيارتك'),
              _text('START SEARCH', 'ابدأ البحث'),
              onTap: () => _showFleet(),
            ),
          ),
          SliverToBoxAdapter(child: _buildCarRail()),
          SliverToBoxAdapter(child: _buildLocalOffers()),
          SliverToBoxAdapter(child: _buildRewardsBanner()),
          SliverToBoxAdapter(child: _buildSponsors()),
          SliverToBoxAdapter(child: _buildCommunityCard()),
          SliverToBoxAdapter(child: _buildAdPlacement()),
          SliverToBoxAdapter(child: const SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 18),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _ink,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(
              'LW',
              style: GoogleFonts.cormorantGaramond(
                color: _brass,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(width: 11),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LUXURY WHEEL',
                style: GoogleFonts.manrope(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.2,
                ),
              ),
              Text(
                _text('YOUR CITY, YOUR DRIVE', 'مدينتك، رحلتك'),
                style: GoogleFonts.manrope(
                  color: _muted,
                  fontSize: 8,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: _showFleet,
            borderRadius: BorderRadius.circular(24),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.place_outlined, size: 16, color: _brass),
                  const SizedBox(width: 3),
                  Text(
                    _city,
                    style: GoogleFonts.manrope(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(width: 7),
          IconButton(
            tooltip: _text('Refresh marketplace', 'تحديث السيارات'),
            visualDensity: VisualDensity.compact,
            onPressed: _refreshMarketplace,
            icon: const Icon(Icons.refresh, color: _brass, size: 19),
          ),
          IconButton(
            tooltip: _text('Switch language', 'تغيير اللغة'),
            visualDensity: VisualDensity.compact,
            onPressed: () => setState(() => _arabic = !_arabic),
            icon: Text(
              _arabic ? 'EN' : 'ع',
              style: GoogleFonts.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        height: 348,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: _ink,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              right: -52,
              bottom: 10,
              child: Transform.scale(
                scale: 1.12,
                child: SizedBox(
                  width: 360,
                  height: 245,
                  child: _carImage(
                    'https://images.unsplash.com/photo-1563720223185-11003d516935?auto=format&fit=crop&w=1100&q=85',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF181916),
                    Color(0xDD181916),
                    Color(0x00181916),
                    Color(0xAA181916),
                  ],
                  stops: [0, .34, .64, 1],
                ),
              ),
            ),
            Positioned(
              top: 25,
              left: 24,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 22,
                        height: 1,
                        color: _brass,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _text('A BETTER WAY TO ARRIVE', 'طريق أجمل للوصول'),
                        style: GoogleFonts.manrope(
                          color: _brass,
                          fontSize: 9,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  Text(
                    _text('The art of\narriving.', 'فنّ\nالوصول.'),
                    style: GoogleFonts.cormorantGaramond(
                      color: Colors.white,
                      fontSize: 43,
                      height: .92,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _text(
                      'A considered collection. A drive that feels like yours.',
                      'سيارات مختارة بعناية، ورحلة تشبهك.',
                    ),
                    style: GoogleFonts.manrope(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 22,
              right: 22,
              bottom: 18,
              child: Row(
                children: [
                  Expanded(
                    child: _heroPill(
                      Icons.calendar_month_outlined,
                      _text('PICK-UP', 'الاستلام'),
                      _dateLabel(_pickup),
                      () => _chooseDate(isPickup: true),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _heroPill(
                      Icons.event_available_outlined,
                      _text('RETURN', 'الإعادة'),
                      _dateLabel(_return),
                      () => _chooseDate(isPickup: false),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: _brass,
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: _showFleet,
                      child: const SizedBox(
                        height: 62,
                        width: 54,
                        child: Icon(Icons.arrow_forward, color: _ink),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _heroPill(
    IconData icon,
    String label,
    String value,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.white.withValues(alpha: .10),
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          height: 62,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(icon, color: _brass, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      label,
                      style: GoogleFonts.manrope(
                        color: Colors.white60,
                        fontSize: 8,
                        letterSpacing: .8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeading(
    String title,
    String action, {
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 27,
                height: 1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                action,
                style: GoogleFonts.manrope(
                  color: _brass,
                  fontSize: 9,
                  letterSpacing: .8,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarRail() {
    if (_catalogLoading) {
      return const SizedBox(
        height: 150,
        child: Center(child: CircularProgressIndicator(color: _brass)),
      );
    }
    if (_catalogError != null) {
      return SizedBox(
        height: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off_outlined, color: _muted),
              const SizedBox(height: 7),
              Text('Unable to load rental cars.', style: GoogleFonts.manrope()),
              TextButton(
                onPressed: _loadCatalog,
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: _cars.isEmpty ? null : _showFleet,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  height: 54,
                  width: 54,
                  decoration: BoxDecoration(
                    color: _paper,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.tune_rounded,
                    color: _brass,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _cars.isEmpty
                            ? _text(
                                'No cars are available yet',
                                'لا توجد سيارات متاحة حالياً',
                              )
                            : _text(
                                'A car that fits your plans',
                                'سيارة تناسب خططك',
                              ),
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _text(
                          'Choose city → category → daily rate',
                          'اختر المدينة ← الفئة ← السعر اليومي',
                        ),
                        style: GoogleFonts.manrope(
                          color: _muted,
                          fontSize: 10,
                        ),
                      ),
                      if (_cars.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          _text('START SEARCH', 'ابدأ البحث'),
                          style: GoogleFonts.manrope(
                            color: _brass,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: .8,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (_cars.isNotEmpty)
                  const Icon(Icons.arrow_forward, color: _brass, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocalOffers() {
    final offers = [
      _Offer(
        icon: Icons.local_cafe_outlined,
        category: _text('NEARBY CAFÉS', 'مقاهٍ قريبة'),
        title: _text('A little extra with your latte.', 'قهوة بطعم المكافأة.'),
        detail: _text('Up to 20% off · ${_city}', 'خصم حتى ٢٠٪ · $_city'),
        tone: const Color(0xFFE9E3D7),
      ),
      _Offer(
        icon: Icons.spa_outlined,
        category: _text('SALON PRIVILEGES', 'صالونات التجميل'),
        title: _text('Your moment, on us.', 'لحظتك الخاصة.'),
        detail: _text('Selected women’s salons', 'صالونات نسائية مختارة'),
        tone: const Color(0xFFE9E4E0),
      ),
      _Offer(
        icon: Icons.delivery_dining_outlined,
        category: _text('DINING & DELIVERY', 'الطعام والتوصيل'),
        title: _text('Good taste travels.', 'مذاق يرافقك.'),
        detail: _text('Food delivery partner offers', 'عروض شركاء التوصيل'),
        tone: const Color(0xFFE2E8E3),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          _text('The neighbourhood edit', 'اختيارات من حولك'),
          _text('BY CITY', 'حسب المدينة'),
          onTap: _chooseCity,
        ),
        SizedBox(
          height: 174,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            scrollDirection: Axis.horizontal,
            itemCount: offers.length,
            separatorBuilder: (_, _) => const SizedBox(width: 11),
            itemBuilder: (context, index) {
              final offer = offers[index];
              return SizedBox(
                width: 245,
                child: Material(
                  color: offer.tone,
                  borderRadius: BorderRadius.circular(18),
                  child: InkWell(
                    onTap: () => _showOffer(offer),
                    borderRadius: BorderRadius.circular(18),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(offer.icon, size: 17, color: _brass),
                              const SizedBox(width: 7),
                              Text(
                                offer.category,
                                style: GoogleFonts.manrope(
                                  color: _muted,
                                  fontSize: 8,
                                  letterSpacing: .8,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            offer.title,
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 22,
                              height: 1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            offer.detail,
                            style: GoogleFonts.manrope(
                              color: _muted,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRewardsBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 25, 18, 0),
      child: InkWell(
        onTap: () => setState(() => _tab = 2),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _ink,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: _brass.withValues(alpha: .18),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.stars_rounded, color: _brass),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _text('THE WHEEL CIRCLE', 'دائرة العجلة'),
                      style: GoogleFonts.manrope(
                        color: _brass,
                        fontSize: 9,
                        letterSpacing: 1.3,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _text(
                        'Every reservation brings you closer.',
                        'كل حجز يقربك من مكافأة جديدة.',
                      ),
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward, color: Colors.white70, size: 17),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSponsors() {
    final offers = _liveOffers
        .where(
          (offer) =>
              offer.city == null ||
              offer.city!.toLowerCase() == _city.toLowerCase(),
        )
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          _text('In good company', 'شركاؤنا'),
          _text('OUR PARTNERS', 'شركاؤنا'),
        ),
        if (offers.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
            child: Text(
              'Partner discounts and sponsored offers will appear here.',
              style: GoogleFonts.manrope(color: _muted, fontSize: 10),
            ),
          )
        else
          SizedBox(
            height: 126,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              scrollDirection: Axis.horizontal,
              itemCount: offers.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final offer = offers[index];
                final amount = offer.discountType == 'percent'
                    ? '${offer.discountValue}% off'
                    : '${offer.discountValue} SAR off';
                return Container(
                  width: 280,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      if (offer.sponsorImageUrl?.isNotEmpty == true)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            offer.sponsorImageUrl!,
                            width: 68,
                            height: 68,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => const Icon(
                              Icons.local_offer_outlined,
                              color: _brass,
                              size: 32,
                            ),
                          ),
                        )
                      else
                        const Icon(Icons.local_offer_outlined, color: _brass),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              offer.sponsorName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.manrope(
                                color: _muted,
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              offer.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              amount,
                              style: GoogleFonts.manrope(
                                color: _brass,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildCommunityCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 26, 18, 0),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFE9E3D7),
          borderRadius: BorderRadius.circular(19),
        ),
        child: Row(
          children: [
            const Icon(Icons.auto_awesome_outlined, color: _brass, size: 25),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _text('THE WHEEL JOURNAL', 'مجلة العجلة'),
                    style: GoogleFonts.manrope(
                      color: _muted,
                      fontSize: 8,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _text(
                      'The people who make the journey.',
                      'حكايات من يجعلون الرحلة أجمل.',
                    ),
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    _text(
                      'Stories, city guides & creator picks',
                      'قصص وأدلة المدينة',
                    ),
                    style: GoogleFonts.manrope(color: _muted, fontSize: 9),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: _text('Share Luxury Wheel', 'مشاركة لوكشري ويل'),
              onPressed: () => _share('Luxury Wheel'),
              icon: const Icon(Icons.ios_share, size: 17),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdPlacement() {
    if (_premium) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE8E6DE)),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Row(
          children: [
            const Icon(Icons.campaign_outlined, color: _brass, size: 23),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _text('PARTNER SPOTLIGHT', 'من شركائنا'),
                    style: GoogleFonts.manrope(
                      color: _muted,
                      fontSize: 8,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    _text(
                      'Discover a little more nearby.',
                      'اكتشف المزيد بالقرب منك.',
                    ),
                    style: GoogleFonts.manrope(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => setState(() => _tab = 3),
              child: Text(
                _text('AD-FREE', 'بلا إعلانات'),
                style: GoogleFonts.manrope(
                  color: _brass,
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrips() {
    final recentReservations = [..._reservations]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return _standardPage(
      _text('My journeys', 'رحلاتي'),
      _text('A good drive is worth remembering.', 'رحلة جميلة تستحق أن تُحفظ.'),
      !client.auth.isAuthenticated
          ? Column(
              children: [
                _emptyState(
                  Icons.lock_outline,
                  _text(
                    'Sign in to see your bookings.',
                    'سجّل الدخول لعرض حجوزاتك.',
                  ),
                  _text(
                    'Your booking details and approval status are private to your account.',
                    'تفاصيل حجوزاتك وحالة الموافقة خاصة بحسابك.',
                  ),
                  _text('GO TO PROFILE', 'الانتقال إلى الحساب'),
                  () => setState(() => _tab = 3),
                ),
                const SizedBox(height: 12),
                SignInWidget(
                  client: client,
                  onAuthenticated: _loadCustomerData,
                  onError: (error) => _showMessage('Sign in failed: $error'),
                ),
              ],
            )
          : _bookingError != null
          ? Column(
              children: [
                Text(_bookingError!, style: GoogleFonts.manrope(color: _muted)),
                TextButton(
                  onPressed: _loadCustomerData,
                  child: const Text('Try again'),
                ),
              ],
            )
          : _reservations.isEmpty
          ? _emptyState(
              Icons.route_outlined,
              _text(
                'No bookings yet.',
                'لا توجد حجوزات بعد.',
              ),
              _text(
                'When you book a car, its details and approval status will appear here.',
                'ستظهر تفاصيل السيارة وحالة الموافقة هنا بعد الحجز.',
              ),
              _text('EXPLORE CARS', 'اكتشف السيارات'),
              () => setState(() => _tab = 0),
            )
          : Column(
              children: [
                for (final reservation in recentReservations)
                  _reservationTile(reservation),
              ],
            ),
      action: client.auth.isAuthenticated
          ? IconButton(
              tooltip: 'Refresh bookings',
              onPressed: _loadCustomerData,
              icon: const Icon(Icons.refresh, color: _brass),
            )
          : null,
    );
  }

  Widget _buildRewards() {
    return _standardPage(
      _text('The Wheel Circle', 'دائرة العجلة'),
      _text('Your loyalty has its own perks.', 'ولاؤك له مكافآته.'),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: _ink,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.stars_rounded, color: _brass, size: 27),
                const SizedBox(height: 18),
                Text(
                  '$_points',
                  style: GoogleFonts.cormorantGaramond(
                    color: Colors.white,
                    fontSize: 52,
                    height: 1,
                  ),
                ),
                Text(
                  _text('POINTS AVAILABLE', 'نقطة متاحة'),
                  style: GoogleFonts.manrope(
                    color: _brass,
                    fontSize: 9,
                    letterSpacing: 1.7,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  _text(
                    'Earn 1 point for every 10 SAR on approved bookings.',
                    'اكسب نقطة واحدة مقابل كل ١٠ ريالات عند الموافقة على الحجز.',
                  ),
                  style: GoogleFonts.manrope(
                    color: Colors.white70,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 21),
          Text(
            _text('A few ways to use them', 'طرق للاستفادة من نقاطك'),
            style: GoogleFonts.cormorantGaramond(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _benefit(
            Icons.directions_car_outlined,
            _text('REDEEM ON YOUR NEXT BOOKING', 'استبدلها في حجزك القادم'),
            _text(
              'Every 100 points gives you 10 SAR off. Apply points when requesting a booking.',
              'كل ١٠٠ نقطة تمنحك خصم ١٠ ريالات. استخدم نقاطك عند طلب الحجز.',
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => setState(() => _tab = 0),
              icon: const Icon(Icons.directions_car_outlined),
              label: Text(
                _text('BOOK & REDEEM POINTS', 'احجز واستبدل نقاطك'),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: _ink,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _outlinedAction(
            _text('TAKE A QUICK SURVEY', 'شاركنا رأيك'),
            _showSurvey,
          ),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return _standardPage(
      _text('Your account', 'حسابك'),
      _text('A few things, all in one place.', 'كل ما يهمك في مكان واحد.'),
      Column(
        children: [
          Container(
            padding: const EdgeInsets.all(19),
            decoration: BoxDecoration(
              color: _ink,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 23,
                  backgroundColor: Color(0xFF36362F),
                  child: Icon(Icons.person_outline, color: _brass),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        client.auth.isAuthenticated
                            ? _text('Welcome back.', 'مرحباً بعودتك.')
                            : _text(
                                'Welcome to the good life.',
                                'أهلاً بك في عالم الرفاهية.',
                              ),
                        style: GoogleFonts.cormorantGaramond(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        client.auth.isAuthenticated
                            ? _text(
                                'Your booking account is active.',
                                'حساب حجوزاتك نشط.',
                              )
                            : _text(
                                'Sign in to request and track bookings.',
                                'سجّل الدخول لطلب الحجوزات ومتابعتها.',
                              ),
                        style: GoogleFonts.manrope(
                          color: Colors.white60,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          if (client.auth.isAuthenticated)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () async {
                  await client.auth.signOutDevice();
                  if (mounted) setState(() {});
                },
                icon: const Icon(Icons.logout, size: 16),
                label: Text(_text('Sign out', 'تسجيل الخروج')),
              ),
            )
          else
            SignInWidget(
              client: client,
              onAuthenticated: () {
                _loadCustomerData();
                if (mounted) setState(() {});
              },
              onError: (error) => _showMessage('Sign in failed: $error'),
            ),
          const SizedBox(height: 12),
          _profileAction(
            Icons.admin_panel_settings_outlined,
            _text('Admin workspace', 'لوحة الإدارة'),
            _text(
              'Sign in with an administrator account',
              'سجّل الدخول بحساب مسؤول',
            ),
            () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const AdminDashboardScreen(),
              ),
            ),
          ),
          _profileAction(
            Icons.workspace_premium_outlined,
            _text('Wheel Circle Premium', 'عضوية دائرة العجلة المميزة'),
            _premium
                ? _text(
                    'Active · ad-free experience',
                    'مفعّلة · تجربة بلا إعلانات',
                  )
                : _text(
                    'An ad-free drive, and more',
                    'تجربة بلا إعلانات ومزايا أخرى',
                  ),
            () => _showPremium(),
          ),
          _profileAction(
            Icons.assignment_return_outlined,
            _text('Return policy', 'سياسة الإعادة'),
            _text(
              'Changes, cancellations & returns',
              'التعديلات والإلغاء والإعادة',
            ),
            () => _showLegal('return'),
          ),
          _profileAction(
            Icons.shield_outlined,
            _text('Insurance agreement', 'اتفاقية التأمين'),
            _text(
              'Coverage overview & requirements',
              'ملخص التغطية والمتطلبات',
            ),
            () => _showLegal('insurance'),
          ),
          _profileAction(
            Icons.lock_outline,
            _text('Privacy & non-disclosure', 'الخصوصية وعدم الإفصاح'),
            _text('How your information is handled', 'كيف نتعامل مع معلوماتك'),
            () => _showLegal('privacy'),
          ),
          _profileAction(
            Icons.support_agent_outlined,
            _text('WhatsApp & social', 'واتساب والتواصل الاجتماعي'),
            _text(
              'Contact details are being set up',
              'يجري إعداد بيانات التواصل',
            ),
            _showContact,
          ),
          _profileAction(
            Icons.language_outlined,
            _text('Language', 'اللغة'),
            _arabic ? 'العربية' : 'English',
            () => setState(() => _arabic = !_arabic),
          ),
          _profileAction(
            Icons.rate_review_outlined,
            _text('Share your experience', 'شاركنا تجربتك'),
            _text('A short satisfaction survey', 'استبيان رضا قصير'),
            _showSurvey,
          ),
          const SizedBox(height: 24),
          Text(
            _text(
              'Luxury Wheel · Made for the long way round.',
              'لوكشري ويل · رحلة أجمل في كل طريق.',
            ),
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(color: _muted, fontSize: 9),
          ),
        ],
      ),
    );
  }

  Widget _standardPage(
    String title,
    String subtitle,
    Widget child, {
    Widget? action,
  }) {
    return ListView(
      key: ValueKey(title),
      padding: const EdgeInsets.fromLTRB(22, 23, 22, 32),
      children: [
        Row(
          children: [
            Text(
              'LW',
              style: GoogleFonts.cormorantGaramond(
                color: _brass,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.3,
              ),
            ),
            const Spacer(),
            Text(
              _city.toUpperCase(),
              style: GoogleFonts.manrope(
                color: _muted,
                fontSize: 9,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 38,
                  height: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (action != null) action,
          ],
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: GoogleFonts.manrope(color: _muted, fontSize: 11),
        ),
        const SizedBox(height: 24),
        child,
      ],
    );
  }

  Widget _emptyState(
    IconData icon,
    String title,
    String detail,
    String action,
    VoidCallback onTap,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, color: _brass, size: 31),
          const SizedBox(height: 13),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            detail,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(color: _muted, fontSize: 10),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: onTap,
            style: FilledButton.styleFrom(backgroundColor: _ink),
            child: Text(
              action,
              style: GoogleFonts.manrope(
                fontSize: 9,
                letterSpacing: .8,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reservationTile(RentalReservation reservation) {
    final status = reservation.status;
    final statusColor = switch (status) {
      'approved' => const Color(0xFF2E7D32),
      'rejected' || 'cancelled' => Colors.red.shade700,
      _ => _brass,
    };
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: () => _showReservationDetails(reservation),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  if (reservation.carImageUrl?.isNotEmpty == true)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        reservation.carImageUrl!,
                        width: 63,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    const Icon(
                      Icons.directions_car_filled_outlined,
                      color: _brass,
                      size: 34,
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reservation.carName,
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '${reservation.companyName ?? ''} · ${reservation.branchName ?? ''}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(
                            color: _muted,
                            fontSize: 9,
                          ),
                        ),
                        Text(
                          '${_dateLabel(reservation.pickupDate)} — ${_dateLabel(reservation.returnDate)} · ${reservation.city}',
                          style: GoogleFonts.manrope(
                            color: _muted,
                            fontSize: 9,
                          ),
                        ),
                        if (reservation.pointsDiscount > 0)
                          Text(
                            '${reservation.pointsRedeemed} points redeemed · ${reservation.pointsDiscount} SAR off',
                            style: GoogleFonts.manrope(
                              color: _brass,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        const SizedBox(height: 4),
                        Text(
                          status == 'approved'
                              ? 'Approved'
                              : status == 'rejected'
                              ? 'Rejected'
                              : status == 'cancelled'
                              ? 'Canceled'
                              : 'Awaiting company approval',
                          style: GoogleFonts.manrope(
                            color: statusColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip:
                        'Show booking QR for ${reservation.bookingReference}',
                    onPressed: () => _showReservationDetails(reservation),
                    icon: const Icon(Icons.qr_code_2, color: _brass),
                  ),
                ],
              ),
              if ((status == 'rejected' || status == 'cancelled') &&
                  reservation.statusReason?.trim().isNotEmpty == true) ...[
                const SizedBox(height: 10),
                _bookingNotice(
                  title: status == 'rejected'
                      ? 'Rejected by the rental company'
                      : reservation.statusReason == 'Canceled by you.'
                      ? 'Canceled by you'
                      : 'Canceled by the rental company',
                  message: reservation.statusReason!,
                  color: Colors.red.shade700,
                ),
              ],
              if (status == 'requested') ...[
                const SizedBox(height: 8),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton.icon(
                    key: ValueKey('cancel-booking-${reservation.id}'),
                    onPressed: () => _cancelMyReservation(reservation),
                    icon: const Icon(Icons.cancel_outlined, size: 17),
                    label: const Text('Cancel request'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red.shade700,
                    ),
                  ),
                ),
              ],
              if (reservation.adjustmentStatus != 'none' &&
                  reservation.adjustmentReason?.trim().isNotEmpty == true) ...[
                const SizedBox(height: 10),
                _bookingNotice(
                  title: switch (reservation.adjustmentStatus) {
                    'pending' => 'Change requested — your response is needed',
                    'accepted' => 'You accepted the proposed change',
                    'declined' => 'You declined the proposed change',
                    _ => 'Booking change',
                  },
                  message:
                      '${reservation.adjustmentReason}\n'
                      'Proposed: ${reservation.proposedPickupDate == null ? '' : _dateLabel(reservation.proposedPickupDate!)} — '
                      '${reservation.proposedReturnDate == null ? '' : _dateLabel(reservation.proposedReturnDate!)}'
                      '${reservation.proposedTotalPrice == null ? '' : ' · ${reservation.proposedTotalPrice} SAR'}',
                  color: _brass,
                ),
              ],
              if (reservation.adjustmentStatus == 'pending') ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  alignment: WrapAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () =>
                          _respondToAdjustment(reservation, accept: false),
                      child: const Text('Decline change'),
                    ),
                    FilledButton(
                      onPressed: () =>
                          _respondToAdjustment(reservation, accept: true),
                      style: FilledButton.styleFrom(
                        backgroundColor: _ink,
                      ),
                      child: const Text('Accept change'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _bookingNotice({
    required String title,
    required String message,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: GoogleFonts.manrope(color: _ink, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Future<void> _respondToAdjustment(
    RentalReservation reservation, {
    required bool accept,
  }) async {
    try {
      await client.rental.respondToReservationChange(
        reservation.id!,
        accept,
      );
      await _loadCustomerData();
      _showMessage(
        accept
            ? 'Booking change accepted.'
            : 'Booking change declined. Your original booking remains active.',
      );
    } catch (error) {
      _showMessage('Could not respond to booking change: $error');
    }
  }

  Future<void> _cancelMyReservation(RentalReservation reservation) async {
    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cancel booking request?'),
        content: const Text(
          'You can cancel a booking only while it is awaiting company approval.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Keep request'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.shade700,
            ),
            child: const Text('Cancel request'),
          ),
        ],
      ),
    );
    if (shouldCancel != true) return;

    try {
      await client.rental.cancelMyReservation(reservation.id!);
      await _loadCustomerData();
      _showMessage('Your booking request was canceled.');
    } catch (error) {
      _showMessage('Could not cancel booking request: $error');
    }
  }

  void _showReservationDetails(RentalReservation reservation) {
    showDialog<void>(
      context: context,
      builder: (_) => BookingQrDialog(
        title: reservation.carName,
        bookingReference: reservation.bookingReference,
        details: [
          Text(
            '${reservation.companyName ?? ''} · ${reservation.branchName ?? ''}, ${reservation.city}',
            textAlign: TextAlign.center,
          ),
          Text(
            '${_dateLabel(reservation.pickupDate)} — ${_dateLabel(reservation.returnDate)}',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Status: ${reservation.status == 'requested' ? 'Awaiting approval' : reservation.status}',
            style: GoogleFonts.manrope(
              color: reservation.status == 'approved'
                  ? Colors.green.shade700
                  : reservation.status == 'rejected'
                  ? Colors.red.shade700
                  : _brass,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'Total: ${reservation.totalPrice} SAR · no payment collected',
            textAlign: TextAlign.center,
          ),
          if (reservation.pointsDiscount > 0)
            Text(
              'Points redeemed: ${reservation.pointsRedeemed} · Discount: ${reservation.pointsDiscount} SAR',
              textAlign: TextAlign.center,
            ),
          if (reservation.statusReason?.trim().isNotEmpty == true) ...[
            const SizedBox(height: 8),
            Text(
              'Reason: ${reservation.statusReason}',
              textAlign: TextAlign.center,
            ),
          ],
          if (reservation.adjustmentReason?.trim().isNotEmpty == true) ...[
            const SizedBox(height: 8),
            Text(
              'Change note: ${reservation.adjustmentReason}',
              textAlign: TextAlign.center,
            ),
            if (reservation.proposedPickupDate != null &&
                reservation.proposedReturnDate != null &&
                reservation.proposedTotalPrice != null)
              Text(
                'Proposed: ${_dateLabel(reservation.proposedPickupDate!)} — '
                '${_dateLabel(reservation.proposedReturnDate!)} · '
                '${reservation.proposedTotalPrice} SAR',
                textAlign: TextAlign.center,
              ),
          ],
        ],
      ),
    );
  }

  Widget _benefit(IconData icon, String title, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, size: 19, color: _brass),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  detail,
                  style: GoogleFonts.manrope(color: _muted, fontSize: 9),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 18, color: _muted),
        ],
      ),
    );
  }

  Widget _profileAction(
    IconData icon,
    String title,
    String detail,
    VoidCallback onTap,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      leading: Container(
        height: 39,
        width: 39,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(icon, color: _brass, size: 19),
      ),
      title: Text(
        title,
        style: GoogleFonts.manrope(fontSize: 11, fontWeight: FontWeight.w800),
      ),
      subtitle: Text(
        detail,
        style: GoogleFonts.manrope(color: _muted, fontSize: 9),
      ),
      trailing: const Icon(Icons.chevron_right, color: _muted, size: 18),
      onTap: onTap,
    );
  }

  Widget _outlinedAction(String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 49,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: _ink,
          side: const BorderSide(color: _brass),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 9,
            letterSpacing: .8,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .92),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.manrope(
          fontSize: 8,
          letterSpacing: .6,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _carImage(
    String url, {
    BoxFit fit = BoxFit.cover,
    Alignment alignment = Alignment.center,
  }) {
    return Image.network(
      url,
      fit: fit,
      alignment: alignment,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: const Color(0xFFE9E7E1),
          alignment: Alignment.center,
          child: const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              color: _brass,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => Container(
        color: const Color(0xFFE9E7E1),
        alignment: Alignment.center,
        child: const Icon(Icons.directions_car, color: _brass, size: 50),
      ),
    );
  }

  void _showFleet() {
    final availableCities = {
      ..._cities,
      ..._cars.map((car) => car.city).whereType<String>(),
    }.toList()..sort();
    var step = 0;
    var selectedCity = _city;
    String? selectedCategory;
    var rateRange = const RangeValues(0, 1);

    List<_Car> carsInCity(String city) => _cars
        .where(
          (car) =>
              car.city == null || car.city!.toLowerCase() == city.toLowerCase(),
        )
        .toList();

    List<_Car> carsInCategory() => carsInCity(
      selectedCity,
    ).where((car) => car.category == selectedCategory).toList();

    showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setSheetState) {
          final cityCars = carsInCity(selectedCity);
          final categories =
              cityCars.map((car) => car.category).toSet().toList()..sort();
          final categoryCars = carsInCategory();
          final rates = categoryCars.map((car) => car.rate).toList();
          final minRate = rates.isEmpty
              ? 0.0
              : rates.reduce((a, b) => a < b ? a : b).toDouble();
          final maxRate = rates.isEmpty
              ? 1.0
              : rates.reduce((a, b) => a > b ? a : b).toDouble();
          final sliderMin = minRate == maxRate
              ? (minRate > 0 ? minRate - 1 : 0.0)
              : minRate;
          final sliderMax = minRate == maxRate ? maxRate + 1 : maxRate;
          final filteredCars = categoryCars
              .where(
                (car) =>
                    car.rate >= rateRange.start && car.rate <= rateRange.end,
              )
              .toList();

          return Dialog.fullscreen(
            backgroundColor: _paper,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(19, 16, 19, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        if (step > 0)
                          IconButton(
                            tooltip: _text('Back', 'رجوع'),
                            onPressed: () => setSheetState(
                              () => step = step == 3 ? 2 : step - 1,
                            ),
                            icon: const Icon(Icons.arrow_back),
                          ),
                        Expanded(
                          child: Text(
                            _text(
                              step == 0
                                  ? 'Choose your city'
                                  : step == 1
                                  ? 'Choose a category'
                                  : step == 2
                                  ? 'Set your daily budget'
                                  : 'Cars for you',
                              step == 0
                                  ? 'اختر مدينتك'
                                  : step == 1
                                  ? 'اختر الفئة'
                                  : step == 2
                                  ? 'حدد ميزانيتك اليومية'
                                  : 'سيارات تناسبك',
                            ),
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: _text('Close', 'إغلاق'),
                          onPressed: () => Navigator.pop(dialogContext),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    Text(
                      _text(
                        'STEP ${step < 3 ? step + 1 : 3} OF 3',
                        'الخطوة ${step < 3 ? step + 1 : 3} من ٣',
                      ),
                      style: GoogleFonts.manrope(
                        color: _brass,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Expanded(
                      child: SingleChildScrollView(
                        child: switch (step) {
                          0 => Column(
                            children: [
                              for (final city in availableCities)
                                Card(
                                  color: selectedCity == city
                                      ? const Color(0xFFF0EBDD)
                                      : Colors.white,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.location_on_outlined,
                                      color: _brass,
                                    ),
                                    title: Text(city),
                                    subtitle: Text(
                                      '${carsInCity(city).length} ${_text('cars available', 'سيارات متاحة')}',
                                    ),
                                    trailing: selectedCity == city
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: _brass,
                                          )
                                        : null,
                                    onTap: () => setSheetState(() {
                                      selectedCity = city;
                                      selectedCategory = null;
                                    }),
                                  ),
                                ),
                            ],
                          ),
                          1 =>
                            categories.isEmpty
                                ? Center(
                                    child: Text(
                                      _text(
                                        'No cars are listed in $selectedCity yet.',
                                        'لا توجد سيارات مدرجة في $selectedCity حالياً.',
                                      ),
                                      style: GoogleFonts.manrope(color: _muted),
                                    ),
                                  )
                                : Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      for (final category in categories)
                                        ChoiceChip(
                                          label: Text(category),
                                          selected:
                                              selectedCategory == category,
                                          onSelected: (_) => setSheetState(() {
                                            selectedCategory = category;
                                            final categoryRates =
                                                carsInCategory()
                                                    .map((car) => car.rate)
                                                    .toList();
                                            final low = categoryRates
                                                .reduce((a, b) => a < b ? a : b)
                                                .toDouble();
                                            final high = categoryRates
                                                .reduce((a, b) => a > b ? a : b)
                                                .toDouble();
                                            rateRange = RangeValues(
                                              low,
                                              high,
                                            );
                                          }),
                                        ),
                                    ],
                                  ),
                          2 =>
                            rates.isEmpty
                                ? Center(
                                    child: Text(
                                      _text(
                                        'Choose a category to see its daily rates.',
                                        'اختر فئة لعرض أسعارها اليومية.',
                                      ),
                                      style: GoogleFonts.manrope(color: _muted),
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        _text(
                                          'Daily rate range',
                                          'نطاق السعر اليومي',
                                        ),
                                        style: GoogleFonts.manrope(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '${rateRange.start.round()} – ${rateRange.end.round()} SAR / day',
                                        style: GoogleFonts.manrope(
                                          color: _brass,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      RangeSlider(
                                        values: rateRange,
                                        min: sliderMin,
                                        max: sliderMax,
                                        divisions:
                                            ((sliderMax - sliderMin) * 10)
                                                .round()
                                                .clamp(1, 1000),
                                        activeColor: _brass,
                                        labels: RangeLabels(
                                          '${rateRange.start.round()} SAR',
                                          '${rateRange.end.round()} SAR',
                                        ),
                                        onChanged: (value) => setSheetState(
                                          () => rateRange = value,
                                        ),
                                      ),
                                      Text(
                                        _text(
                                          '$selectedCategory cars in $selectedCity',
                                          'سيارات $selectedCategory في $selectedCity',
                                        ),
                                        style: GoogleFonts.manrope(
                                          color: _muted,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                          _ =>
                            filteredCars.isEmpty
                                ? Center(
                                    child: Text(
                                      _text(
                                        'No cars match this budget. Go back to adjust your range.',
                                        'لا توجد سيارات ضمن هذه الميزانية. ارجع لتعديل النطاق.',
                                      ),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.manrope(color: _muted),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      for (final car in filteredCars)
                                        Card(
                                          color: Colors.white,
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 4,
                                                ),
                                            leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: SizedBox(
                                                width: 64,
                                                height: 48,
                                                child: _carImage(car.image),
                                              ),
                                            ),
                                            title: Text(
                                              car.name,
                                              style: GoogleFonts.manrope(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            subtitle: Text(
                                              '${car.companyName} · ${car.branchName ?? 'Branch not assigned'} · ${car.rate} SAR / day',
                                              style: GoogleFonts.manrope(
                                                color: _muted,
                                                fontSize: 9,
                                              ),
                                            ),
                                            trailing: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 13,
                                            ),
                                            onTap: () {
                                              setState(
                                                () => _city = selectedCity,
                                              );
                                              Navigator.pop(dialogContext);
                                              Future<void>.delayed(
                                                Duration.zero,
                                                () {
                                                  if (mounted) {
                                                    _showCarDetails(car);
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (step < 3)
                      FilledButton(
                        onPressed:
                            step == 1 && selectedCategory == null ||
                                step == 2 && selectedCategory == null ||
                                step == 1 && categories.isEmpty
                            ? null
                            : () => setSheetState(() => step++),
                        style: FilledButton.styleFrom(
                          backgroundColor: _ink,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(
                          _text(
                            step == 2 ? 'Show matching cars' : 'Continue',
                            step == 2 ? 'عرض السيارات المطابقة' : 'متابعة',
                          ),
                        ),
                      )
                    else
                      OutlinedButton(
                        onPressed: () => setSheetState(() => step = 2),
                        child: Text(
                          _text('Adjust daily rate', 'تعديل السعر اليومي'),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCarDetails(_Car car) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: _paper,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 17, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  height: 185,
                  width: double.infinity,
                  child: _carImage(car.image),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                car.name,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${car.companyName} · ${car.branchName} · ${car.city}',
                style: GoogleFonts.manrope(color: _muted, fontSize: 10),
              ),
              if (car.description?.isNotEmpty == true) ...[
                const SizedBox(height: 8),
                Text(
                  car.description!,
                  style: GoogleFonts.manrope(color: _muted, fontSize: 10),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                '${car.color ?? ''} · ${car.seats} ${_text('seats', 'مقاعد')} · ${car.year}',
                style: GoogleFonts.manrope(color: _muted, fontSize: 10),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '${car.rate} SAR',
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    _text(' / day', ' / يوم'),
                    style: GoogleFonts.manrope(color: _muted, fontSize: 10),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => _share(car.name),
                    icon: const Icon(Icons.ios_share, size: 14),
                    label: Text(
                      _text('Share', 'مشاركة'),
                      style: GoogleFonts.manrope(fontSize: 10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              if (car.branchId == null)
                Text(
                  'A rental branch must be assigned before bookings can be requested.',
                  style: GoogleFonts.manrope(color: _muted, fontSize: 10),
                )
              else
                _outlinedAction(
                  _text('REVIEW TERMS & RESERVE', 'راجع الشروط واحجز'),
                  () {
                    Navigator.pop(context);
                    _showReservation(car);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showReservation(_Car car) {
    if (!client.auth.isAuthenticated) {
      setState(() => _tab = 3);
      _showMessage('Sign in to place a booking request.');
      return;
    }
    if (car.managedCarId == null || car.branchId == null) {
      _showMessage('This car is not connected to a bookable rental branch.');
      return;
    }
    var termsAccepted = false;
    var submitting = false;
    var pointsToRedeem = 0;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: _paper,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setSheetState) {
          final days = BookingDates.daysBetween(_pickup, _return).clamp(
            1,
            BookingDates.maxRentalDays,
          );
          final total = days * car.rate;
          final maxRedeemablePoints =
              (_points < (total ~/ 10) * 100 ? _points : (total ~/ 10) * 100) ~/
              100 *
              100;
          final selectedPoints = pointsToRedeem > maxRedeemablePoints
              ? maxRedeemablePoints
              : pointsToRedeem;
          final pointsDiscount = selectedPoints ~/ 10;
          final discountedTotal = total - pointsDiscount;
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                18,
                20,
                20 + MediaQuery.viewInsetsOf(context).bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _text('Your reservation', 'تفاصيل الحجز'),
                          style: GoogleFonts.cormorantGaramond(fontSize: 29),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  Text(
                    car.name,
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 13),
                  Row(
                    children: [
                      Expanded(
                        child: _dateTile(
                          _text('PICK-UP', 'الاستلام'),
                          _dateLabel(_pickup),
                          () async {
                            await _chooseDate(isPickup: true);
                            setSheetState(() {});
                          },
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: _dateTile(
                          _text('RETURN', 'الإعادة'),
                          _dateLabel(_return),
                          () async {
                            await _chooseDate(isPickup: false);
                            setSheetState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        _text(
                          '$days day${days == 1 ? '' : 's'} · $discountedTotal SAR',
                          '$days أيام · $discountedTotal ر.س',
                        ),
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Payment is not collected now',
                        style: GoogleFonts.manrope(
                          color: _muted,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  if (maxRedeemablePoints >= 100) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: const Color(0xFFE8E6DE)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _text(
                                    'Redeem points',
                                    'استبدال النقاط',
                                  ),
                                  style: GoogleFonts.manrope(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Text(
                                '$selectedPoints / $_points',
                                style: GoogleFonts.manrope(
                                  color: _muted,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: selectedPoints.toDouble(),
                            min: 0,
                            max: maxRedeemablePoints.toDouble(),
                            divisions: maxRedeemablePoints ~/ 100,
                            activeColor: _brass,
                            onChanged: (value) => setSheetState(
                              () =>
                                  pointsToRedeem = (value.round() ~/ 100) * 100,
                            ),
                          ),
                          Text(
                            _text(
                              selectedPoints == 0
                                  ? '100 points = 10 SAR off · $total SAR before discount'
                                  : '$selectedPoints points save $pointsDiscount SAR · total $discountedTotal SAR',
                              selectedPoints == 0
                                  ? '١٠٠ نقطة = خصم ١٠ ريالات · الإجمالي قبل الخصم $total ر.س'
                                  : 'خصم $pointsDiscount ر.س مقابل $selectedPoints نقطة · الإجمالي $discountedTotal ر.س',
                            ),
                            style: GoogleFonts.manrope(
                              color: _muted,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else if (_points >= 100)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        _text(
                          'This booking total is too low to apply a 100-point reward.',
                          'قيمة هذا الحجز أقل من الحد اللازم لاستبدال ١٠٠ نقطة.',
                        ),
                        style: GoogleFonts.manrope(
                          color: _muted,
                          fontSize: 9,
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        _text(
                          'Earn points on approved bookings. You need at least 100 points to redeem.',
                          'اكسب النقاط عند الموافقة على الحجز. تحتاج إلى ١٠٠ نقطة على الأقل للاستبدال.',
                        ),
                        style: GoogleFonts.manrope(
                          color: _muted,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  const SizedBox(height: 7),
                  Wrap(
                    spacing: 1,
                    runSpacing: 0,
                    children: [
                      TextButton(
                        onPressed: () => _showLegal('return'),
                        child: Text(
                          _text('Return policy', 'سياسة الإعادة'),
                          style: GoogleFonts.manrope(fontSize: 9),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _showLegal('insurance'),
                        child: Text(
                          _text('Insurance', 'التأمين'),
                          style: GoogleFonts.manrope(fontSize: 9),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _showLegal('privacy'),
                        child: Text(
                          _text('Privacy & NDA', 'الخصوصية'),
                          style: GoogleFonts.manrope(fontSize: 9),
                        ),
                      ),
                    ],
                  ),
                  CheckboxListTile(
                    value: termsAccepted,
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: _brass,
                    title: Text(
                      _text(
                        'I have reviewed the rental, return and insurance terms.',
                        'اطلعت على شروط الإيجار والإعادة والتأمين.',
                      ),
                      style: GoogleFonts.manrope(fontSize: 9),
                    ),
                    onChanged: (value) => setSheetState(
                      () => termsAccepted = value ?? false,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 49,
                    child: FilledButton(
                      onPressed: termsAccepted && !submitting
                          ? () async {
                              setSheetState(() => submitting = true);
                              try {
                                final reservation = await client.rental
                                    .reserveWithPoints(
                                      car.managedCarId!,
                                      car.branchId!,
                                      _pickup,
                                      _return,
                                      selectedPoints,
                                    );
                                if (!mounted) return;
                                Navigator.pop(sheetContext);
                                await _loadCustomerData();
                                _showBookingConfirmation(reservation);
                              } catch (error) {
                                setSheetState(() => submitting = false);
                                _showMessage('Could not place booking: $error');
                              }
                            }
                          : null,
                      style: FilledButton.styleFrom(
                        backgroundColor: _ink,
                        disabledBackgroundColor: _ink.withValues(alpha: .25),
                      ),
                      child: submitting
                          ? const SizedBox(
                              width: 19,
                              height: 19,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              _text('REQUEST BOOKING', 'طلب الحجز'),
                              style: GoogleFonts.manrope(
                                fontSize: 9,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _text(
                      'Your booking is pending the rental company’s approval. No payment is collected.',
                      'الحجز بانتظار موافقة شركة التأجير. لن يتم تحصيل أي مبلغ.',
                    ),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(color: _muted, fontSize: 8),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _dateTile(String label, String date, VoidCallback onTap) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.manrope(
                  color: _muted,
                  fontSize: 8,
                  letterSpacing: .8,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBookingConfirmation(RentalReservation reservation) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _paper,
        icon: const Icon(Icons.check_circle_outline, color: _brass, size: 37),
        title: Text(
          _text('Booking request received.', 'تم استلام طلب الحجز.'),
          textAlign: TextAlign.center,
          style: GoogleFonts.cormorantGaramond(fontSize: 28),
        ),
        content: Text(
          _text(
            '${reservation.carName} is awaiting approval from ${reservation.companyName ?? 'the rental company'}. Reference: ${reservation.bookingReference}. No payment was collected.',
            'حجز ${reservation.carName} بانتظار موافقة شركة التأجير. رقم الحجز: ${reservation.bookingReference}. لم يتم تحصيل أي مبلغ.',
          ),
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(fontSize: 11),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _tab = 1);
            },
            child: Text(_text('VIEW MY TRIPS', 'عرض رحلاتي')),
          ),
        ],
      ),
    );
  }

  void _showPremium() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: _paper,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(23, 25, 23, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.workspace_premium_outlined,
                color: _brass,
                size: 34,
              ),
              const SizedBox(height: 12),
              Text(
                _text('The quieter way to travel.', 'رحلتك، بلا إعلانات.'),
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(fontSize: 28),
              ),
              const SizedBox(height: 7),
              Text(
                _text(
                  'Wheel Circle Premium is planned to include an ad-free experience and member privileges. Subscription checkout will be available once configured.',
                  'عضوية دائرة العجلة المميزة قيد الإعداد، وستشمل تجربة بلا إعلانات ومزايا للأعضاء.',
                ),
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(color: _muted, fontSize: 10),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: _ink),
                  onPressed: () {
                    setState(() => _premium = !_premium);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(
                        content: Text(
                          _premium
                              ? _text(
                                  'Preview enabled · subscription purchases are not configured yet.',
                                  'تم تفعيل المعاينة · الاشتراكات غير مهيأة بعد.',
                                )
                              : _text(
                                  'Preview turned off.',
                                  'تم إيقاف المعاينة.',
                                ),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    _premium
                        ? _text('TURN PREVIEW OFF', 'إيقاف المعاينة')
                        : _text(
                            'PREVIEW AD-FREE MODE',
                            'معاينة الوضع بلا إعلانات',
                          ),
                    style: GoogleFonts.manrope(
                      fontSize: 9,
                      letterSpacing: .6,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSurvey() {
    if (!client.auth.isAuthenticated) {
      setState(() => _tab = 3);
      _showMessage('Sign in to submit your rating and feedback.');
      return;
    }

    var rating = 0;
    var submitting = false;
    final feedbackController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: _paper,
          title: Text(
            _text('How was your experience?', 'كيف كانت تجربتك؟'),
            style: GoogleFonts.cormorantGaramond(fontSize: 26),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () => setDialogState(() => rating = index + 1),
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: _brass,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: feedbackController,
                maxLines: 3,
                maxLength: 2000,
                decoration: InputDecoration(
                  hintText: _text(
                    'Anything we could do better?',
                    'كيف يمكننا تحسين تجربتك؟',
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                style: GoogleFonts.manrope(fontSize: 10),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(_text('CANCEL', 'إلغاء')),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: _ink),
              onPressed: rating == 0 || submitting
                  ? null
                  : () async {
                      setDialogState(() => submitting = true);
                      try {
                        await client.rental.submitSatisfactionSurvey(
                          rating,
                          feedbackController.text,
                        );
                        if (!dialogContext.mounted) return;
                        Navigator.pop(dialogContext);
                        if (mounted) {
                          _showMessage(
                            _text(
                              'Thank you for helping us do better.',
                              'شكراً لمساعدتنا على التحسن.',
                            ),
                          );
                        }
                      } catch (error) {
                        if (!dialogContext.mounted) return;
                        setDialogState(() => submitting = false);
                        _showMessage(
                          'Could not submit your feedback: $error',
                        );
                      }
                    },
              child: submitting
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(_text('SEND', 'إرسال')),
            ),
          ],
        ),
      ),
    ).whenComplete(() => feedbackController.dispose());
  }

  void _showLegal(String type) {
    final (title, content) = switch (type) {
      'return' => (
        _text('Return policy', 'سياسة الإعادة'),
        _text(
          'This preview does not set a binding return or cancellation policy. Before confirming a real rental, the provider must show you its signed terms, including the return location and time, late-return charges, fuel and cleanliness expectations, mileage limits, deposits and cancellation fees. Confirm the vehicle condition with the provider at pick-up and return.',
          'هذه معاينة ولا تحدد سياسة ملزمة للإعادة أو الإلغاء. قبل تأكيد الإيجار الفعلي، يجب على الشركة عرض شروطها المعتمدة، بما في ذلك مكان ووقت الإعادة ورسوم التأخير والوقود والنظافة وحدود المسافة والتأمين ورسوم الإلغاء. وثّق حالة السيارة عند الاستلام والإعادة.',
        ),
      ),
      'insurance' => (
        _text('Insurance agreement', 'اتفاقية التأمين'),
        _text(
          'Insurance coverage, excess amounts, exclusions, eligible drivers and claim procedures vary by rental provider and vehicle. The insurance certificate and rental agreement from your provider are authoritative. Review both before accepting a vehicle. This preview is not an insurance contract.',
          'تختلف التغطية ومبلغ التحمل والاستثناءات والسائقون المؤهلون وإجراءات المطالبات حسب شركة التأجير والسيارة. شهادة التأمين واتفاقية الشركة هما المرجع المعتمد. يرجى مراجعتهما قبل استلام السيارة. هذه المعاينة ليست عقد تأمين.',
        ),
      ),
      _ => (
        _text('Privacy & non-disclosure', 'الخصوصية وعدم الإفصاح'),
        _text(
          'Booking details and survey ratings or comments are sent to Luxury Wheel and associated with your account. Administrators can review submitted feedback to improve the service. Do not include sensitive or confidential information in comments.',
          'يتم إرسال تفاصيل الحجز وتقييمات الاستبيان وتعليقاتك إلى لوكشري ويل وربطها بحسابك. يمكن للمسؤولين الاطلاع على الملاحظات لتحسين الخدمة. يرجى عدم تضمين معلومات حساسة أو سرية في التعليقات.',
        ),
      ),
    };

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: _paper,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 23, 22, 26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                content,
                style: GoogleFonts.manrope(fontSize: 11, height: 1.7),
              ),
              const SizedBox(height: 17),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9E3D7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _text(
                    'Preview information only · Have the final terms reviewed and approved by the rental operator and its legal adviser.',
                    'معلومات للمعاينة · يجب اعتماد الشروط النهائية من مشغّل التأجير ومستشاره القانوني.',
                  ),
                  style: GoogleFonts.manrope(color: _muted, fontSize: 9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showContact() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _paper,
        icon: const Icon(Icons.support_agent_outlined, color: _brass, size: 34),
        title: Text(
          _text('We’re here to help.', 'نسعد بمساعدتك.'),
          style: GoogleFonts.cormorantGaramond(fontSize: 27),
        ),
        content: Text(
          _text(
            'WhatsApp support number and social media accounts have not been supplied yet. Contact details will appear here when the Luxury Wheel team configures them.',
            'لم يتم تزويدنا برقم واتساب أو حسابات التواصل الاجتماعي بعد. ستظهر بيانات التواصل هنا عند إعدادها.',
          ),
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(fontSize: 10, height: 1.6),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(_text('CLOSE', 'إغلاق')),
          ),
        ],
      ),
    );
  }

  void _showOffer(_Offer offer) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _paper,
        icon: Icon(offer.icon, color: _brass, size: 32),
        title: Text(
          offer.category,
          style: GoogleFonts.manrope(fontSize: 11, fontWeight: FontWeight.w800),
        ),
        content: Text(
          _text(
            'A city-based partner offer for $_city. Participating merchants, discount codes and availability will be provided by the local partners before launch.',
            'عرض من شركائنا في $_city. ستتم إضافة المتاجر المشاركة ورموز الخصم والتوفر من الشركاء المحليين قبل الإطلاق.',
          ),
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(fontSize: 10, height: 1.6),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(_text('GOT IT', 'حسناً')),
          ),
        ],
      ),
    );
  }

  Future<void> _chooseCity() async {
    final availableCities = {
      ..._cities,
      ..._cars.map((car) => car.city).whereType<String>(),
    }.toList()..sort();
    final city = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: _paper,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _text('Choose your city', 'اختر مدينتك'),
                style: GoogleFonts.cormorantGaramond(fontSize: 27),
              ),
              for (final city in availableCities)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.place_outlined, color: _brass),
                  title: Text(city, style: GoogleFonts.manrope(fontSize: 12)),
                  trailing: city == _city
                      ? const Icon(Icons.check, color: _brass)
                      : null,
                  onTap: () => Navigator.pop(context, city),
                ),
            ],
          ),
        ),
      ),
    );
    if (city != null) setState(() => _city = city);
  }

  Future<void> _chooseDate({required bool isPickup}) async {
    final today = BookingDates.dateOnly(DateTime.now());
    final initial = isPickup ? _pickup : _return;
    final firstDate = isPickup
        ? today
        : BookingDates.earliestReturnDate(_pickup, today: today);
    final lastDate = isPickup
        ? today.add(const Duration(days: 365))
        : BookingDates.latestReturnDate(_pickup, today: today);
    final selected = await showDatePicker(
      context: context,
      initialDate: BookingDates.clampDate(initial, firstDate, lastDate),
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: isPickup
          ? _text('Choose pick-up date', 'اختر تاريخ الاستلام')
          : _text('Choose return date', 'اختر تاريخ الإعادة'),
    );
    if (selected == null) return;
    setState(() {
      if (isPickup) {
        _pickup = BookingDates.dateOnly(selected);
        _return = BookingDates.adjustReturnDate(_return, _pickup);
      } else {
        _return = BookingDates.dateOnly(selected);
      }
    });
  }

  String _dateLabel(DateTime value) =>
      '${_month(value.month)} ${value.day.toString().padLeft(2, '0')}';

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  String _month(int month) => switch (month) {
    1 => _text('Jan', 'يناير'),
    2 => _text('Feb', 'فبراير'),
    3 => _text('Mar', 'مارس'),
    4 => _text('Apr', 'أبريل'),
    5 => _text('May', 'مايو'),
    6 => _text('Jun', 'يونيو'),
    7 => _text('Jul', 'يوليو'),
    8 => _text('Aug', 'أغسطس'),
    9 => _text('Sep', 'سبتمبر'),
    10 => _text('Oct', 'أكتوبر'),
    11 => _text('Nov', 'نوفمبر'),
    _ => _text('Dec', 'ديسمبر'),
  };

  void _share(String item) {
    final message = _text(
      'Discover $item with Luxury Wheel — a considered collection for the long way round.',
      'اكتشف $item مع لوكشري ويل — سيارات مختارة لرحلة أجمل.',
    );
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: _paper,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _text('Pass it along.', 'شاركها مع من تحب.'),
                style: GoogleFonts.cormorantGaramond(fontSize: 28),
              ),
              const SizedBox(height: 7),
              Text(
                message,
                style: GoogleFonts.manrope(color: _muted, fontSize: 10),
              ),
              const SizedBox(height: 15),
              _outlinedAction(
                _text('COPY SHARE MESSAGE', 'نسخ رسالة المشاركة'),
                () async {
                  await Clipboard.setData(ClipboardData(text: message));
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _text(
                          'Message copied. Paste it into your social app.',
                          'تم نسخ الرسالة. الصقها في تطبيق التواصل.',
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Car {
  const _Car({
    required this.managedCarId,
    required this.branchId,
    required this.companyId,
    required this.name,
    required this.color,
    required this.category,
    required this.seats,
    required this.rate,
    required this.rating,
    required this.image,
    required this.companyName,
    required this.branchName,
    required this.city,
    required this.companyLogoUrl,
    required this.description,
    required this.year,
  });

  factory _Car.fromCatalog(CarCatalog catalog) => _Car(
    managedCarId: catalog.carId,
    branchId: catalog.branchId,
    companyId: catalog.companyId,
    name: '${catalog.make} ${catalog.model}',
    color: catalog.color,
    category: catalog.category,
    seats: catalog.seats,
    rate: catalog.dailyRate,
    rating: 'New',
    image: catalog.imageUrls.firstOrNull ?? '',
    companyName: catalog.companyName,
    branchName: catalog.branchName,
    city: catalog.city,
    companyLogoUrl: catalog.companyLogoUrl,
    description: catalog.description,
    year: catalog.year,
  );

  final int? managedCarId;
  final int? branchId;
  final int? companyId;
  final String name;
  final String? color;
  final String category;
  final int seats;
  final int rate;
  final String rating;
  final String image;
  final String companyName;
  final String? branchName;
  final String? city;
  final String? companyLogoUrl;
  final String? description;
  final int year;
}

class _Offer {
  const _Offer({
    required this.icon,
    required this.category,
    required this.title,
    required this.detail,
    required this.tone,
  });

  final IconData icon;
  final String category;
  final String title;
  final String detail;
  final Color tone;
}
