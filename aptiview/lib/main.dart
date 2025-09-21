import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(AptiviewApp());
}

class AptiviewApp extends StatelessWidget {
  const AptiviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aptiview - AI Career Dashboard',
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF6366F1),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6366F1),
          secondary: Color(0xFFA855F7),
          surface: Color(0xFF1E293B),
        ),
      ),
      home: CareerDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CareerDashboard extends StatefulWidget {
  @override
  _CareerDashboardState createState() => _CareerDashboardState();
}

class _CareerDashboardState extends State<CareerDashboard>
    with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late AnimationController _pulseController;
  late AnimationController _flowController;
  late Animation<double> _breathingAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _flowAnimation;

  // Enhanced data with both growing and diminishing trends
  final List<CareerTrend> careerData = [
    CareerTrend('AI/ML', 90, 285, Colors.purple, TrendDirection.growing),
    CareerTrend('DevOps', 75, 150, Colors.blue, TrendDirection.growing),
    CareerTrend('Data Science', 85, 200, Colors.green, TrendDirection.growing),
    CareerTrend(
      'Cybersecurity',
      70,
      120,
      Colors.orange,
      TrendDirection.growing,
    ),
    CareerTrend('UX/UI Design', 65, 100, Colors.pink, TrendDirection.growing),
    CareerTrend(
      'Traditional IT',
      45,
      -15,
      Colors.red,
      TrendDirection.diminishing,
    ),
    CareerTrend(
      'Manual Testing',
      35,
      -25,
      Colors.grey,
      TrendDirection.diminishing,
    ),
    CareerTrend(
      'Legacy Systems',
      25,
      -35,
      Colors.brown,
      TrendDirection.diminishing,
    ),
  ];

  final List<FlSpot> growthData = [
    FlSpot(2020, 30),
    FlSpot(2021, 45),
    FlSpot(2022, 60),
    FlSpot(2023, 75),
    FlSpot(2024, 90),
    FlSpot(2025, 95),
  ];

  final List<FlSpot> diminishingData = [
    FlSpot(2020, 80),
    FlSpot(2021, 70),
    FlSpot(2022, 55),
    FlSpot(2023, 40),
    FlSpot(2024, 30),
    FlSpot(2025, 20),
  ];

  final List<CareerFlowStep> careerFlow = [
    CareerFlowStep('Assessment', 'AI Analysis', Colors.blue, Icons.psychology),
    CareerFlowStep('Skills Mapping', 'Gap Analysis', Colors.purple, Icons.map),
    CareerFlowStep(
      'Path Selection',
      'AI Recommendations',
      Colors.green,
      Icons.route,
    ),
    CareerFlowStep(
      'Learning Plan',
      'Personalized Roadmap',
      Colors.orange,
      Icons.school,
    ),
    CareerFlowStep(
      'Career Launch',
      'Success Tracking',
      Colors.pink,
      Icons.rocket_launch,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _breathingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _flowController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _breathingAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _flowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _flowController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _pulseController.dispose();
    _flowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0F172A),
              const Color(0xFF1E1B4B),
              const Color(0xFF0F172A),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Breathing background orbs
            _buildBreathingBackground(),

            // Main content
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(),
                          const SizedBox(height: 30),
                          _buildQuickStats(),
                          const SizedBox(height: 30),
                          _buildCareerFlowchart(),
                          const SizedBox(height: 30),
                          _buildChartsGrid(),
                          const SizedBox(height: 30),
                          _buildInsightsPanel(),
                          const SizedBox(height: 20), // Extra padding at bottom
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreathingBackground() {
    return Stack(
      children: [
        // Main breathing orb
        AnimatedBuilder(
          animation: _breathingAnimation,
          builder: (context, child) {
            return Positioned(
              top: -100,
              right: -100,
              child: Transform.scale(
                scale: _breathingAnimation.value,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF6366F1).withOpacity(0.3),
                        const Color(0xFFA855F7).withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // Secondary floating orbs
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Positioned(
              bottom: 100,
              left: -50,
              child: Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF06B6D4).withOpacity(0.2),
                        const Color(0xFF3B82F6).withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // Flowing particles
        ...List.generate(15, (index) {
          return AnimatedBuilder(
            animation: _flowAnimation,
            builder: (context, child) {
              final progress = (_flowAnimation.value + index * 0.1) % 1.0;
              return Positioned(
                left: MediaQuery.of(context).size.width * progress,
                top: 100 + (index * 50.0),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, Rishi! 👋',
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your AI career intelligence dashboard',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF10B981).withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.trending_up,
                  color: Color(0xFF10B981),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'Your career score improved by 15% this month!',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF10B981),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Career Match',
            '92%',
            Icons.adjust,
            const Color(0xFF6366F1),
            '+5% from last month',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Skills Assessed',
            '24',
            Icons.psychology,
            const Color(0xFF10B981),
            '8 new skills learned',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Opportunities',
            '156',
            Icons.work,
            const Color(0xFFF59E0B),
            '23 new this week',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.95 + (_pulseAnimation.value - 0.9) * 0.1,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: color, size: 20),
                    ),
                    Text(
                      value,
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCareerFlowchart() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_tree,
                color: const Color(0xFF6366F1),
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Your Career Journey Flow',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: careerFlow.length,
              itemBuilder: (context, index) {
                final step = careerFlow[index];
                final isLast = index == careerFlow.length - 1;

                return Row(
                  children: [
                    _buildFlowStep(step, index),
                    if (!isLast) ...[
                      const SizedBox(width: 16),
                      AnimatedBuilder(
                        animation: _flowAnimation,
                        builder: (context, child) {
                          return Container(
                            width: 40,
                            height: 2,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  step.color.withOpacity(0.5),
                                  careerFlow[index + 1].color.withOpacity(0.5),
                                ],
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1),
                              child: LinearProgressIndicator(
                                value:
                                    (_flowAnimation.value + index * 0.2) % 1.0,
                                backgroundColor: Colors.transparent,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  step.color.withOpacity(0.8),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlowStep(CareerFlowStep step, int index) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        final delay = index * 0.1;
        final progress = (_flowAnimation.value + delay) % 1.0;

        return Transform.scale(
          scale: 0.9 + (_pulseAnimation.value - 0.9) * 0.2,
          child: Container(
            width: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  step.color.withOpacity(0.2),
                  step.color.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: step.color.withOpacity(progress > 0.5 ? 0.5 : 0.3),
                width: progress > 0.5 ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(step.icon, color: step.color, size: 24),
                const SizedBox(height: 8),
                Text(
                  step.title,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  step.subtitle,
                  style: GoogleFonts.inter(fontSize: 10, color: Colors.white60),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChartsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(flex: 2, child: _buildGrowthChart()),
            const SizedBox(width: 20),
            Expanded(flex: 1, child: _buildDiminishingChart()),
          ],
        ),
        const SizedBox(height: 20),
        _buildCareerComparisonChart(),
      ],
    );
  }

  Widget _buildGrowthChart() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: Color(0xFF10B981),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emerging Career Growth',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'High-demand tech careers showing explosive growth',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 20,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) => SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          '${value.toInt()}',
                          style: GoogleFonts.inter(
                            color: Colors.white60,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      getTitlesWidget: (value, meta) => Text(
                        '${value.toInt()}%',
                        style: GoogleFonts.inter(
                          color: Colors.white60,
                          fontSize: 10,
                        ),
                      ),
                      reservedSize: 42,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                minX: 2020,
                maxX: 2025,
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: growthData,
                    isCurved: true,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF34D399)],
                    ),
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) =>
                          FlDotCirclePainter(
                            radius: 6,
                            color: Colors.white,
                            strokeWidth: 3,
                            strokeColor: const Color(0xFF10B981),
                          ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF10B981).withOpacity(0.3),
                          const Color(0xFF10B981).withOpacity(0.05),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiminishingChart() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.trending_down,
                  color: Color(0xFFEF4444),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Declining Careers',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 20,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) => SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          '${value.toInt()}',
                          style: GoogleFonts.inter(
                            color: Colors.white60,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      getTitlesWidget: (value, meta) => Text(
                        '${value.toInt()}%',
                        style: GoogleFonts.inter(
                          color: Colors.white60,
                          fontSize: 10,
                        ),
                      ),
                      reservedSize: 42,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                minX: 2020,
                maxX: 2025,
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: diminishingData,
                    isCurved: true,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEF4444), Color(0xFFF87171)],
                    ),
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) =>
                          FlDotCirclePainter(
                            radius: 6,
                            color: Colors.white,
                            strokeWidth: 3,
                            strokeColor: const Color(0xFFEF4444),
                          ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFEF4444).withOpacity(0.3),
                          const Color(0xFFEF4444).withOpacity(0.05),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareerComparisonChart() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Career Trends Overview',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Compare growing vs declining career paths',
            style: GoogleFonts.inter(fontSize: 14, color: Colors.white60),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final careers = [
                          'AI/ML',
                          'DevOps',
                          'Data',
                          'Cyber',
                          'UX/UI',
                          'Trad IT',
                          'Manual',
                          'Legacy',
                        ];
                        if (value.toInt() < careers.length) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              careers[value.toInt()],
                              style: GoogleFonts.inter(
                                color: Colors.white60,
                                fontSize: 10,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                      reservedSize: 38,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: 20,
                      getTitlesWidget: (value, meta) => Text(
                        '${value.toInt()}%',
                        style: GoogleFonts.inter(
                          color: Colors.white60,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: careerData.asMap().entries.map((entry) {
                  final trend = entry.value;
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: trend.demand.toDouble(),
                        color: trend.direction == TrendDirection.growing
                            ? trend.color
                            : trend.color.withOpacity(0.7),
                        width: 16,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(6),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Growing Careers', const Color(0xFF10B981)),
              const SizedBox(width: 24),
              _buildLegendItem('Declining Careers', const Color(0xFFEF4444)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildInsightsPanel() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: const Color(0xFFF59E0B), size: 24),
              const SizedBox(width: 12),
              Text(
                'AI Career Insights',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildInsightCard(
                  'Top Recommendation',
                  'AI/ML Engineer',
                  'Based on your skills and market trends',
                  const Color(0xFF6366F1),
                  Icons.rocket,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInsightCard(
                  'Skill Gap Alert',
                  '3 skills to learn',
                  'Cloud Architecture, MLOps, Ethics',
                  const Color(0xFFF59E0B),
                  Icons.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInsightCard(
            'Market Opportunity',
            '156 new positions this month',
            'Average salary: \$125K - \$180K',
            const Color(0xFF10B981),
            Icons.trending_up,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(
    String title,
    String value,
    String subtitle,
    Color color,
    IconData icon, {
    bool isFullWidth = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.inter(fontSize: 12, color: Colors.white60),
          ),
        ],
      ),
    );
  }
}

enum TrendDirection { growing, diminishing }

class CareerTrend {
  final String name;
  final int demand;
  final int growth;
  final Color color;
  final TrendDirection direction;

  CareerTrend(this.name, this.demand, this.growth, this.color, this.direction);
}

class CareerFlowStep {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;

  CareerFlowStep(this.title, this.subtitle, this.color, this.icon);
}
