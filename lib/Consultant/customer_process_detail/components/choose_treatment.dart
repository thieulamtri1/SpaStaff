import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spa_and_beauty_staff/Model/Treatment.dart';
import 'package:spa_and_beauty_staff/Service/consultant_service.dart';
import 'package:spa_and_beauty_staff/constants.dart';

class ChooseTreatmentScreen extends StatefulWidget {
  final int packageId;

  const ChooseTreatmentScreen({Key key, this.packageId}) : super(key: key);

  @override
  _ChooseTreatmentScreenState createState() => _ChooseTreatmentScreenState();
}

class _ChooseTreatmentScreenState extends State<ChooseTreatmentScreen> {
  bool _loading;
  Treatment _treatment;
  List<bool> _isOpen;

  @override
  void initState() {
    _loading = true;
    ConsultantService.getTreatmentByPackageId(widget.packageId)
        .then((value) => {
              setState(() {
                _treatment = value;
                _loading = false;
                _isOpen = List.generate(value.data.length, (index) => false);
              })
            });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Container(
            child: Lottie.asset("assets/lottie/loading.json"),
          )
        : SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionPanelList(
                    children: [
                      ...List.generate(
                        _treatment.data.length,
                        (index) => ExpansionPanel(
                            headerBuilder: (context, isOpen) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context, _treatment.data[index]);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5),
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                            color: kGreen,
                                            borderRadius: BorderRadius.circular(20)),
                                        child: Center(
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                                fontSize: 25, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Treatment: " + _treatment.data[index].name,
                                        style: TextStyle(fontSize: 17, color: kTextColor),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            body: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...List.generate(
                                      _treatment.data[index].treatmentservices
                                          .length,
                                      (index1) => Text("Bước " +
                                          (index1 + 1).toString() +
                                          ": " +
                                          _treatment
                                              .data[index]
                                              .treatmentservices[index1]
                                              .spaService
                                              .name))
                                ],
                              ),
                            ),
                            isExpanded: _isOpen[index]),
                      ),
                    ],
                    expansionCallback: (i, isOpen) =>
                        setState(() => _isOpen[i] = !isOpen)),
              ),
            ),
          );
  }
}
