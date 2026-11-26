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

import '/auth/firebase_auth/auth_util.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_functions/cloud_functions.dart';

const _cOrange = Color(0xFFFF6500);
const _cInk = Color(0xFF0B0B0B);
const _cGray = Color(0xFF85858D);
const _cSubtle = Color(0xFFF7F7F8);
const _cLine = Color(0xFFEEEEF0);
const _cGreen = Color(0xFF16A34A);
const _cPeach = Color(0xFFFFF1E8);

class _RingPainter extends CustomPainter {
  _RingPainter(this.pct);
  final double pct;
  @override
  void paint(Canvas c, Size s) {
    final r = s.width / 2 - 7;
    final center = Offset(s.width / 2, s.height / 2);
    final bg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..color = const Color(0xFFF3E4D8)
      ..strokeCap = StrokeCap.round;
    final fg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..color = _cOrange
      ..strokeCap = StrokeCap.round;
    c.drawCircle(center, r, bg);
    c.drawArc(Rect.fromCircle(center: center, radius: r), -math.pi / 2,
        2 * math.pi * pct.clamp(0.0, 1.0).toDouble(), false, fg);
  }

  @override
  bool shouldRepaint(_RingPainter o) => o.pct != pct;
}

class _LinePainter extends CustomPainter {
  _LinePainter(this.v);
  final List<double> v;
  @override
  void paint(Canvas c, Size s) {
    if (v.isEmpty) return;
    final grid = Paint()
      ..color = const Color(0xFFEEEEF0)
      ..strokeWidth = 1;
    for (var i = 0; i < 4; i++) {
      final y = 10 + (s.height - 20) * i / 3;
      c.drawLine(Offset(0, y), Offset(s.width, y), grid);
    }
    final mn = v.reduce(math.min);
    final mx = v.reduce(math.max);
    final span = (mx - mn).abs() < 0.0001 ? 1.0 : (mx - mn);
    Offset pt(int i) {
      final x =
          v.length == 1 ? s.width / 2 : 8 + (s.width - 16) * i / (v.length - 1);
      final y = (s.height - 24) - ((v[i] - mn) / span) * (s.height - 48) + 12;
      return Offset(x, y);
    }

    final line = Paint()
      ..color = _cOrange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path();
    for (var i = 0; i < v.length; i++) {
      final p = pt(i);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    if (v.length > 1) c.drawPath(path, line);
    final dot = Paint()..color = _cOrange;
    final ring = Paint()..color = Colors.white;
    for (var i = 0; i < v.length; i++) {
      final p = pt(i);
      c.drawCircle(p, 6, ring);
      c.drawCircle(p, 4, dot);
    }
  }

  @override
  bool shouldRepaint(_LinePainter o) => o.v != v;
}

class EnvisionCoachClients extends StatefulWidget {
  const EnvisionCoachClients({super.key, this.width, this.height});
  final double? width;
  final double? height;
  @override
  State<EnvisionCoachClients> createState() => _EnvisionCoachClientsState();
}

class _EnvisionCoachClientsState extends State<EnvisionCoachClients> {
  String _view = 'main';
  int _nav = 1;
  int _filter = 0;
  String _q = '';
  String _convQ = '';
  int _tab = 0;
  int _range = 1;
  int _metric = 0;
  late DateTime _date;
  DocumentReference<Map<String, dynamic>>? _meRef;
  Map<String, dynamic> _me = {};
  bool _redirected = false;
  List<Map<String, dynamic>> _clients = [];
  List<Map<String, dynamic>> _allMsgs = [];
  final Map<String, DateTime> _lastLog = {};
  bool _loading = true;
  String? _err;
  Map<String, dynamic>? _sel;
  List<Map<String, dynamic>> _logs = [];
  List<Map<String, dynamic>> _comments = [];
  List<Map<String, dynamic>> _notes = [];
  List<Map<String, dynamic>> _goals = [];
  List<Map<String, dynamic>> _plans = [];
  List<Map<String, dynamic>> _subV = [];
  List<Map<String, dynamic>> _exLogs = [];
  List<Map<String, dynamic>> _meas = [];
  List<Map<String, dynamic>> _photos = [];
  final List<StreamSubscription> _subs = [];
  final List<StreamSubscription> _logSubs = [];
  final List<StreamSubscription> _selSubs = [];

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

  @override
  void initState() {
    super.initState();
    _date = _today();
    _listen();
  }

  @override
  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    for (final s in _logSubs) {
      s.cancel();
    }
    for (final s in _selSubs) {
      s.cancel();
    }
    super.dispose();
  }

  // ---------- helpers ----------
  DateTime _today() {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day);
  }

  DateTime? _dt(dynamic v) {
    if (v is Timestamp) return v.toDate();
    if (v is DateTime) return v;
    return null;
  }

  bool _same(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  int _i(dynamic v) {
    if (v is num) return v.toInt();
    return int.tryParse(v.toString()) ?? 0;
  }

  double _d(dynamic v) {
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }

  String _s(dynamic v) => v == null ? '' : v.toString();

  Map<String, dynamic> _m(QueryDocumentSnapshot<Map<String, dynamic>> d) {
    return {...d.data(), 'id': d.id, 'ref': d.reference};
  }

  String _ago(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return diff.inMinutes.toString() + 'm ago';
    if (diff.inHours < 24) return diff.inHours.toString() + 'h ago';
    return diff.inDays.toString() + 'd ago';
  }

  String _clock(DateTime t) {
    final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final m = t.minute.toString().padLeft(2, '0');
    return h.toString() + ':' + m + (t.hour >= 12 ? ' PM' : ' AM');
  }

  String _label(DateTime d) =>
      _wd[d.weekday - 1] + ', ' + _mo[d.month - 1] + ' ' + d.day.toString();

  String _short(DateTime d) => _mo[d.month - 1] + ' ' + d.day.toString();

  String _fmt(int n) {
    final s = n.toString();
    final b = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
      b.write(s[i]);
    }
    return b.toString();
  }

  String _num1(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toStringAsFixed(1);

  String _cap(String t) => t.isEmpty ? t : t[0].toUpperCase() + t.substring(1);

  void _toast(String t) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t)));
  }

  bool _isCoach(Map<String, dynamic> u) {
    final r = _s(u['role']).toLowerCase();
    if (r.contains('coach') || r.contains('train')) return true;
    return u['coach'] == null &&
        (_s(u['coachCode']).isNotEmpty ||
            _s(u['gymName']).isNotEmpty ||
            _s(u['whatYouCoach']).isNotEmpty);
  }

  List<Map<String, dynamic>> _desc(List<Map<String, dynamic>> l, String key) {
    final out = List<Map<String, dynamic>>.from(l);
    out.sort((a, b) => (_dt(b[key]) ?? DateTime(2000))
        .compareTo(_dt(a[key]) ?? DateTime(2000)));
    return out;
  }

  // ---------- data ----------
  void _listen() {
    final u = FirebaseAuth.instance.currentUser;
    if (u == null) {
      _loading = false;
      return;
    }
    final db = FirebaseFirestore.instance;
    _meRef = db.collection('users').doc(u.uid);
    _subs.add(_meRef!.snapshots().listen((s) {
      if (!mounted) return;
      final data = s.data() ?? {};
      if (s.exists && !_redirected && !_isCoach(data)) {
        _redirected = true;
        context.goNamed('EnvisionClientDashboard');
        return;
      }
      setState(() => _me = data);
    }, onError: (_) {}));
    final listCoachClients = FirebaseFunctions.instanceFor(
      region: 'us-central1',
    ).httpsCallable('listCoachClients');

    _subs.add(db
        .collection('coach_clients')
        .where('coach_id', isEqualTo: u.uid)
        .where('status', isEqualTo: 'active')
        .snapshots()
        .asyncMap((_) async {
      final response = await listCoachClients.call();
      final data = Map<String, dynamic>.from(response.data as Map);
      final rows = data['clients'] as List;

      final list = rows.map((item) {
        final row = Map<String, dynamic>.from(item as Map);
        final id = row['id'] as String;
        return <String, dynamic>{
          'id': id,
          'ref': db.collection('users').doc(id),
          'display_name': row['display_name'],
          'photo_url': row['photo_url'],
        };
      }).toList();

      list.sort((a, b) => _s(a['display_name'])
          .toLowerCase()
          .compareTo(_s(b['display_name']).toLowerCase()));
      return list;
    }).listen((list) {
      if (!mounted || FirebaseAuth.instance.currentUser?.uid != u.uid) return;
      setState(() {
        _clients = list;
        _loading = false;
        _err = null;
      });
      _listenLastLogs();
    }, onError: (Object error) {
      if (!mounted || FirebaseAuth.instance.currentUser?.uid != u.uid) return;
      final code = error is FirebaseFunctionsException
          ? error.code
          : error.runtimeType.toString();
      debugPrint('Coach directory load failed: $code');
      setState(() {
        _loading = false;
        _err = 'Could not load your clients.';
      });
    }));
    _subs.add(db
        .collection('messages')
        .where('coachRef', isEqualTo: _meRef)
        .snapshots()
        .listen((s) {
      if (mounted) setState(() => _allMsgs = s.docs.map(_m).toList());
    }, onError: (_) {}));
  }

  void _listenLastLogs() {
    for (final s in _logSubs) {
      s.cancel();
    }
    _logSubs.clear();
    final refs = _clients.map((c) => c['ref']).toList();
    for (var i = 0; i < refs.length; i += 10) {
      final chunk = refs.sublist(i, math.min(i + 10, refs.length));
      _logSubs.add(FirebaseFirestore.instance
          .collection('food_logs')
          .where('client', whereIn: chunk)
          .snapshots()
          .listen((s) {
        final m = <String, DateTime>{};
        for (final d in s.docs) {
          final c = d.data()['client'];
          final t = _dt(d.data()['logged_at']);
          if (c is DocumentReference && t != null) {
            final old = m[c.id];
            if (old == null || t.isAfter(old)) m[c.id] = t;
          }
        }
        if (mounted) setState(() => _lastLog.addAll(m));
      }, onError: (_) {}));
    }
  }

  void _watch(String col, String field, dynamic ref, dynamic id,
      void Function(List<Map<String, dynamic>>) set) {
    _selSubs.add(FirebaseFirestore.instance
        .collection(col)
        .where(field, isEqualTo: ref)
        .snapshots()
        .listen((s) {
      if (!mounted || _sel?['id'] != id) return;
      setState(() => set(s.docs.map(_m).toList()));
    }, onError: (_) {}));
  }

  void _open(Map<String, dynamic> c, {int tab = 0}) {
    for (final s in _selSubs) {
      s.cancel();
    }
    _selSubs.clear();
    final id = c['id'];
    setState(() {
      _sel = c;
      _view = 'detail';
      _tab = tab;
      _logs = [];
      _comments = [];
      _notes = [];
      _goals = [];
      _plans = [];
      _subV = [];
      _exLogs = [];
      _meas = [];
      _photos = [];
      _date = _today();
    });
    final ref = c['ref'];
    _watch('food_logs', 'client', ref, id, (l) => _logs = l);
    _watch('meal_comments', 'clientRef', ref, id, (l) => _comments = l);
    _watch('coach_daily_notes', 'clientRef', ref, id, (l) => _notes = l);
    _watch('nutrition_goals', 'client', ref, id, (l) => _goals = l);
    _watch('workout_plans', 'client', ref, id, (l) => _plans = l);
    _watch('exercise_video_submissions', 'client', ref, id, (l) => _subV = l);
    _watch('exercise_logs', 'client', ref, id, (l) => _exLogs = l);
    _watch('body_measurements', 'client', ref, id, (l) => _meas = l);
    _watch('progress_photos', 'client', ref, id, (l) => _photos = l);
  }

  void _back() {
    for (final s in _selSubs) {
      s.cancel();
    }
    _selSubs.clear();
    setState(() {
      _view = 'main';
      _sel = null;
    });
  }

  List<Map<String, dynamic>> _filtered() {
    var base = _filter == 2 ? <Map<String, dynamic>>[] : _clients;
    final q = _q.trim().toLowerCase();
    if (q.isNotEmpty) {
      base = base
          .where((c) => _s(c['display_name']).toLowerCase().contains(q))
          .toList();
    }
    return base;
  }

  List<Map<String, dynamic>> get _dayLogs {
    final l = _logs.where((e) {
      final t = _dt(e['logged_at']);
      return t != null && _same(t, _date);
    }).toList();
    l.sort((a, b) => _dt(a['logged_at'])!.compareTo(_dt(b['logged_at'])!));
    return l;
  }

  List<Map<String, dynamic>> _commentsFor(String mealId) {
    final l = _comments.where((c) {
      final r = c['mealRef'];
      return r is DocumentReference &&
          r.id == mealId &&
          _s(c['content']).trim().isNotEmpty;
    }).toList();
    return _desc(l, 'createdAt');
  }

  List<Map<String, dynamic>> get _dayNotes {
    final l = _notes.where((n) {
      final t = _dt(n['date']);
      return t != null && _same(t, _date) && _s(n['content']).trim().isNotEmpty;
    }).toList();
    return _desc(l, 'createdAt');
  }

  Map<String, dynamic>? get _goal {
    final end = DateTime(_date.year, _date.month, _date.day, 23, 59, 59);
    final all = _desc(_goals, 'effective_date');
    for (final g in all) {
      final t = _dt(g['effective_date']);
      if (t == null || !t.isAfter(end)) return g;
    }
    return all.isEmpty ? null : all.last;
  }

  int _unreadFor(String clientId) {
    return _allMsgs.where((m) {
      final c = m['clientRef'];
      final snd = m['senderRef'];
      return c is DocumentReference &&
          c.id == clientId &&
          snd is DocumentReference &&
          snd.id != _meRef?.id &&
          m['read'] != true;
    }).length;
  }

  Map<String, dynamic>? _lastMsg(String clientId) {
    Map<String, dynamic>? best;
    for (final m in _allMsgs) {
      final c = m['clientRef'];
      if (c is DocumentReference && c.id == clientId) {
        final t = _dt(m['createdAt']);
        if (t == null) continue;
        if (best == null || t.isAfter(_dt(best['createdAt'])!)) best = m;
      }
    }
    return best;
  }

  void _shift(int d) => setState(() => _date = _date.add(Duration(days: d)));

  Future<void> _pickDate() async {
    final p = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (c, w) => Theme(
        data: Theme.of(c)
            .copyWith(colorScheme: const ColorScheme.light(primary: _cOrange)),
        child: w!,
      ),
    );
    if (p != null && mounted)
      setState(() => _date = DateTime(p.year, p.month, p.day));
  }

  // ---------- small widgets ----------
  Widget _initials(String t, double s) {
    return Container(
      color: const Color(0xFFECECEF),
      alignment: Alignment.center,
      child: Text(t,
          style: TextStyle(
              fontWeight: FontWeight.w800, fontSize: s * 0.34, color: _cInk)),
    );
  }

  Widget _avatar(Map<String, dynamic>? p, double s) {
    final url = _s(p?['photo_url']);
    final name = _s(p?['display_name']).trim();
    final ini = name.isEmpty
        ? '?'
        : name
            .split(' ')
            .where((e) => e.isNotEmpty)
            .take(2)
            .map((e) => e[0].toUpperCase())
            .join();
    return ClipOval(
      child: SizedBox(
        width: s,
        height: s,
        child: url.isNotEmpty
            ? Image.network(url,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _initials(ini, s))
            : _initials(ini, s),
      ),
    );
  }

  Widget _logo() {
    Widget bar() => Transform(
          transform: Matrix4.skewX(-0.45),
          child: Container(
              width: 4.5,
              height: 20,
              decoration: BoxDecoration(
                  color: _cOrange, borderRadius: BorderRadius.circular(2))),
        );
    return Row(children: [
      bar(),
      const SizedBox(width: 3),
      bar(),
      const SizedBox(width: 3),
      bar()
    ]);
  }

  Widget _empty(IconData ic, String title, String sub) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 12),
      child: Column(children: [
        Container(
          width: 64,
          height: 64,
          decoration:
              const BoxDecoration(color: _cSubtle, shape: BoxShape.circle),
          child: Icon(ic, size: 28, color: _cGray),
        ),
        const SizedBox(height: 16),
        Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text(sub,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, color: _cGray, height: 1.35)),
      ]),
    );
  }

  Widget _skeleton() {
    Widget row() => Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(children: [
            Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                    color: _cSubtle, shape: BoxShape.circle)),
            const SizedBox(width: 14),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  width: 140,
                  height: 16,
                  decoration: BoxDecoration(
                      color: _cSubtle, borderRadius: BorderRadius.circular(8))),
              const SizedBox(height: 8),
              Container(
                  width: 90,
                  height: 12,
                  decoration: BoxDecoration(
                      color: _cSubtle, borderRadius: BorderRadius.circular(6))),
            ]),
          ]),
        );
    return Column(children: [row(), row(), row()]);
  }

  Widget _h1(String t) => Text(t,
      style: const TextStyle(
          fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: -0.5));

  Widget _card(Widget child,
      {Color color = Colors.white, EdgeInsets pad = const EdgeInsets.all(16)}) {
    return Container(
      width: double.infinity,
      padding: pad,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: color == Colors.white ? Border.all(color: _cLine) : null,
        boxShadow: color == Colors.white
            ? const [
                BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 10,
                    offset: Offset(0, 2))
              ]
            : null,
      ),
      child: child,
    );
  }

  Widget _act(IconData ic, String label, VoidCallback f) {
    return Expanded(
      child: GestureDetector(
        onTap: f,
        child: Container(
          height: 84,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _cLine),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 10,
                  offset: Offset(0, 2))
            ],
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(ic, size: 26),
            const SizedBox(height: 7),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 13.5, fontWeight: FontWeight.w700)),
          ]),
        ),
      ),
    );
  }

  Widget _chipBtn(String t, bool on, VoidCallback f) {
    return GestureDetector(
      onTap: f,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: on ? _cInk : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: on ? _cInk : _cLine),
        ),
        child: Text(t,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: on ? Colors.white : _cInk)),
      ),
    );
  }

  Widget _pill(String t, Color fg, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(t,
          style:
              TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: fg)),
    );
  }

  Widget _thumb(String url, double s,
      {IconData ic = Icons.restaurant_outlined}) {
    final ph = Container(
      width: s,
      height: s,
      decoration: BoxDecoration(
          color: _cSubtle, borderRadius: BorderRadius.circular(14)),
      child: Icon(ic, color: _cGray),
    );
    if (url.isEmpty) return ph;
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.network(url,
          width: s,
          height: s,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => ph),
    );
  }

  Widget _tf(TextEditingController c, String hint,
      {bool num = false, int lines = 1, bool auto = false}) {
    return TextField(
      controller: c,
      autofocus: auto,
      minLines: lines,
      maxLines: lines == 1 ? 1 : lines + 2,
      keyboardType: num
          ? const TextInputType.numberWithOptions(decimal: true)
          : (lines > 1 ? TextInputType.multiline : TextInputType.text),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: _cGray),
        filled: true,
        fillColor: _cSubtle,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none),
      ),
    );
  }

  Widget _sheetFrame(BuildContext ctx, Widget child, double maxH) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * maxH),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
        padding: EdgeInsets.fromLTRB(
            20, 14, 20, MediaQuery.of(ctx).padding.bottom + 16),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                  child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 14),
                      decoration: BoxDecoration(
                          color: _cLine,
                          borderRadius: BorderRadius.circular(2)))),
              Flexible(child: child),
            ]),
      ),
    );
  }

  Future<void> _showSheet(Widget Function(BuildContext ctx, StateSetter setS) b,
      {double maxH = 0.9}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
          builder: (ctx, setS) => _sheetFrame(ctx, b(ctx, setS), maxH)),
    );
  }

  Widget _cta(String t, bool busy, VoidCallback? f, {bool dark = false}) {
    return GestureDetector(
      onTap: busy ? null : f,
      child: Container(
        height: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: dark ? _cInk : _cOrange,
            borderRadius: BorderRadius.circular(16)),
        child: Text(busy ? 'Saving...' : t,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.white)),
      ),
    );
  }

  // ---------- build ----------
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return DefaultTextStyle.merge(
      style: const TextStyle(
          fontFamily: 'Geist', color: _cInk, decoration: TextDecoration.none),
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? mq.size.height,
        color: Colors.white,
        child: _view == 'detail' ? _detail(mq) : _main(mq),
      ),
    );
  }

  Widget _topBar(MediaQueryData mq) {
    return Row(children: [
      _logo(),
      const SizedBox(width: 9),
      const Text('Envision',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
      const Spacer(),
      const Icon(Icons.notifications_none, size: 27),
      const SizedBox(width: 14),
      PopupMenuButton<String>(
        tooltip: 'Temporary testing controls',
        icon: const Icon(Icons.logout, size: 22, color: _cInk),
        itemBuilder: (_) => [
          const PopupMenuItem(value: 'logout', child: Text('Log out (test)')),
          if (currentUserEmail.toLowerCase() == 'isaac.gbaba@uri.edu')
            const PopupMenuItem(
                value: 'onboarding', child: Text('Restart signup (test)')),
        ],
        onSelected: (value) async {
          if (value == 'onboarding') {
            await currentUserReference
                ?.update({'onboarding_status': 'incomplete'});
            if (mounted) context.goNamed('CEnvisionRolePro');
            return;
          }
          GoRouter.of(context).prepareAuthEvent();
          await FirebaseAuth.instance.signOut();
          GoRouter.of(context).clearRedirectLocation();
          if (mounted) context.goNamed('BEnvisionWelcomePro');
        },
      ),
      _avatar(_me, 40),
    ]);
  }

  Widget _navItem(IconData i, bool on, VoidCallback f, {int badge = 0}) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: f,
        child: Center(
          child: Stack(clipBehavior: Clip.none, children: [
            Icon(i, size: 28, color: on ? _cInk : _cGray),
            if (badge > 0)
              Positioned(
                  right: -6,
                  top: -4,
                  child: Container(
                      width: 11,
                      height: 11,
                      decoration: BoxDecoration(
                          color: _cOrange,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2)))),
          ]),
        ),
      ),
    );
  }

  Widget _bottomNav(MediaQueryData mq) {
    final unread = _allMsgs.where((m) {
      final snd = m['senderRef'];
      return snd is DocumentReference &&
          snd.id != _meRef?.id &&
          m['read'] != true;
    }).length;
    return Container(
      height: 62 + mq.padding.bottom,
      padding: EdgeInsets.only(bottom: mq.padding.bottom),
      decoration: const BoxDecoration(
          color: Colors.white, border: Border(top: BorderSide(color: _cLine))),
      child: Row(children: [
        _navItem(
            Icons.home_outlined, _nav == 0, () => setState(() => _nav = 0)),
        _navItem(
            Icons.groups_outlined, _nav == 1, () => setState(() => _nav = 1)),
        _navItem(Icons.chat_bubble_outline, _nav == 2,
            () => setState(() => _nav = 2),
            badge: unread),
      ]),
    );
  }

  Widget _main(MediaQueryData mq) {
    Widget page;
    if (_nav == 0) {
      page = _home(mq);
    } else if (_nav == 2) {
      page = _inbox(mq);
    } else {
      page = _directory(mq);
    }
    return Column(children: [Expanded(child: page), _bottomNav(mq)]);
  }

  // ---------- directory ----------
  Widget _chip(String t, int i) {
    final on = _filter == i;
    return GestureDetector(
      onTap: () => setState(() => _filter = i),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
        decoration: BoxDecoration(
          color: on ? _cInk : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: on ? _cInk : _cLine),
        ),
        child: Text(t,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: on ? Colors.white : _cInk)),
      ),
    );
  }

  Widget _clientRow(Map<String, dynamic> c) {
    final last = _lastLog[c['id']];
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _open(c),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: _cLine))),
        child: Row(children: [
          Stack(children: [
            _avatar(c, 56),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: _cGreen,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.5)),
              ),
            ),
          ]),
          const SizedBox(width: 14),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                  _s(c['display_name']).isEmpty
                      ? 'Client'
                      : _s(c['display_name']),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 3),
              Text(last == null ? 'No logs yet' : 'Last log: ' + _ago(last),
                  style: const TextStyle(fontSize: 15, color: _cGray)),
            ]),
          ),
          const Icon(Icons.chevron_right, size: 24, color: _cInk),
        ]),
      ),
    );
  }

  Widget _searchBox(String hint, void Function(String) f) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: _cSubtle, borderRadius: BorderRadius.circular(18)),
      child: Row(children: [
        const Icon(Icons.search, color: _cGray),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            onChanged: f,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: _cGray),
                border: InputBorder.none,
                isDense: true),
          ),
        ),
      ]),
    );
  }

  Widget _directory(MediaQueryData mq) {
    final list = _filtered();
    final code = _s(_me['coachCode']);
    Widget content;
    if (_loading) {
      content = _skeleton();
    } else if (_err != null) {
      content = _empty(Icons.error_outline, 'Something went wrong', _err!);
    } else if (_filter == 2) {
      content = _empty(Icons.hourglass_empty, 'No pending invitations',
          'Clients who request to join you will show up here.');
    } else if (_clients.isEmpty) {
      content = _empty(
          Icons.groups_outlined,
          'No clients yet',
          code.isEmpty
              ? 'Clients who join with your coach code will appear here.'
              : 'Share your coach code ' + code + ' so clients can join you.');
    } else if (list.isEmpty) {
      content =
          _empty(Icons.search, 'No matches', 'No clients match your search.');
    } else {
      content = Column(children: list.map(_clientRow).toList());
    }
    return ListView(
      padding: EdgeInsets.fromLTRB(22, mq.padding.top + 12, 22, 24),
      children: [
        _topBar(mq),
        const SizedBox(height: 32),
        const Text('Coach Dashboard',
            style: TextStyle(fontSize: 18, color: _cGray)),
        const Text('Clients',
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w900,
                letterSpacing: -2,
                height: 1.05)),
        const SizedBox(height: 8),
        const Text('Manage your clients, review progress, and stay connected.',
            style: TextStyle(fontSize: 16, color: _cGray, height: 1.35)),
        const SizedBox(height: 22),
        _searchBox('Search clients...', (v) => setState(() => _q = v)),
        const SizedBox(height: 18),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            _chip('All (' + _clients.length.toString() + ')', 0),
            _chip('Active (' + _clients.length.toString() + ')', 1),
            _chip('Pending (0)', 2),
          ]),
        ),
        const SizedBox(height: 14),
        content,
      ],
    );
  }

  // ---------- coach home ----------
  Widget _metricTile(String label, String value, IconData ic) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _cLine),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 10,
                  offset: Offset(0, 2))
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(ic, size: 22, color: _cOrange),
          const SizedBox(height: 10),
          Text(value,
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 13, color: _cGray)),
        ]),
      ),
    );
  }

  Widget _home(MediaQueryData mq) {
    final today = _today();
    final loggedToday = _clients.where((c) {
      final t = _lastLog[c['id']];
      return t != null && _same(t, today);
    }).length;
    final unread = _allMsgs.where((m) {
      final snd = m['senderRef'];
      return snd is DocumentReference &&
          snd.id != _meRef?.id &&
          m['read'] != true;
    }).length;
    final quiet = _clients.where((c) {
      final t = _lastLog[c['id']];
      return t == null || DateTime.now().difference(t).inDays >= 3;
    }).toList();
    final name = _s(_me['display_name']).split(' ').first;
    return ListView(
      padding: EdgeInsets.fromLTRB(17, mq.padding.top + 12, 17, 24),
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _topBar(mq)),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Coach Dashboard',
                style: TextStyle(fontSize: 18, color: _cGray)),
            Text(name.isEmpty ? 'Home' : 'Hi, ' + name,
                style: const TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2,
                    height: 1.05)),
          ]),
        ),
        const SizedBox(height: 22),
        Row(children: [
          _metricTile('Active clients', _clients.length.toString(),
              Icons.groups_outlined),
          _metricTile('Logged today', loggedToday.toString(),
              Icons.restaurant_outlined),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          _metricTile(
              'Unread messages', unread.toString(), Icons.chat_bubble_outline),
          _metricTile(
              'Quiet 3+ days', quiet.length.toString(), Icons.hourglass_empty),
        ]),
        const SizedBox(height: 26),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _h1('Needs attention')),
        const SizedBox(height: 8),
        if (_clients.isEmpty)
          _empty(Icons.groups_outlined, 'No clients yet',
              'Clients who join with your coach code will appear here.')
        else if (quiet.isEmpty)
          _empty(Icons.check_circle_outline, 'Everyone is on track',
              'All of your clients logged in the last 3 days.')
        else
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(children: quiet.map(_clientRow).toList())),
      ],
    );
  }

  // ---------- inbox ----------
  Widget _inbox(MediaQueryData mq) {
    final q = _convQ.trim().toLowerCase();
    var list = _clients
        .where(
            (c) => q.isEmpty || _s(c['display_name']).toLowerCase().contains(q))
        .toList();
    list.sort((a, b) {
      final ta = _dt(_lastMsg(a['id'])?['createdAt']);
      final tb = _dt(_lastMsg(b['id'])?['createdAt']);
      if (ta == null && tb == null) return 0;
      if (ta == null) return 1;
      if (tb == null) return -1;
      return tb.compareTo(ta);
    });
    return ListView(
      padding: EdgeInsets.fromLTRB(22, mq.padding.top + 16, 22, 24),
      children: [
        const Text('Messages',
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.5)),
        const SizedBox(height: 16),
        _searchBox(
            'Search conversations...', (v) => setState(() => _convQ = v)),
        const SizedBox(height: 8),
        if (_clients.isEmpty)
          _empty(Icons.chat_bubble_outline, 'No conversations',
              'Once clients join you, you can message them here.')
        else if (list.isEmpty)
          _empty(
              Icons.search, 'No matches', 'No conversations match your search.')
        else
          ...list.map(_convRow),
      ],
    );
  }

  Widget _convRow(Map<String, dynamic> c) {
    final last = _lastMsg(c['id']);
    final unread = _unreadFor(c['id']);
    final t = _dt(last?['createdAt']);
    final mine = last != null &&
        last['senderRef'] is DocumentReference &&
        (last['senderRef'] as DocumentReference).id == _meRef?.id;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _openChat(c),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: _cLine))),
        child: Row(children: [
          _avatar(c, 54),
          const SizedBox(width: 14),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                  _s(c['display_name']).isEmpty
                      ? 'Client'
                      : _s(c['display_name']),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w800)),
              const SizedBox(height: 3),
              Text(
                  last == null
                      ? 'Start a conversation'
                      : (mine ? 'You: ' : '') + _s(last['text']),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14.5,
                      color: unread > 0 ? _cInk : _cGray,
                      fontWeight:
                          unread > 0 ? FontWeight.w700 : FontWeight.w400)),
            ]),
          ),
          const SizedBox(width: 8),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            if (t != null)
              Text(_ago(t).replaceAll(' ago', ''),
                  style: const TextStyle(fontSize: 13, color: _cGray)),
            if (unread > 0)
              Container(
                margin: const EdgeInsets.only(top: 6),
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: _cOrange, shape: BoxShape.circle),
                child: Text(unread.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w800)),
              ),
          ]),
        ]),
      ),
    );
  }

  Future<void> _openChat(Map<String, dynamic> c) async {
    final me = _meRef;
    if (me == null) return;
    final tc = TextEditingController();
    final sc = ScrollController();
    final db = FirebaseFirestore.instance;
    // mark incoming as read
    try {
      final q = await db
          .collection('messages')
          .where('coachRef', isEqualTo: me)
          .where('clientRef', isEqualTo: c['ref'])
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
    await _showSheet((ctx, setS) {
      Future<void> send() async {
        final txt = tc.text.trim();
        if (txt.isEmpty) return;
        tc.clear();
        try {
          await db.collection('messages').add({
            'coachRef': me,
            'clientRef': c['ref'],
            'senderRef': me,
            'text': txt,
            'read': false,
            'createdAt': Timestamp.now(),
          });
        } catch (_) {
          _toast('Could not send. Try again.');
        }
      }

      return SizedBox(
        height: MediaQuery.of(ctx).size.height * 0.78,
        child: Column(children: [
          Row(children: [
            _avatar(c, 44),
            const SizedBox(width: 12),
            Expanded(
                child: Text(
                    _s(c['display_name']).isEmpty
                        ? 'Client'
                        : _s(c['display_name']),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w900))),
          ]),
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: db
                  .collection('messages')
                  .where('coachRef', isEqualTo: me)
                  .where('clientRef', isEqualTo: c['ref'])
                  .snapshots(),
              builder: (cx, snap) {
                final docs =
                    _desc(snap.data?.docs.map(_m).toList() ?? [], 'createdAt');
                if (docs.isEmpty) {
                  return const Center(
                      child: Text('No messages yet. Say hello.',
                          style: TextStyle(color: _cGray, fontSize: 15)));
                }
                return ListView.builder(
                  reverse: true,
                  controller: sc,
                  itemCount: docs.length,
                  itemBuilder: (cx2, i) {
                    final m = docs[i];
                    final snd = m['senderRef'];
                    final mine = snd is DocumentReference && snd.id == me.id;
                    final t = _dt(m['createdAt']);
                    return Align(
                      alignment:
                          mine ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(ctx).size.width * 0.74),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                            color: mine ? _cOrange : _cSubtle,
                            borderRadius: BorderRadius.circular(18)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(_s(m['text']),
                                  style: TextStyle(
                                      fontSize: 15.5,
                                      height: 1.3,
                                      color: mine ? Colors.white : _cInk)),
                              if (t != null)
                                Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(_clock(t),
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: mine
                                                ? const Color(0xCCFFFFFF)
                                                : _cGray))),
                            ]),
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
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => send(),
                decoration: InputDecoration(
                  hintText: 'Message...',
                  filled: true,
                  fillColor: _cSubtle,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: send,
              child: Container(
                  width: 46,
                  height: 46,
                  decoration: const BoxDecoration(
                      color: _cOrange, shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_upward, color: Colors.white)),
            ),
          ]),
        ]),
      );
    }, maxH: 0.92);
  }

  // ---------- detail ----------
  Widget _sq(IconData ic, VoidCallback f) {
    return GestureDetector(
      onTap: f,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: _cLine)),
        child: Icon(ic, size: 24),
      ),
    );
  }

  Widget _tabs() {
    const names = ['Overview', 'Nutrition', 'Training', 'Progress'];
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: _cLine))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        for (var i = 0; i < 4; i++)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() => _tab = i),
            child: Container(
              padding: const EdgeInsets.only(top: 6, bottom: 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: _tab == i ? _cInk : Colors.transparent,
                          width: 3))),
              child: Text(names[i],
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: _tab == i ? FontWeight.w800 : FontWeight.w500,
                      color: _tab == i ? _cInk : _cGray)),
            ),
          ),
      ]),
    );
  }

  Widget _dateBar() {
    return Row(children: [
      _sq(Icons.chevron_left, () => _shift(-1)),
      const SizedBox(width: 10),
      Expanded(
        child: GestureDetector(
          onTap: _pickDate,
          child: Container(
            height: 46,
            decoration: BoxDecoration(
                border: Border.all(color: _cLine),
                borderRadius: BorderRadius.circular(24)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.calendar_today_outlined, size: 18),
              const SizedBox(width: 8),
              Text(_label(_date),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, size: 20),
            ]),
          ),
        ),
      ),
      const SizedBox(width: 10),
      _sq(Icons.chevron_right, () => _shift(1)),
    ]);
  }

  Widget _detail(MediaQueryData mq) {
    final c = _sel ?? {};
    Widget body;
    if (_tab == 0) {
      body = _overview();
    } else if (_tab == 1) {
      body = _nutrition();
    } else if (_tab == 2) {
      body = _training();
    } else {
      body = _progress();
    }
    return Column(children: [
      Padding(
        padding: EdgeInsets.fromLTRB(14, mq.padding.top + 8, 18, 0),
        child: Row(children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _back,
            child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.arrow_back_ios_new, size: 22)),
          ),
          const Spacer(),
          GestureDetector(
              onTap: () => _openChat(c),
              child: const Icon(Icons.chat_bubble_outline, size: 25)),
          const SizedBox(width: 18),
          GestureDetector(
              onTap: _openMenu, child: const Icon(Icons.more_horiz, size: 28)),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(22, 4, 22, 0),
        child: Row(children: [
          _avatar(c, 64),
          const SizedBox(width: 14),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                  _s(c['display_name']).isEmpty
                      ? 'Client'
                      : _s(c['display_name']),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5)),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: const Color(0xFFE8F7EE),
                    borderRadius: BorderRadius.circular(14)),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.check, size: 14, color: _cGreen),
                  SizedBox(width: 4),
                  Text('Active',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: _cGreen)),
                ]),
              ),
            ]),
          ),
        ]),
      ),
      _tabs(),
      Expanded(
        child: GestureDetector(
          onHorizontalDragEnd: (d) {
            final v = d.primaryVelocity ?? 0;
            if (v < -300 && _tab < 3) setState(() => _tab++);
            if (v > 300 && _tab > 0) setState(() => _tab--);
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(22, 18, 22, mq.padding.bottom + 28),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_tab != 3) _dateBar(),
                  if (_tab != 3) const SizedBox(height: 22),
                  body,
                ]),
          ),
        ),
      ),
    ]);
  }

  Future<void> _openMenu() async {
    final c = _sel;
    if (c == null) return;
    Widget item(BuildContext ctx, IconData ic, String t, VoidCallback f) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pop(ctx);
          f();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(children: [
            Icon(ic, size: 24),
            const SizedBox(width: 16),
            Text(t,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          ]),
        ),
      );
    }

    await _showSheet((ctx, setS) {
      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            item(ctx, Icons.chat_bubble_outline, 'Message', () => _openChat(c)),
            item(ctx, Icons.edit_note, 'Add note', _openNote),
            item(
                ctx, Icons.track_changes, 'Adjust nutrition goals', _openGoals),
            item(ctx, Icons.fitness_center, 'Assign workout', _openAssign),
            item(ctx, Icons.monitor_weight_outlined, 'Add measurement',
                _openMeasure),
          ]);
    });
  }

  // ---------- overview ----------
  Widget _macroBar(String label, int v, int goal) {
    final pct = goal > 0 ? (v / goal).clamp(0.0, 1.0).toDouble() : 0.0;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
          const SizedBox(height: 3),
          Text(v.toString() + (goal > 0 ? ' / ' + goal.toString() : '') + ' g',
              style: const TextStyle(fontSize: 13, color: _cGray)),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
                value: pct,
                minHeight: 5,
                backgroundColor: const Color(0xFFF3E4D8),
                valueColor: const AlwaysStoppedAnimation<Color>(_cOrange)),
          ),
        ]),
      ),
    );
  }

  List<Map<String, dynamic>> _activity() {
    final out = <Map<String, dynamic>>[];
    for (final m in _logs) {
      final t = _dt(m['logged_at']);
      if (t == null) continue;
      final type = _s(m['meal_type']);
      out.add({
        't': t,
        'kind': 'meal',
        'title': 'Logged ' + (type.isEmpty || type == 'meal' ? 'meal' : type),
        'sub': _s(m['description']) +
            ' - ' +
            _i(m['calories']).toString() +
            ' kcal',
        'img': _s(m['image_url']),
        'icon': Icons.restaurant_outlined,
        'raw': m
      });
    }
    for (final v in _subV) {
      final t = _dt(v['uploaded_at']);
      if (t == null) continue;
      out.add({
        't': t,
        'kind': 'video',
        'title': 'Exercise video uploaded',
        'sub': _s(v['review_status']) == 'reviewed'
            ? 'Reviewed'
            : 'Waiting for your review',
        'img': '',
        'icon': Icons.videocam_outlined,
        'raw': v
      });
    }
    for (final m in _meas) {
      final t = _dt(m['measured_at']);
      if (t == null) continue;
      final w = _d(m['weight']);
      out.add({
        't': t,
        'kind': 'meas',
        'title': w > 0 ? 'Weight recorded' : 'Measurements updated',
        'sub': w > 0
            ? _num1(w) +
                ' ' +
                (_s(m['weight_unit']).isEmpty ? 'lb' : _s(m['weight_unit']))
            : 'Body measurements',
        'img': '',
        'icon': Icons.monitor_weight_outlined,
        'raw': m
      });
    }
    for (final p in _photos) {
      final t = _dt(p['taken_at']);
      if (t == null) continue;
      out.add({
        't': t,
        'kind': 'photo',
        'title': 'Progress photo',
        'sub': _cap(_s(p['photo_type'])) + ' view',
        'img': _s(p['photo_path']),
        'icon': Icons.photo_outlined,
        'raw': p
      });
    }
    out.sort((a, b) => (b['t'] as DateTime).compareTo(a['t'] as DateTime));
    return out.take(8).toList();
  }

  Widget _activityRow(Map<String, dynamic> a) {
    final t = a['t'] as DateTime;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final k = a['kind'];
        if (k == 'meal') {
          setState(() {
            _tab = 1;
            _date = DateTime(t.year, t.month, t.day);
          });
          _openMeal(a['raw'] as Map<String, dynamic>);
        } else if (k == 'video') {
          setState(() => _tab = 2);
          _openVideo(a['raw'] as Map<String, dynamic>);
        } else if (k == 'photo') {
          _openPhoto(a['raw'] as Map<String, dynamic>);
        } else {
          setState(() => _tab = 3);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: _cLine))),
        child: Row(children: [
          _thumb(_s(a['img']), 54, ic: a['icon'] as IconData),
          const SizedBox(width: 14),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_s(a['title']),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800)),
              const SizedBox(height: 2),
              Text(_s(a['sub']),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13.5, color: _cGray)),
              Text(_ago(t),
                  style: const TextStyle(fontSize: 12.5, color: _cGray)),
            ]),
          ),
          const Icon(Icons.chevron_right, size: 22),
        ]),
      ),
    );
  }

  Widget _overview() {
    final meals = _dayLogs;
    final cal = meals.fold<int>(0, (a, m) => a + _i(m['calories']));
    final pr = meals.fold<int>(0, (a, m) => a + _i(m['protein']));
    final cb = meals.fold<int>(0, (a, m) => a + _i(m['carbs']));
    final ft = meals.fold<int>(0, (a, m) => a + _i(m['fat']));
    final g = _goal;
    final gc = g == null ? 0 : _i(g['calories']);
    final pct = gc > 0 ? cal / gc : 0.0;
    final act = _activity();
    final isToday = _same(_date, _today());
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _card(
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(isToday ? "Today's Summary" : 'Summary',
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 10),
                    Text(_fmt(cal),
                        style: const TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.5)),
                    Text(gc > 0 ? '/ ' + _fmt(gc) + ' kcal' : 'kcal logged',
                        style: const TextStyle(fontSize: 15, color: _cGray)),
                  ]),
            ),
            SizedBox(
              width: 96,
              height: 96,
              child: Stack(alignment: Alignment.center, children: [
                CustomPaint(
                    size: const Size(96, 96),
                    painter: _RingPainter(pct.toDouble())),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(gc > 0 ? (pct * 100).round().toString() + '%' : '--',
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.w900)),
                  const Text('consumed',
                      style: TextStyle(fontSize: 10.5, color: _cGray)),
                ]),
              ]),
            ),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _macroBar('Protein', pr, g == null ? 0 : _i(g['protein'])),
            _macroBar('Carbs', cb, g == null ? 0 : _i(g['carbs'])),
            _macroBar('Fat', ft, g == null ? 0 : _i(g['fat'])),
          ]),
          if (g == null)
            GestureDetector(
              onTap: _openGoals,
              child: const Padding(
                  padding: EdgeInsets.only(top: 14),
                  child: Text('No nutrition goals set yet. Set goals',
                      style: TextStyle(
                          color: _cOrange,
                          fontWeight: FontWeight.w800,
                          fontSize: 14))),
            ),
        ]),
        color: const Color(0xFFFFF4EC),
        pad: const EdgeInsets.all(18),
      ),
      const SizedBox(height: 14),
      Row(children: [
        _act(Icons.edit_note, 'Add Note', _openNote),
        const SizedBox(width: 10),
        _act(Icons.chat_bubble_outline, 'Message', () => _openChat(_sel!)),
        const SizedBox(width: 10),
        _act(Icons.track_changes, 'Adjust Goals', _openGoals),
      ]),
      const SizedBox(height: 26),
      _h1('Recent Activity'),
      const SizedBox(height: 6),
      if (act.isEmpty)
        _empty(Icons.timeline, 'No activity yet',
            'Meals, workouts, weigh-ins and photos from this client will show up here.')
      else
        ...act.map(_activityRow),
    ]);
  }

  // ---------- nutrition ----------
  Widget _stat(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
            color: _cSubtle, borderRadius: BorderRadius.circular(14)),
        child: Column(children: [
          Text(value,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 12, color: _cGray)),
        ]),
      ),
    );
  }

  Widget _mealRow(Map<String, dynamic> m) {
    final t = _dt(m['logged_at']);
    final cm = _commentsFor(m['id']);
    final type = _s(m['meal_type']);
    final sub = (type.isEmpty || type == 'meal' ? '' : _cap(type) + ' - ') +
        (t == null ? '' : _clock(t));
    final desc = _s(m['description']).isEmpty ? 'Meal' : _s(m['description']);
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _openMeal(m),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            _thumb(_s(m['image_url']), 68),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(desc,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w800)),
                    if (sub.isNotEmpty)
                      Text(sub,
                          style: const TextStyle(fontSize: 13, color: _cGray)),
                    const SizedBox(height: 3),
                    Text(
                        _i(m['calories']).toString() +
                            ' kcal - P ' +
                            _i(m['protein']).toString() +
                            'g - C ' +
                            _i(m['carbs']).toString() +
                            'g - F ' +
                            _i(m['fat']).toString() +
                            'g',
                        style: const TextStyle(fontSize: 13, color: _cGray)),
                  ]),
            ),
            GestureDetector(
              onTap: () => _openMeal(m),
              child: Stack(clipBehavior: Clip.none, children: [
                Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                        color: _cSubtle, shape: BoxShape.circle),
                    child: const Icon(Icons.chat_bubble_outline, size: 19)),
                if (cm.isNotEmpty)
                  Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: _cOrange,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white, width: 1.5)))),
              ]),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, size: 22),
          ]),
        ),
        if (cm.isNotEmpty)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
                color: _cPeach, borderRadius: BorderRadius.circular(14)),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Icon(Icons.chat_bubble_outline, size: 18, color: _cOrange),
              const SizedBox(width: 10),
              Expanded(
                child: Text.rich(
                    TextSpan(children: [
                      const TextSpan(
                          text: 'Coach: ',
                          style: TextStyle(
                              color: _cOrange, fontWeight: FontWeight.w800)),
                      TextSpan(text: _s(cm.first['content'])),
                    ]),
                    style: const TextStyle(fontSize: 14, height: 1.35)),
              ),
            ]),
          ),
      ]),
    );
  }

  Widget _noteCard(Map<String, dynamic> n) {
    final t = _dt(n['createdAt']);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _cLine),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0A000000), blurRadius: 10, offset: Offset(0, 2))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(width: 4, color: _cOrange),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _avatar(_me, 36),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Expanded(
                                    child: Text(
                                        _s(_me['display_name']).isEmpty
                                            ? 'Coach'
                                            : _s(_me['display_name']),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800))),
                                if (t != null)
                                  Text(_ago(t),
                                      style: const TextStyle(
                                          fontSize: 12, color: _cGray)),
                              ]),
                              const SizedBox(height: 4),
                              Text(_s(n['content']),
                                  style: const TextStyle(
                                      fontSize: 15, height: 1.35)),
                            ]),
                      ),
                    ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _nutrition() {
    final meals = _dayLogs;
    final total = meals.fold<int>(0, (a, m) => a + _i(m['calories']));
    final notes = _dayNotes;
    final first = (_s(_sel?['display_name']).isEmpty
            ? 'This client'
            : _s(_sel?['display_name']))
        .split(' ')
        .first;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      for (final n in notes) _noteCard(n),
      Row(children: [
        Expanded(child: _h1('Meal Logs')),
        Text(_fmt(total) + ' kcal',
            style: const TextStyle(fontSize: 17, color: _cGray)),
      ]),
      const SizedBox(height: 16),
      if (meals.isEmpty)
        _empty(Icons.restaurant_outlined, 'No meals logged',
            first + ' has not logged any meals on this day.')
      else
        ...meals.map(_mealRow),
      const SizedBox(height: 6),
      Row(children: [
        _act(Icons.edit_note, 'Add Note', _openNote),
        const SizedBox(width: 12),
        _act(Icons.chat_bubble_outline, 'Message', () => _openChat(_sel!)),
        const SizedBox(width: 12),
        _act(Icons.track_changes, 'Adjust Goals', _openGoals),
      ]),
    ]);
  }

  // ---------- training ----------
  Widget _exName(dynamic ref, {TextStyle? style}) {
    if (ref is! DocumentReference) return Text('Exercise', style: style);
    return FutureBuilder<DocumentSnapshot<Object?>>(
      future: ref.get(),
      builder: (c, s) {
        final d = s.data?.data();
        final name = d is Map ? _s(d['exercise_name']) : '';
        return Text(name.isEmpty ? 'Exercise' : name, style: style);
      },
    );
  }

  Widget _planRow(Map<String, dynamic> p) {
    final done = _s(p['status']).toLowerCase() == 'completed';
    final dur = _i(p['duration_min']);
    final type = _s(p['workout_type']);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _openWorkout(p),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: _cLine))),
        child: Row(children: [
          Stack(alignment: Alignment.center, children: [
            _thumb(_s(p['image_url']), 70, ic: Icons.fitness_center),
            if (_s(p['image_url']).isNotEmpty)
              const Icon(Icons.play_circle_fill, color: Colors.white, size: 30),
          ]),
          const SizedBox(width: 14),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                  _s(p['workout_name']).isEmpty
                      ? 'Workout'
                      : _s(p['workout_name']),
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w800)),
              const SizedBox(height: 2),
              Text(
                  (dur > 0 ? dur.toString() + ' min' : '') +
                      (dur > 0 && type.isNotEmpty ? ' - ' : '') +
                      type,
                  style: const TextStyle(fontSize: 13.5, color: _cGray)),
              const SizedBox(height: 6),
              done
                  ? _pill('Completed', _cGreen, const Color(0xFFE8F7EE))
                  : _pill('Scheduled', _cGray, _cSubtle),
            ]),
          ),
          const Icon(Icons.chevron_right, size: 22),
        ]),
      ),
    );
  }

  Widget _training() {
    final day = _plans.where((p) {
      final t = _dt(p['scheduled_date']);
      return t != null && _same(t, _date);
    }).toList();
    final pending = _desc(
        _subV.where((v) => _s(v['review_status']) != 'reviewed').toList(),
        'uploaded_at');
    final first = (_s(_sel?['display_name']).isEmpty
            ? 'This client'
            : _s(_sel?['display_name']))
        .split(' ')
        .first;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (pending.isNotEmpty) ...[
        Row(children: [
          Expanded(child: _h1('Review videos')),
          _pill(pending.length.toString() + ' pending', _cOrange, _cPeach),
        ]),
        const SizedBox(height: 10),
        ...pending.map((v) {
          final t = _dt(v['uploaded_at']);
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _openVideo(v),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: _cPeach, borderRadius: BorderRadius.circular(16)),
              child: Row(children: [
                const Icon(Icons.videocam_outlined, color: _cOrange),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _exName(v['exercise'],
                            style: const TextStyle(
                                fontSize: 15.5, fontWeight: FontWeight.w800)),
                        Text(t == null ? 'Uploaded' : 'Uploaded ' + _ago(t),
                            style:
                                const TextStyle(fontSize: 13, color: _cGray)),
                      ]),
                ),
                const Icon(Icons.chevron_right, size: 22),
              ]),
            ),
          );
        }),
        const SizedBox(height: 18),
      ],
      _h1('Workouts'),
      const SizedBox(height: 8),
      if (day.isEmpty)
        _empty(Icons.fitness_center, 'No workouts assigned',
            first + ' has no workouts on this day. Assign one to get started.')
      else
        ...day.map(_planRow),
      const SizedBox(height: 14),
      Row(children: [
        _act(Icons.add_circle_outline, 'Assign Workout', _openAssign),
        const SizedBox(width: 12),
        _act(Icons.edit_note, 'Add Note', _openNote),
      ]),
    ]);
  }

  // ---------- progress ----------
  List<Map<String, dynamic>> _rangeMeas() {
    const days = [7, 30, 90, 180, 0];
    final d = days[_range];
    final l = _meas.where((m) {
      final t = _dt(m['measured_at']);
      if (t == null) return false;
      return d == 0 || DateTime.now().difference(t).inDays <= d;
    }).toList();
    l.sort((a, b) => _dt(a['measured_at'])!.compareTo(_dt(b['measured_at'])!));
    return l;
  }

  String _metricKey(int i) =>
      i == 0 ? 'weight' : (i == 1 ? 'body_fat_pct' : 'muscle_mass');

  Widget _metricCard(int i, List<Map<String, dynamic>> ms) {
    const names = ['Weight', 'Body Fat', 'Muscle'];
    final key = _metricKey(i);
    final vals = ms.where((m) => _d(m[key]) > 0).toList();
    final on = _metric == i;
    String value = '--';
    String delta = '';
    if (vals.isNotEmpty) {
      final last = _d(vals.last[key]);
      final unit = i == 1
          ? '%'
          : ' ' +
              (_s(vals.last['weight_unit']).isEmpty
                  ? 'lb'
                  : _s(vals.last['weight_unit']));
      value = _num1(last) + unit;
      if (vals.length > 1) {
        final diff = last - _d(vals.first[key]);
        delta = (diff <= 0 ? 'Down ' : 'Up ') +
            _num1(diff.abs()) +
            (i == 1 ? ' pts' : ' lb');
      }
    }
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _metric = i),
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border:
                Border.all(color: on ? _cOrange : _cLine, width: on ? 1.6 : 1),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(names[i],
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(value,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.w900)),
            const SizedBox(height: 2),
            Text(delta.isEmpty ? ' ' : delta,
                style: const TextStyle(fontSize: 11.5, color: _cGray)),
          ]),
        ),
      ),
    );
  }

  Widget _progress() {
    const rl = ['1W', '1M', '3M', '6M', 'All'];
    final ms = _rangeMeas();
    final key = _metricKey(_metric);
    final series =
        ms.where((m) => _d(m[key]) > 0).map((m) => _d(m[key])).toList();
    final photos = _desc(_photos, 'taken_at');
    final hist = _desc(_meas, 'measured_at').take(8).toList();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _h1('Progress'),
      const SizedBox(height: 12),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          for (var i = 0; i < 5; i++)
            _chipBtn(rl[i], _range == i, () => setState(() => _range = i))
        ]),
      ),
      const SizedBox(height: 14),
      Row(children: [
        _metricCard(0, ms),
        _metricCard(1, ms),
        _metricCard(2, ms)
      ]),
      const SizedBox(height: 14),
      _card(
        series.isEmpty
            ? const SizedBox(
                height: 120,
                child: Center(
                    child: Text('No recorded values in this period.',
                        style: TextStyle(color: _cGray))))
            : SizedBox(
                height: 160,
                child: CustomPaint(
                    size: const Size(double.infinity, 160),
                    painter: _LinePainter(series))),
      ),
      const SizedBox(height: 24),
      Row(children: [
        Expanded(child: _h1('Photos')),
        if (photos.isNotEmpty)
          GestureDetector(
              onTap: _openGallery,
              child: const Text('View All',
                  style: TextStyle(
                      fontSize: 15,
                      color: _cGray,
                      fontWeight: FontWeight.w600))),
      ]),
      const SizedBox(height: 12),
      if (photos.isEmpty)
        _empty(Icons.photo_outlined, 'No progress photos',
            'Photos your client uploads will appear here.')
      else
        Row(children: [
          for (final p in photos.take(2))
            Expanded(
              child: GestureDetector(
                onTap: () => _openPhoto(p),
                child: Container(
                  height: 190,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      color: _cSubtle, borderRadius: BorderRadius.circular(16)),
                  child: Stack(children: [
                    Positioned.fill(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(_s(p['photo_path']),
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const Icon(
                                    Icons.photo_outlined,
                                    color: _cGray)))),
                    Positioned(
                        left: 8,
                        bottom: 8,
                        child: _pill(
                            _dt(p['taken_at']) == null
                                ? ''
                                : _short(_dt(p['taken_at'])!),
                            _cInk,
                            Colors.white)),
                  ]),
                ),
              ),
            ),
        ]),
      const SizedBox(height: 24),
      Row(children: [
        Expanded(child: _h1('Measurements')),
        GestureDetector(
            onTap: _openMeasure,
            child: const Text('Add',
                style: TextStyle(
                    fontSize: 15,
                    color: _cOrange,
                    fontWeight: FontWeight.w800))),
      ]),
      const SizedBox(height: 8),
      if (hist.isEmpty)
        _empty(Icons.straighten, 'No measurements yet',
            'Add a measurement to start tracking progress.')
      else
        ...hist.map((m) {
          final t = _dt(m['measured_at']);
          final parts = <String>[];
          if (_d(m['weight']) > 0)
            parts.add(_num1(_d(m['weight'])) +
                ' ' +
                (_s(m['weight_unit']).isEmpty ? 'lb' : _s(m['weight_unit'])));
          if (_d(m['body_fat_pct']) > 0)
            parts.add(_num1(_d(m['body_fat_pct'])) + '% BF');
          if (_d(m['muscle_mass']) > 0)
            parts.add(_num1(_d(m['muscle_mass'])) + ' muscle');
          if (_d(m['waist']) > 0) parts.add('waist ' + _num1(_d(m['waist'])));
          if (_d(m['chest']) > 0) parts.add('chest ' + _num1(_d(m['chest'])));
          if (_d(m['arm']) > 0) parts.add('arm ' + _num1(_d(m['arm'])));
          if (_d(m['thigh']) > 0) parts.add('thigh ' + _num1(_d(m['thigh'])));
          if (_d(m['hip']) > 0) parts.add('hip ' + _num1(_d(m['hip'])));
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: _cLine))),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  width: 64,
                  child: Text(t == null ? '' : _short(t),
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800))),
              Expanded(
                  child: Text(parts.isEmpty ? 'Measurement' : parts.join(' - '),
                      style: const TextStyle(
                          fontSize: 14, color: _cGray, height: 1.35))),
            ]),
          );
        }),
    ]);
  }

  // ---------- sheets ----------
  Widget _sheetTitle(String t, {String sub = ''}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.4)),
        if (sub.isNotEmpty)
          Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(sub,
                  style: const TextStyle(fontSize: 14, color: _cGray))),
      ]),
    );
  }

  Widget _lbl(String t) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(t,
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w700, color: _cGray)),
    );
  }

  DocumentReference<Map<String, dynamic>>? get _clientRef {
    final r = _sel == null ? null : _sel!['ref'];
    return r is DocumentReference<Map<String, dynamic>> ? r : null;
  }

  int _toInt(String s) {
    final v = double.tryParse(s.trim());
    return v == null ? 0 : v.round();
  }

  Future<void> _openMeal(Map<String, dynamic> m) async {
    final me = _meRef;
    final cr = _clientRef;
    if (me == null || cr == null) return;
    final tc = TextEditingController();
    bool busy = false;
    await _showSheet((ctx, setS) {
      final cm = _commentsFor(_s(m['id']));
      final img = _s(m['image_url']);
      return Flexible(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _sheetTitle(
                _s(m['description']).isEmpty ? 'Meal' : _s(m['description']),
                sub: _s(m['meal_type'])),
            if (img.isNotEmpty)
              Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(img,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const SizedBox()))),
            Row(children: [
              _pill(_fmt(_i(m['calories'])) + ' kcal', _cOrange, _cPeach),
              const SizedBox(width: 8),
              _pill('P ' + _i(m['protein']).toString() + 'g', _cInk, _cSubtle),
              const SizedBox(width: 8),
              _pill('C ' + _i(m['carbs']).toString() + 'g', _cInk, _cSubtle),
              const SizedBox(width: 8),
              _pill('F ' + _i(m['fat']).toString() + 'g', _cInk, _cSubtle),
            ]),
            if (cm.isNotEmpty) _lbl('Your feedback'),
            ...cm.map((c) => Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: _cSubtle, borderRadius: BorderRadius.circular(14)),
                  child: Text(_s(c['content']),
                      style: const TextStyle(fontSize: 15)),
                )),
            _lbl('Add feedback'),
            _tf(tc, 'Write feedback for this meal', lines: 3),
            const SizedBox(height: 14),
            _cta('Send feedback', busy, () async {
              final txt = tc.text.trim();
              if (txt.isEmpty) return;
              setS(() => busy = true);
              try {
                await FirebaseFirestore.instance
                    .collection('meal_comments')
                    .add({
                  'mealRef': m['ref'],
                  'clientRef': cr,
                  'coachRef': me,
                  'content': txt,
                  'createdAt': FieldValue.serverTimestamp(),
                });
                if (ctx.mounted) Navigator.of(ctx).pop();
                _toast('Feedback sent');
              } catch (e) {
                setS(() => busy = false);
                _toast('Could not send feedback');
              }
            }),
          ]),
        ),
      );
    });
  }

  Future<void> _openNote() async {
    final me = _meRef;
    final cr = _clientRef;
    if (me == null || cr == null) return;
    final tc = TextEditingController();
    bool busy = false;
    await _showSheet((ctx, setS) {
      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _sheetTitle('Coach note',
                sub: _wd[_date.weekday - 1] +
                    ', ' +
                    _mo[_date.month - 1] +
                    ' ' +
                    _date.day.toString()),
            _tf(tc, 'Write a note for your client', lines: 4, auto: true),
            const SizedBox(height: 14),
            _cta('Save note', busy, () async {
              final txt = tc.text.trim();
              if (txt.isEmpty) return;
              setS(() => busy = true);
              try {
                await FirebaseFirestore.instance
                    .collection('coach_daily_notes')
                    .add({
                  'clientRef': cr,
                  'coachRef': me,
                  'date': Timestamp.fromDate(
                      DateTime(_date.year, _date.month, _date.day)),
                  'content': txt,
                  'createdAt': FieldValue.serverTimestamp(),
                });
                if (ctx.mounted) Navigator.of(ctx).pop();
                _toast('Note saved');
              } catch (e) {
                setS(() => busy = false);
                _toast('Could not save note');
              }
            }),
          ]);
    });
  }

  Future<void> _openGoals() async {
    final me = _meRef;
    final cr = _clientRef;
    if (me == null || cr == null) return;
    final g = _goal;
    final cal = TextEditingController(
        text: g == null ? '' : _i(g['calories']).toString());
    final pro = TextEditingController(
        text: g == null ? '' : _i(g['protein']).toString());
    final car =
        TextEditingController(text: g == null ? '' : _i(g['carbs']).toString());
    final fat =
        TextEditingController(text: g == null ? '' : _i(g['fat']).toString());
    bool busy = false;
    await _showSheet((ctx, setS) {
      return SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _sheetTitle('Nutrition goals', sub: 'Daily targets for this client'),
          _lbl('Calories'),
          _tf(cal, 'kcal', num: true),
          _lbl('Protein (g)'),
          _tf(pro, 'grams', num: true),
          _lbl('Carbs (g)'),
          _tf(car, 'grams', num: true),
          _lbl('Fat (g)'),
          _tf(fat, 'grams', num: true),
          const SizedBox(height: 16),
          _cta('Save goals', busy, () async {
            if (_toInt(cal.text) <= 0) {
              _toast('Enter a calorie target');
              return;
            }
            setS(() => busy = true);
            try {
              await FirebaseFirestore.instance
                  .collection('nutrition_goals')
                  .add({
                'client': cr,
                'created_by': me,
                'effective_date': Timestamp.fromDate(
                    DateTime(_date.year, _date.month, _date.day)),
                'calories': _toInt(cal.text),
                'protein': _toInt(pro.text),
                'carbs': _toInt(car.text),
                'fat': _toInt(fat.text),
                'createdAt': FieldValue.serverTimestamp(),
              });
              if (ctx.mounted) Navigator.of(ctx).pop();
              _toast('Goals updated');
            } catch (e) {
              setS(() => busy = false);
              _toast('Could not save goals');
            }
          }),
        ]),
      );
    });
  }

  Future<void> _openAssign() async {
    final me = _meRef;
    final cr = _clientRef;
    if (me == null || cr == null) return;
    final name = TextEditingController();
    final dur = TextEditingController(text: '45');
    final types = ['Strength', 'Cardio', 'Mobility', 'HIIT'];
    int type = 0;
    final rows = <List<TextEditingController>>[
      [
        TextEditingController(),
        TextEditingController(),
        TextEditingController()
      ],
    ];
    bool busy = false;
    await _showSheet((ctx, setS) {
      return Flexible(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _sheetTitle('Assign workout',
                sub: _wd[_date.weekday - 1] +
                    ', ' +
                    _mo[_date.month - 1] +
                    ' ' +
                    _date.day.toString()),
            _tf(name, 'Workout name'),
            _lbl('Type'),
            Wrap(spacing: 8, runSpacing: 8, children: [
              for (int i = 0; i < types.length; i++)
                _chipBtn(types[i], type == i, () => setS(() => type = i)),
            ]),
            _lbl('Duration (min)'),
            _tf(dur, 'minutes', num: true),
            _lbl('Exercises'),
            for (int i = 0; i < rows.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(children: [
                  Expanded(flex: 5, child: _tf(rows[i][0], 'Exercise')),
                  const SizedBox(width: 8),
                  Expanded(flex: 2, child: _tf(rows[i][1], 'Sets', num: true)),
                  const SizedBox(width: 8),
                  Expanded(flex: 2, child: _tf(rows[i][2], 'Reps')),
                ]),
              ),
            GestureDetector(
              onTap: () => setS(() => rows.add([
                    TextEditingController(),
                    TextEditingController(),
                    TextEditingController()
                  ])),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('+ Add exercise',
                    style: TextStyle(
                        color: _cOrange,
                        fontWeight: FontWeight.w800,
                        fontSize: 15)),
              ),
            ),
            const SizedBox(height: 10),
            _cta('Assign workout', busy, () async {
              if (name.text.trim().isEmpty) {
                _toast('Name the workout');
                return;
              }
              setS(() => busy = true);
              try {
                final db = FirebaseFirestore.instance;
                final ref = await db.collection('workout_plans').add({
                  'client': cr,
                  'coach': me,
                  'assigned_by_coach': true,
                  'workout_name': name.text.trim(),
                  'workout_type': types[type],
                  'duration_min': _toInt(dur.text),
                  'scheduled_date': Timestamp.fromDate(
                      DateTime(_date.year, _date.month, _date.day)),
                  'status': 'assigned',
                });
                int order = 0;
                for (final r in rows) {
                  if (r[0].text.trim().isEmpty) continue;
                  await db.collection('workout_exercises').add({
                    'workout': ref,
                    'exercise_name': r[0].text.trim(),
                    'sets': _toInt(r[1].text),
                    'target_reps': r[2].text.trim(),
                    'exercise_order': order,
                  });
                  order++;
                }
                if (ctx.mounted) Navigator.of(ctx).pop();
                _toast('Workout assigned');
              } catch (e) {
                setS(() => busy = false);
                _toast('Could not assign workout');
              }
            }),
          ]),
        ),
      );
    });
  }

  Future<void> _openMeasure() async {
    final me = _meRef;
    final cr = _clientRef;
    if (me == null || cr == null) return;
    final last = _desc(_meas, 'measured_at');
    final unit = last.isNotEmpty && _s(last.first['weight_unit']).isNotEmpty
        ? _s(last.first['weight_unit'])
        : 'lb';
    final w = TextEditingController();
    final bf = TextEditingController();
    final waist = TextEditingController();
    final chest = TextEditingController();
    final arm = TextEditingController();
    final thigh = TextEditingController();
    final hip = TextEditingController();
    bool busy = false;
    await _showSheet((ctx, setS) {
      return Flexible(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _sheetTitle('Add measurement'),
            _lbl('Weight (' + unit + ')'),
            _tf(w, 'Weight', num: true),
            _lbl('Body fat %'),
            _tf(bf, 'Optional', num: true),
            _lbl('Waist'),
            _tf(waist, 'Optional', num: true),
            _lbl('Chest'),
            _tf(chest, 'Optional', num: true),
            _lbl('Arm'),
            _tf(arm, 'Optional', num: true),
            _lbl('Thigh'),
            _tf(thigh, 'Optional', num: true),
            _lbl('Hip'),
            _tf(hip, 'Optional', num: true),
            const SizedBox(height: 16),
            _cta('Save measurement', busy, () async {
              final data = <String, dynamic>{
                'client': cr,
                'created_by': me,
                'measured_at': Timestamp.now(),
                'weight_unit': unit,
              };
              void put(String k, TextEditingController c) {
                final v = double.tryParse(c.text.trim());
                if (v != null) data[k] = v;
              }

              put('weight', w);
              put('body_fat_pct', bf);
              put('waist', waist);
              put('chest', chest);
              put('arm', arm);
              put('thigh', thigh);
              put('hip', hip);
              if (data.length <= 4) {
                _toast('Enter at least one value');
                return;
              }
              setS(() => busy = true);
              try {
                await FirebaseFirestore.instance
                    .collection('body_measurements')
                    .add(data);
                if (ctx.mounted) Navigator.of(ctx).pop();
                _toast('Measurement saved');
              } catch (e) {
                setS(() => busy = false);
                _toast('Could not save measurement');
              }
            }),
          ]),
        ),
      );
    });
  }

  Future<void> _openWorkout(Map<String, dynamic> p) async {
    final pr = p['ref'];
    if (pr is! DocumentReference) return;
    final cr = _clientRef;
    final en = TextEditingController();
    final es = TextEditingController();
    final er = TextEditingController();
    await _showSheet((ctx, setS) {
      return Flexible(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _sheetTitle(
                _s(p['workout_name']).isEmpty
                    ? 'Workout'
                    : _s(p['workout_name']),
                sub: _s(p['workout_type']) +
                    (_i(p['duration_min']) > 0
                        ? '  ·  ' + _i(p['duration_min']).toString() + ' min'
                        : '')),
            Row(children: [
              _pill(_s(p['status']).isEmpty ? 'assigned' : _s(p['status']),
                  _cOrange, _cPeach),
            ]),
            _lbl('Exercises'),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('workout_exercises')
                  .where('workout', isEqualTo: pr)
                  .snapshots(),
              builder: (c2, snap) {
                if (!snap.hasData)
                  return const Padding(
                      padding: EdgeInsets.all(14),
                      child: Center(
                          child: CircularProgressIndicator(
                              color: _cOrange, strokeWidth: 2)));
                final l = snap.data!.docs.map(_m).toList();
                l.sort((a, b) =>
                    _i(a['exercise_order']).compareTo(_i(b['exercise_order'])));
                if (l.isEmpty)
                  return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text('No exercises yet',
                          style: TextStyle(color: _cGray, fontSize: 15)));
                return Column(
                  children: l
                      .map((x) => Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                                color: _cSubtle,
                                borderRadius: BorderRadius.circular(14)),
                            child: Row(children: [
                              Expanded(
                                  child: Text(_s(x['exercise_name']),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700))),
                              Text(
                                  _i(x['sets']).toString() +
                                      ' x ' +
                                      _s(x['target_reps']),
                                  style: const TextStyle(
                                      color: _cGray,
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    await (x['ref'] as DocumentReference)
                                        .delete();
                                  } catch (_) {
                                    _toast('Could not remove');
                                  }
                                },
                                child: const Icon(Icons.close,
                                    size: 18, color: _cGray),
                              ),
                            ]),
                          ))
                      .toList(),
                );
              },
            ),
            _lbl('Add exercise'),
            Row(children: [
              Expanded(flex: 5, child: _tf(en, 'Exercise')),
              const SizedBox(width: 8),
              Expanded(flex: 2, child: _tf(es, 'Sets', num: true)),
              const SizedBox(width: 8),
              Expanded(flex: 2, child: _tf(er, 'Reps')),
            ]),
            const SizedBox(height: 12),
            _cta('Add exercise', false, () async {
              if (en.text.trim().isEmpty) return;
              try {
                await FirebaseFirestore.instance
                    .collection('workout_exercises')
                    .add({
                  'workout': pr,
                  'exercise_name': en.text.trim(),
                  'sets': _toInt(es.text),
                  'target_reps': er.text.trim(),
                  'exercise_order':
                      DateTime.now().millisecondsSinceEpoch ~/ 1000,
                });
                en.clear();
                es.clear();
                er.clear();
              } catch (e) {
                _toast('Could not add exercise');
              }
            }, dark: true),
          ]),
        ),
      );
    });
  }

  Future<void> _openVideo(Map<String, dynamic> v) async {
    final me = _meRef;
    final cr = _clientRef;
    if (me == null || cr == null) return;
    final tc = TextEditingController();
    bool busy = false;
    final url = _s(v['video_path']);
    Future<void> submit(
        BuildContext ctx, StateSetter setS, String status) async {
      final txt = tc.text.trim();
      if (txt.isEmpty && status == 'rerecord') {
        _toast('Say what to fix');
        return;
      }
      setS(() => busy = true);
      try {
        if (txt.isNotEmpty) {
          await FirebaseFirestore.instance.collection('exercise_feedback').add({
            'submission': v['ref'],
            'coach': me,
            'comment': txt,
            'created_at': FieldValue.serverTimestamp(),
          });
        }
        await (v['ref'] as DocumentReference).update({
          'review_status': status,
          'reviewed_at': FieldValue.serverTimestamp()
        });
        if (ctx.mounted) Navigator.of(ctx).pop();
        _toast(
            status == 'reviewed' ? 'Marked reviewed' : 'Re-record requested');
      } catch (e) {
        setS(() => busy = false);
        _toast('Could not update video');
      }
    }

    await _showSheet((ctx, setS) {
      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _sheetTitle('Form video',
                sub: _dt(v['uploaded_at']) == null
                    ? ''
                    : _ago(_dt(v['uploaded_at'])!)),
            GestureDetector(
              onTap: () async {
                if (url.isEmpty) {
                  _toast('No video file found');
                  return;
                }
                try {
                  await launchUrl(Uri.parse(url),
                      mode: LaunchMode.externalApplication);
                } catch (_) {
                  _toast('Could not open video');
                }
              },
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    color: _cInk, borderRadius: BorderRadius.circular(18)),
                child: const Center(
                    child: Icon(Icons.play_circle_fill,
                        color: Colors.white, size: 56)),
              ),
            ),
            _lbl('Feedback'),
            _tf(tc, 'Cues, corrections, praise', lines: 3),
            const SizedBox(height: 14),
            _cta('Send feedback and mark reviewed', busy,
                () => submit(ctx, setS, 'reviewed')),
            const SizedBox(height: 10),
            _cta('Request re-record', busy, () => submit(ctx, setS, 'rerecord'),
                dark: true),
          ]);
    });
  }

  Future<void> _openGallery() async {
    final l = _desc(_photos, 'taken_at');
    await _showSheet((ctx, setS) {
      return Flexible(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _sheetTitle('Progress photos', sub: l.length.toString() + ' total'),
            if (l.isEmpty)
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                      child: Text('No photos yet',
                          style: TextStyle(color: _cGray, fontSize: 15))))
            else
              GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: l
                    .map((p) => GestureDetector(
                          onTap: () {
                            Navigator.of(ctx).pop();
                            _openPhoto(p);
                          },
                          child: _thumb(_s(p['photo_path']), 110,
                              ic: Icons.image_outlined),
                        ))
                    .toList(),
              ),
          ]),
        ),
      );
    });
  }

  Future<void> _openPhoto(Map<String, dynamic> p) async {
    final me = _meRef;
    final cr = _clientRef;
    final pr = p['ref'];
    if (me == null || cr == null || pr is! DocumentReference) return;
    final tc = TextEditingController();
    bool busy = false;
    final url = _s(p['photo_path']);
    final t = _dt(p['taken_at']);
    await _showSheet((ctx, setS) {
      return Flexible(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _sheetTitle(
                _s(p['photo_type']).isEmpty
                    ? 'Progress photo'
                    : _s(p['photo_type']),
                sub: t == null
                    ? ''
                    : _mo[t.month - 1] +
                        ' ' +
                        t.day.toString() +
                        ', ' +
                        t.year.toString()),
            if (url.isNotEmpty)
              ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(url,
                      height: 340,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox(
                          height: 120,
                          child: Center(
                              child: Icon(Icons.image_not_supported_outlined,
                                  color: _cGray))))),
            _lbl('Feedback'),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('progress_feedback')
                  .where('photoRef', isEqualTo: pr)
                  .snapshots(),
              builder: (c2, snap) {
                if (!snap.hasData) return const SizedBox();
                final l = _desc(snap.data!.docs.map(_m).toList(), 'createdAt');
                return Column(
                  children: l
                      .map((x) => Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: _cSubtle,
                                borderRadius: BorderRadius.circular(14)),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(_s(x['content']),
                                    style: const TextStyle(fontSize: 15))),
                          ))
                      .toList(),
                );
              },
            ),
            _tf(tc, 'Write feedback on this photo', lines: 3),
            const SizedBox(height: 14),
            _cta('Send feedback', busy, () async {
              final txt = tc.text.trim();
              if (txt.isEmpty) return;
              setS(() => busy = true);
              try {
                await FirebaseFirestore.instance
                    .collection('progress_feedback')
                    .add({
                  'photoRef': pr,
                  'coachRef': me,
                  'clientRef': cr,
                  'content': txt,
                  'createdAt': FieldValue.serverTimestamp(),
                });
                tc.clear();
                setS(() => busy = false);
                _toast('Feedback sent');
              } catch (e) {
                setS(() => busy = false);
                _toast('Could not send feedback');
              }
            }),
          ]),
        ),
      );
    });
  }
}
