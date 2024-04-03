import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_grandmerche/core/common/error_text.dart';
import 'package:the_grandmerche/core/common/loader.dart';
import 'package:the_grandmerche/core/constants/colors/palletes.dart';
import 'package:the_grandmerche/core/constants/pictures/pictures.dart';
import 'package:the_grandmerche/features/details_screen/details_screen.dart';
import 'package:the_grandmerche/features/home_screen/controller/home_screen_controller.dart';
import 'package:the_grandmerche/features/login_screen/login_screen.dart';
import 'package:the_grandmerche/main.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List ratingsList = [
    "3.7",
    '4.3',
    '4.3',
    '4',
    '4',
    '4',
    '4.3',
    '4',
    '4',
    '4.3'
  ];
  List hotelImages = [
    Pictures.restaurant9,
    Pictures.restaurant1,
    Pictures.restaurant2,
    Pictures.restaurant3,
    Pictures.restaurant6,
    Pictures.restaurant7,
    Pictures.restaurant8,
    Pictures.restaurant1,
    Pictures.restaurant2,
    Pictures.restaurant10,
  ];
  Future logOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('login');
      prefs.remove('username');
      prefs.remove('password').then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false)
          });
    } catch (e) {
      print("Error during logout $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Pallets.orange,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            backgroundColor: Pallets.orange,
            foregroundColor: Colors.white,
            title: Text(
              "RESTAURANTS",
              style: TextStyle(
                  fontSize: width * .045, fontWeight: FontWeight.bold),
            ),
            actions: [
              InkWell(
                onTap: () => logOut(),
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    Text(
                      "Log out",
                      style:
                          TextStyle(fontSize: width * .04, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * .03,
              )
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                  top: width * .02, left: width * .01, right: width * .01),
              child: SizedBox(
                width: width,
                child: Column(
                  children: [
                    ref.watch(fetchRestoProvider).when(
                          data: (data) {
                            return ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.restaurants.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HotelDetailsScreen(
                                            restaurant: data.restaurants[index],
                                            hotelImage: hotelImages[index],
                                            rating: double.tryParse(
                                                ratingsList[index])!,
                                          ),
                                        ));
                                  },
                                  child: Container(
                                    height: height * .36,
                                    width: width,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: height * .2,
                                          width: width,
                                          child: Image.asset(
                                            hotelImages[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(width * .04),
                                          width: width,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    data.restaurants[index]
                                                        .name,
                                                    style: TextStyle(
                                                        fontSize: width * .05,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                  Container(
                                                    height: width * .07,
                                                    // width: width * .15,
                                                    padding: EdgeInsets.only(
                                                        left: width * .02,
                                                        right: width * .02),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              width * .06),
                                                      color: Colors.green,
                                                    ),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            ratingsList[index]
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width * .04,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
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
                                              SizedBox(
                                                height: width * .04,
                                              ),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                      backgroundColor:
                                                          Colors.grey,
                                                      foregroundColor:
                                                          Colors.white,
                                                      radius: width * .03,
                                                      child: Icon(
                                                        Icons
                                                            .restaurant_menu_rounded,
                                                        size: width * .04,
                                                      )),
                                                  SizedBox(
                                                    width: width * .02,
                                                  ),
                                                  Text(
                                                    data.restaurants[index]
                                                        .cuisineType,
                                                    style: TextStyle(
                                                        fontSize: width * .04),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: width * .03,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    CupertinoIcons
                                                        .location_solid,
                                                    size: width * .06,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    width: width * .02,
                                                  ),
                                                  Text(
                                                    data.restaurants[index]
                                                        .address,
                                                    style: TextStyle(
                                                        fontSize: width * .04),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: width * .03,
                                );
                              },
                            );
                          },
                          error: (error, stackTrace) {
                            print("hererererere");
                            print(error);
                            print(stackTrace);
                            return Center(
                                child: ErrorText(error: error.toString()));
                          },
                          loading: () => Container(
                              height: height, width: width, child: Loader()),
                        )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
