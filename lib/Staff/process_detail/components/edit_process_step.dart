import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:spa_and_beauty_staff/Consultant/customer_process_detail/components/booking_for_first_step/components/body.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetailSteps.dart';
import 'package:spa_and_beauty_staff/Service/staff_service.dart';
import 'package:spa_and_beauty_staff/constants.dart';
import 'package:spa_and_beauty_staff/default_button.dart';
import 'package:spa_and_beauty_staff/helper/Helper.dart';
import 'package:http/http.dart' as http;
import 'package:spa_and_beauty_staff/main.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:async/async.dart';

class EditProcessStep extends StatefulWidget {
  final BookingDetailStepInstance bookingDetailStepInstance;

  const EditProcessStep({Key key, this.bookingDetailStepInstance})
      : super(key: key);

  @override
  _EditProcessStepState createState() => _EditProcessStepState();
}

class _EditProcessStepState extends State<EditProcessStep> {
  TextEditingController _resultController;

  @override
  void initState() {
    setState(() {
      _resultController = TextEditingController(
          text: widget.bookingDetailStepInstance.consultationContent.result !=
                  null
              ? widget.bookingDetailStepInstance.consultationContent.result
              : "");
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Cập nhật thông tin",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              color: kPrimaryColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tên bước: ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                          widget.bookingDetailStepInstance.treatmentService
                              .spaService.name,
                          style: TextStyle(fontSize: 20, color: Colors.white))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ngày đặt lịch: ",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Text(
                          MyHelper.getUserDate(
                              widget.bookingDetailStepInstance.dateBooking),
                          style: TextStyle(fontSize: 20, color: Colors.white))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Thời gian: ",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Text(
                          widget.bookingDetailStepInstance.startTime.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.white))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Chuyên viên: ",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Text(widget.bookingDetailStepInstance.staff.user.fullname,
                          style: TextStyle(fontSize: 20, color: Colors.white))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.flag_outlined,
                        color: kTextColor,
                      ),
                      Text(
                        "KẾT QUẢ DỰ KIẾN: ",
                        style: TextStyle(fontSize: 17, color: kTextColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(widget.bookingDetailStepInstance
                                .consultationContent.expectation ==
                            null
                        ? "chưa có kết quả dự kiến"
                        : widget.bookingDetailStepInstance.consultationContent
                                    .expectation ==
                                ""
                            ? "chưa có kết quả dự kiến"
                            : widget.bookingDetailStepInstance
                                .consultationContent.expectation),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: kTextColor,
                      ),
                      Text(
                        "GHI CHÚ: ",
                        style: TextStyle(fontSize: 17, color: kTextColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(widget.bookingDetailStepInstance
                                .consultationContent.note ==
                            null
                        ? "chưa có ghi chú"
                        : widget.bookingDetailStepInstance.consultationContent
                            .note),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.description_outlined,
                        color: kTextColor,
                      ),
                      Text(
                        "THÔNG TIN KẾT QUẢ: ",
                        style: TextStyle(fontSize: 17, color: kTextColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      BeforeImage(
                        consultationContent: widget.bookingDetailStepInstance.consultationContent,
                      ),
                      AfterImage(consultationContent: widget.bookingDetailStepInstance.consultationContent,),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(child: Text("Trước khi điều trị")),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(child: Text("Sau khi điều trị")),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kết quả",
                    style: TextStyle(fontSize: 20, color: kTextColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _resultController,
                    minLines: 3,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        hintText: "Kết quả",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: kTextColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: kPrimaryColor),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  DefaultButton(
                    text: "Hoàn tất",
                    press: () {
                      showDialog(
                        context: context,
                        builder: (builder) {
                          return Dialog(
                            child: Stack(
                              overflow: Overflow.visible,
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  padding:
                                  EdgeInsets.fromLTRB(20, 50, 20, 20),
                                  width: double.infinity,
                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Bạn chắc chứ",
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                          "thông tin sau khi hoàn tất không thể sửa đổi, bạn chắc chứ?", textAlign: TextAlign.center,),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    showDialog(
                                                      context: context,
                                                      builder: (builder) {
                                                        return Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 80),
                                                          child: Dialog(
                                                            child: Container(
                                                              height: 150,
                                                              child: Lottie.asset(
                                                                  "assets/lottie/circle_loading.json"),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                    StaffService.editProcessStep(
                                                        widget.bookingDetailStepInstance.id,
                                                        _resultController.text,
                                                        widget.bookingDetailStepInstance.staff.id)
                                                        .then((value) {
                                                      Navigator.pop(context);
                                                      value.compareTo("200") == 0
                                                          ? showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return MyCustomDialog(
                                                            height: 250,
                                                            press: () {
                                                              Navigator.pop(context);
                                                              Navigator.pop(context);
                                                            },
                                                            title: "Thành Công !",
                                                            description:
                                                            "Cập nhật thông tin thành công",
                                                            buttonTitle: "Thoát",
                                                            lottie: "assets/lottie/success.json",
                                                          );
                                                        },
                                                      )
                                                          : showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return MyCustomDialog(
                                                            height: 250,
                                                            press: () {
                                                              Navigator.pop(context);
                                                              Navigator.pop(context);
                                                            },
                                                            title: "Thất bại !",
                                                            description: "Cập nhật thông tin thất bại.",
                                                            buttonTitle: "Thoát",
                                                            lottie: "assets/lottie/fail.json",
                                                          );
                                                        },
                                                      );
                                                    });
                                                  },
                                                  child: Text("Xác nhận"))),
                                          Expanded(
                                              flex: 1,
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Thoát"))),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: -35,
                                  child: SvgPicture.asset(
                                    "assets/icons/check.svg",
                                    width: 70,
                                    height: 70,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );

                      //---------------------------------------------
                    },
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}

class AfterImage extends StatefulWidget {
  final ConsultationContent consultationContent;
  const AfterImage({
    Key key, this.consultationContent,
  }) : super(key: key);

  @override
  _AfterImageState createState() => _AfterImageState();
}

class _AfterImageState extends State<AfterImage> {
  File imageFile;
  ImagePicker imagePicker;
  final ImagePicker picker = ImagePicker();
  String image;

  @override
  void initState() {
    if (widget.consultationContent.imageAfter != null) {
      image = widget.consultationContent.imageAfter;
    }
    // TODO: implement initState
    super.initState();
  }

  void takePhoto(ImageSource source, BuildContext context) async {
    final pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    setState(() {
      imageFile = pickedFile;
      print("imageFilePath: " + imageFile.path);
    });
    uploadFile(imageFile,context);
  }

  uploadFile(File imageFile, BuildContext context) async {
    showDialog(
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 80),
          child: Dialog(
            child: Container(
              height: 150,
              child: Lottie.asset(
                  "assets/lottie/circle_loading.json"),
            ),
          ),
        );
      },
    );
    // open a bytestream
    var stream =
    new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();
    // string to uri
    var uri = Uri.parse(
        "https://swp490spa.herokuapp.com/api/staff/consultationContent/uploadImageAfter");
    // create multipart request
    var request = new http.MultipartRequest("PUT", uri);
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer " + MyApp.storage.getItem("token"),
    });
    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    // add file to multipart
    request.files.add(multipartFile);
    // add field
    request.fields['consultationContentId'] =
        widget.consultationContent.id.toString();
    // send
    var response = await request.send();
    print(response.statusCode);
    Navigator.pop(context);
    if(response.statusCode == 200){
      showDialog(
        context: context,
        builder: (context) {
          return MyCustomDialog(
            height: 250,
            press: () {
              Navigator.pop(context);
            },
            title: "Cập nhật thành công",
            description:
            "Hình ảnh đã được cập nhật thành công",
            buttonTitle: "Quay về",
            lottie:
            "assets/lottie/success.json",
          );
        },
      );
    }else{
      showDialog(
        context: context,
        builder: (context) {
          return MyCustomDialog(
            height: 250,
            press: () {
              Navigator.pop(context);
            },
            title: "Cập nhật thất bại",
            description:
            "Tải lên hình ảnh không thành công",
            buttonTitle: "Quay về",
            lottie:
            "assets/lottie/fail.json",
          );
        },
      );
    }
    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            fit: StackFit.expand,
            children: [
              imageFile == null
                  ? Image.network(image == null
                  ? 'https://via.placeholder.com/150'
                  : image, fit: BoxFit.cover,)
                  : Image.file(File(imageFile.path),fit: BoxFit.cover,),
              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    print("Update image profile");
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomSheet(context)),
                    );
                  },
                  child: Icon(Icons.camera_alt_rounded),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(this.context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Chọn hình",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                onPressed: () async {
                  await takePhoto(ImageSource.camera, context);
                  print("Chụp xong rồi!!");
                },
                icon: Icon(Icons.camera),
                label: Text("Camera"),
              ),
              FlatButton.icon(
                onPressed: () async {
                  await takePhoto(ImageSource.gallery, context);
                  print("Lấy hình xong rồi!!");
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BeforeImage extends StatefulWidget {
  final ConsultationContent consultationContent;

  const BeforeImage({
    Key key,
    this.consultationContent,
  }) : super(key: key);

  @override
  _BeforeImageState createState() => _BeforeImageState();
}

class _BeforeImageState extends State<BeforeImage> {
  File imageFile;
  ImagePicker imagePicker;
  final ImagePicker picker = ImagePicker();
  String image;
  bool _uploading;

  @override
  void initState() {
    if (widget.consultationContent.imageBefore != null) {
      image = widget.consultationContent.imageBefore;
    }
    // TODO: implement initState
    super.initState();
  }

  void takePhoto(ImageSource source, BuildContext context) async {
    final pickedFile = await ImagePicker.pickImage(
      source: source,
    );
    setState(() {
      imageFile = pickedFile;
      print("imageFilePath: " + imageFile.path);
    });
    uploadFile(imageFile,context);
  }

  uploadFile(File imageFile, BuildContext context) async {
    showDialog(
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 80),
          child: Dialog(
            child: Container(
              height: 150,
              child: Lottie.asset(
                  "assets/lottie/circle_loading.json"),
            ),
          ),
        );
      },
    );
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();
    // string to uri
    var uri = Uri.parse(
        "https://swp490spa.herokuapp.com/api/staff/consultationContent/uploadImageBefore");
    // create multipart request
    var request = new http.MultipartRequest("PUT", uri);
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer " + MyApp.storage.getItem("token"),
    });
    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    // add file to multipart
    request.files.add(multipartFile);
    // add field
    request.fields['consultationContentId'] =
        widget.consultationContent.id.toString();
    // send
    var response = await request.send();
    print(response.statusCode);
    Navigator.pop(context);
    if(response.statusCode == 200){
    showDialog(
      context: context,
      builder: (context) {
        return MyCustomDialog(
          height: 250,
          press: () {
            Navigator.pop(context);
          },
          title: "Cập nhật thành công",
          description:
          "Hình ảnh đã được cập nhật thành công",
          buttonTitle: "Quay về",
          lottie:
          "assets/lottie/success.json",
        );
      },
    );
    }else{
      showDialog(
        context: context,
        builder: (context) {
          return MyCustomDialog(
            height: 250,
            press: () {
              Navigator.pop(context);
            },
            title: "Cập nhật thất bại",
            description:
            "Tải lên hình ảnh không thành công",
            buttonTitle: "Quay về",
            lottie:
            "assets/lottie/fail.json",
          );
        },
      );
    }
    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            fit: StackFit.expand,
            children: [
              imageFile == null
                  ? Image.network(image == null
                      ? 'https://via.placeholder.com/150'
                      : image, fit: BoxFit.cover,)
                  : Image.file(File(imageFile.path),fit: BoxFit.cover,),
              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    print("Update image profile");
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomSheet(context)),
                    );
                  },
                  child: Icon(Icons.camera_alt_rounded),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(this.context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Chọn hình",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                onPressed: () async {
                  await takePhoto(ImageSource.camera, context);
                  print("Chụp xong rồi!!");
                },
                icon: Icon(Icons.camera),
                label: Text("Camera"),
              ),
              FlatButton.icon(
                onPressed: () async {
                  await takePhoto(ImageSource.gallery, context);
                  print("Lấy hình xong rồi!!");
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
