import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_grandmerche/core/constants/colors/palletes.dart';
import 'package:the_grandmerche/features/details_screen/reviews.dart';
import 'package:the_grandmerche/main.dart';
import 'package:the_grandmerche/model/restaurant_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../core/common/snack_bar.dart';

class HotelDetailsScreen extends ConsumerStatefulWidget {
  final Restaurant restaurant;
  final String hotelImage;
  final double rating;
  const HotelDetailsScreen(
      {super.key,
      required this.restaurant,
      required this.hotelImage,
      required this.rating});

  @override
  ConsumerState<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends ConsumerState<HotelDetailsScreen> {
  int selectedIndex = 0;
  List openingHours = [];
  Future<void> googleMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl).then(
        (value) => customSnackbar(context, 'message'),
      );
    } else {
      throw 'Could not launch $googleUrl';
    }
  }

  final selectedWeekDay = StateProvider<String>(
    (ref) => 'Monday : 5:30pm - 12:00am ',
  );
  List<String> weekdays = [
    'Monday : 5:30pm - 12:00am ',
    "Tuesday : 5:30pm - 12:00am ",
    "Wednesday : 5:30pm - 12:00am",
    "Thursday : 5:30pm - 12:00am ",
    "Friday : 5:30pm - 12:00am ",
    "Saturday : 5:30pm - 12:00am ",
    "Sunday : Closed ",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Pallets.orange,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.directions,
              color: Colors.white,
              size: width * .05,
            ),
            Text(
              "GO",
              style: TextStyle(
                  fontSize: width * .03,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
        onPressed: () {
          googleMap(widget.restaurant.latlng.lat, widget.restaurant.latlng.lng);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * .3,
              width: width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        widget.hotelImage,
                      ),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: EdgeInsets.only(
                    top: width * .06, left: width * .03, bottom: width * .03),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.black,
                            size: width * 0.08,
                          )),
                      Text(
                        widget.restaurant.name,
                        style: TextStyle(
                            fontSize: width * .045, color: Colors.black),
                      )
                    ]),
              ),
            ),
            SizedBox(
              height: width * .03,
            ),
            Container(
              height: height * 0.24,
              width: width,
              padding: EdgeInsets.all(width * .03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.restaurant.name,
                        style: TextStyle(
                            fontSize: width * .05,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Container(
                        height: width * .07,
                        width: width * .15,
                        padding: EdgeInsets.only(
                            left: width * .02, right: width * .02),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * .06),
                          color: Colors.green,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.rating.toStringAsFixed(1),
                                style: TextStyle(
                                    fontSize: width * .04,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: width * .04,
                              )
                            ]),
                      )
                    ],
                  ),
                  Text(
                    widget.restaurant.neighborhood.name.substring(0, 1) +
                        widget.restaurant.neighborhood.name
                            .substring(1)
                            .toLowerCase(),
                    style: TextStyle(
                        fontSize: width * .04, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          radius: width * .03,
                          child: Icon(
                            Icons.restaurant_menu_rounded,
                            size: width * .04,
                          )),
                      SizedBox(
                        width: width * .02,
                      ),
                      Text(
                        widget.restaurant.cuisineType,
                        style: TextStyle(fontSize: width * .04),
                      )
                    ],
                  ),
                  SizedBox(
                    height: width * .03,
                  ),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.location_solid,
                        size: width * .06,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: width * .02,
                      ),
                      Text(
                        widget.restaurant.address,
                        style: TextStyle(fontSize: width * .04),
                      )
                    ],
                  ),
                  SizedBox(
                    height: width * .02,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_filled_rounded,
                        size: width * .06,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: width * .02,
                      ),
                      Consumer(
                        builder: (context, ref, child) => SizedBox(
                          width: width * 0.65,
                          child: DropdownButton(
                            underline: Container(),
                            icon: Icon(CupertinoIcons.chevron_down),
                            style: TextStyle(
                                fontSize: width * .04, color: Colors.black),
                            value: ref.watch(selectedWeekDay),
                            items: weekdays
                                .map((item) => DropdownMenuItem(
                                    child: Text(item), value: item))
                                .toList(),
                            isExpanded: true,
                            selectedItemBuilder: (_) {
                              return weekdays.map<Widget>((String lang) {
                                return Center(
                                  widthFactor: 1,
                                  child: Text(lang,
                                      style:
                                          const TextStyle(color: Colors.black)),
                                );
                              }).toList();
                            },
                            onChanged: (value) {
                              ref.read(selectedWeekDay.notifier).update(
                                    (state) => value!,
                                  );
                            },
                          ),
                        ),
                      )
                      // DropdownButton(
                      //   items: openingHours.map<DropdownMenuItem<String>((String value) {
                      //     return DropdownMenuItem(
                      //       child: widget.restaurant.operatingHours.
                      //       )
                      //   }),
                      //   onChanged: onChanged
                      //   )
                      // SizedBox(
                      //   width: width * 0.5,
                      //   child: CustomDropdown(
                      //     items: weekdays,
                      //     onChanged: (p0) {
                      //       ref
                      //           .read(selectedWeekDay.notifier)
                      //           .update((state) => p0);
                      //     },
                      //   ),
                      // )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: width * 0.06,
            ),
            Padding(
              padding: EdgeInsets.only(top: width * .03, left: width * .03),
              child: Text(
                "Ratings & Reviews",
                style: TextStyle(
                    fontSize: width * .06, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.separated(
              itemCount: widget.restaurant.reviews.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                print(widget.restaurant.reviews.length);
                return ReviewsSeoerate(
                    reviews: widget.restaurant.reviews[index]);
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            )
          ],
        ),
      ),
    );
  }
}
