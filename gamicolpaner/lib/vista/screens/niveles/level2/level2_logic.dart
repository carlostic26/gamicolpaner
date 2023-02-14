class GameCards {
  final String hiddenCardpath =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhIZ0BeUdFWmKEPuHG8oqYPvKvLKbqVNHuiatUdPUCTvlDPUqsGPOjlf-O0VLFKGn1ThkIRpjtJ1xlKFp0q9SMG0pMtdsERgeKUGmOZCxkdgxr_zbyPhJQofnGHIy3jsYoNjp66DeodhoFnRC66yvzxsI9QsE_9lj2SqinF8T9TEMG7N8SYZ08Sb5w/s320/icon.png';
  List<String>? gameImg;

  final List<String> cards_list = [
    //A continuación se presenta el acceso directo a la dirección de los diferentes tipos de imagenes relacionadas a las tarjetas
    //son valores duplicados ya que estos se guardan en parejas al momento de establecer la lista
    "https://blogger.googleusercontent.com/img/a/AVvXsEgXn9Apbi4XLRaapIhX6HaD6aNwY2j_gKkNxfpDd-F4oW3Jb4P_cZZ8ZDezWpAY2ua6wVoC3tk3pjsE9lbD6bkhpLyjGdflY_rqh1-iT96cDWVSoc3yOXG4b31ePQOlBYBD-IqneIjDcWLOmhOiih8u3q_oNcCPCF38VOyEaCOfL0nmnwOt9qACJyE=w400-h179",
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
    "https://cdn.pixabay.com/photo/2015/03/30/20/33/heart-700141_1280.jpg",
    "https://empresas.blogthinkbig.com/wp-content/uploads/2019/11/Imagen3-245003649.jpg?w=800",

    "https://i.blogs.es/ceda9c/dalle/450_1000.jpg",
    "https://images.unsplash.com/reserve/Af0sF2OS5S5gatqrKzVP_Silhoutte.jpg?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80",

    "https://blogger.googleusercontent.com/img/a/AVvXsEgXn9Apbi4XLRaapIhX6HaD6aNwY2j_gKkNxfpDd-F4oW3Jb4P_cZZ8ZDezWpAY2ua6wVoC3tk3pjsE9lbD6bkhpLyjGdflY_rqh1-iT96cDWVSoc3yOXG4b31ePQOlBYBD-IqneIjDcWLOmhOiih8u3q_oNcCPCF38VOyEaCOfL0nmnwOt9qACJyE=w400-h179",
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
    "https://cdn.pixabay.com/photo/2015/03/30/20/33/heart-700141_1280.jpg",
    "https://empresas.blogthinkbig.com/wp-content/uploads/2019/11/Imagen3-245003649.jpg?w=800",

    "https://i.blogs.es/ceda9c/dalle/450_1000.jpg",
    "https://images.unsplash.com/reserve/Af0sF2OS5S5gatqrKzVP_Silhoutte.jpg?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80",
  ];

  // en esta lista guardaremos las dos primeras cartas tocadas y validar si son compatibles o no
  List<Map<int, String>> matchCheck = [];

  final int cardCount = 12;

  void initGame() {
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
