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

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
Future<DateTime?> showEnvisionCalendar(
  BuildContext context,
  DateTime? selectedDate,
  List<DateTime>? nutritionDates,
  List<DateTime>? trainingDates,
  List<DateTime>? progressDates,
) {
  DateTime dayOnly(DateTime d) => DateTime(d.year, d.month, d.day);
  Set<DateTime> toSet(List<DateTime>? l) => (l ?? []).map(dayOnly).toSet();

  return showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black54,
    builder: (_) => _EnvisionCalendarSheet(
      initial: dayOnly(selectedDate ?? DateTime.now()),
      nutrition: toSet(nutritionDates),
      training: toSet(trainingDates),
      progress: toSet(progressDates),
    ),
  );
}

const _orange = Color(0xFFF97316);
const _slate = Color(0xFF4B5563);
const _green = Color(0xFF65C728);
const _maxFutureDays = 90;

class _EnvisionCalendarSheet extends StatefulWidget {
  const _EnvisionCalendarSheet({
    required this.initial,
    required this.nutrition,
    required this.training,
    required this.progress,
  });

  final DateTime initial;
  final Set<DateTime> nutrition;
  final Set<DateTime> training;
  final Set<DateTime> progress;

  @override
  State<_EnvisionCalendarSheet> createState() => _EnvisionCalendarSheetState();
}

class _EnvisionCalendarSheetState extends State<_EnvisionCalendarSheet> {
  late DateTime _month;
  late final DateTime _today;
  late final DateTime _maxDate;

  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  static const _weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  void initState() {
    super.initState();
    final n = DateTime.now();
    _today = DateTime(n.year, n.month, n.day);
    _maxDate = DateTime(n.year, n.month, n.day + _maxFutureDays);
    _month = DateTime(widget.initial.year, widget.initial.month, 1);
  }

  bool get _canGoNext =>
      !DateTime(_month.year, _month.month + 1, 1).isAfter(_maxDate);

  void _shift(int delta) =>
      setState(() => _month = DateTime(_month.year, _month.month + delta, 1));

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(20, 10, 20, 16 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFD1D5DB),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Expanded(
                child: Text('Select Date',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.black)),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(_today),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEDD5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Today',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: _orange)),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                      color: Color(0xFFF3F4F6), shape: BoxShape.circle),
                  child: const Icon(Icons.close, color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              IconButton(
                onPressed: () => _shift(-1),
                icon: const Icon(Icons.chevron_left, size: 30),
              ),
              Expanded(
                child: Text(
                  '${_months[_month.month - 1]} ${_month.year}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              IconButton(
                onPressed: _canGoNext ? () => _shift(1) : null,
                disabledColor: const Color(0xFFD1D5DB),
                icon: const Icon(Icons.chevron_right, size: 30),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: _weekdays
                .map((d) => Expanded(
                      child: Center(
                        child: Text(d,
                            style: const TextStyle(
                                fontSize: 14, color: Color(0xFF6B7280))),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          ..._buildWeeks(),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _LegendItem(color: _orange, label: 'Nutrition'),
              _LegendItem(color: _slate, label: 'Training'),
              _LegendItem(color: _green, label: 'Progress'),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildWeeks() {
    final daysInMonth = DateTime(_month.year, _month.month + 1, 0).day;
    final leading = _month.weekday % 7;

    final cells = <Widget>[
      for (var i = 0; i < leading; i++) const Expanded(child: SizedBox()),
      for (var d = 1; d <= daysInMonth; d++)
        _dayCell(DateTime(_month.year, _month.month, d)),
    ];
    while (cells.length % 7 != 0) {
      cells.add(const Expanded(child: SizedBox()));
    }

    return [
      for (var i = 0; i < cells.length; i += 7)
        Row(children: cells.sublist(i, i + 7)),
    ];
  }

  Widget _dayCell(DateTime d) {
    final selected = d == widget.initial;
    final isToday = d == _today;
    final isFuture = d.isAfter(_today);
    final beyondCap = d.isAfter(_maxDate);
    final dots = <Color>[
      if (widget.nutrition.contains(d)) _orange,
      if (widget.training.contains(d)) _slate,
      if (widget.progress.contains(d)) _green,
    ];

    // Future days with nothing scheduled are dimmed; beyond the cap is disabled.
    Color textColor = Colors.black;
    if (beyondCap) {
      textColor = const Color(0xFFD1D5DB);
    } else if (isFuture && dots.isEmpty) {
      textColor = const Color(0xFF9CA3AF);
    }
    if (selected) textColor = Colors.white;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: beyondCap ? null : () => Navigator.of(context).pop(d),
        child: SizedBox(
          height: 58,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? _orange : Colors.transparent,
                  shape: BoxShape.circle,
                  border: (isToday && !selected)
                      ? Border.all(color: _orange, width: 1.5)
                      : null,
                ),
                child: Text(
                  '${d.day}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 6,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final c in dots)
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        decoration:
                            BoxDecoration(color: c, shape: BoxShape.circle),
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
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      );
}
