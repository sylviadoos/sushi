import 'package:flutter/material.dart';

import '../features/shared/buttons/rounded_edges_button.dart';


// ignore: must_be_immutable
class NoInternet extends StatefulWidget {
  // const NoInternet({ Key? key }) : super(key: key);
  dynamic onTap;
  // ignore: use_key_in_widget_constructors
  NoInternet({required this.onTap});

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      height: media.height * 1,
      width: media.width * 1,
      color: Colors.transparent.withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(media.width * 0.05),
            width: media.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Column(
              children: [
                SizedBox(
                  width: media.width * 0.6,
                  child: Image.asset('assets/images/noInternet.png',
                      fit: BoxFit.contain, color: Colors.black),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Text(
                   'No Internet Connection',

                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Text(

                  'Please check your Internet connection, try enabling wifi or try again later',

                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                RoundedEdgesButton(
                    onTap: widget.onTap,
                    txt: 'Ok',)
              ],
            ),
          )
        ],
      ),
    );
  }
}