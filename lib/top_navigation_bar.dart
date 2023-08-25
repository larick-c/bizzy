import 'package:flutter/material.dart';




AppBar CustomAppBar(){
  return AppBar(
    backgroundColor: Colors.blueGrey,
    title: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: (){

            },
            child: Image.asset(
                'assets/images/logo.png',
              height: 35,
              width: 35,
            ),
          ),
          InkWell(
            onTap: (){

            },
            child: Image.asset(
                'assets/images/logo.png',
              height: 35,
              width: 35,
            ),
          ),
          InkWell(
            onTap: (){

            },
            child: Image.asset(
                'assets/images/logo.png',
              height: 35,
              width: 35,
            ),
          ),
        ],
      ),
    ),
  );
}

