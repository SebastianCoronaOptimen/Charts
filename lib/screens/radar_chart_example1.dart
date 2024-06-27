import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

  class RadarChartExample1 extends StatefulWidget {
    const RadarChartExample1({super.key});

      final sysColor = const Color(0xFFCEF500);
      final mexColor = const Color(0xFF9F72F8);
      final gdlColor = const Color(0xFF5271FF);
      final tijColor = const Color(0xFFFF66C4);
      final mtyColor = const Color(0xFFFF4040);
      final cunColor = const Color(0xFF38B6FF);
      final bjxColor = const Color(0xFFFF891F);

    @override
    State<RadarChartExample1> createState() => _RadarChartExample1State();
  }

  class _RadarChartExample1State extends State<RadarChartExample1> {

    int selectedDataSetIndex = -1;
    double usedAngle = 0;
    bool relativeAngleMode = false;


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             GestureDetector(
            onTap: () {
              setState(() {
                selectedDataSetIndex = -1;
              });
            },
            child:  Center(
              child: Text(
                'Stations'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ), 
          ), 
            const SizedBox(height: 4),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              children: rawDataSets()
                  .asMap()
                  .map((index, value) {
                    final isSelected = index == selectedDataSetIndex;
                    return MapEntry(
                      index,
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDataSetIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          height: 26,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color.fromARGB(240, 59, 59, 59)
                                : const Color.fromARGB(0, 0, 0, 0), //Opcion no seleccionada
                            borderRadius: BorderRadius.circular(46),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 6,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInToLinear,
                                padding: EdgeInsets.all(isSelected ? 8 : 6),
                                decoration: BoxDecoration(
                                  color: value.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInToLinear,
                                style: TextStyle(
                                  color:
                                      isSelected ? value.color : Colors.white,
                                ),
                                child: Text(value.title),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                  .values
                  .toList(),
            ),
            const SizedBox(height: 50,),
            AspectRatio(
              aspectRatio: 1.3,
              child: RadarChart(
                RadarChartData(
                  radarTouchData: RadarTouchData(
                    touchCallback: (FlTouchEvent event, response) {
                      if (!event.isInterestedForInteractions) {
                        setState(() {
                          selectedDataSetIndex = -1;
                        });
                        return;
                      }
                      setState(() {
                        selectedDataSetIndex =
                            response?.touchedSpot?.touchedDataSetIndex ?? -1;
                      });
                    },
                  ),
                  dataSets: showingDataSets(),
                  radarBackgroundColor: const Color.fromARGB(0, 255, 255, 255), //Fondo de la radar
                  borderData: FlBorderData(show: false),
                  radarBorderData: const BorderSide(color: Color.fromARGB(255, 255, 255, 255)), //Borde de la radar
                  titlePositionPercentageOffset: 0.2,
                  titleTextStyle:
                      const TextStyle(color: Colors.white, fontSize: 11),//titulos de las categorias
                  getTitle: (index, angle) {
                    switch (index) {
                      case 0:
                        return RadarChartTitle(
                          text: 'OTP+15',
                          angle: usedAngle,
                        );
                      case 1:
                        return RadarChartTitle(
                          text: 'OTP+15 exc',
                          angle: usedAngle,
                        );
                      case 2:
                        return RadarChartTitle(text: 'BTP+0', angle: usedAngle);
                      case 3:
                        return RadarChartTitle(text: 'ATD+0', angle: usedAngle);
                      case 4:
                        return RadarChartTitle(text: 'GTP+0', angle: usedAngle);
                      case 5:
                        return RadarChartTitle(text: 'GTP+5', angle: usedAngle);
                      case 6:
                        return RadarChartTitle(text: 'ATD+5', angle: usedAngle);
                      case 7:
                        return RadarChartTitle(text: 'BTP+5', angle: usedAngle);
                      case 8:
                        return RadarChartTitle(text: 'PAX OTP', angle: usedAngle);
                      default:
                        return const RadarChartTitle(text: '');
                    }
                  },
                  tickCount: 5, //Divisiones de la radar
                  ticksTextStyle:
                      const TextStyle(color: Colors.white, fontSize: 10),
                  tickBorderData: const BorderSide(color: Colors.white,), //Color de las divisiones
                  gridBorderData: const BorderSide(color: Colors.white, width: 0.5), // Radios de la radar
                  radarShape: RadarShape.polygon
                ),
                swapAnimationDuration: const Duration(milliseconds: 400),
              ),
            ),
          ],
        ),
      )
      );
      }

  List<RadarDataSet> showingDataSets() {
      return rawDataSets().asMap().entries.map((entry) {
        final index = entry.key;
        final rawDataSet = entry.value;

        final isSelected = index == selectedDataSetIndex
            ? true
            : selectedDataSetIndex == -1
                ? true
                : false;

        return RadarDataSet(
          fillColor: isSelected
              ? rawDataSet.color.withOpacity(0.0) // Relleno cuando esta activa
              : rawDataSet.color.withOpacity(0.00), //Relleno cuando no esta activa
          borderColor:
              isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
          entryRadius: isSelected ? 3 : 2,
          dataEntries:
              rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
          borderWidth: isSelected ? 2.3 : 2,
        );
      }).toList();
    }

    List<RawDataSet> rawDataSets() {
      return [
        RawDataSet(
          title: 'System',
          color: widget.sysColor,
          values: [
            0,
            90,
            75,
            65,
            80,
            85,
            78,
            99,
            50
          ],
        ),
        RawDataSet(
          title: 'MEX',
          color: widget.mexColor,
          values: [
            80,
            90,
            50,
            65,
            80,
            85,
            78,
            99,
            50
          ],
        ),
        RawDataSet(
          title: 'GDL',
          color: widget.gdlColor,
          values: [
            80,
            90,
            75,
            65,
            30,
            85,
            78,
            99,
            50
          ],
        ),
        RawDataSet(
          title: 'TIJ',
          color: widget.tijColor,
          values: [
            80,
            90,
            75,
            65,
            80,
            85,
            78,
            80,
            50
          ],
        ),
        RawDataSet(
          title: 'MTY',
          color: widget.mtyColor,
          values: [
            80,
            90,
            75,
            65,
            80,
            85,
            78,
            99,
            40
          ],
        ),
        RawDataSet(
          title: 'CUN',
          color: widget.cunColor,
          values: [
            80,
            90,
            75,
            65,
            70,
            85,
            78,
            99,
            40
          ],
        ),
        RawDataSet(
          title: 'BJX',
          color: widget.bjxColor,
          values: [
            80,
            90,
            75,
            65,
            70,
            85,
            78,
            99,
            40
          ],
        ),
      ];
    }
  }

  class RawDataSet {
    RawDataSet({
      required this.title,
      required this.color,
      required this.values,
    });

    final String title;
    final Color color;
    final List<double> values;
  }
