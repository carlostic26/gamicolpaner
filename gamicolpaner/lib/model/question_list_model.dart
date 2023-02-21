class question {
  final String modulo;
  final String pregunta;
  final String resp_1;
  final String resp_2;
  final String resp_3;
  final String resp_4;
  final String op_1;
  final String op_2;
  final String op_3;
  final String op_4;
  final String imagen;

  question({
    required this.modulo,
    required this.pregunta,
    required this.resp_1,
    required this.resp_2,
    required this.resp_3,
    required this.resp_4,
    required this.op_1,
    required this.op_2,
    required this.op_3,
    required this.op_4,
    required this.imagen,
  });

  Map<String, dynamic> toMap() {
    return {
      'modulo': modulo,
      'pregunta': pregunta,
      'resp_1': resp_1,
      'resp_2': resp_2,
      'resp_3': resp_3,
      'resp_4': resp_4,
      'op_1': op_1,
      'op_2': op_2,
      'op_3': op_3,
      'op_4': op_4,
      'imagen': imagen,
    };
  }

  question.fromMap(Map<String, dynamic> res)
      : modulo = res["modulo"],
        pregunta = res["pregunta"],
        resp_1 = res["resp_1"],
        resp_2 = res["resp_2"],
        resp_3 = res["resp_3"],
        resp_4 = res["resp_4"],
        op_1 = res["op_1"],
        op_2 = res["op_2"],
        op_3 = res["op_3"],
        op_4 = res["op_4"],
        imagen = res["imagen"];

  @override
  String toString() {
    return 'question{modulo: $modulo, pregunta: $pregunta, resp_1: $resp_1, resp_2: $resp_2, resp_3: $resp_3, resp_4: $resp_4, op_1: $op_1, op_2: $op_2, op_3: $op_3, op_4: $op_4, imagen: $imagen}';
  }
}
