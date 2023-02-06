import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class world_game extends StatefulWidget {
  final String requiredModulo;

  const world_game({required this.requiredModulo, Key? key}) : super(key: key);

  @override
  State<world_game> createState() => _world_gameState();
}

class _world_gameState extends State<world_game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Center(
          child: Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      'https://blogger.googleusercontent.com/img/a/AVvXsEgBWLtvel3tZVFCn9zmKgG5SaOmbbKKiwV8tAMG9vcgx3ul0ibalLDCyQyA0DH95XEyJAGRxcuCfuF-hrWv2nT29d5T5g6aAJy-N7gFy3Q1dxvOIw1xVbVAlH0N-IWo7AvBAmoae1_50V0XV8fp1pkc1NPU4SlnyM_3nsHkANX-_R6sYNbAqbJK2dk=s16000',
                  //height: 1000,
                  /*
              //dimension de ancho y alto de pantalla candy crush
              height: MediaQuery.of(context).size.height * 1.0,
              width: MediaQuery.of(context).size.width * 1.0,
                  */
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ));
  }
}
