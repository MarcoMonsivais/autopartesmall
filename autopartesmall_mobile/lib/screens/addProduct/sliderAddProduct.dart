import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';
import 'package:autopartes_mall/constants/Theme.dart';
import 'package:image_picker/image_picker.dart';

class AddProductCarousel extends StatefulWidget {
  final List<Map<String, String>> imgArray;
  final File image;

  const AddProductCarousel({
    Key key,
    @required this.imgArray, this.image
  }) : super(key: key);

  @override
  _AddProductCarouselState createState() => _AddProductCarouselState();
}

File _image;

class _AddProductCarouselState extends State<AddProductCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widget.imgArray
          .map((item) =>
          Container(
                width: 100,
                child: Column (
                  children: [
                    GestureDetector(
                      onTap: () {
                        _image = getImage(false) as File;
                      },
                      child:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
//                                color: Color.fromRGBO(0, 0, 0, 0.4),
                                color: ArgonColors.secondary,
                                blurRadius: 8,
                                spreadRadius: 0.3,
                                offset: Offset(0, 3))
                          ]),
                          child: AspectRatio(
                            aspectRatio: 2 / 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child:
//                              Image.file(
//                                widget.image,
                                Image.asset('assets/img/addImages.png',
                                fit: BoxFit.fill,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Column(
                        children: [
                          Text(item["title"],
                              style: TextStyle(
                                  fontSize: 12, color: ArgonColors.text)),
                        ],
                      ),
                    )
                  ],
                ),
              ))
          .toList(),

      options: CarouselOptions(
          viewportFraction: 0.5,
          height: 160,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16/9,
          enableInfiniteScroll: false,
          autoPlayInterval: Duration(seconds: 2),
          pauseAutoPlayOnTouch: true,
          pauseAutoPlayInFiniteScroll: true,
          initialPage: 0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }),
    );
  }
}

Future<File> getImage(bool gallery) async {

  ImagePicker picker = ImagePicker();
  PickedFile pickedFile;

  pickedFile = await picker.getImage(source: ImageSource.gallery,);


  _image = File(pickedFile.path);
  return _image;

}
