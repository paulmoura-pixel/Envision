// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

const _gOrange = Color(0xFFFF6A00);
const _gInk = Color(0xFF0B0B0B);
const _gGray = Color(0xFF85858D);
const _gLine = Color(0xFFE5E5E7);
const _gRed = Color(0xFFD92D20);
const _gMinCal = 1200;
const _gMaxCal = 4000;

Future showEnvisionNutritionGoals(BuildContext context) async {
  final me = currentUserReference;
  if (me == null) return;
  Map<String, dynamic>? latest;
  bool locked = false;
  String managedBy = '';
  try {
    final q = await FirebaseFirestore.instance
        .collection('nutrition_goals')
        .where('client', isEqualTo: me)
        .get();
    DateTime? best;
    for (final d in q.docs) {
      final m = d.data();
      final t = m['effective_date'];
      final dt =
          t is Timestamp ? t.toDate() : DateTime.fromMillisecondsSinceEpoch(0);
      if (best == null || dt.isAfter(best)) {
        best = dt;
        latest = m;
      }
    }
    final by = latest?['updated_by'];
    if (by is DocumentReference && by.id != me.id) {
      locked = true;
      managedBy = 'your coach';
      try {
        final u = await by.get();
        final um = u.data();
        if (um is Map) {
          final n = (um['display_name'] ?? '').toString().trim();
          if (n.isNotEmpty) managedBy = n;
        }
      } catch (_) {}
    }
  } catch (_) {}
  if (!context.mounted) return;
  await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black54,
    builder: (_) => _EnvisionGoalsSheet(
      me: me,
      initial: latest,
      locked: locked,
      managedBy: managedBy,
    ),
  );
}

class _EnvisionGoalsSheet extends StatefulWidget {
  const _EnvisionGoalsSheet({
    required this.me,
    required this.initial,
    required this.locked,
    required this.managedBy,
  });
  final DocumentReference me;
  final Map<String, dynamic>? initial;
  final bool locked;
  final String managedBy;

  @override
  State<_EnvisionGoalsSheet> createState() => _EnvisionGoalsSheetState();
}

class _EnvisionGoalsSheetState extends State<_EnvisionGoalsSheet> {
  final _cal = TextEditingController();
  final _pro = TextEditingController();
  final _carb = TextEditingController();
  final _fat = TextEditingController();
  bool _auto = true;
  bool _saving = false;
  String? _calErr;
  String? _macroErr;
  String? _saveErr;
  String _snap = '';

  @override
  void initState() {
    super.initState();
    final m = widget.initial;
    int? gi(String k) {
      final v = m?[k];
      return v is num ? v.round() : null;
    }

    final c = gi('calories');
    if (c != null && c > 0) {
      _cal.text = c.toString();
      _pro.text = (gi('protein') ?? 0).toString();
      _carb.text = (gi('carbs') ?? 0).toString();
      _fat.text = (gi('fat') ?? 0).toString();
      _auto = (m?['mode'] ?? '') == 'auto';
    } else {
      _cal.text = '2200';
      _auto = true;
      _autoFill();
    }
    _snap = _stateKey();
  }

  @override
  void dispose() {
    _cal.dispose();
    _pro.dispose();
    _carb.dispose();
    _fat.dispose();
    super.dispose();
  }

  String _stateKey() =>
      _cal.text +
      '|' +
      _pro.text +
      '|' +
      _carb.text +
      '|' +
      _fat.text +
      '|' +
      (_auto ? 'a' : 'c');

  int? _v(TextEditingController c) => int.tryParse(c.text.trim());

  String _fmt(int n) {
    final s = n.abs().toString();
    final b = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
      b.write(s[i]);
    }
    return b.toString();
  }

  void _autoFill() {
    final c = _v(_cal);
    if (c == null) return;
    _pro.text = (c * 0.30 / 4).round().toString();
    _carb.text = (c * 0.45 / 4).round().toString();
    _fat.text = (c * 0.25 / 9).round().toString();
  }

  void _onCal(String _) {
    setState(() {
      _saveErr = null;
      final c = _v(_cal);
      if (c == null) {
        _calErr = 'Enter a daily calorie goal.';
      } else if (c < 500 || c > 10000) {
        _calErr = 'Enter a goal between 500 and 10,000 kcal.';
      } else {
        _calErr = null;
        if (_auto) _autoFill();
      }
    });
  }

  void _onMacro(String _) {
    setState(() {
      _auto = false;
      _macroErr = null;
      _saveErr = null;
    });
  }

  void _setFromFrac(double f) {
    final v = ((_gMinCal + f * (_gMaxCal - _gMinCal)) / 50).round() * 50;
    _cal.text = v.toString();
    _onCal('');
  }

  int _macroKcal() =>
      (_v(_pro) ?? 0) * 4 + (_v(_carb) ?? 0) * 4 + (_v(_fat) ?? 0) * 9;

  bool _validate() {
    bool ok = true;
    final c = _v(_cal);
    String? ce;
    if (c == null) {
      ce = 'Enter a daily calorie goal.';
      ok = false;
    } else if (c < 500 || c > 10000) {
      ce = 'Enter a goal between 500 and 10,000 kcal.';
      ok = false;
    }
    String? me;
    for (final t in [_pro, _carb, _fat]) {
      final g = _v(t);
      if (g == null || g < 0 || g > 1000) {
        me = 'Enter 0 to 1,000 g for each macro.';
        ok = false;
      }
    }
    setState(() {
      _calErr = ce;
      _macroErr = me;
    });
    return ok;
  }

  Future<void> _save() async {
    if (_saving || widget.locked) return;
    FocusScope.of(context).unfocus();
    if (!_validate()) return;
    setState(() {
      _saving = true;
      _saveErr = null;
    });
    try {
      final n = DateTime.now();
      final today = DateTime(n.year, n.month, n.day);
      final col = FirebaseFirestore.instance.collection('nutrition_goals');
      final existing = await col.where('client', isEqualTo: widget.me).get();
      DocumentReference? sameDay;
      for (final d in existing.docs) {
        final t = d.data()['effective_date'];
        if (t is Timestamp) {
          final x = t.toDate();
          if (x.year == today.year &&
              x.month == today.month &&
              x.day == today.day) {
            sameDay = d.reference;
          }
        }
      }
      final data = <String, dynamic>{
        'calories': _v(_cal),
        'protein': _v(_pro),
        'carbs': _v(_carb),
        'fat': _v(_fat),
        'mode': _auto ? 'auto' : 'custom',
        'client': widget.me,
        'updated_by': widget.me,
        'effective_date': Timestamp.fromDate(today),
        'updated_time': FieldValue.serverTimestamp(),
      };
      if (sameDay != null) {
        await sameDay.update(data);
      } else {
        data['created_time'] = FieldValue.serverTimestamp();
        await col.add(data);
      }
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _saveErr = 'Could not save your goals. Please try again.';
      });
    }
  }

  Future<void> _close() async {
    if (widget.locked || _stateKey() == _snap) {
      Navigator.of(context).pop();
      return;
    }
    final discard = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text('Your edits will not be saved.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Keep editing')),
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Discard')),
        ],
      ),
    );
    if (discard == true && mounted) Navigator.of(context).pop();
  }

  Widget _numBox(TextEditingController c, String unit, double width,
      void Function(String) onChanged, bool ro, double fs) {
    return Container(
      width: width,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _gLine),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: c,
              readOnly: ro,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(5),
              ],
              textAlign: TextAlign.right,
              onChanged: onChanged,
              cursorColor: _gInk,
              style: TextStyle(
                  fontSize: fs, fontWeight: FontWeight.w500, color: _gInk),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(unit, style: const TextStyle(fontSize: 16, color: _gGray)),
        ],
      ),
    );
  }

  Widget _slider(int? cal, bool ro) {
    final v = math.max(_gMinCal, math.min(_gMaxCal, cal ?? 2200));
    final frac = (v - _gMinCal) / (_gMaxCal - _gMinCal);
    return LayoutBuilder(builder: (ctx, bc) {
      const r = 15.0;
      final usable = bc.maxWidth - 2 * r;
      void upd(double dx) {
        if (ro) return;
        _setFromFrac(((dx - r) / usable).clamp(0.0, 1.0));
      }

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (d) => upd(d.localPosition.dx),
        onHorizontalDragUpdate: (d) => upd(d.localPosition.dx),
        child: SizedBox(
          height: 40,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                    color: _gLine, borderRadius: BorderRadius.circular(3)),
              ),
              Container(
                height: 6,
                width: r + usable * frac,
                decoration: BoxDecoration(
                    color: _gOrange, borderRadius: BorderRadius.circular(3)),
              ),
              Positioned(
                left: usable * frac,
                top: 5,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: _gOrange, width: 1.5),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 6,
                          offset: Offset(0, 2)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _macro(IconData icon, String name, String sub, TextEditingController c,
      int perKcal, bool ro) {
    final g = _v(c) ?? 0;
    final cal = _v(_cal);
    final pct =
        (cal != null && cal > 0) ? ((g * perKcal) / cal * 100).round() : 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _gLine),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: _gInk),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: _gInk)),
                const SizedBox(height: 2),
                Text(sub,
                    style: const TextStyle(fontSize: 13.5, color: _gGray)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _numBox(c, 'g', 92, _onMacro, ro, 20),
          const SizedBox(width: 10),
          SizedBox(
            width: 38,
            child: Text(pct.toString() + '%',
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 15, color: _gGray)),
          ),
        ],
      ),
    );
  }

  Widget _opt(String t, bool sel, bool ro, VoidCallback f) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: ro ? null : f,
      child: Padding(
        padding: const EdgeInsets.only(right: 18, top: 4, bottom: 4),
        child: Text(
          t,
          style: TextStyle(
            fontSize: 14,
            fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
            color: sel ? _gInk : _gGray,
            decoration: sel ? TextDecoration.underline : TextDecoration.none,
            decorationColor: _gOrange,
            decorationThickness: 2,
          ),
        ),
      ),
    );
  }

  Widget _err(String t) => Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(t, style: const TextStyle(fontSize: 13, color: _gRed)),
      );

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final cal = _v(_cal);
    final ro = widget.locked;
    final kcal = _macroKcal();
    final goal = cal ?? 0;
    final diff = kcal - goal;
    final off = cal != null && diff.abs() > math.max(25, (goal * 0.02).round());
    final summary = off
        ? 'Your macros add up to ' +
            _fmt(kcal) +
            ' kcal, ' +
            _fmt(diff) +
            ' kcal ' +
            (diff > 0 ? 'over' : 'under') +
            ' your ' +
            _fmt(goal) +
            ' kcal goal. Adjust them or save as is.'
        : 'Your macros add up to ' + _fmt(kcal) + ' kcal.';

    return Padding(
      padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
      child: Container(
        constraints: BoxConstraints(maxHeight: mq.size.height * 0.94),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFFD1D1D6),
                  borderRadius: BorderRadius.circular(2)),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: GestureDetector(
                            onTap: _close,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFF2F2F4),
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.close,
                                  size: 22, color: _gInk),
                            ),
                          ),
                        ),
                      ],
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Set Your Nutrition Goals',
                        style: TextStyle(
                            fontSize: 32,
                            height: 1.1,
                            letterSpacing: -0.8,
                            fontWeight: FontWeight.w800,
                            color: _gInk),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Customize your daily targets to track your progress.',
                      style: TextStyle(fontSize: 16, color: _gGray),
                    ),
                    if (ro) ...[
                      const SizedBox(height: 10),
                      Text(
                        'These goals are managed by ' +
                            widget.managedBy +
                            '. Ask them if you need a change.',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _gInk),
                      ),
                    ],
                    const SizedBox(height: 26),
                    Row(
                      children: [
                        const Expanded(
                          child: Text('Daily Calorie Goal',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: _gInk)),
                        ),
                        const SizedBox(width: 8),
                        _numBox(_cal, 'kcal', 150, _onCal, ro, 22),
                      ],
                    ),
                    if (_calErr != null) _err(_calErr!),
                    const SizedBox(height: 12),
                    _slider(cal, ro),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('1,200',
                            style: TextStyle(fontSize: 14, color: _gGray)),
                        Text('4,000',
                            style: TextStyle(fontSize: 14, color: _gGray)),
                      ],
                    ),
                    const SizedBox(height: 26),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Expanded(
                          child: Text('Macro Goals',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: _gInk)),
                        ),
                        Text('Based on ' + _fmt(goal) + ' kcal',
                            style:
                                const TextStyle(fontSize: 14, color: _gGray)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _opt('Auto split', _auto, ro, () {
                          setState(() {
                            _auto = true;
                            _macroErr = null;
                            _autoFill();
                          });
                        }),
                        _opt('Custom', !_auto, ro, () {
                          setState(() => _auto = false);
                        }),
                      ],
                    ),
                    if (_auto)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Auto split: 30% protein, 45% carbs, 25% fat. A simple starting point, not medical advice.',
                          style: TextStyle(fontSize: 13, color: _gGray),
                        ),
                      ),
                    const SizedBox(height: 6),
                    _macro(Icons.fitness_center_outlined, 'Protein',
                        'Build and maintain muscle.', _pro, 4, ro),
                    _macro(Icons.layers_outlined, 'Carbs',
                        'Fuel your training and activity.', _carb, 4, ro),
                    _macro(Icons.water_drop_outlined, 'Fat',
                        'Support hormones and recovery.', _fat, 9, ro),
                    if (_macroErr != null) _err(_macroErr!),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 8),
                      child: Text(summary,
                          style: TextStyle(
                              fontSize: 13,
                              color: off ? _gInk : _gGray,
                              fontWeight:
                                  off ? FontWeight.w600 : FontWeight.w400)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 12 + mq.padding.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_saveErr != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(_saveErr!,
                          style: const TextStyle(fontSize: 13, color: _gRed)),
                    ),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _saving
                          ? null
                          : (ro ? () => Navigator.of(context).pop() : _save),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _gInk,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: _gInk,
                        disabledForegroundColor: Colors.white70,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: _saving
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2.5, color: Colors.white))
                          : Text(ro ? 'Close' : 'Save Goals',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
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
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
