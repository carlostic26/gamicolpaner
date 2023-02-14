class GameCards {
  final String hiddenCardpath = 'assets/logo_cards.png';
  List<String>? gameImg;

  final List<String> cards_list = [
    //A continuación se presenta el acceso directo a la dirección de los diferentes tipos de imagenes relacionadas a las tarjetas
    //son valores duplicados ya que estos se guardan en parejas al momento de establecer la lista
    "assets/games/DesarrolloSoftware/level8/ds_nivel8_1.png",
    "assets/games/DesarrolloSoftware/level8/ds_nivel8_3.png",
    "assets/games/DesarrolloSoftware/level8/ds_nivel8_5.png",
    "assets/games/DesarrolloSoftware/level8/ds_nivel8_2.png",
    "assets/games/DesarrolloSoftware/level8/ds_nivel8_4.png",
    "assets/games/DesarrolloSoftware/level8/ds_nivel8_6.png",

    "assets/games/DesarrolloSoftware/level8/ds_nivel8_5.png",
    "assets/games/DesarrolloSoftware/level8/ds_nivel8_6.png",
    "assets/games/DesarrolloSoftware/level8/ds_nivel8_3.png",
    "assets/games/DesarrolloSoftware/level8/ds_nivel8_4.png",
    "assets/games/DesarrolloSoftware/level8/ds_nivel8_1.png",
    "assets/games/DesarrolloSoftware/level8/ds_nivel8_2.png",
  ];

  // en esta lista guardaremos las dos primeras cartas tocadas y validar si son compatibles o no
  List<Map<int, String>> matchCheck = [];

  final int cardCount = 12;

  void initGame() {
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
