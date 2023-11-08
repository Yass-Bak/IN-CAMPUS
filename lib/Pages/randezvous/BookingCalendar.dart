import 'dart:collection';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_campus/Pages/randezvous/randezvous_page.dart';
import 'package:in_campus/helper/hexColors.dart';
import 'package:in_campus/helper/jours_feries.dart';
import 'package:in_campus/main.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toast/toast.dart';
import '../../models/User.dart';
import '../../models/event.dart';

class BookingCalendar extends StatefulWidget {
  BookingCalendar({this.type});

  final String? type;

  @override
  _BookingCalendarState createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  List<String> dates = List.empty(growable: true);
  List<String> heures = List.empty(growable: true);
  late final PageController _pageController;
  late final ValueNotifier<List<Event>> _selectedEvents;

  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDays.add(_focusedDay.value);
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay.value));
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedEvents.dispose();
    super.dispose();
  }

  bool get canClearSelection =>
      _selectedDays.isNotEmpty || _rangeStart != null || _rangeEnd != null;

  List<Event> _getEventsForDay(DateTime day) {
    String dayDate = day.day.toString() +
        "/" +
        day.month.toString() +
        "/" +
        day.year.toString();
    List<String> allHeures = List.empty(growable: true);
    for (int j = 9; j < 17; j++) {
      allHeures.add(j.toString());
      allHeures.add(j.toString() + ":30");
    }
    List<Event> events = List.empty(growable: true);
    if (dates.length == 0) {
      // Toast.show("verifier votre connexion", duration: Toast.lengthShort, gravity: Toast.bottom);
    } else {
      if (dates.contains(dayDate)) {
        allHeures.clear();
        for (int j = 9; j < 17; j++) {
          allHeures.add(j.toString());
          allHeures.add(j.toString() + ":30");
        }

        List<String> nb = List.empty(growable: true);
        if ((dates
                    .elementAt(dates.indexOf(dayDate))
                    .split("/")[0]
                    .compareTo(day.day.toString()) ==
                0) &&
            (dates
                    .elementAt(dates.indexOf(dayDate))
                    .split("/")[1]
                    .compareTo(day.month.toString()) ==
                0) &&
            (dates
                    .elementAt(dates.indexOf(dayDate))
                    .split("/")[2]
                    .compareTo(day.year.toString()) ==
                0)) {
          nb.clear();
          nb = heures.elementAt(dates.indexOf(dayDate)).split(", ");
          log("********************************");
          log(dayDate);
          nb.forEach((element) {
            log(element.toString());
            allHeures.remove(element);
            log(allHeures.toString());
          });
        }
      }
      if (!MyApp.uuser!.rendezvous!.contains(dayDate)) {
        for (var element in allHeures) {
          events.add(Event(element));
        }
      }
    }
    return events;
  }

  List<Event> _getEventsForDays(Iterable<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return _getEventsForDays(days);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (JoursFeries.isHoliday(selectedDay)) {
      setState(() {
        _selectedDays.clear();
        _selectedEvents.value = _getEventsForDays(_selectedDays);
      });
      Toast.show("c'est un jour férié",
          duration: Toast.lengthShort, gravity: Toast.bottom);
    } else {
      setState(() {
        _selectedDays.clear();
        _selectedDays.add(selectedDay);
        _focusedDay.value = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
        _selectedEvents.value = _getEventsForDays(_selectedDays);
      });
      _selectedEvents.value = _getEventsForDays(_selectedDays);
    }
  }

  /* void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _focusedDay.value = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _selectedDays.clear();
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    //   log(widget.type!);
    ToastContext().init(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('Rendez-vous').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            log("has data");
            var d = snapshot.data!.docs.map((e) => e.get("date"));
            var h = snapshot.data!.docs.map((e) => e.get("heures"));
            dates = d
                .toString()
                .replaceAll("(", "")
                .replaceAll(")", "")
                .split(', ');
            heures = h
                .toString()
                .replaceAll("([", "")
                .replaceAll("])", "")
                .split("], [");
          } else {
            log("no data ");
          }
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () => Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => (RendezVousPage()))),
                child: Icon(FontAwesomeIcons.arrowLeft),
              ),
              backgroundColor: HexColor.fromHex('2F2E41'),
              title: Text("Rendez-Vous"),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/HomeScreen");
                    // do something
                  },
                )
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: w,
                  height: h * 0.1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: const AssetImage(
                        "img/undraw_Checking_boxes_re_9h8m.png"),
                    fit: BoxFit.cover,
                    /*   colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.dstATop),*/
                  )),
                ),
                ValueListenableBuilder<DateTime>(
                  valueListenable: _focusedDay,
                  builder: (context, value, _) {
                    return _CalendarHeader(
                      focusedDay: value,
                      clearButtonVisible: canClearSelection,
                      onTodayButtonTap: () {
                        setState(() => _focusedDay.value = DateTime.now());
                      },
                      onClearButtonTap: () {
                        setState(() {
                          _rangeStart = null;
                          _rangeEnd = null;
                          _selectedDays.clear();
                          _selectedEvents.value = [];
                        });
                      },
                      onLeftArrowTap: () {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                      onRightArrowTap: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                    );
                  },
                ),
                TableCalendar<Event>(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay.value,
                  headerVisible: false,
                  selectedDayPredicate: (day) => _selectedDays.contains(day),
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  eventLoader: _getEventsForDay,
                  holidayPredicate: (day) {
                    // Every 20th day of the month will be treated as a holiday
                    return JoursFeries.isHoliday(day);
                  },
                  onDaySelected: _onDaySelected,
                  onCalendarCreated: (controller) =>
                      _pageController = controller,
                  onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() => _calendarFormat = format);
                    }
                  },
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 50,
                  child: ValueListenableBuilder<List<Event>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: InkWell(
                              //_selectedDays.first.day.toString()+"/"+_selectedDays.first.month.toString()+"/"+_selectedDays.first.year.toString()
                              onTap: () async {
                                final rdv = FirebaseFirestore.instance
                                    .collection("Rendez-vous")
                                    .doc(_selectedDays.first.day.toString() +
                                        "-" +
                                        _selectedDays.first.month.toString() +
                                        "-" +
                                        _selectedDays.first.year.toString());
                                rdv.get().then((snapshot) async {
                                  if (snapshot.exists) {
                                    final json = {
                                      'date': _selectedDays.first.day
                                              .toString() +
                                          "/" +
                                          _selectedDays.first.month.toString() +
                                          "/" +
                                          _selectedDays.first.year.toString(),
                                      'heures': FieldValue.arrayUnion(
                                          ['${value[index]}']),
                                      'etudiants':
                                          FieldValue.arrayUnion([MyApp.cin]),
                                      'raison': FieldValue.arrayUnion([
                                        _selectedDays.first.day.toString() +
                                            "/" +
                                            _selectedDays.first.month
                                                .toString() +
                                            "/" +
                                            _selectedDays.first.year
                                                .toString() +
                                            " à " +
                                            '${value[index]}' +
                                            ' | Raison : ' +
                                            widget.type.toString()
                                      ])
                                    };
                                    await rdv.update(json);
                                    setState(() {
                                      _selectedDays.clear();
                                    });
                                  } else {
                                    final json = {
                                      'date': _selectedDays.first.day
                                              .toString() +
                                          "/" +
                                          _selectedDays.first.month.toString() +
                                          "/" +
                                          _selectedDays.first.year.toString(),
                                      'heures': ['${value[index]}'],
                                      'etudiants': [MyApp.cin],
                                      'raison': [
                                        _selectedDays.first.day.toString() +
                                            "/" +
                                            _selectedDays.first.month
                                                .toString() +
                                            "/" +
                                            _selectedDays.first.year
                                                .toString() +
                                            " à " +
                                            '${value[index]}' +
                                            ' | Raison : ' +
                                            widget.type.toString()
                                      ]
                                    };
                                    await rdv.set(json);
                                    setState(() {
                                      _selectedDays.clear();
                                      log(_selectedDays.toString());
                                    });
                                  }
                                });
                                final docUser = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(
                                        FirebaseAuth.instance.currentUser!.uid);
                                docUser.update({
                                  'rendezvous': FieldValue.arrayUnion([
                                    _selectedDays.first.day.toString() +
                                        "/" +
                                        _selectedDays.first.month.toString() +
                                        "/" +
                                        _selectedDays.first.year.toString()
                                  ]),
                                  'heuresRdv': FieldValue.arrayUnion([
                                    _selectedDays.first.day.toString() +
                                        "/" +
                                        _selectedDays.first.month.toString() +
                                        "/" +
                                        _selectedDays.first.year.toString() +
                                        " à " +
                                        '${value[index]}' +
                                        ' | Raison : ' +
                                        widget.type.toString()
                                  ])
                                });
                                final docUser2 = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(
                                        FirebaseAuth.instance.currentUser!.uid);
                                docUser2.get().then((value) {
                                  if (value.exists) {
                                    log("*******---------+++++++++++++-----------**********");
                                    MyApp.uuser = Uuser(
                                        Uuser.fromJson(value.data()!)
                                            .displayName,
                                        Uuser.fromJson(value.data()!)
                                            .Etablissement!,
                                        Uuser.fromJson(value.data()!)
                                            .NiveauEtude!,
                                        Uuser.fromJson(value.data()!).Sexe!,
                                        Uuser.fromJson(value.data()!).dateNais!,
                                        Uuser.fromJson(value.data()!).Cin!,
                                        Uuser.fromJson(value.data()!)
                                            .rendezvous!,
                                        Uuser.fromJson(value.data()!)
                                            .heuresRdv!);
                                    log("////************/////////**************");
                                    log(MyApp.uuser!.rendezvous.toString());
                                    MyApp.cin =
                                        Uuser.fromJson(value.data()!).Cin!;
                                    log("********CIN**********");
                                    log(MyApp.uuser!.Cin!);
                                    print('Voila YUPPPI  ' +
                                        MyApp.uuser!.Cin! +
                                        MyApp.uuser!.dateNais! +
                                        MyApp.uuser!.Etablissement! +
                                        MyApp.uuser!.rendezvous.toString() +
                                        '  Voila  YUPPPI');
                                    Navigator.of(context).push(
                                        new MaterialPageRoute(
                                            builder: (_) => RendezVousPage()));
                                  }
                                });
                              },
                              child: Container(
                                width: 180,
                                decoration: BoxDecoration(
                                  color: HexColor.fromHex('2F88FF'),
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Center(
                                    child: Text(
                                  '${value[index]}',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, "/MesRendezVousPage");
              },
              label: Text('MES RENDEZ-VOUS',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: HexColor.fromHex('01579B'))),
              icon:
                  Icon(Icons.calendar_today, color: HexColor.fromHex('01579B')),
              backgroundColor: HexColor.fromHex('FFD15B'),
            ),
          );
        });
  }
}

class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onClearButtonTap;
  final bool clearButtonVisible;

  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.onTodayButtonTap,
    required this.onClearButtonTap,
    required this.clearButtonVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMM().format(focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 16.0),
          SizedBox(
            width: 120.0,
            child: Text(
              headerText,
              style: TextStyle(fontSize: 26.0),
            ),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today, size: 20.0),
            visualDensity: VisualDensity.compact,
            onPressed: onTodayButtonTap,
          ),
          if (clearButtonVisible)
            IconButton(
              icon: Icon(Icons.clear, size: 20.0),
              visualDensity: VisualDensity.compact,
              onPressed: onClearButtonTap,
            ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: onLeftArrowTap,
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: onRightArrowTap,
          ),
        ],
      ),
    );
  }
}
