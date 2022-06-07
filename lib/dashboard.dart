// ignore_for_file: depend_on_referenced_packages

import 'package:feedbackdashboard/color_manager.dart';
import 'package:feedbackdashboard/cons.dart';
import 'package:feedbackdashboard/font_manager.dart';
import 'package:feedbackdashboard/video.dart';
import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:video_player/video_player.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen(
      {Key? key, required this.allDataFeedback, required this.allDataComplains})
      : super(key: key);
  final List allDataFeedback;
  final List allDataComplains;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool screen = true;
  bool feedback = true;

  @override
  Widget build(BuildContext context) {
    widget.allDataFeedback;
    widget.allDataComplains;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    setState(() {
      if (width <= 1100) {
        screen = false;
      } else {
        screen = true;
      }
    });
    return Scaffold(
      backgroundColor: ColorManager.bgcolor,
      body: Row(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
              width * 0.02,
              height * 0.02,
              0,
              height * 0.02,
            ),
            height: height,
            width: width * 0.16,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: ColorManager.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height / 12,
                ),
                Container(
                  height: height / 12,
                  width: height / 12,
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: height / 64,
                ),
                screen
                    ? Text(
                        'Admin',
                        style: TextStyle(
                          color: ColorManager.darkBlack,
                          //fontFamily: FontConstants.fontFamily,
                          fontWeight: FontWeightManager.medium,
                          fontSize: 32,
                        ),
                      )
                    : const Text(''),
                SizedBox(
                  height: height / 40,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorManager.skyBlue,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            feedback = true;
                          });
                        },
                        child: screen
                            ? Text(
                                "Feedbacks",
                                style: TextStyle(
                                  //fontFamily: FontConstants.fontFamily,
                                  fontWeight: FontWeightManager.semibold,
                                  fontSize: 22,
                                  color: ColorManager.white,
                                ),
                              )
                            : Text(
                                'F',
                                style: TextStyle(
                                  //fontFamily: FontConstants.fontFamily,
                                  fontWeight: FontWeightManager.semibold,
                                  fontSize: 22,
                                  color: ColorManager.white,
                                ),
                              )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorManager.lightRed,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            feedback = false;
                          });
                        },
                        child: screen
                            ? Text(
                                "Complains",
                                style: TextStyle(
                                  // fontFamily: FontConstants.fontFamily,
                                  fontWeight: FontWeightManager.semibold,
                                  fontSize: 22,
                                  color: ColorManager.white,
                                ),
                              )
                            : Text(
                                'C',
                                style: TextStyle(
                                  //fontFamily: FontConstants.fontFamily,
                                  fontWeight: FontWeightManager.semibold,
                                  fontSize: 22,
                                  color: ColorManager.white,
                                ),
                              )),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        width * 0.02, height * 0.02, width * 0.02, 0),
                    height: height * 0.1,
                    width: width * 0.78,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: ColorManager.lightGrey, width: 1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: feedback
                          ? Text(
                              'Feedback Messages',
                              style: TextStyle(
                                //fontFamily: FontConstants.fontFamily,
                                fontWeight: FontWeightManager.semibold,
                                fontSize: 22,
                                color: ColorManager.darkBlack,
                              ),
                            )
                          : Text(
                              'Complains',
                              style: TextStyle(
                                //fontFamily: FontConstants.fontFamily,
                                fontWeight: FontWeightManager.semibold,
                                fontSize: 22,
                                color: ColorManager.darkBlack,
                              ),
                            ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(width * 0.02, height * 0.02,
                        width * 0.02, height * 0.02),
                        padding: const EdgeInsets.only(bottom: 10),
                    height: height * 0.84,
                    width: width * 0.78,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: ColorManager.lightGrey, width: 1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: feedback
                        ? ListView.builder(
                            itemCount: widget.allDataFeedback.length,
                            itemBuilder: (context, i) {
                              int index = i + 1;
                              return SizedBox(
                                child: ExpansionTile(
                                  title: Row(
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        '$index.',
                                        style: TextStyle(
                                          //fontFamily: FontConstants.fontFamily,
                                          fontWeight: FontWeightManager.medium,
                                          fontSize: 16,
                                          color: ColorManager.darkBlack,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        widget.allDataFeedback[i][0],
                                        style: TextStyle(
                                          // fontFamily: FontConstants.fontFamily,
                                          fontWeight: FontWeightManager.medium,
                                          fontSize: 16,
                                          color: ColorManager.darkBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                  children: <Widget>[
                                    ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            45, 0, 0, 0),
                                        child: Text(
                                          "Message :",
                                          style: TextStyle(
                                            //  fontFamily:
                                            //     FontConstants.fontFamily,
                                            fontWeight:
                                                FontWeightManager.medium,
                                            fontSize: 16,
                                            color: ColorManager.darkBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          60, 0, 20, 10),
                                      padding: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: ColorManager.light,
                                        border: Border.all(
                                            color: ColorManager.lightGrey,
                                            width: 1),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        widget.allDataFeedback[i][1],
                                        style: TextStyle(
                                          // fontFamily: FontConstants.fontFamily,
                                          fontWeight: FontWeightManager.medium,
                                          fontSize: 14,
                                          color: ColorManager.darkBlack,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: widget.allDataComplains.length,
                            itemBuilder: (context, i) {
                              int index = i + 1;
                              return SizedBox(
                                child: ExpansionTile(
                                  title: Row(
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        '$index.',
                                        style: TextStyle(
                                          // fontFamily: FontConstants.fontFamily,
                                          fontWeight: FontWeightManager.medium,
                                          fontSize: 16,
                                          color: ColorManager.darkBlack,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        widget.allDataComplains[i][0],
                                        style: TextStyle(
                                          //  fontFamily: FontConstants.fontFamily,
                                          fontWeight: FontWeightManager.medium,
                                          fontSize: 16,
                                          color: ColorManager.darkBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                  children: <Widget>[
                                    const SizedBox(
                                      width: 60,
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                        ),
                                        Text(
                                          "Name :",
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeightManager.medium,
                                            fontSize: 16,
                                            color: ColorManager.darkBlack,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.allDataComplains[i][1],
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeightManager.medium,
                                            fontSize: 16,
                                            color: ColorManager.darkBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 120,
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                        ),
                                        Text(
                                          "PhoneNumber:",
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeightManager.medium,
                                            fontSize: 16,
                                            color: ColorManager.darkBlack,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.allDataComplains[i][2],
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeightManager.medium,
                                            fontSize: 16,
                                            color: ColorManager.darkBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                        ),
                                        Text(
                                          "Address :",
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeightManager.medium,
                                            fontSize: 16,
                                            color: ColorManager.darkBlack,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${widget.allDataComplains[i][3][1]}, ${widget.allDataComplains[i][3][2]}',
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeightManager.medium,
                                            fontSize: 16,
                                            color: ColorManager.darkBlack,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            _showMap(
                                                context,
                                                widget.allDataComplains[i][3]
                                                    [4],
                                                widget.allDataComplains[i][3]
                                                    [5]);
                                          },
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Icon(
                                              Icons.navigation,
                                              color: ColorManager.primaryDark,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                        ),
                                        Text(
                                          "WardNo :",
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeightManager.medium,
                                            fontSize: 16,
                                            color: ColorManager.darkBlack,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.allDataComplains[i][4]
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeightManager.medium,
                                            fontSize: 16,
                                            color: ColorManager.darkBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Message :",
                                      style: TextStyle(
                                        // fontFamily: FontConstants.fontFamily,
                                        fontWeight: FontWeightManager.medium,
                                        fontSize: 16,
                                        color: ColorManager.darkBlack,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          60, 10, 20, 10),
                                      padding: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: ColorManager.light,
                                        border: Border.all(
                                            color: ColorManager.lightGrey,
                                            width: 1),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        widget.allDataComplains[i][5],
                                        style: TextStyle(
                                          //  fontFamily: FontConstants.fontFamily,
                                          fontWeight: FontWeightManager.medium,
                                          fontSize: 14,
                                          color: ColorManager.darkBlack,
                                        ),
                                      ),
                                    ),
                                    widget.allDataComplains[i][7] != 0
                                        ? Column(
                                            children: [
                                              Text(
                                                "Media File :",
                                                style: TextStyle(
                                                  // fontFamily: FontConstants.fontFamily,
                                                  fontWeight:
                                                      FontWeightManager.medium,
                                                  fontSize: 16,
                                                  color: ColorManager.darkBlack,
                                                ),
                                              ),
                                              widget.allDataComplains[i][7] == 1
                                                  ? Container(
                                                      height: 200,
                                                      margin: const EdgeInsets
                                                              .fromLTRB(
                                                          60, 10, 20, 10),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            ColorManager.light,
                                                        border: Border.all(
                                                            color: ColorManager
                                                                .lightGrey,
                                                            width: 1),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                      child: Image.network(widget
                                                              .allDataComplains[
                                                          i][8]),
                                                    )
                                                  : Container(
                                                      height: 200,
                                                      margin:
                                                          const EdgeInsets
                                                                  .fromLTRB(
                                                              60, 10, 20, 10),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            ColorManager.light,
                                                        border: Border.all(
                                                            color: ColorManager
                                                                .lightGrey,
                                                            width: 1),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          // _showVideo(
                                                          //   context,
                                                          //   widget.allDataComplains[
                                                          //       i][8],
                                                          //   widget.allDataComplains[
                                                          //       i][0],
                                                          // );

                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          VideoAppOne(
                                                                            url:
                                                                                widget.allDataComplains[i][8],
                                                                            title:
                                                                                widget.allDataComplains[i][0],
                                                                          )));
                                                        },
                                                        child: Image.asset(
                                                            'assets/images/video.png'),
                                                      )),
                                            ],
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  _showVideo(BuildContext context, String url, String title) {
    // ignore: no_leading_underscores_for_local_identifiers
    final VideoPlayerController _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: ColorManager.primaryDark,
          title: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeightManager.medium,
                fontSize: 26,
                color: ColorManager.darkBlack,
              ),
            ),
          ),
          children: [
            SimpleDialogOption(
              child: Center(
                child: SizedBox(
                  height: 500,
                  width: 400,
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Container(),
                ),
              ),
            ),
            SimpleDialogOption(
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: ColorManager.darkBlack,
                ),
              ),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cancel,
                    color: ColorManager.darkBlack,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeightManager.medium,
                      fontSize: 20,
                      color: ColorManager.darkBlack,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

_showMap(BuildContext context, String lat, String lon) {
  double lati = double.parse(lat);
  double long = double.parse(lon);

  return showDialog(
    context: context,
    builder: (context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      return SimpleDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: ColorManager.skyBlue,
        
        title: Row(
          children: [
            IconButton(
              onPressed: (() {
                Navigator.of(context).pop();
              }),
              icon: Icon(
                Icons.arrow_back,
                color: ColorManager.white,
              ),
            ),
             SizedBox(
              width:width/9 ,
            ),
            Text("Map",style: TextStyle(color: ColorManager.white,fontSize: 26),)
          ],
        ),
        children: [
          SizedBox(
            height: height / 2,
            width: width / 3,
            child: FlutterMap(
              options: MapOptions(
                onTap: ((tapPosition, point) => {}),
                zoom: 14.0,
                center: LatLng(lati, long),
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(lati, long),
                      builder: (ctx) => DecoratedIcon(
                        icon: Icon(
                          Icons.add_location,
                          color: ColorManager.darkBlack,
                          size: 32,
                        ),
                        decoration: const IconDecoration(border: IconBorder()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
