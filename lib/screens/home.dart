import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets.dart';
import 'add_meal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;
  int _day = 3; // Thursday

  static const _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const _dates = [19, 20, 21, 22, 23, 24, 25];
  // 0 none, 1 partial, 2 complete
  static const _done = [2, 2, 1, 1, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    if (_tab != 0) return _secondaryTabPage(bottom);
    return Scaffold(
      backgroundColor: EC.bg,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Stack(children: [
            SafeArea(
              bottom: false,
              child: ListView(
                padding: EdgeInsets.fromLTRB(EC.pad, 12, EC.pad, 130 + bottom),
                children: [
                  _header(),
                  const SizedBox(height: 22),
                  _weekStrip(),
                  const SizedBox(height: 22),
                  _calorieCard(),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(
                        child: _macro('Protein', 98, 160, EC.protein,
                            Icons.egg_alt_rounded)),
                    const SizedBox(width: 10),
                    Expanded(
                        child: _macro(
                            'Carbs', 142, 280, EC.carbs, Icons.grain_rounded)),
                    const SizedBox(width: 10),
                    Expanded(
                        child: _macro(
                            'Fat', 38, 70, EC.fat, Icons.opacity_rounded)),
                  ]),
                  const SizedBox(height: 28),
                  _title('Today\'s workout', action: 'Schedule'),
                  const SizedBox(height: 12),
                  _workoutCard(),
                  const SizedBox(height: 18),
                  _title('Coach note'),
                  const SizedBox(height: 12),
                  _coachMessage(),
                  const SizedBox(height: 28),
                  _title('Recent meals', action: 'See all'),
                  const SizedBox(height: 12),
                  _meal(
                      '🥑', 'Avocado toast & eggs', '8:15 AM', 420, 24, 36, 20),
                  const SizedBox(height: 10),
                  _meal('🥗', 'Grilled chicken salad', '12:40 PM', 540, 48, 22,
                      26),
                  const SizedBox(height: 10),
                  _meal('🥤', 'Protein shake', '3:30 PM', 190, 30, 8, 3),
                  const SizedBox(height: 28),
                  _title('Daily activity'),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(
                        child: _stat(
                            Icons.directions_walk_rounded, '8,432', 'Steps')),
                    const SizedBox(width: 10),
                    Expanded(
                        child: _stat(Icons.bedtime_rounded, '7h 20m', 'Sleep')),
                    const SizedBox(width: 10),
                    Expanded(
                        child: _stat(Icons.favorite_rounded, '68', 'Avg bpm')),
                  ]),
                ],
              ),
            ),
            Positioned(
              left: EC.pad,
              right: EC.pad,
              bottom: bottom + 12,
              child: FloatingNav(
                index: _tab,
                onTab: (i) => setState(() => _tab = i),
                onAdd: () => showAddMealSheet(context),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _secondaryTabPage(double bottom) {
    const titles = ['Home', 'Training', 'Nutrition', 'Progress'];
    const subtitles = [
      '',
      'Your plan, sessions, and coaching cues.',
      'Meals, targets, and daily consistency.',
      'See the work compound over time.',
    ];
    const icons = [
      Icons.home_rounded,
      Icons.fitness_center_rounded,
      Icons.restaurant_rounded,
      Icons.show_chart_rounded,
    ];
    final items = switch (_tab) {
      1 => const [
          ('Upper Body Power', 'Today · 45 min', '6 exercises'),
          ('Lower Body Strength', 'Saturday', '5 exercises'),
          ('Mobility reset', 'Sunday', '18 min'),
        ],
      2 => const [
          ('Breakfast', '420 kcal', '24g protein'),
          ('Lunch', '540 kcal', '48g protein'),
          ('Dinner target', '690 kcal left', 'Plan ahead'),
        ],
      _ => const [
          ('Training streak', '4 weeks', '+1 from last month'),
          ('Strength score', '82', '+6 this cycle'),
          ('Plan adherence', '91%', 'Personal best'),
        ],
    };

    return Scaffold(
      backgroundColor: EC.bg,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Stack(
            children: [
              SafeArea(
                bottom: false,
                child: ListView(
                  padding:
                      EdgeInsets.fromLTRB(EC.pad, 18, EC.pad, 130 + bottom),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(titles[_tab].toUpperCase(),
                                  style: ts(11,
                                      w: FontWeight.w800,
                                      color: EC.orange,
                                      ls: 1.5)),
                              const SizedBox(height: 8),
                              Text(titles[_tab],
                                  style: ts(36, w: FontWeight.w800, ls: -1.2)),
                            ],
                          ),
                        ),
                        _circleIcon(Icons.tune_rounded),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(subtitles[_tab],
                        style: ts(15, color: EC.text2, h: 1.45)),
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: EC.orangeTint,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: EC.orange.withOpacity(.18)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: const BoxDecoration(
                                color: EC.orange, shape: BoxShape.circle),
                            child: Icon(icons[_tab], color: EC.bg, size: 27),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    _tab == 1
                                        ? 'Ready when you are'
                                        : _tab == 2
                                            ? '850 calories left'
                                            : 'You are trending up',
                                    style: ts(19, w: FontWeight.w800)),
                                const SizedBox(height: 4),
                                Text('Consistency compounds.',
                                    style: ts(13, color: EC.text2)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text('Overview', style: ts(20, w: FontWeight.w800)),
                    const SizedBox(height: 12),
                    for (final item in items) ...[
                      EnvCard(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: EC.card2,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child:
                                  Icon(icons[_tab], color: EC.orange, size: 20),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.$1,
                                      style: ts(15, w: FontWeight.w700)),
                                  const SizedBox(height: 4),
                                  Text(item.$2, style: ts(13, color: EC.text2)),
                                ],
                              ),
                            ),
                            Text(item.$3,
                                style: ts(12,
                                    w: FontWeight.w700, color: EC.orange)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
              Positioned(
                left: EC.pad,
                right: EC.pad,
                bottom: bottom + 12,
                child: FloatingNav(
                  index: _tab,
                  onTab: (i) => setState(() => _tab = i),
                  onAdd: () => showAddMealSheet(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(String t, {String? action}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              t,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: ts(20, w: FontWeight.w700),
            ),
          ),
          if (action != null)
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                action,
                style: ts(14, w: FontWeight.w600, color: EC.orange),
              ),
            ),
        ],
      );

  Widget _header() => Row(children: [
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Thursday, Oct 22', style: ts(14, color: EC.text2)),
            const SizedBox(height: 4),
            Text('Good morning, Maya',
                style: ts(28, w: FontWeight.w800, h: 1.1, ls: -0.6)),
          ]),
        ),
        _circleIcon(Icons.notifications_none_rounded, dot: true),
        const SizedBox(width: 8),
        _circleIcon(
          EC.isLight ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          onTap: toggleAppTheme,
        ),
        const SizedBox(width: 10),
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(color: EC.orangeTint, shape: BoxShape.circle),
          child: Text('M', style: ts(17, w: FontWeight.w700, color: EC.orange)),
        ),
      ]);

  Widget _circleIcon(IconData i, {bool dot = false, VoidCallback? onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: EC.card,
            shape: BoxShape.circle,
            border: Border.all(color: EC.border),
          ),
          child: Stack(alignment: Alignment.center, children: [
            Icon(i, size: 22),
            if (dot)
              Positioned(
                top: 11,
                right: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: EC.orange,
                    shape: BoxShape.circle,
                    border: Border.all(color: EC.card, width: 1.5),
                  ),
                ),
              ),
          ]),
        ),
      );

  Widget _weekStrip() => Row(
        children: List.generate(7, (i) {
          final sel = i == _day;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _day = i),
              child: Column(children: [
                Text(_days[i],
                    style: ts(12, w: FontWeight.w600, color: EC.text2)),
                const SizedBox(height: 8),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 42,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: sel ? EC.orange : EC.card,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: sel ? EC.orange : EC.border, width: 1.5),
                  ),
                  child: Text('${_dates[i]}',
                      style: ts(15,
                          w: FontWeight.w700, color: sel ? EC.bg : EC.text)),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _done[i] == 2
                        ? EC.green
                        : _done[i] == 1
                            ? EC.orange
                            : Colors.transparent,
                  ),
                ),
              ]),
            ),
          );
        }),
      );

  Widget _calorieCard() => EnvCard(
        padding: const EdgeInsets.fromLTRB(24, 22, 22, 22),
        child: Row(children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('850', style: ts(52, w: FontWeight.w800, h: 1.0, ls: -1.5)),
              const SizedBox(height: 6),
              Text('Calories left', style: ts(15, color: EC.text2)),
              const SizedBox(height: 14),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                    color: EC.orangeTint,
                    borderRadius: BorderRadius.circular(12)),
                child: Text('1,650 of 2,500',
                    style: ts(12, w: FontWeight.w700, color: EC.orangeDeep)),
              ),
            ]),
          ),
          RingGauge(
            progress: 1650 / 2500,
            size: 128,
            stroke: 12,
            child: Container(
              width: 62,
              height: 62,
              decoration:
                  BoxDecoration(color: EC.orangeTint, shape: BoxShape.circle),
              child: const Icon(Icons.local_fire_department_rounded,
                  color: EC.orange, size: 30),
            ),
          ),
        ]),
      );

  Widget _macro(String name, int cur, int goal, Color c, IconData icon) =>
      EnvCard(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${goal - cur}g', style: ts(22, w: FontWeight.w800, ls: -0.4)),
          const SizedBox(height: 2),
          Text('$name left', style: ts(12, color: EC.text2)),
          const SizedBox(height: 14),
          Center(
            child: RingGauge(
              progress: cur / goal,
              size: 58,
              stroke: 6,
              color: c,
              child: Icon(icon, size: 20, color: c),
            ),
          ),
        ]),
      );

  Widget _workoutCard() => Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: EC.orangeTint,
          borderRadius: BorderRadius.circular(EC.r),
          border: Border.all(color: EC.workoutBorder),
        ),
        child: Row(children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('UPPER BODY',
                  style: ts(12,
                      w: FontWeight.w800, color: EC.orangeDeep, ls: 1.2)),
              const SizedBox(height: 6),
              Text('Upper Body Power',
                  style: ts(23, w: FontWeight.w800, ls: -0.4)),
              const SizedBox(height: 8),
              Text('45 min  ·  6 exercises',
                  style: ts(14, color: EC.workoutText)),
              const SizedBox(height: 2),
              Text('Assigned by Coach Sarah',
                  style: ts(13, color: EC.workoutText)),
            ]),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: EC.orange,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: EC.orange.withOpacity(0.4),
                    blurRadius: 18,
                    offset: const Offset(0, 8))
              ],
            ),
            child: Icon(Icons.play_arrow_rounded, color: EC.bg, size: 36),
          ),
        ]),
      );

  Widget _meal(String emoji, String name, String time, int kcal, int p, int c,
          int f) =>
      EnvCard(
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          Container(
            width: 70,
            height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: EC.orangeTint,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 34)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  child: Text(name,
                      overflow: TextOverflow.ellipsis,
                      style: ts(16, w: FontWeight.w700)),
                ),
                Text(time, style: ts(12, color: EC.text2)),
              ]),
              const SizedBox(height: 6),
              Row(children: [
                const Icon(Icons.local_fire_department_rounded,
                    size: 16, color: EC.orange),
                const SizedBox(width: 4),
                Text('$kcal kcal', style: ts(14, w: FontWeight.w700)),
              ]),
              const SizedBox(height: 6),
              Row(children: [
                _chip('P ${p}g', EC.protein),
                const SizedBox(width: 6),
                _chip('C ${c}g', EC.carbs),
                const SizedBox(width: 6),
                _chip('F ${f}g', EC.fat),
              ]),
            ]),
          ),
        ]),
      );

  Widget _chip(String t, Color c) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
            color: c.withOpacity(0.10), borderRadius: BorderRadius.circular(8)),
        child: Text(t, style: ts(11, w: FontWeight.w700, color: c)),
      );

  Widget _stat(IconData i, String v, String l) => EnvCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(i, size: 22, color: EC.orange),
          const SizedBox(height: 12),
          Text(v, style: ts(19, w: FontWeight.w800, ls: -0.3)),
          const SizedBox(height: 2),
          Text(l, style: ts(12, color: EC.text2)),
        ]),
      );

  Widget _coachMessage() => EnvCard(
        child: Row(children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration:
                const BoxDecoration(color: EC.orange, shape: BoxShape.circle),
            child: Text('S', style: ts(18, w: FontWeight.w700, color: EC.bg)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Coach Sarah', style: ts(15, w: FontWeight.w700)),
                Text('9:12 AM', style: ts(12, color: EC.text2)),
              ]),
              const SizedBox(height: 3),
              Text(
                  'Great form on those squats yesterday. Let\'s push the weight a little today.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: ts(14, color: EC.text2, h: 1.35)),
            ]),
          ),
        ]),
      );
}
