import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets.dart';

class CoachDashboardScreen extends StatefulWidget {
  const CoachDashboardScreen({super.key});

  @override
  State<CoachDashboardScreen> createState() => _CoachDashboardScreenState();
}

class _CoachDashboardScreenState extends State<CoachDashboardScreen> {
  int _section = 0;

  static const _sections = [
    ('Overview', Icons.grid_view_rounded),
    ('Clients', Icons.people_alt_rounded),
    ('Programs', Icons.fitness_center_rounded),
    ('Messages', Icons.chat_bubble_outline_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final desktop = constraints.maxWidth >= 900;
        return Scaffold(
          backgroundColor: EC.bg,
          body: Row(
            children: [
              if (desktop)
                _DesktopSidebar(
                  selected: _section,
                  onSelect: (value) => setState(() => _section = value),
                ),
              Expanded(
                child: SafeArea(
                  bottom: false,
                  child: _CoachContent(section: _section, desktop: desktop),
                ),
              ),
            ],
          ),
          bottomNavigationBar: desktop
              ? null
              : NavigationBar(
                  selectedIndex: _section,
                  onDestinationSelected: (value) =>
                      setState(() => _section = value),
                  backgroundColor: EC.card,
                  indicatorColor: EC.orangeTint,
                  destinations: [
                    for (final item in _sections)
                      NavigationDestination(
                        icon: Icon(item.$2),
                        selectedIcon: Icon(item.$2, color: EC.orangeDeep),
                        label: item.$1,
                      ),
                  ],
                ),
        );
      },
    );
  }
}

class _DesktopSidebar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;

  const _DesktopSidebar({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.fromLTRB(14, 22, 14, 16),
      decoration: BoxDecoration(
        color: EC.card,
        border: Border.all(color: EC.border),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: EC.orange,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(Icons.bolt_rounded, color: EC.bg, size: 20),
                ),
                const SizedBox(width: 10),
                Text('ENVISION', style: ts(13, w: FontWeight.w800, ls: 2.2)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          for (var i = 0; i < _CoachDashboardScreenState._sections.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _SidebarItem(
                label: _CoachDashboardScreenState._sections[i].$1,
                icon: _CoachDashboardScreenState._sections[i].$2,
                selected: selected == i,
                onTap: () => onSelect(i),
              ),
            ),
          const Spacer(),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: EC.orangeTint,
                child: Text('T', style: ts(14, w: FontWeight.w800)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Taylor Kim', style: ts(13, w: FontWeight.w700)),
                    Text('Head coach', style: ts(11, color: EC.text2)),
                  ],
                ),
              ),
              Icon(Icons.more_horiz_rounded, color: EC.text2),
            ],
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? EC.orangeTint : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border:
              selected ? Border.all(color: EC.orange.withOpacity(.22)) : null,
        ),
        child: Row(
          children: [
            Icon(icon, size: 19, color: selected ? EC.orangeDeep : EC.text2),
            const SizedBox(width: 11),
            Text(
              label,
              style: ts(13,
                  w: selected ? FontWeight.w800 : FontWeight.w600,
                  color: selected ? EC.text : EC.text2),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoachContent extends StatelessWidget {
  final int section;
  final bool desktop;

  const _CoachContent({required this.section, required this.desktop});

  @override
  Widget build(BuildContext context) {
    final padding = desktop ? 28.0 : 18.0;
    return ListView(
      padding: EdgeInsets.fromLTRB(padding, 22, padding, desktop ? 30 : 110),
      children: [
        _DashboardHeader(desktop: desktop),
        const SizedBox(height: 26),
        if (section == 0)
          _Overview(desktop: desktop)
        else
          _SectionList(section: section),
      ],
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  final bool desktop;
  const _DashboardHeader({required this.desktop});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('COACH WORKSPACE',
                  style: ts(11,
                      w: FontWeight.w800, color: EC.orangeDeep, ls: 1.5)),
              const SizedBox(height: 7),
              Text(desktop ? 'Good morning, Taylor' : 'Morning, Taylor',
                  style: ts(desktop ? 32 : 27, w: FontWeight.w800, ls: -.8)),
              const SizedBox(height: 4),
              Text('Here’s what needs your attention today.',
                  style: ts(14, color: EC.text2)),
            ],
          ),
        ),
        IconButton.filledTonal(
          onPressed: toggleAppTheme,
          icon: Icon(
              EC.isLight ? Icons.dark_mode_rounded : Icons.light_mode_rounded),
          tooltip: EC.isLight ? 'Use dark mode' : 'Use light mode',
        ),
        const SizedBox(width: 8),
        IconButton.filledTonal(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded),
        ),
      ],
    );
  }
}

class _Overview extends StatelessWidget {
  final bool desktop;
  const _Overview({required this.desktop});

  @override
  Widget build(BuildContext context) {
    const stats = [
      ('24', 'Active clients', Icons.people_alt_rounded),
      ('18', 'Trained today', Icons.fitness_center_rounded),
      ('5', 'Need attention', Icons.warning_amber_rounded),
      ('7', 'Meals unlogged', Icons.restaurant_rounded),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: desktop ? 4 : 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: desktop ? 1.6 : 1.25,
          children: [for (final stat in stats) _StatCard(stat: stat)],
        ),
        const SizedBox(height: 26),
        if (desktop)
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _ClientAttention()),
              SizedBox(width: 14),
              Expanded(flex: 2, child: _ScheduleCard()),
            ],
          )
        else ...[
          const _ClientAttention(),
          const SizedBox(height: 14),
          const _ScheduleCard(),
        ],
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final (String, String, IconData) stat;
  const _StatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return EnvCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(stat.$3, size: 21, color: EC.orangeDeep),
          Text(stat.$1, style: ts(26, w: FontWeight.w800, ls: -.6)),
          Text(stat.$2, style: ts(12, color: EC.text2)),
        ],
      ),
    );
  }
}

class _ClientAttention extends StatelessWidget {
  const _ClientAttention();

  @override
  Widget build(BuildContext context) {
    const clients = [
      ('Maya Chen', 'Workout complete · nutrition on track', '92%'),
      ('Jordan Lee', 'Missed check-in · needs attention', '58%'),
      ('Alex Morgan', 'Lower body scheduled', '71%'),
      ('Priya Shah', 'Rest day · on track', '88%'),
    ];
    return EnvCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text('Client attention',
                      style: ts(18, w: FontWeight.w800))),
              Text('View all',
                  style: ts(12, w: FontWeight.w700, color: EC.orangeDeep)),
            ],
          ),
          const SizedBox(height: 14),
          for (var i = 0; i < clients.length; i++) ...[
            _ClientRow(client: clients[i], index: i),
            if (i != clients.length - 1) Divider(color: EC.border, height: 22),
          ],
        ],
      ),
    );
  }
}

class _ClientRow extends StatelessWidget {
  final (String, String, String) client;
  final int index;
  const _ClientRow({required this.client, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: index == 1 ? EC.red.withOpacity(.18) : EC.orangeTint,
          child: Text(client.$1.substring(0, 1),
              style: ts(13, w: FontWeight.w800)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(client.$1, style: ts(14, w: FontWeight.w700)),
              const SizedBox(height: 3),
              Text(client.$2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: ts(11.5, color: EC.text2)),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text(client.$3,
            style: ts(13,
                w: FontWeight.w800,
                color: index == 1 ? EC.red : EC.orangeDeep)),
      ],
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard();

  @override
  Widget build(BuildContext context) {
    const sessions = [
      ('9:00', 'Maya Chen', 'Upper body'),
      ('10:30', 'Jordan Lee', 'Conditioning'),
      ('1:00', 'Group session', '6 clients'),
      ('4:00', 'Alex Morgan', 'Lower body'),
    ];
    return EnvCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Today’s schedule', style: ts(18, w: FontWeight.w800)),
          const SizedBox(height: 14),
          for (final session in sessions)
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  SizedBox(
                      width: 44,
                      child: Text(session.$1, style: ts(11, color: EC.text2))),
                  Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                          color: EC.orange, shape: BoxShape.circle)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(session.$2, style: ts(13, w: FontWeight.w700)),
                        Text(session.$3, style: ts(11, color: EC.text2)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionList extends StatelessWidget {
  final int section;
  const _SectionList({required this.section});

  @override
  Widget build(BuildContext context) {
    final title = _CoachDashboardScreenState._sections[section].$1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: ts(22, w: FontWeight.w800)),
        const SizedBox(height: 12),
        for (var i = 0; i < 5; i++) ...[
          EnvCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: EC.orangeTint,
                child: Icon(_CoachDashboardScreenState._sections[section].$2,
                    color: EC.orangeDeep, size: 19),
              ),
              title: Text('$title ${i + 1}', style: ts(14, w: FontWeight.w700)),
              subtitle: Text('Updated today', style: ts(12, color: EC.text2)),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}
