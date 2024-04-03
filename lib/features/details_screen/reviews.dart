import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../main.dart';
import '../../model/restaurant_model.dart';

class ReviewsSeoerate extends StatefulWidget {
  final Review reviews;
  const ReviewsSeoerate({super.key, required this.reviews});

  @override
  State<ReviewsSeoerate> createState() => _ReviewsSeoerateState();
}

class _ReviewsSeoerateState extends State<ReviewsSeoerate> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _isExpanded ? height * 0.35 : height * 0.18,
      width: width,
      padding: EdgeInsets.all(width * .02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Container(
                height: width * .07,
                width: width * .13,
                padding: EdgeInsets.only(left: width * .03, right: width * .03),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * .06),
                  color: Colors.green,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.reviews.rating.toString(),
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
              ),
              SizedBox(
                width: width * .01,
              ),
              Text(
                widget.reviews.name,
                style: TextStyle(fontSize: width * .04),
              )
            ],
          ),
          _isExpanded
              ? Text(
                  widget.reviews.comments,
                  textAlign: TextAlign.justify,
                )
              : Text(
                  '${widget.reviews.comments.substring(0, 80)}...',
                  textAlign: TextAlign.justify,
                ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    // ignore: prefer_interpolation_to_compose_strings
                    widget.reviews.date.name.substring(0, 7) +
                        ' ' +
                        widget.reviews.date.name.substring(8, 10) +
                        " " +
                        widget.reviews.date.name.substring(10),
                    style: TextStyle(fontSize: width * .024),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  setState(() {});
                  _isExpanded = !_isExpanded;
                },
                child: Text(
                  _isExpanded ? "Read less" : "Read more",
                  style: TextStyle(
                      fontSize: width * .03,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
