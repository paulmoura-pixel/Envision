// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:ui' as ui;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:firebase_auth/firebase_auth.dart';

const _kOrange = Color(0xFFFF6500);
const _kInk = Color(0xFF0B0B0B);
const _kGray = Color(0xFF85858D);
const _kSubtle = Color(0xFFF7F7F8);
const _kLine = Color(0xFFEEEEF0);
const _kGreen = Color(0xFF16A34A);

/// Whole Envision client dashboard (Nutrition / Training / Progress) as one
/// widget.
///
/// Reads Firestore itself (users, food_logs, nutrition_goals, workout_plans,
/// workout_exercises, body_measurements, progress_photos) for the signed-in
/// client. Set Width/Height to infinity. Only the action callbacks are
/// parameters.
class EnvisionDashboard extends StatefulWidget {
  const EnvisionDashboard({
    super.key,
    this.width,
    this.height,
    this.onPlus,
    this.onCoach,
    this.onHome,
    this.onDateChanged,
    this.onMealTap,
    this.onNotes,
    this.onLogWorkout,
    this.onUploadVideo,
    this.onLogMeasurements,
    this.onLogPhoto,
    this.onBodyComp,
    this.onSeeAllPhotos,
    this.onExerciseToggled,
    this.onSetGoal,
  });

  final double? width;
  final double? height;
  final Future Function()? onPlus;
  final Future Function()? onCoach;
  final Future Function()? onHome;
  final Future Function()? onDateChanged;
  final Future Function()? onMealTap;
  final Future Function()? onNotes;
  final Future Function()? onLogWorkout;
  final Future Function()? onUploadVideo;
  final Future Function()? onLogMeasurements;
  final Future Function()? onLogPhoto;
  final Future Function()? onBodyComp;
  final Future Function()? onSeeAllPhotos;
  final Future Function()? onExerciseToggled;
  final Future Function()? onSetGoal;

  @override
  State<EnvisionDashboard> createState() => _EnvisionDashboardState();
}

class _D {
  String? userName;
  String? avatarUrl;
  int? caloriesConsumed;
  int? calorieGoal;
  double? proteinNow;
  double? proteinGoal;
  double? carbsNow;
  double? carbsGoal;
  double? fatNow;
  double? fatGoal;
  List<String>? mealTitles;
  List<String>? mealDescriptions;
  List<int>? mealKcals;
  List<String>? mealImages;
  String? workoutTitle;
  int? workoutMinutes;
  String? workoutType;
  String? workoutFocus;
  List<String>? exerciseNames;
  List<String>? exerciseDetails;
  List<bool>? exerciseDone;
  String? weight;
  String? bodyFat;
  String? muscle;
  String? bmi;
  String? weightDelta;
  String? bodyFatDelta;
  String? muscleDelta;
  List<String>? photoUrls;
  List<String>? photoLabels;
  List<double>? weightSeries;
  List<double>? muscleSeries;
  List<double>? bodyFatSeries;
  List<String>? seriesLabels;
  Future Function()? onPlus;
  Future Function()? onCoach;
  Future Function()? onHome;
  Future Function()? onDateChanged;
  Future Function()? onMealTap;
  Future Function()? onNotes;
  Future Function()? onLogWorkout;
  Future Function()? onUploadVideo;
  Future Function()? onLogMeasurements;
  Future Function()? onLogPhoto;
  Future Function()? onBodyComp;
  Future Function()? onSeeAllPhotos;
  Future Function()? onExerciseToggled;
}

class _EnvisionDashboardState extends State<EnvisionDashboard> {
  int _tab = 0;
  int _metric = 0;
  bool _loaded = false;
  late DateTime _date;
  Timer? _clock;
  String _lastGreeting = '';
  List<bool>? _done;
  bool _roleChecked = false;

  final _d = _D();
  final List<StreamSubscription> _subs = [];
  Map<String, dynamic> _user = {};
  List<Map<String, dynamic>> _food = [],
      _goals = [],
      _plans = [],
      _meas = [],
      _photos = [];
  final Map<String, List<Map<String, dynamic>>> _exercises = {};
  List<Map<String, dynamic>> _elogs = [];
  final Set<String> _loadingPlans = {};
  List<Map<String, dynamic>> _notes = [], _comments = [];
  List<DocumentReference> _mealRefs = [];
  final Map<String, Map<String, dynamic>> _people = {};

  @override
  void initState() {
    super.initState();
    final n = DateTime.now();
    _date = DateTime(n.year, n.month, n.day);
    _lastGreeting = _greeting;
    _clock = Timer.periodic(const Duration(minutes: 1), (_) {
      if (!mounted) return;
      final g = _greeting;
      if (g != _lastGreeting) {
        _lastGreeting = g;
        setState(() {});
      }
    });
    _listen();
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted && !_loaded) setState(() => _loaded = true);
    });
  }

  @override
  void dispose() {
    _clock?.cancel();
    for (final s in _subs) {
      s.cancel();
    }
    super.dispose();
  }

  Future<void> _openCoachChat() async {
    final me = currentUserReference;
    final coach = _user['coach'];
    if (me == null || coach is! DocumentReference) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Join a coach to start messaging')));
      return;
    }
    final tc = TextEditingController();
    final sc = ScrollController();
    final db = FirebaseFirestore.instance;
    try {
      final q = await db
          .collection('messages')
          .where('clientRef', isEqualTo: me)
          .get();
      for (final d in q.docs) {
        final snd = d.data()['senderRef'];
        if (snd is DocumentReference &&
            snd.id != me.id &&
            d.data()['read'] != true) {
          d.reference.update({'read': true});
        }
      }
    } catch (_) {}
    if (!mounted) return;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(ctx).size.height * 0.85,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
            padding: EdgeInsets.fromLTRB(
                16, 14, 16, MediaQuery.of(ctx).padding.bottom + 12),
            child: Column(children: [
              Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                      color: _kLine, borderRadius: BorderRadius.circular(4))),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Your coach',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.4))),
              const SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: db
                      .collection('messages')
                      .where('clientRef', isEqualTo: me)
                      .snapshots(),
                  builder: (c2, snap) {
                    if (!snap.hasData)
                      return const Center(
                          child: CircularProgressIndicator(
                              color: _kOrange, strokeWidth: 2));
                    final l = snap.data!.docs
                        .map((d) => d.data())
                        .where((m) =>
                            m['coachRef'] is DocumentReference &&
                            (m['coachRef'] as DocumentReference).id == coach.id)
                        .toList();
                    l.sort((a, b) {
                      final x = a['createdAt'];
                      final y = b['createdAt'];
                      final dx = x is Timestamp ? x.toDate() : DateTime.now();
                      final dy = y is Timestamp ? y.toDate() : DateTime.now();
                      return dx.compareTo(dy);
                    });
                    if (l.isEmpty)
                      return const Center(
                          child: Text('No messages yet. Say hi to your coach.',
                              style: TextStyle(color: _kGray, fontSize: 15)));
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (sc.hasClients) sc.jumpTo(sc.position.maxScrollExtent);
                    });
                    return ListView.builder(
                      controller: sc,
                      itemCount: l.length,
                      itemBuilder: (c3, i) {
                        final m = l[i];
                        final s = m['senderRef'];
                        final mine = s is DocumentReference && s.id == me.id;
                        return Align(
                          alignment: mine
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 3),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(ctx).size.width * 0.75),
                            decoration: BoxDecoration(
                                color: mine ? _kOrange : _kSubtle,
                                borderRadius: BorderRadius.circular(18)),
                            child: Text((m['text'] ?? '').toString(),
                                style: TextStyle(
                                    fontSize: 15.5,
                                    color: mine ? Colors.white : _kInk)),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: tc,
                    decoration: InputDecoration(
                      hintText: 'Message your coach',
                      filled: true,
                      fillColor: _kSubtle,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () async {
                    final txt = tc.text.trim();
                    if (txt.isEmpty) return;
                    tc.clear();
                    try {
                      await db.collection('messages').add({
                        'coachRef': coach,
                        'clientRef': me,
                        'senderRef': me,
                        'text': txt,
                        'read': false,
                        'createdAt': FieldValue.serverTimestamp(),
                      });
                    } catch (_) {}
                  },
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                        color: _kOrange, shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_upward, color: Colors.white),
                  ),
                ),
              ]),
            ]),
          ),
        );
      },
    );
  }

  void _listen() {
    final me = currentUserReference;
    if (me == null) {
      _loaded = true;
      return;
    }
    final db = FirebaseFirestore.instance;
    _subs.add(me.snapshots().listen((d) {
      _loaded = true;
      _user = (d.data() as Map<String, dynamic>?) ?? {};
      _recompute();
      if (!_roleChecked) {
        _roleChecked = true;
        final rr = (_user['role'] ?? '').toString().toLowerCase();
        final isCoach = rr.contains('coach') ||
            rr.contains('train') ||
            (_user['coach'] == null &&
                ((_user['coachCode'] ?? '').toString().isNotEmpty ||
                    (_user['gymName'] ?? '').toString().isNotEmpty ||
                    (_user['whatYouCoach'] ?? '').toString().isNotEmpty));
        if (isCoach) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) context.goNamed('EnvisionCoachPro');
          });
        }
      }
    }));
    void col(String name, void Function(List<Map<String, dynamic>>) set) {
      _subs.add(db
          .collection(name)
          .where('client', isEqualTo: me)
          .snapshots()
          .listen((q) {
        final rows = q.docs.map((e) {
          final m = Map<String, dynamic>.from(e.data());
          m['__ref'] = e.reference;
          return m;
        }).toList();
        set(rows);
        _recompute();
        if (name == 'workout_plans') _loadExercises();
      }, onError: (_) {}));
    }

    col('food_logs', (r) => _food = r);
    col('nutrition_goals', (r) => _goals = r);
    col('workout_plans', (r) => _plans = r);
    col('body_measurements', (r) => _meas = r);
    col('progress_photos', (r) => _photos = r);
    col('exercise_logs', (r) => _elogs = r);
    void colRef(String name, void Function(List<Map<String, dynamic>>) set) {
      _subs.add(db
          .collection(name)
          .where('clientRef', isEqualTo: me)
          .snapshots()
          .listen((q) {
        set(q.docs.map((e) {
          final m = Map<String, dynamic>.from(e.data());
          m['__ref'] = e.reference;
          return m;
        }).toList());
        _recompute();
      }, onError: (_) {}));
    }

    colRef('coach_daily_notes', (r) => _notes = r);
    colRef('meal_comments', (r) => _comments = r);
  }

  static DateTime? _dt(dynamic v) => v is Timestamp ? v.toDate() : null;
  static bool _sameDay(DateTime? a, DateTime b) =>
      a != null && a.year == b.year && a.month == b.month && a.day == b.day;
  static double? _num(dynamic v) => v is num ? v.toDouble() : null;
  static String _md(DateTime d) => '${_mo[d.month - 1]} ${d.day}';
  static String _signed(double v, String unit) =>
      '${v < 0 ? '\u2212' : '+'}${v.abs().toStringAsFixed(1)}$unit';

  Map<String, dynamic>? get _todayPlan {
    for (final p in _plans) {
      if (_sameDay(_dt(p['scheduled_date']), _date)) return p;
    }
    return null;
  }

  Future<void> _loadExercises() async {
    final p = _todayPlan;
    if (p == null) return;
    final ref = p['__ref'] as DocumentReference;
    if (_exercises.containsKey(ref.id) || _loadingPlans.contains(ref.id)) {
      return;
    }
    _loadingPlans.add(ref.id);
    try {
      final q = await FirebaseFirestore.instance
          .collection('workout_exercises')
          .where('workout', isEqualTo: ref)
          .get();
      final rows = q.docs
          .map((e) => <String, dynamic>{
                ...Map<String, dynamic>.from(e.data()),
                '__ref': e.reference
              })
          .toList();
      rows.sort((a, b) => ((a['exercise_order'] ?? 0) as num)
          .compareTo((b['exercise_order'] ?? 0) as num));
      _exercises[ref.id] = rows;
    } catch (_) {
      _exercises[ref.id] = [];
    }
    _loadingPlans.remove(ref.id);
    _recompute();
  }

  void _dateChanged() {
    _done = null;
    _recompute();
    _loadExercises();
    _d.onDateChanged?.call();
  }

  void _recompute() {
    if (!mounted) return;
    final d = _d;
    // user
    final dn = (_user['display_name'] ?? '').toString().trim();
    d.userName = dn.isEmpty ? null : dn.split(' ').first;
    d.avatarUrl = (_user['photo_url'] ?? '').toString();
    // nutrition
    final meals = _food
        .where((m) => _sameDay(_dt(m['logged_at']), _date))
        .toList()
      ..sort((a, b) => _dt(a['logged_at'])!.compareTo(_dt(b['logged_at'])!));
    int sum(String k) =>
        meals.fold<int>(0, (a, m) => a + ((m[k] ?? 0) as num).toInt());
    d.caloriesConsumed = sum('calories');
    _mealRefs =
        meals.map((m) => m['__ref']).whereType<DocumentReference>().toList();
    d.proteinNow = sum('protein').toDouble();
    d.carbsNow = sum('carbs').toDouble();
    d.fatNow = sum('fat').toDouble();
    d.mealTitles = meals.map((m) {
      final t = (m['meal_type'] ?? 'Meal').toString();
      return t.isEmpty ? 'Meal' : t[0].toUpperCase() + t.substring(1);
    }).toList();
    d.mealDescriptions =
        meals.map((m) => (m['description'] ?? '').toString()).toList();
    d.mealKcals =
        meals.map((m) => ((m['calories'] ?? 0) as num).toInt()).toList();
    d.mealImages = meals.map((m) => (m['image_url'] ?? '').toString()).toList();
    final end = DateTime(_date.year, _date.month, _date.day, 23, 59, 59);
    final gs = _goals.where((g) => _dt(g['effective_date']) != null).toList()
      ..sort((a, b) =>
          _dt(a['effective_date'])!.compareTo(_dt(b['effective_date'])!));
    Map<String, dynamic>? goal;
    for (final g in gs) {
      if (!_dt(g['effective_date'])!.isAfter(end)) goal = g;
    }
    goal ??= gs.isNotEmpty ? gs.last : (_goals.isNotEmpty ? _goals.last : null);
    d.calorieGoal = goal == null ? 0 : ((goal['calories'] ?? 0) as num).toInt();
    d.proteinGoal =
        goal == null ? 0 : ((goal['protein'] ?? 0) as num).toDouble();
    d.carbsGoal = goal == null ? 0 : ((goal['carbs'] ?? 0) as num).toDouble();
    d.fatGoal = goal == null ? 0 : ((goal['fat'] ?? 0) as num).toDouble();
    // training
    final p = _todayPlan;
    if (p == null) {
      d.workoutTitle = null;
      d.exerciseNames = [];
      d.exerciseDetails = [];
    } else {
      d.workoutTitle = (p['workout_name'] ?? 'Workout').toString();
      d.workoutMinutes = ((p['duration_min'] ?? 0) as num).toInt();
      d.workoutType = (p['workout_type'] ?? '').toString();
      final nt = (p['notes'] ?? '').toString();
      d.workoutFocus = nt.length <= 14 ? nt : '';
      final ex = _exercises[(p['__ref'] as DocumentReference).id] ?? [];
      d.exerciseNames =
          ex.map((e) => (e['exercise_name'] ?? '').toString()).toList();
      d.exerciseDetails = ex
          .map((e) =>
              e['sets'].toString() +
              ' sets × ' +
              e['target_reps'].toString() +
              ' reps' +
              ((_num(e['target_weight']) ?? 0) > 0
                  ? ' · ' + _num(e['target_weight'])!.round().toString() + ' lb'
                  : ''))
          .toList();
    }
    // progress
    final ms = _meas
        .where((m) =>
            _dt(m['measured_at']) != null &&
            !_dt(m['measured_at'])!.isAfter(end))
        .toList()
      ..sort(
          (a, b) => _dt(a['measured_at'])!.compareTo(_dt(b['measured_at'])!));
    double lb(Map<String, dynamic> m) {
      final w = _num(m['weight']) ?? 0;
      return (m['weight_unit'] ?? 'lb').toString().toLowerCase().startsWith('k')
          ? w * 2.20462
          : w;
    }

    if (ms.isEmpty) {
      d.weight = d.bodyFat = d.muscle = d.bmi = null;
      d.weightDelta = d.bodyFatDelta = d.muscleDelta = null;
      d.weightSeries = d.muscleSeries = d.bodyFatSeries = [];
      d.seriesLabels = [];
    } else {
      final first = ms.first, last = ms.last;
      final w = lb(last);
      d.weight = w > 0 ? w.toStringAsFixed(1) : null;
      final bf = _num(last['body_fat_pct']) ?? 0;
      d.bodyFat = bf > 0 ? bf.toStringAsFixed(1) : null;
      final mu = _num(last['muscle_mass']) ?? 0;
      d.muscle = mu > 0 ? mu.toStringAsFixed(1) : null;
      final h = _num(_user['height_in']) ?? 0;
      d.bmi = (h > 0 && w > 0) ? (703 * w / (h * h)).toStringAsFixed(1) : null;
      d.weightDelta =
          (ms.length > 1 && w > 0) ? _signed(w - lb(first), ' lb') : null;
      d.bodyFatDelta = (ms.length > 1 && bf > 0)
          ? _signed(bf - (_num(first['body_fat_pct']) ?? bf), '%')
          : null;
      d.muscleDelta = (ms.length > 1 && mu > 0)
          ? _signed(mu - (_num(first['muscle_mass']) ?? mu), ' lb')
          : null;
      final tail = ms.length > 8 ? ms.sublist(ms.length - 8) : ms;
      List<double> ser(double Function(Map<String, dynamic>) f) {
        final v = tail.map(f).toList();
        return v.every((x) => x > 0) ? v : [];
      }

      d.weightSeries = ser(lb);
      d.muscleSeries = ser((m) => _num(m['muscle_mass']) ?? 0);
      d.bodyFatSeries = ser((m) => _num(m['body_fat_pct']) ?? 0);
      d.seriesLabels = tail.map((m) => _md(_dt(m['measured_at'])!)).toList();
    }
    final ph = _photos
        .where((x) =>
            _dt(x['taken_at']) != null && !_dt(x['taken_at'])!.isAfter(end))
        .toList()
      ..sort((a, b) => _dt(a['taken_at'])!.compareTo(_dt(b['taken_at'])!));
    final pt = ph.length > 3 ? ph.sublist(ph.length - 3) : ph;
    d.photoUrls = pt.map((x) => (x['photo_path'] ?? '').toString()).toList();
    d.photoLabels = pt.map((x) => _md(_dt(x['taken_at'])!)).toList();
    setState(() {});
  }

  static const _wd = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const _mo = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  String get _dateLabel =>
      '${_wd[_date.weekday - 1]}, ${_mo[_date.month - 1]} ${_date.day}';

  String get _greeting {
    final h = DateTime.now().hour;
    return h < 12
        ? 'Good morning,'
        : (h < 18 ? 'Good afternoon,' : 'Good evening,');
  }

  bool get _canGoForward {
    final n = DateTime.now();
    return _date.isBefore(DateTime(n.year, n.month, n.day + 90));
  }

  bool get _isFuture {
    final n = DateTime.now();
    return DateTime(_date.year, _date.month, _date.day)
        .isAfter(DateTime(n.year, n.month, n.day));
  }

  void _shift(int d) {
    if (d > 0 && !_canGoForward) return;
    setState(() => _date = DateTime(_date.year, _date.month, _date.day + d));
    _dateChanged();
  }

  Future<void> _pick() async {
    List<DateTime> ds(Iterable<Map<String, dynamic>> l, String k) =>
        l.map((m) => _dt(m[k])).whereType<DateTime>().toList();
    final p = await showEnvisionCalendar(
      context,
      _date,
      ds(_food, 'logged_at'),
      ds(_plans, 'scheduled_date'),
      [...ds(_meas, 'measured_at'), ...ds(_photos, 'taken_at')],
    );
    if (p != null) {
      setState(() => _date = DateTime(p.year, p.month, p.day));
      _dateChanged();
    }
  }

  Widget _futureNote(IconData icon, String title, String body) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: BoxDecoration(
        color: _kSubtle,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _kLine),
      ),
      child: Column(
        children: [
          Icon(icon, size: 36, color: _kGray),
          const SizedBox(height: 14),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: _kInk),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, color: _kGray),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _d.onPlus = _tab == 1
        ? () async {
            final d = await _showWorkoutSheets(context, _date);
            if (d != null && mounted) {
              setState(() => _date = DateTime(d.year, d.month, d.day));
              _dateChanged();
            }
          }
        : (_isFuture
            ? null
            : (_tab == 0
                ? () async {
                    await _openNutritionSheet();
                  }
                : widget.onPlus));
    _d.onCoach = widget.onCoach;
    _d.onHome = widget.onHome;
    _d.onDateChanged = widget.onDateChanged;
    _d.onMealTap = widget.onMealTap;
    _d.onNotes = widget.onNotes;
    _d.onLogWorkout = _isFuture
        ? null
        : () async {
            await _openLog();
          };
    _d.onUploadVideo = _isFuture ? null : widget.onUploadVideo;
    _d.onLogMeasurements = _isFuture ? null : widget.onLogMeasurements;
    _d.onLogPhoto = _isFuture ? null : widget.onLogPhoto;
    _d.onBodyComp = widget.onBodyComp;
    _d.onSeeAllPhotos = widget.onSeeAllPhotos;
    _d.onExerciseToggled = _isFuture ? null : widget.onExerciseToggled;
    final w = _d;
    return PopScope(
        canPop: false,
        child: DefaultTextStyle.merge(
            style: TextStyle(fontFamily: 'Geist'),
            child: Container(
              width: widget.width,
              height: widget.height,
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      color: _kOrange,
                      onRefresh: _refresh,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(
                            20, 8 + MediaQuery.of(context).padding.top, 20, 24),
                        children: [
                          if (!_loaded)
                            ..._skeleton()
                          else ...[
                            _header(),
                            const SizedBox(height: 14),
                            _tabs(),
                            const SizedBox(height: 16),
                            _dateRow(),
                            const SizedBox(height: 14),
                            if (_tab == 0)
                              (_isFuture
                                  ? _futureNote(
                                      Icons.restaurant_outlined,
                                      'Nothing logged yet',
                                      'Meals can be logged once the day arrives.')
                                  : _nutrition()),
                            if (_tab == 1) _training(),
                            if (_tab == 2)
                              (_isFuture
                                  ? _futureNote(
                                      Icons.event_outlined,
                                      'Come back on this date',
                                      'Measurements and photos can be added on the day.')
                                  : _progress()),
                          ],
                        ],
                      ),
                    ),
                  ),
                  SafeArea(top: false, child: _bottomNav()),
                ],
              ),
            )));
  }

  // ---------------- shared ----------------
  Future<void> _refresh() async {
    for (final s in _subs) {
      s.cancel();
    }
    _subs.clear();
    if (mounted) setState(() => _loaded = false);
    _listen();
    await Future.delayed(const Duration(milliseconds: 900));
    if (mounted) setState(() => _loaded = true);
  }

  Widget _sk(double w, double h, [double r = 10]) => Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
          color: const Color(0xFFECECEF),
          borderRadius: BorderRadius.circular(r)));
  Future<void> _openNutritionSheet() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      barrierColor: Colors.black54,
      builder: (ctx) {
        String mode = 'camera';
        XFile? shot;
        final nameC = TextEditingController();
        final calC = TextEditingController();
        final pC = TextEditingController();
        final cC = TextEditingController();
        final fC = TextEditingController();
        bool saving = false;
        String? err;
        const orange = Color(0xFFF26B1D);
        return StatefulBuilder(builder: (ctx, setS) {
          final h = MediaQuery.of(ctx).size.height;
          Future<void> pick(ImageSource s) async {
            try {
              final f =
                  await ImagePicker().pickImage(source: s, imageQuality: 85);
              if (f != null)
                setS(() {
                  shot = f;
                  mode = 'photo';
                });
            } catch (_) {}
          }

          Widget fld(String label, TextEditingController c, bool num) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: c,
                keyboardType: num ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(
                  labelText: label,
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none),
                ),
              ),
            );
          }

          Widget btn(String t, bool primary, VoidCallback? f) {
            return Expanded(
              child: GestureDetector(
                onTap: f,
                child: Container(
                  height: 54,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primary ? orange : const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(t,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: primary ? Colors.white : Colors.black87)),
                ),
              ),
            );
          }

          Future<void> save() async {
            final name = nameC.text.trim();
            final cal = int.tryParse(calC.text.trim());
            if (name.isEmpty || cal == null) {
              setS(() => err = 'Add a name and calories.');
              return;
            }
            final u = FirebaseAuth.instance.currentUser;
            if (u == null) {
              setS(() => err = 'Please sign in again.');
              return;
            }
            setS(() {
              saving = true;
              err = null;
            });
            try {
              final ref =
                  FirebaseFirestore.instance.collection('users').doc(u.uid);
              final now = DateTime.now();
              await FirebaseFirestore.instance.collection('food_logs').add({
                'client': ref,
                'created_by': ref,
                'description': name,
                'meal_type': 'meal',
                'calories': cal,
                'protein': int.tryParse(pC.text.trim()) ?? 0,
                'carbs': int.tryParse(cC.text.trim()) ?? 0,
                'fat': int.tryParse(fC.text.trim()) ?? 0,
                'image_url': '',
                'logged_at': Timestamp.fromDate(DateTime(
                    _date.year, _date.month, _date.day, now.hour, now.minute)),
              });
              if (ctx.mounted) Navigator.pop(ctx);
            } catch (_) {
              setS(() {
                saving = false;
                err = 'Could not save. Try again.';
              });
            }
          }

          final isCam = mode == 'camera';
          final isPhoto = mode == 'photo';
          Widget body;
          if (isCam) {
            body = Column(
              children: [
                EnvisionCameraView(
                  height: h * 0.55,
                  onCaptured: (p) => setS(() {
                    shot = XFile(p);
                    mode = 'photo';
                  }),
                  onGallery: () => pick(ImageSource.gallery),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => setS(() => mode = 'review'),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Enter manually',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54)),
                  ),
                ),
              ],
            );
          } else if (isPhoto) {
            body = Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: SizedBox(
                    height: h * 0.55,
                    width: double.infinity,
                    child: FutureBuilder<List<int>>(
                      future: shot!.readAsBytes(),
                      builder: (c, s) => s.hasData
                          ? Image.memory(Uint8List.fromList(s.data!),
                              fit: BoxFit.cover)
                          : const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(children: [
                  btn('Retake', false, () => setS(() => mode = 'camera')),
                  const SizedBox(width: 12),
                  btn('Use Photo', true, () => setS(() => mode = 'review')),
                ]),
              ],
            );
          } else {
            body = SingleChildScrollView(
              child: Column(
                children: [
                  fld('Meal name', nameC, false),
                  fld('Calories', calC, true),
                  Row(children: [
                    Expanded(child: fld('Protein (g)', pC, true)),
                    const SizedBox(width: 10),
                    Expanded(child: fld('Carbs (g)', cC, true)),
                    const SizedBox(width: 10),
                    Expanded(child: fld('Fat (g)', fC, true)),
                  ]),
                  if (err != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(err!,
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w600)),
                    ),
                  Row(children: [
                    btn(saving ? 'Saving...' : 'Add Meal', true,
                        saving ? null : save)
                  ]),
                ],
              ),
            );
          }
          return Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOut,
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                padding: EdgeInsets.fromLTRB(
                    20, 22, 20, MediaQuery.of(ctx).padding.bottom + 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            isCam
                                ? 'Log / Scan'
                                : (isPhoto ? 'Use this photo?' : 'Add meal'),
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w800),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(ctx),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                                color: Color(0xFFF0F0F0),
                                shape: BoxShape.circle),
                            child: const Icon(Icons.close, size: 20),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    body,
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  List<Widget> _skeleton() => [
        _Pulse(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            _sk(44, 40),
            const SizedBox(width: 8),
            _sk(110, 24),
            const Spacer(),
            _sk(26, 26, 13),
            const SizedBox(width: 18),
            _sk(26, 26, 13),
            const SizedBox(width: 14),
            _sk(48, 48, 24)
          ]),
          const SizedBox(height: 22),
          _sk(130, 20),
          const SizedBox(height: 10),
          _sk(200, 48, 12),
          const SizedBox(height: 10),
          _sk(240, 16),
          const SizedBox(height: 24),
          Row(children: [
            Expanded(child: _sk(double.infinity, 22)),
            const SizedBox(width: 24),
            Expanded(child: _sk(double.infinity, 22)),
            const SizedBox(width: 24),
            Expanded(child: _sk(double.infinity, 22))
          ]),
          const SizedBox(height: 16),
          _sk(double.infinity, 46, 23),
          const SizedBox(height: 16),
          _sk(double.infinity, 230, 24),
          const SizedBox(height: 22),
          _sk(120, 24),
          const SizedBox(height: 14),
          _sk(double.infinity, 86, 20),
          const SizedBox(height: 12),
          _sk(double.infinity, 86, 20),
          const SizedBox(height: 12),
          _sk(double.infinity, 86, 20),
        ])),
      ];
  Widget _header() {
    final name = (_d.userName == null || _d.userName!.isEmpty)
        ? 'Athlete'
        : _d.userName!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
                width: 30,
                height: 30,
                child: OverflowBox(
                    maxWidth: 44,
                    maxHeight: 40,
                    child: Transform.scale(
                        scale: 2.4,
                        child: Image.network(
                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/envision-8wd5is/assets/wb945eu7k2ly/Three_Orange_Slashes_Logo.png',
                            width: 44,
                            height: 40,
                            fit: BoxFit.contain)))),
            const SizedBox(width: 6),
            Text('Envision',
                style: TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    color: _kInk)),
            const Spacer(),
            GestureDetector(
                onTap: _pick,
                child: const Icon(Icons.calendar_today_outlined,
                    size: 26, color: _kInk)),
            const SizedBox(width: 20),
            Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_none, size: 29, color: _kInk),
                Positioned(
                  right: 2,
                  top: 0,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                        color: _kOrange, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            PopupMenuButton<String>(
              tooltip: 'Account options',
              icon: const Icon(Icons.logout, size: 22, color: _kInk),
              itemBuilder: (_) => [
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 20),
                      SizedBox(width: 10),
                      Text('Log out'),
                    ],
                  ),
                ),
                if (currentUserEmail.toLowerCase() == 'isaac.gbaba@uri.edu')
                  const PopupMenuItem<String>(
                    value: 'onboarding',
                    child: Text('Restart signup (test)'),
                  ),
              ],
              onSelected: (value) async {
                if (value == 'onboarding') {
                  try {
                    await currentUserReference?.update({
                      'onboarding_status': 'incomplete',
                    });

                    if (mounted) {
                      context.goNamed('ClientJoin');
                    }
                  } catch (e) {
                    debugPrint('Onboarding reset error: $e');
                  }
                  return;
                }

                if (value == 'logout') {
                  final router = GoRouter.of(context);

                  try {
                    router.prepareAuthEvent();

                    await FirebaseAuth.instance.signOut();

                    router.clearRedirectLocation();
                    router.goNamed('BEnvisionWelcomePro');
                  } catch (e) {
                    debugPrint('Logout error: $e');

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Logout failed: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
                //CHANGED LINES ABOVE
                //    if (value == 'logout') {
                //     final router = GoRouter.of(context);
                //   try {
                //     router.prepareAuthEvent();
                //     //changed from await authManager.signOut();
                //     await FirebaseAuth.instance.signOut();

                //     router.clearRedirectLocation();

                //     router.goNamed('BEnvisionWelcomePro');
                //   } catch (e) {
                //     debugPrint('Logout error: $e');

                //     if (mounted) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text('Logout failed: $e'),
                //           backgroundColor: Colors.red,
                //         ),
                //       );
                //     }
                //   }
                // }
              },
            ),
            _avatar(),
          ],
        ),
        const SizedBox(height: 18),
        Text(_greeting,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: _kGray)),
        Text(name,
            style: const TextStyle(
                fontSize: 54,
                height: 1.05,
                letterSpacing: -1.5,
                fontWeight: FontWeight.w900,
                color: _kInk)),
        const SizedBox(height: 2),
        const Text('Stay consistent. Build progress.',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.w500, color: _kGray)),
      ],
    );
  }

  Widget _avatar() {
    final u = _d.avatarUrl;
    return ClipOval(
      child: Container(
        width: 48,
        height: 48,
        color: const Color(0xFF3A2A20),
        child: (u != null && u.isNotEmpty)
            ? Image.network(u,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.person, color: Colors.white))
            : const Icon(Icons.person, color: Colors.white),
      ),
    );
  }

  Widget _tabs() {
    const names = ['Nutrition', 'Training', 'Progress'];
    return Row(
      children: List.generate(3, (i) {
        final sel = i == _tab;
        return Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() => _tab = i),
            child: Column(
              children: [
                Text(names[i],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: sel ? FontWeight.w900 : FontWeight.w500,
                        color: sel ? _kInk : _kGray)),
                const SizedBox(height: 10),
                Container(
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                      color: sel ? _kInk : Colors.transparent,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _dateRow() {
    Widget arrow(IconData i, VoidCallback f) => GestureDetector(
          onTap: f,
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: _kLine)),
            child: Icon(i, size: 22, color: _kInk),
          ),
        );
    return Row(
      children: [
        arrow(Icons.chevron_left, () => _shift(-1)),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: _pick,
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                  color: _kSubtle, borderRadius: BorderRadius.circular(23)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      size: 18, color: _kInk),
                  const SizedBox(width: 8),
                  Text(_dateLabel,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: _kInk)),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down, size: 20, color: _kInk),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Opacity(
          opacity: _canGoForward ? 1 : 0.35,
          child: arrow(Icons.chevron_right, () => _shift(1)),
        ),
      ],
    );
  }

  BoxDecoration _card({Color color = Colors.white}) => BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0F000000), blurRadius: 14, offset: Offset(0, 4))
        ],
      );

  Widget _bottomNav() {
    Widget item(IconData i, Future Function()? f, {bool active = false}) =>
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: f == null ? null : () => f(),
            child:
                Center(child: Icon(i, size: 30, color: active ? _kInk : _kInk)),
          ),
        );
    return SizedBox(
      height: 74,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 52,
            margin: const EdgeInsets.only(top: 22),
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: _kLine))),
            child: Row(
              children: [
                item(Icons.home_outlined, () async {
                  setState(() {
                    _tab = 0;
                    _date = DateTime.now();
                  });
                }, active: true),
                const Expanded(child: SizedBox()),
                item(Icons.groups_outlined, _openCoachChat),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: _d.onPlus == null ? null : () => _d.onPlus!(),
              child: Container(
                width: 62,
                height: 62,
                decoration: const BoxDecoration(
                  color: _kOrange,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x40FF6500),
                        blurRadius: 16,
                        offset: Offset(0, 6))
                  ],
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 34),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _setGoalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFDF1EB), Color(0xFFFBF8F6)]),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: _kOrange.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.local_fire_department_outlined,
                color: _kOrange, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Set your calorie goal',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: _kInk)),
                const SizedBox(height: 4),
                const Text('Personalize your daily nutrition targets.',
                    style: TextStyle(fontSize: 15, color: _kGray)),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => widget.onSetGoal?.call(),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                    decoration: BoxDecoration(
                      color: _kOrange.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Set Goal',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: _kOrange)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _empty(String t, IconData i) => Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        alignment: Alignment.center,
        child: Column(
          children: [
            Icon(i, color: _kGray, size: 28),
            const SizedBox(height: 8),
            Text(t,
                textAlign: TextAlign.center,
                style: const TextStyle(color: _kGray, fontSize: 14)),
          ],
        ),
      );

  // ---------------- nutrition ----------------
  Map<String, dynamic> _person(dynamic ref) {
    if (ref is! DocumentReference) return const {};
    final cached = _people[ref.id];
    if (cached != null) return cached;
    _people[ref.id] = {};
    ref.get().then((s) {
      if (!mounted) return;
      final data = s.data();
      setState(() =>
          _people[ref.id] = data is Map ? Map<String, dynamic>.from(data) : {});
    }).catchError((_) {});
    return const {};
  }

  String _firstName(Map<String, dynamic> p) {
    final n = (p['display_name'] ?? '').toString().trim();
    return n.isEmpty ? 'Coach' : n.split(' ').first;
  }

  Widget _smallAvatar(Map<String, dynamic> p, double size) {
    final url = (p['photo_url'] ?? '').toString();
    final nm = _firstName(p);
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color: _kSubtle,
        alignment: Alignment.center,
        child: url.isNotEmpty
            ? Image.network(url,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Text(nm[0].toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, color: _kInk)))
            : Text(nm[0].toUpperCase(),
                style:
                    const TextStyle(fontWeight: FontWeight.w800, color: _kInk)),
      ),
    );
  }

  String _stamp(DateTime? t) {
    if (t == null) return '';
    const mon = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final mm = t.minute.toString().padLeft(2, '0');
    final ap = t.hour < 12 ? 'AM' : 'PM';
    final now = DateTime.now();
    final today = _sameDay(t, now);
    return (today ? 'Today' : mon[t.month - 1] + ' ' + t.day.toString()) +
        ', ' +
        h.toString() +
        ':' +
        mm +
        ' ' +
        ap;
  }

  DateTime _stampOf(Map<String, dynamic> m) =>
      _dt(m['updatedAt']) ?? _dt(m['createdAt']) ?? DateTime(2000);

  List<Map<String, dynamic>> _commentsFor(String mealId) {
    final l = _comments.where((c) {
      final r = c['mealRef'];
      return r is DocumentReference &&
          r.id == mealId &&
          (c['content'] ?? '').toString().trim().isNotEmpty;
    }).toList()
      ..sort((a, b) => _stampOf(b).compareTo(_stampOf(a)));
    return l;
  }

  /// EnvisionCoachNoteCard: shown only when the coach left a note for the
  /// selected date. White card with a narrow orange left accent.
  Widget _coachNoteCard() {
    final todays = _notes
        .where((n) =>
            _sameDay(_dt(n['date']), _date) &&
            (n['content'] ?? '').toString().trim().isNotEmpty)
        .toList()
      ..sort((a, b) => _stampOf(b).compareTo(_stampOf(a)));
    if (todays.isEmpty) return const SizedBox.shrink();
    final n = todays.first;
    final p = _person(n['coachRef']);
    return Container(
      margin: const EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
              color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 3))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 4, color: _kOrange),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _smallAvatar(p, 38),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text('Coach ' + _firstName(p),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          color: _kInk)),
                                ),
                                Text(_stamp(_stampOf(n)),
                                    style: const TextStyle(
                                        fontSize: 12, color: _kGray)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text((n['content'] ?? '').toString(),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14, height: 1.35, color: _kInk)),
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

  /// EnvisionMealCommentIndicator: outlined speech bubble, orange dot when
  /// the meal has coach feedback. Opens the feedback sheet.
  Widget _commentIndicator(int i) {
    final id = i < _mealRefs.length ? _mealRefs[i].id : '';
    if (id.isEmpty) return const SizedBox.shrink();
    final has = _commentsFor(id).isNotEmpty;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _openFeedback(i),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.chat_bubble_outline, color: _kGray, size: 22),
            if (has)
              Positioned(
                right: -1,
                top: -1,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                      color: _kOrange, shape: BoxShape.circle),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// EnvisionMealFeedbackPreview: pale-peach inline coach feedback under the
  /// meal row, truncated to two lines. Hidden when there is no feedback.
  Widget _feedbackPreview(Map<String, dynamic> c, int i) {
    return GestureDetector(
      onTap: () => _openFeedback(i),
      child: Transform.translate(
        offset: const Offset(0, -10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
          decoration: const BoxDecoration(
            color: Color(0xFFFFF1E6),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16)),
          ),
          child: Text.rich(
            TextSpan(children: [
              const TextSpan(
                  text: 'Coach: ',
                  style:
                      TextStyle(fontWeight: FontWeight.w800, color: _kOrange)),
              TextSpan(text: (c['content'] ?? '').toString()),
            ]),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, height: 1.3, color: _kInk),
          ),
        ),
      ),
    );
  }

  /// EnvisionMealFeedbackSheet: all coach feedback for one meal.
  void _openFeedback(int i) {
    if (i >= _mealRefs.length) return;
    final list = _commentsFor(_mealRefs[i].id);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Coach feedback',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w900, color: _kInk)),
              const SizedBox(height: 12),
              if (list.isEmpty)
                const Text('No feedback on this meal yet.',
                    style: TextStyle(fontSize: 15, color: _kGray)),
              for (final c in list)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _smallAvatar(
                          _person(c['authorRef'] ?? c['coachRef']), 32),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                _firstName(_person(
                                        c['authorRef'] ?? c['coachRef'])) +
                                    '  ' +
                                    _stamp(_stampOf(c)),
                                style: const TextStyle(
                                    fontSize: 12, color: _kGray)),
                            const SizedBox(height: 2),
                            Text((c['content'] ?? '').toString(),
                                style: const TextStyle(
                                    fontSize: 15, height: 1.35, color: _kInk)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nutrition() {
    final w = _d;
    final goal = w.calorieGoal ?? 0;
    final eaten = w.caloriesConsumed ?? 0;
    final remaining = math.max(0, goal - eaten);
    final pct = goal <= 0 ? 0.0 : (eaten / goal).clamp(0.0, 1.0);
    final titles = w.mealTitles ?? const <String>[];
    final total = (w.mealKcals ?? const <int>[]).fold<int>(0, (a, b) => a + b);

    Widget macro(String l, double? n, double? g) {
      final cur = n ?? 0;
      final goal = g ?? 0;
      final p = goal <= 0 ? 0.0 : (cur / goal).clamp(0.0, 1.0);
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l,
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w700, color: _kInk)),
            const SizedBox(height: 2),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: '${cur.round()}',
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w700, color: _kInk)),
              TextSpan(
                  text: ' / ${goal.round()} g',
                  style: const TextStyle(fontSize: 15, color: _kGray)),
            ])),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                  value: p,
                  minHeight: 5,
                  backgroundColor: _kLine,
                  valueColor: const AlwaysStoppedAnimation(_kOrange)),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFDF1EB), Color(0xFFFBF8F6)]),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(goal > 0 ? 'Calories remaining' : 'Calories',
                            style: TextStyle(fontSize: 17, color: _kGray)),
                        const SizedBox(height: 6),
                        Text(_fmt(goal > 0 ? remaining : eaten),
                            style: const TextStyle(
                                fontSize: 50,
                                height: 1.05,
                                fontWeight: FontWeight.w900,
                                color: _kInk)),
                        const SizedBox(height: 4),
                        goal > 0
                            ? Text('of ${_fmt(goal)} kcal goal',
                                style: const TextStyle(
                                    fontSize: 16, color: _kGray))
                            : GestureDetector(
                                onTap: () =>
                                    showEnvisionNutritionGoals(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: _kOrange,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Text('Set Goal',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: CustomPaint(
                      painter: _RingPainter(pct),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${(pct * 100).round()}%',
                                style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900,
                                    color: _kInk)),
                            const Text('consumed',
                                style: TextStyle(fontSize: 14, color: _kGray)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  macro('Protein', w.proteinNow, w.proteinGoal),
                  const SizedBox(width: 18),
                  macro('Carbs', w.carbsNow, w.carbsGoal),
                  const SizedBox(width: 18),
                  macro('Fat', w.fatNow, w.fatGoal),
                ],
              ),
            ],
          ),
        ),
        _coachNoteCard(),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Meal Logs',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w900, color: _kInk)),
            Text('${_fmt(total)} kcal',
                style: const TextStyle(fontSize: 16, color: _kGray)),
          ],
        ),
        SizedBox(height: titles.isEmpty ? 0 : 12),
        if (titles.isEmpty)
          _empty('No meals logged yet. Tap + to log your first meal.',
              Icons.restaurant_outlined),
        for (int i = 0; i < titles.length; i++) _mealRow(i),
      ],
    );
  }

  Widget _mealRow(int i) {
    final id = i < _mealRefs.length ? _mealRefs[i].id : '';
    final cs = id.isEmpty ? <Map<String, dynamic>>[] : _commentsFor(id);
    return Column(children: [
      _mealRowBase(i),
      if (cs.isNotEmpty) _feedbackPreview(cs.first, i),
    ]);
  }

  Widget _mealRowBase(int i) {
    final w = _d;
    String at<T>(List<T>? l, String d) =>
        (l != null && i < l.length) ? '${l[i]}' : d;
    final img = at<String>(w.mealImages, '');
    return GestureDetector(
      onTap: w.onMealTap == null ? null : () => w.onMealTap!(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: _card(),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 70,
                height: 62,
                color: _kSubtle,
                child: img.isNotEmpty
                    ? Image.network(img,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.restaurant, color: _kGray))
                    : const Icon(Icons.restaurant, color: _kGray),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(at<String>(w.mealTitles, ''),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: _kInk)),
                  Text(at<String>(w.mealDescriptions, ''),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, color: _kGray)),
                ],
              ),
            ),
            _commentIndicator(i),
            Text('${at<int>(w.mealKcals, '0')} kcal',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700, color: _kInk)),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, color: _kGray, size: 22),
          ],
        ),
      ),
    );
  }

  bool _exDone(Map<String, dynamic> ex) {
    final r = ex['__ref'];
    if (r is! DocumentReference) return false;
    return _elogs.any((l) {
      final w = l['workout_exercise'];
      return w is DocumentReference && w.id == r.id && l['completed'] == true;
    });
  }

  Future<void> _openLog({int? only}) async {
    final p = _todayPlan;
    if (p == null) return;
    final rows = _exercises[(p['__ref'] as DocumentReference).id] ?? [];
    if (rows.isEmpty || !mounted) return;
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) =>
            _LogSheet(plan: p, exercises: rows, logs: _elogs, only: only));
  }

  // ---------------- training ----------------
  Widget _training() {
    final w = _d;
    final names = w.exerciseNames ?? const <String>[];
    final exRows = _todayPlan == null
        ? <Map<String, dynamic>>[]
        : (_exercises[(_todayPlan!['__ref'] as DocumentReference).id] ?? []);
    _done = List<bool>.generate(
        names.length, (i) => i < exRows.length && _exDone(exRows[i]));
    final completed = _done!.take(names.length).where((e) => e).length;
    final has = (w.workoutTitle ?? '').isNotEmpty;

    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 150),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF0B0B0B), Color(0xFF2B2B2E)]),
          ),
          child: Row(
            children: [
              Expanded(
                child: has
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Today's Workout",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(w.workoutTitle!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900)),
                          const SizedBox(height: 10),
                          Wrap(spacing: 14, children: [
                            _heroChip(
                                Icons.schedule, '${w.workoutMinutes ?? 0} min'),
                            _heroChip(Icons.fitness_center,
                                w.workoutType ?? 'Strength'),
                            if ((w.workoutFocus ?? '').isNotEmpty)
                              _heroChip(Icons.adjust, w.workoutFocus!),
                            _heroChip(
                                _todayPlan?['assigned_by_coach'] == true
                                    ? Icons.verified_outlined
                                    : Icons.person_outline,
                                _todayPlan?['assigned_by_coach'] == true
                                    ? 'Assigned by Coach'
                                    : 'Created by You'),
                          ]),
                        ],
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Today's Workout",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          SizedBox(height: 4),
                          Text('Rest day',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900)),
                          SizedBox(height: 6),
                          Text('No workout assigned for this date',
                              style: TextStyle(color: Color(0xFFBDBDC4))),
                        ],
                      ),
              ),
              if (has)
                GestureDetector(
                  onTap:
                      w.onLogWorkout == null ? null : () => w.onLogWorkout!(),
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.play_arrow, size: 36, color: _kInk),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
          decoration: _card(color: _kSubtle).copyWith(boxShadow: const []),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Workout Plan',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: _kInk)),
                  Text('$completed / ${names.length} complete',
                      style: const TextStyle(fontSize: 15, color: _kGray)),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                    value: names.isEmpty ? 0 : completed / names.length,
                    minHeight: 7,
                    backgroundColor: _kLine,
                    valueColor: const AlwaysStoppedAnimation(_kOrange)),
              ),
              const SizedBox(height: 8),
              if (names.isEmpty)
                _empty(
                    'No exercises planned for this day.', Icons.fitness_center),
              for (int i = 0; i < names.length; i++) _exerciseRow(i, names),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _pillAction(Icons.notes, 'Notes', _d.onNotes),
            const SizedBox(width: 10),
            _pillAction(
                Icons.videocam_outlined, 'Log Workout', _d.onLogWorkout),
            const SizedBox(width: 10),
            _pillAction(
                Icons.file_upload_outlined, 'Upload Video', _d.onUploadVideo),
          ],
        ),
      ],
    );
  }

  Widget _heroChip(IconData i, String t) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(i, color: Colors.white, size: 18),
          const SizedBox(width: 5),
          Text(t, style: const TextStyle(color: Colors.white, fontSize: 15)),
        ],
      );

  Widget _exerciseRow(int i, List<String> names) {
    final det = (_d.exerciseDetails != null && i < _d.exerciseDetails!.length)
        ? _d.exerciseDetails![i]
        : '';
    final done = _done![i];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
          border: i == 0 ? null : const Border(top: BorderSide(color: _kLine))),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 66,
              height: 56,
              color: const Color(0xFF1B1B1E),
              child: const Center(
                child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.play_arrow, size: 16, color: _kInk)),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(names[i],
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: _kInk)),
                Text(det, style: const TextStyle(fontSize: 15, color: _kGray)),
              ],
            ),
          ),
          GestureDetector(
            onTap: _isFuture ? null : () => _openLog(only: i),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: done ? _kOrange : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: done ? _kOrange : const Color(0xFFB8B8BF),
                    width: 1.5),
              ),
              child: done
                  ? const Icon(Icons.check, color: Colors.white, size: 22)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pillAction(IconData i, String t, Future Function()? f) => Expanded(
        child: GestureDetector(
          onTap: f == null ? null : () => f(),
          child: Container(
            height: 52,
            decoration: BoxDecoration(
                color: _kSubtle, borderRadius: BorderRadius.circular(26)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(i, size: 20, color: _kInk),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(t,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _kInk)),
                ),
              ],
            ),
          ),
        ),
      );

  // ---------------- progress ----------------
  Widget _progress() {
    final w = _d;
    final photos = w.photoUrls ?? const <String>[];

    Widget stat(String l, String? v, String unit, String? delta,
        {bool up = false}) {
      final hasDelta = delta != null && delta.isNotEmpty;
      up = hasDelta && delta.startsWith('+');
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l, style: const TextStyle(fontSize: 14, color: _kInk)),
            const SizedBox(height: 4),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: (v == null || v.isEmpty) ? '—' : v,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w900, color: _kInk)),
              TextSpan(
                  text: (v == null || v.isEmpty) ? '' : ' $unit',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700, color: _kInk)),
            ])),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: hasDelta ? const Color(0xFFDCF5E4) : _kLine,
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasDelta)
                    Icon(up ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        size: 18, color: _kGreen),
                  Text(hasDelta ? delta : '—',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: hasDelta ? _kGreen : _kGray)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final series = _metric == 0
        ? w.weightSeries
        : (_metric == 1 ? w.muscleSeries : w.bodyFatSeries);
    final tabs = ['Weight', 'Muscle', 'Body Fat'];
    final titles = ['Weight Trend', 'Muscle Trend', 'Body Fat Trend'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: _card(color: _kSubtle).copyWith(boxShadow: const []),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              stat('Weight', w.weight, 'lb', w.weightDelta),
              stat('Body Fat', w.bodyFat, '%', w.bodyFatDelta),
              stat('Muscle Mass', w.muscle, 'lb', w.muscleDelta, up: true),
              stat('BMI', w.bmi, '', null),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: _card(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Progress Photos',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: _kInk)),
                  GestureDetector(
                    onTap: w.onSeeAllPhotos == null
                        ? null
                        : () => w.onSeeAllPhotos!(),
                    child: const Row(children: [
                      Text('See All',
                          style: TextStyle(
                              color: _kOrange,
                              fontWeight: FontWeight.w700,
                              fontSize: 15)),
                      Icon(Icons.chevron_right, color: _kOrange, size: 18),
                    ]),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (photos.isEmpty)
                _empty('No progress photos yet. Add one from the + menu.',
                    Icons.photo_camera_outlined)
              else
                Row(
                  children: [
                    for (int i = 0; i < math.min(3, photos.length); i++) ...[
                      if (i > 0) const SizedBox(width: 8),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 0.85,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(photos[i],
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                        color: _kSubtle,
                                        child: const Icon(Icons.image,
                                            color: _kGray))),
                                Positioned(
                                  left: 8,
                                  bottom: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Text(
                                        (w.photoLabels != null &&
                                                i < w.photoLabels!.length)
                                            ? w.photoLabels![i]
                                            : '',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: _kInk)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: _card(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(titles[_metric],
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: _kInk)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: _kSubtle,
                        borderRadius: BorderRadius.circular(18)),
                    child: Row(
                      children: List.generate(3, (i) {
                        final sel = i == _metric;
                        return GestureDetector(
                          onTap: () => setState(() => _metric = i),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                color: sel ? _kOrange : Colors.transparent,
                                borderRadius: BorderRadius.circular(18)),
                            child: Text(tabs[i],
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: sel ? Colors.white : _kGray)),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 170,
                child: (series == null || series.length < 2)
                    ? _empty('Log at least two entries to see a trend.',
                        Icons.show_chart)
                    : CustomPaint(
                        size: const Size(double.infinity, 170),
                        painter: _TrendPainter(series, w.seriesLabels),
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text('Logs',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w900, color: _kInk)),
        const SizedBox(height: 10),
        Row(
          children: [
            _logCard(Icons.monitor_weight_outlined, 'Measurements',
                'Weight, BF, Muscle', w.onLogMeasurements),
            const SizedBox(width: 8),
            _logCard(Icons.photo_camera_outlined, 'Progress Photo',
                'Track visual changes', w.onLogPhoto),
            const SizedBox(width: 8),
            _logCard(
                Icons.bar_chart, 'Body Comp', 'Detailed metrics', w.onBodyComp),
          ],
        ),
      ],
    );
  }

  Widget _logCard(IconData i, String t, String s, Future Function()? f) =>
      Expanded(
        child: GestureDetector(
          onTap: f == null ? null : () => f(),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: _card(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(i, size: 26, color: _kInk),
                    const Icon(Icons.chevron_right, size: 16, color: _kGray),
                  ],
                ),
                const SizedBox(height: 6),
                Text(t,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: _kInk)),
                Text(s,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: _kGray)),
              ],
            ),
          ),
        ),
      );

  static String _fmt(int n) {
    final s = n.toString();
    final b = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
      b.write(s[i]);
    }
    return b.toString();
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter(this.pct);
  final double pct;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 14.0;
    final rect = Rect.fromLTWH(
        stroke / 2, stroke / 2, size.width - stroke, size.height - stroke);
    canvas.drawArc(
        rect,
        0,
        2 * math.pi,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = stroke
          ..color = const Color(0xFFE6E6E8));
    if (pct > 0) {
      canvas.drawArc(
          rect,
          -math.pi / 2,
          2 * math.pi * pct,
          false,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = stroke
            ..strokeCap = StrokeCap.round
            ..color = _kOrange);
    }
  }

  @override
  bool shouldRepaint(_RingPainter o) => o.pct != pct;
}

class _TrendPainter extends CustomPainter {
  _TrendPainter(this.v, this.labels);
  final List<double> v;
  final List<String>? labels;

  @override
  void paint(Canvas canvas, Size size) {
    const left = 36.0, bottom = 24.0, top = 8.0, right = 10.0;
    final minV = v.reduce(math.min);
    final maxV = v.reduce(math.max);
    final pad = (maxV - minV) == 0 ? 1.0 : (maxV - minV) * 0.25;
    final lo = minV - pad, hi = maxV + pad;
    final cw = size.width - left - right;
    final ch = size.height - top - bottom;
    Offset pt(int i) => Offset(left + cw * i / (v.length - 1),
        top + ch * (1 - (v[i] - lo) / (hi - lo)));

    final tp = TextPainter(textDirection: ui.TextDirection.ltr);
    void text(String s, Offset o, {bool right = false}) {
      tp.text = TextSpan(
          text: s, style: const TextStyle(fontSize: 12, color: _kGray));
      tp.layout();
      tp.paint(canvas, right ? Offset(o.dx - tp.width, o.dy) : o);
    }

    final grid = Paint()
      ..color = _kLine
      ..strokeWidth = 1;
    for (int g = 0; g < 4; g++) {
      final y = top + ch * g / 3;
      canvas.drawLine(Offset(left, y), Offset(left + cw, y), grid);
      text((hi - (hi - lo) * g / 3).round().toString(), Offset(left - 6, y - 7),
          right: true);
    }

    final path = Path()..moveTo(pt(0).dx, pt(0).dy);
    for (int i = 1; i < v.length; i++) {
      final a = pt(i - 1), b = pt(i);
      final mx = (a.dx + b.dx) / 2;
      path.cubicTo(mx, a.dy, mx, b.dy, b.dx, b.dy);
    }
    final fill = Path.from(path)
      ..lineTo(pt(v.length - 1).dx, top + ch)
      ..lineTo(pt(0).dx, top + ch)
      ..close();
    canvas.drawPath(
        fill,
        Paint()
          ..shader = const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x40FF6500), Color(0x00FF6500)])
              .createShader(Rect.fromLTWH(left, top, cw, ch)));
    canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..color = _kOrange);
    for (int i = 0; i < v.length; i++) {
      canvas.drawCircle(pt(i), 5, Paint()..color = Colors.white);
      canvas.drawCircle(
          pt(i),
          5,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = _kOrange);
    }
    if (labels != null) {
      final n = math.min(labels!.length, v.length);
      for (int i = 0; i < n; i++) {
        tp.text = TextSpan(
            text: labels![i],
            style: const TextStyle(fontSize: 12, color: _kGray));
        tp.layout();
        final x = (pt(i).dx - tp.width / 2)
            .clamp(0.0, size.width - tp.width)
            .toDouble();
        tp.paint(canvas, Offset(x, size.height - 16));
      }
    }
  }

  @override
  bool shouldRepaint(_TrendPainter o) => true;
}
// ============================================================
// PASTE THIS BLOCK AT THE VERY END of EnvisionDashboard
// (after the _TrendPainter class, before the final "// Set your widget
// name..." comment). It adds: Add Workout sheet (Coach Workouts + Create
// Your Own) and the workout logger. No new imports needed.
// ============================================================

class _LibEx {
  const _LibEx(this.name, this.muscle, this.equip);
  final String name;
  final String muscle;
  final String equip;
}

const List<_LibEx> _kLib = [
  _LibEx('Bench Press', 'Chest · Triceps', 'Barbell'),
  _LibEx('Incline Dumbbell Press', 'Chest · Shoulders', 'Dumbbell'),
  _LibEx('Push-Up', 'Chest · Triceps', 'Bodyweight'),
  _LibEx('Cable Fly', 'Chest', 'Cable'),
  _LibEx('Overhead Press', 'Shoulders · Triceps', 'Barbell'),
  _LibEx('Shoulder Press', 'Shoulders', 'Dumbbell'),
  _LibEx('Lateral Raise', 'Shoulders', 'Dumbbell'),
  _LibEx('Face Pull', 'Rear Delts · Back', 'Cable'),
  _LibEx('Pull-Up', 'Back · Biceps', 'Bodyweight'),
  _LibEx('Lat Pulldown', 'Back · Biceps', 'Cable'),
  _LibEx('Bent Over Row', 'Back · Biceps', 'Barbell'),
  _LibEx('Dumbbell Row', 'Back', 'Dumbbell'),
  _LibEx('Seated Cable Row', 'Back', 'Cable'),
  _LibEx('Deadlift', 'Back · Glutes · Hamstrings', 'Barbell'),
  _LibEx('Romanian Deadlift', 'Hamstrings · Glutes', 'Barbell'),
  _LibEx('Squat', 'Legs · Glutes', 'Barbell'),
  _LibEx('Front Squat', 'Quads · Core', 'Barbell'),
  _LibEx('Goblet Squat', 'Quads · Glutes', 'Dumbbell'),
  _LibEx('Leg Press', 'Quads · Glutes', 'Machine'),
  _LibEx('Lunge', 'Quads · Glutes', 'Dumbbell'),
  _LibEx('Bulgarian Split Squat', 'Quads · Glutes', 'Dumbbell'),
  _LibEx('Leg Curl', 'Hamstrings', 'Machine'),
  _LibEx('Leg Extension', 'Quads', 'Machine'),
  _LibEx('Hip Thrust', 'Glutes', 'Barbell'),
  _LibEx('Calf Raise', 'Calves', 'Machine'),
  _LibEx('Bicep Curl', 'Biceps', 'Dumbbell'),
  _LibEx('Hammer Curl', 'Biceps · Forearms', 'Dumbbell'),
  _LibEx('Tricep Pushdown', 'Triceps', 'Cable'),
  _LibEx('Skull Crusher', 'Triceps', 'Barbell'),
  _LibEx('Dips', 'Chest · Triceps', 'Bodyweight'),
  _LibEx('Plank', 'Core', 'Bodyweight'),
  _LibEx('Hanging Leg Raise', 'Core', 'Bodyweight'),
  _LibEx('Cable Crunch', 'Core', 'Cable'),
  _LibEx('Russian Twist', 'Core', 'Bodyweight'),
  _LibEx('Kettlebell Swing', 'Glutes · Back', 'Kettlebell'),
  _LibEx('Burpee', 'Full Body', 'Bodyweight'),
];

class _Sel {
  _Sel(this.name, this.muscle);
  final String name;
  final String muscle;
  int sets = 3;
  int reps = 10;
  double weight = 0;
  int rest = 60;
}

Future<DateTime?> _showWorkoutSheets(BuildContext context, DateTime date) =>
    showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _WorkoutSheets(date: date),
    );

class _WorkoutSheets extends StatefulWidget {
  const _WorkoutSheets({required this.date});
  final DateTime date;
  @override
  State<_WorkoutSheets> createState() => _WorkoutSheetsState();
}

class _WorkoutSheetsState extends State<_WorkoutSheets> {
  int _tab = 0;
  final _name = TextEditingController();
  final _search = TextEditingController();
  final List<_Sel> _sel = [];
  List<Map<String, dynamic>> _coach = [];
  final Map<String, int> _counts = {};
  bool _loading = true;
  bool _saving = false;
  String? _err;

  @override
  void initState() {
    super.initState();
    _loadCoach();
  }

  @override
  void dispose() {
    _name.dispose();
    _search.dispose();
    super.dispose();
  }

  Future<void> _loadCoach() async {
    final me = currentUserReference;
    if (me == null) {
      if (mounted) setState(() => _loading = false);
      return;
    }
    try {
      final db = FirebaseFirestore.instance;
      final q = await db
          .collection('workout_plans')
          .where('client', isEqualTo: me)
          .get();
      final rows = q.docs
          .map((d) {
            final m = Map<String, dynamic>.from(d.data());
            m['__ref'] = d.reference;
            return m;
          })
          .where((m) => m['assigned_by_coach'] == true)
          .toList();
      DateTime dtOf(dynamic v) => v is Timestamp ? v.toDate() : DateTime(2000);
      rows.sort((a, b) =>
          dtOf(b['scheduled_date']).compareTo(dtOf(a['scheduled_date'])));
      for (final m in rows) {
        final ref = m['__ref'] as DocumentReference;
        try {
          final agg = await db
              .collection('workout_exercises')
              .where('workout', isEqualTo: ref)
              .count()
              .get();
          _counts[ref.id] = agg.count ?? 0;
        } catch (_) {}
      }
      if (!mounted) return;
      setState(() {
        _coach = rows;
        _loading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) {
      setState(() => _err = 'Give your workout a name.');
      return;
    }
    if (_sel.isEmpty) {
      setState(() => _err = 'Add at least one exercise.');
      return;
    }
    final me = currentUserReference;
    if (me == null) {
      setState(() => _err = 'Please sign in again.');
      return;
    }
    setState(() {
      _saving = true;
      _err = null;
    });
    try {
      final db = FirebaseFirestore.instance;
      final batch = db.batch();
      final planRef = db.collection('workout_plans').doc();
      var secs = 0;
      for (final s in _sel) {
        secs += s.sets * (40 + s.rest);
      }
      final mins = (secs / 60).round().clamp(10, 180);
      final d = widget.date;
      batch.set(planRef, {
        'client': me,
        'workout_name': name,
        'workout_type': 'Custom',
        'scheduled_date': Timestamp.fromDate(DateTime(d.year, d.month, d.day)),
        'duration_min': mins,
        'assigned_by_coach': false,
        'status': 'scheduled',
        'notes': '',
      });
      for (int i = 0; i < _sel.length; i++) {
        final s = _sel[i];
        batch.set(db.collection('workout_exercises').doc(), {
          'workout': planRef,
          'exercise_name': s.name,
          'exercise_order': i,
          'sets': s.sets,
          'target_reps': '${s.reps}',
          'rest_seconds': s.rest,
          'target_weight': s.weight,
          'instructions': '',
        });
      }
      await batch.commit();
      if (!mounted) return;
      Navigator.pop(context, d);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _err = 'Could not save. Try again.';
      });
    }
  }

  Widget _seg() {
    Widget t(int i, String label) {
      final sel = _tab == i;
      return Expanded(
        child: GestureDetector(
          onTap: () => setState(() => _tab = i),
          child: Container(
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: sel ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
              border: sel ? Border.all(color: _kLine) : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: sel ? FontWeight.w800 : FontWeight.w500,
                        color: sel ? _kInk : _kGray)),
                if (sel)
                  Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 90,
                      height: 3,
                      decoration: BoxDecoration(
                          color: _kOrange,
                          borderRadius: BorderRadius.circular(2))),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: _kSubtle, borderRadius: BorderRadius.circular(18)),
      child: Row(children: [t(0, 'Coach Workouts'), t(1, 'Create My Own')]),
    );
  }

  Widget _coachTab() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const Text('Assigned by your coach',
            style: TextStyle(fontSize: 15, color: _kGray)),
        const SizedBox(height: 10),
        if (_loading)
          const Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                  child: CircularProgressIndicator(
                      color: _kOrange, strokeWidth: 2)))
        else if (_coach.isEmpty)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: _kSubtle, borderRadius: BorderRadius.circular(18)),
            child: const Text(
                'No workouts from your coach yet. They will show up here once assigned.',
                style: TextStyle(fontSize: 15, color: _kGray)),
          ),
        for (final m in _coach) _coachCard(m),
        const SizedBox(height: 18),
        const Divider(color: _kLine),
        const SizedBox(height: 12),
        const Text('Or start from scratch',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w900, color: _kInk)),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => setState(() => _tab = 1),
          child: Container(
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: _kInk, borderRadius: BorderRadius.circular(28)),
            child: const Text('Create Custom Workout',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _coachCard(Map<String, dynamic> m) {
    final ref = m['__ref'] as DocumentReference;
    final n = _counts[ref.id];
    final sd = m['scheduled_date'];
    final dur = ((m['duration_min'] ?? 0) as num).toInt();
    final label = sd is Timestamp
        ? '${_EnvisionDashboardState._mo[sd.toDate().month - 1]} ${sd.toDate().day}'
        : '';
    return GestureDetector(
      onTap: () {
        if (sd is Timestamp) Navigator.pop(context, sd.toDate());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: _kSubtle, borderRadius: BorderRadius.circular(18)),
        child: Row(children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
                color: _kInk, borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.fitness_center, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text((m['workout_name'] ?? 'Workout').toString(),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: _kInk)),
                const SizedBox(height: 2),
                Text('${n == null ? '' : '$n exercises · '}$dur min',
                    style: const TextStyle(fontSize: 14, color: _kGray)),
                if (label.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFE3CF),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(label,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: _kOrange)),
                  ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: _kInk),
        ]),
      ),
    );
  }

  Widget _field(String hint, TextEditingController c,
      {IconData? icon, ValueChanged<String>? onChanged}) {
    return TextField(
      controller: c,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: _kGray),
        prefixIcon: icon == null ? null : Icon(icon, color: _kInk),
        filled: true,
        fillColor: _kSubtle,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none),
      ),
    );
  }

  Widget _stepper(
      String label, String value, VoidCallback minus, VoidCallback plus) {
    Widget b(IconData i, VoidCallback f) => GestureDetector(
          onTap: f,
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
                color: Color(0xFFE9E9EC), shape: BoxShape.circle),
            child: Icon(i, size: 18, color: _kInk),
          ),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: _kGray)),
        const SizedBox(height: 4),
        Row(children: [
          b(Icons.remove, minus),
          SizedBox(
              width: 44,
              child: Text(value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w800))),
          b(Icons.add, plus),
        ]),
      ],
    );
  }

  Widget _selCard(int i) {
    final s = _sel[i];
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kLine)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.name,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w900)),
                  Text(s.muscle,
                      style: const TextStyle(fontSize: 13, color: _kGray)),
                ],
              ),
            ),
            GestureDetector(
                onTap: i == 0
                    ? null
                    : () => setState(() {
                          final t = _sel.removeAt(i);
                          _sel.insert(i - 1, t);
                        }),
                child: Icon(Icons.arrow_upward,
                    size: 20, color: i == 0 ? _kLine : _kInk)),
            const SizedBox(width: 10),
            GestureDetector(
                onTap: i == _sel.length - 1
                    ? null
                    : () => setState(() {
                          final t = _sel.removeAt(i);
                          _sel.insert(i + 1, t);
                        }),
                child: Icon(Icons.arrow_downward,
                    size: 20, color: i == _sel.length - 1 ? _kLine : _kInk)),
            const SizedBox(width: 10),
            GestureDetector(
                onTap: () => setState(() => _sel.removeAt(i)),
                child: const Icon(Icons.close, size: 20, color: _kGray)),
          ]),
          const SizedBox(height: 10),
          Wrap(spacing: 14, runSpacing: 10, children: [
            _stepper(
                'Sets',
                '${s.sets}',
                () => setState(() => s.sets = math.max(1, s.sets - 1)),
                () => setState(() => s.sets = math.min(10, s.sets + 1))),
            _stepper(
                'Reps',
                '${s.reps}',
                () => setState(() => s.reps = math.max(1, s.reps - 1)),
                () => setState(() => s.reps = math.min(50, s.reps + 1))),
            _stepper(
                'Weight (lb)',
                s.weight == 0 ? '—' : '${s.weight.round()}',
                () => setState(() => s.weight = math.max(0, s.weight - 5)),
                () => setState(() => s.weight = s.weight + 5)),
            _stepper(
                'Rest (s)',
                '${s.rest}',
                () => setState(() => s.rest = math.max(0, s.rest - 15)),
                () => setState(() => s.rest = math.min(600, s.rest + 15))),
          ]),
        ],
      ),
    );
  }

  Widget _createTab() {
    final q = _search.text.trim().toLowerCase();
    final results = _kLib
        .where((e) =>
            !_sel.any((s) => s.name == e.name) &&
            (q.isEmpty ||
                e.name.toLowerCase().contains(q) ||
                e.muscle.toLowerCase().contains(q) ||
                e.equip.toLowerCase().contains(q)))
        .take(8)
        .toList();
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const Text('Build a custom workout and save it for later.',
                  style: TextStyle(fontSize: 16, color: _kGray)),
              const SizedBox(height: 16),
              const Text('Workout Name',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900, color: _kInk)),
              const SizedBox(height: 8),
              _field('e.g. Push Day, Upper Body, Full Body', _name),
              const SizedBox(height: 18),
              const Text('Add Exercises',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900, color: _kInk)),
              const SizedBox(height: 8),
              _field('Search exercises...', _search,
                  icon: Icons.search, onChanged: (_) => setState(() {})),
              const SizedBox(height: 8),
              for (final e in results)
                GestureDetector(
                  onTap: () => setState(() => _sel.add(_Sel(e.name, e.muscle))),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: _kSubtle,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                            color: _kInk,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.fitness_center,
                            color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w800)),
                            Text('${e.muscle} · ${e.equip}',
                                style: const TextStyle(
                                    fontSize: 13, color: _kGray)),
                          ],
                        ),
                      ),
                      Container(
                        width: 34,
                        height: 34,
                        decoration: const BoxDecoration(
                            color: _kOrange, shape: BoxShape.circle),
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 20),
                      ),
                    ]),
                  ),
                ),
              if (_sel.isNotEmpty) ...[
                const SizedBox(height: 14),
                const Text('Your Workout',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: _kInk)),
                const SizedBox(height: 8),
                for (int i = 0; i < _sel.length; i++) _selCard(i),
              ],
            ],
          ),
        ),
        if (_err != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(_err!,
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w600)),
          ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: _saving ? null : _save,
          child: Container(
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: _kInk, borderRadius: BorderRadius.circular(28)),
            child: Text(_saving ? 'Saving...' : 'Save Workout',
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final avail = mq.size.height - mq.viewInsets.bottom - mq.padding.top - 8;
    return Padding(
      padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
      child: Container(
        height: math.min(mq.size.height * 0.92, avail),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
        padding: EdgeInsets.fromLTRB(20, 12, 20, mq.padding.bottom + 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                        color: _kLine,
                        borderRadius: BorderRadius.circular(4)))),
            Row(children: [
              Expanded(
                child: Text(
                    _tab == 0 ? 'Add Workout' : 'Create Your Own Workout',
                    style: const TextStyle(
                        fontSize: 28,
                        height: 1.1,
                        fontWeight: FontWeight.w900,
                        color: _kInk)),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      color: _kSubtle, shape: BoxShape.circle),
                  child: const Icon(Icons.close, size: 22, color: _kInk),
                ),
              ),
            ]),
            const SizedBox(height: 14),
            _seg(),
            const SizedBox(height: 14),
            Expanded(child: _tab == 0 ? _coachTab() : _createTab()),
          ],
        ),
      ),
    );
  }
}

// ---------------- Workout logger ----------------
class _LogSheet extends StatefulWidget {
  const _LogSheet({
    required this.plan,
    required this.exercises,
    required this.logs,
    this.only,
  });
  final Map<String, dynamic> plan;
  final List<Map<String, dynamic>> exercises;
  final List<Map<String, dynamic>> logs;
  final int? only;
  @override
  State<_LogSheet> createState() => _LogSheetState();
}

class _LogSheetState extends State<_LogSheet> {
  late final List<int> _idx = widget.only != null
      ? [widget.only!]
      : List<int>.generate(widget.exercises.length, (i) => i);
  final Map<String, List<TextEditingController>> _reps = {};
  final Map<String, List<TextEditingController>> _wts = {};
  final Map<String, List<bool>> _ok = {};
  bool _saving = false;
  String? _err;

  String _id(int i) => (widget.exercises[i]['__ref'] as DocumentReference).id;
  int _sets(int i) =>
      ((widget.exercises[i]['sets'] ?? 3) as num).toInt().clamp(1, 12);

  Map<String, dynamic>? _log(int i) {
    for (final l in widget.logs) {
      final w = l['workout_exercise'];
      if (w is DocumentReference && w.id == _id(i)) return l;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    for (final i in _idx) {
      final ex = widget.exercises[i];
      final n = _sets(i);
      final log = _log(i);
      final defReps =
          RegExp(r'\d+').firstMatch('${ex['target_reps'] ?? ''}')?.group(0) ??
              '';
      final tw = (ex['target_weight'] is num)
          ? (ex['target_weight'] as num).toDouble()
          : 0.0;
      final lr =
          (log?['actual_reps'] is List) ? log!['actual_reps'] as List : [];
      final lw = (log?['actual_weights'] is List)
          ? log!['actual_weights'] as List
          : [];
      final cs = ((log?['completed_sets'] ?? 0) as num).toInt();
      _reps[_id(i)] = List.generate(
          n,
          (j) => TextEditingController(
              text: j < lr.length ? '${lr[j]}' : defReps));
      _wts[_id(i)] = List.generate(
          n,
          (j) => TextEditingController(
              text: j < lw.length
                  ? ((lw[j] as num) == 0 ? '' : '${(lw[j] as num).round()}')
                  : (tw > 0 ? '${tw.round()}' : '')));
      _ok[_id(i)] = List.generate(n, (j) => j < cs);
    }
  }

  @override
  void dispose() {
    for (final l in [..._reps.values, ..._wts.values]) {
      for (final c in l) {
        c.dispose();
      }
    }
    super.dispose();
  }

  Future<void> _save() async {
    final me = currentUserReference;
    if (me == null) return;
    setState(() {
      _saving = true;
      _err = null;
    });
    try {
      final db = FirebaseFirestore.instance;
      final batch = db.batch();
      final finished = <String, bool>{};
      for (final i in _idx) {
        final id = _id(i);
        final n = _sets(i);
        final reps = <int>[];
        final wts = <double>[];
        var done = 0;
        for (int j = 0; j < n; j++) {
          if (_ok[id]![j]) {
            reps.add(int.tryParse(_reps[id]![j].text.trim()) ?? 0);
            wts.add(double.tryParse(_wts[id]![j].text.trim()) ?? 0);
            done++;
          }
        }
        final existing = _log(i);
        final data = {
          'workout_exercise': widget.exercises[i]['__ref'],
          'client': me,
          'completed_sets': done,
          'actual_reps': reps,
          'actual_weights': wts,
          'completed': done >= n,
          'logged_at': Timestamp.now(),
        };
        if (existing != null && existing['__ref'] is DocumentReference) {
          batch.update(existing['__ref'] as DocumentReference, data);
        } else if (done > 0) {
          batch.set(db.collection('exercise_logs').doc(), data);
        }
        finished[id] = done >= n;
      }
      for (int i = 0; i < widget.exercises.length; i++) {
        final id = _id(i);
        if (finished.containsKey(id)) continue;
        final l = _log(i);
        finished[id] = l != null && l['completed'] == true;
      }
      final all = finished.values.isNotEmpty && finished.values.every((v) => v);
      final any = finished.values.any((v) => v) ||
          _ok.values.any((l) => l.any((v) => v));
      final planRef = widget.plan['__ref'] as DocumentReference;
      if (all) {
        batch.update(
            planRef, {'status': 'completed', 'completed_at': Timestamp.now()});
      } else if (any) {
        batch.update(planRef, {'status': 'in_progress'});
      }
      await batch.commit();
      if (!mounted) return;
      Navigator.pop(context);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _err = 'Could not save. Try again.';
      });
    }
  }

  Widget _num(TextEditingController c, String hint) => SizedBox(
        width: 70,
        height: 40,
        child: TextField(
          controller: c,
          textAlign: TextAlign.center,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: _kGray, fontSize: 13),
            filled: true,
            fillColor: _kSubtle,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
          ),
        ),
      );

  Widget _exCard(int i) {
    final ex = widget.exercises[i];
    final id = _id(i);
    final n = _sets(i);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: _kSubtle, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text((ex['exercise_name'] ?? '').toString(),
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          Text(
              'Target: ${ex['sets'] ?? '-'} sets × ${ex['target_reps'] ?? '-'} reps',
              style: const TextStyle(fontSize: 13, color: _kGray)),
          const SizedBox(height: 10),
          for (int j = 0; j < n; j++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(children: [
                SizedBox(
                    width: 52,
                    child: Text('Set ${j + 1}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700))),
                _num(_wts[id]![j], 'lb'),
                const SizedBox(width: 8),
                _num(_reps[id]![j], 'reps'),
                const Spacer(),
                GestureDetector(
                  onTap: () => setState(() => _ok[id]![j] = !_ok[id]![j]),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: _ok[id]![j] ? _kOrange : Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                          color:
                              _ok[id]![j] ? _kOrange : const Color(0xFFB8B8BF),
                          width: 1.5),
                    ),
                    child: _ok[id]![j]
                        ? const Icon(Icons.check, color: Colors.white, size: 22)
                        : null,
                  ),
                ),
              ]),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final avail = mq.size.height - mq.viewInsets.bottom - mq.padding.top - 8;
    return Padding(
      padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
      child: Container(
        height: math.min(mq.size.height * 0.9, avail),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
        padding: EdgeInsets.fromLTRB(20, 12, 20, mq.padding.bottom + 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                        color: _kLine,
                        borderRadius: BorderRadius.circular(4)))),
            Row(children: [
              Expanded(
                child: Text(
                    widget.only != null
                        ? 'Log exercise'
                        : (widget.plan['workout_name'] ?? 'Log workout')
                            .toString(),
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: _kInk)),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      color: _kSubtle, shape: BoxShape.circle),
                  child: const Icon(Icons.close, size: 22, color: _kInk),
                ),
              ),
            ]),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [for (final i in _idx) _exCard(i)],
              ),
            ),
            if (_err != null)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(_err!,
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600)),
              ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _saving ? null : _save,
              child: Container(
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: _kOrange, borderRadius: BorderRadius.circular(28)),
                child: Text(_saving ? 'Saving...' : 'Save progress',
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the `</>` button on the right!

class _Pulse extends StatefulWidget {
  final Widget child;
  const _Pulse({required this.child});
  @override
  State<_Pulse> createState() => _PulseState();
}

class _PulseState extends State<_Pulse> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1100))
    ..repeat(reverse: true);
  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
      opacity: Tween<double>(begin: 0.45, end: 1.0)
          .animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut)),
      child: widget.child);
}
