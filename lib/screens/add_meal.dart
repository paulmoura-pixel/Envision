import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets.dart';

/// Bottom sheet with the 7 ways to log a meal.
void showAddMealSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const _AddMealSheet(),
  );
}

class _AddMealSheet extends StatelessWidget {
  const _AddMealSheet();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    void review() {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true, builder: (_) => const MealReviewScreen()));
    }

    final items = <(IconData, String, String, VoidCallback)>[
      (Icons.photo_camera_rounded, 'Take photo', 'AI estimates it', review),
      (Icons.photo_library_rounded, 'Upload photo', 'From gallery', review),
      (Icons.mic_rounded, 'Describe', 'Use your voice', review),
      (Icons.search_rounded, 'Search food', 'Database', () {}),
      (Icons.qr_code_scanner_rounded, 'Scan barcode', 'Packaged food', () {}),
      (Icons.edit_note_rounded, 'Manual entry', 'Type it in', () {}),
    ];

    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + bottom),
      decoration: BoxDecoration(
        color: EC.bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
              color: EC.border, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child:
              Text('Add a meal', style: ts(26, w: FontWeight.w800, ls: -0.5)),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Pick the fastest way to log it.',
              style: ts(15, color: EC.text2)),
        ),
        const SizedBox(height: 18),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.55,
          children: [
            for (final it in items)
              EnvCard(
                onTap: it.$4,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: EC.orangeTint,
                          borderRadius: BorderRadius.circular(14)),
                      child: Icon(it.$1, color: EC.orange, size: 22),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(it.$2, style: ts(16, w: FontWeight.w700)),
                          Text(it.$3, style: ts(12, color: EC.text2)),
                        ]),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 14),
        PillButton(
          label: 'Log a recent meal',
          icon: Icons.history_rounded,
          dark: true,
          onTap: () {},
        ),
      ]),
    );
  }
}

/// AI analysis (loading) then editable review. Values are ESTIMATES.
class MealReviewScreen extends StatefulWidget {
  const MealReviewScreen({super.key});
  @override
  State<MealReviewScreen> createState() => _MealReviewScreenState();
}

class _MealReviewScreenState extends State<MealReviewScreen> {
  bool _loading = true;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) setState(() => _loading = false);
    });
  }

  int get _kcal => (620 * _scale).round();
  int get _p => (48 * _scale).round();
  int get _c => (65 * _scale).round();
  int get _f => (16 * _scale).round();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EC.bg,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          child: _loading ? _loadingView() : _result(),
        ),
      ),
    );
  }

  Widget _loadingView() => Center(
        key: const ValueKey('l'),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 220,
            height: 220,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFE3D2), Color(0xFFFFF1E9)]),
            ),
            child: const Text('🍗🍚', style: TextStyle(fontSize: 64)),
          ),
          const SizedBox(height: 32),
          const SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(strokeWidth: 3, color: EC.orange),
          ),
          const SizedBox(height: 18),
          Text('Analyzing your meal', style: ts(22, w: FontWeight.w800)),
          const SizedBox(height: 6),
          Text('Identifying foods and portions…',
              style: ts(15, color: EC.text2)),
        ]),
      );

  Widget _result() => Column(key: const ValueKey('r'), children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(EC.pad, 8, EC.pad, 24),
            children: [
              Row(children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: EC.border)),
                    child: const Icon(Icons.close_rounded),
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: EC.orangeTint,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(children: [
                    const Icon(Icons.auto_awesome_rounded,
                        size: 15, color: EC.orange),
                    const SizedBox(width: 6),
                    Text('AI estimate',
                        style:
                            ts(13, w: FontWeight.w700, color: EC.orangeDeep)),
                  ]),
                ),
              ]),
              const SizedBox(height: 16),
              Container(
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(EC.r + 4),
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFFE3D2), Color(0xFFFFF1E9)]),
                ),
                child: const Text('🍗🍚🥦', style: TextStyle(fontSize: 60)),
              ),
              const SizedBox(height: 20),
              Text('Grilled chicken & rice',
                  style: ts(26, w: FontWeight.w800, ls: -0.5)),
              const SizedBox(height: 4),
              Text('Today, 12:40 PM · Lunch', style: ts(14, color: EC.text2)),
              const SizedBox(height: 18),
              EnvCard(
                child: Row(children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        color: EC.orangeTint, shape: BoxShape.circle),
                    child: const Icon(Icons.local_fire_department_rounded,
                        color: EC.orange),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Calories', style: ts(13, color: EC.text2)),
                          Text('$_kcal',
                              style: ts(34, w: FontWeight.w800, ls: -1)),
                        ]),
                  ),
                  _stepper(Icons.remove_rounded, () {
                    if (_scale > 0.5) setState(() => _scale -= 0.25);
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child:
                        Text('${_scale}x', style: ts(15, w: FontWeight.w700)),
                  ),
                  _stepper(Icons.add_rounded, () {
                    if (_scale < 2.5) setState(() => _scale += 0.25);
                  }),
                ]),
              ),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: _macro('Protein', _p, EC.protein)),
                const SizedBox(width: 10),
                Expanded(child: _macro('Carbs', _c, EC.carbs)),
                const SizedBox(width: 10),
                Expanded(child: _macro('Fat', _f, EC.fat)),
              ]),
              const SizedBox(height: 22),
              Text('Detected foods', style: ts(18, w: FontWeight.w700)),
              const SizedBox(height: 10),
              _food('🍗', 'Grilled chicken breast', '150 g'),
              const SizedBox(height: 8),
              _food('🍚', 'White rice', '1 cup'),
              const SizedBox(height: 8),
              _food('🥦', 'Steamed broccoli', '80 g'),
              const SizedBox(height: 16),
              Text(
                'Values are estimates from your photo, not exact measurements. Edit anything that looks off.',
                style: ts(12.5, color: EC.text2, h: 1.4),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(EC.pad, 0, EC.pad, 12),
          child: PillButton(
              label: 'Save meal', onTap: () => Navigator.pop(context)),
        ),
      ]);

  Widget _stepper(IconData i, VoidCallback t) => GestureDetector(
        onTap: t,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: EC.bg,
              shape: BoxShape.circle,
              border: Border.all(color: EC.border)),
          child: Icon(i, size: 20),
        ),
      );

  Widget _macro(String n, int g, Color c) => EnvCard(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
          const SizedBox(height: 10),
          Text('${g}g', style: ts(22, w: FontWeight.w800)),
          Text(n, style: ts(12, color: EC.text2)),
        ]),
      );

  Widget _food(String e, String n, String q) => EnvCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(children: [
          Text(e, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 12),
          Expanded(child: Text(n, style: ts(15, w: FontWeight.w600))),
          Text(q, style: ts(14, color: EC.text2)),
          const SizedBox(width: 8),
          const Icon(Icons.edit_rounded, size: 18, color: EC.orange),
        ]),
      );
}
