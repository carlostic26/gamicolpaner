library simulacro;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamicolpaner/controller/anim/shakeWidget.dart';
import 'package:gamicolpaner/controller/modulo.dart';
import 'package:gamicolpaner/model/dbexam.dart';
import 'package:gamicolpaner/model/question_list_model.dart';
import 'package:gamicolpaner/vista/screens/world_game.dart';
import 'package:gamicolpaner/vista/visual/colors_colpaner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gamicolpaner/model/dbexam.dart';

part 'result_page.dart';
part 'model/question_widget.dart';
part 'model/options_widget.dart';
part 'model/question.dart';
part 'model/option.dart';

/*NIVEL TIPO QUIZ 
  Este nivel consiste en desplegar diferentes tipos de preguntas
  El jugador deberá seleccionar una de las opciones.

  El sistema validará la respuesta seleccionada a traves de un aviso sobre la respuesta.

*/

class simulacro extends StatefulWidget {
  final String modulo;
  const simulacro({required this.modulo, Key? key}) : super(key: key);

  @override
  State<simulacro> createState() => _simulacroState();
}

class _simulacroState extends State<simulacro> {
  //llamando la clase question para conectar sqflite
  late DatabaseHandler handler;
  Future<List<question_model>>? _question;

  //guarda el modulo ingresado en sharedPreferences
  void _storeModulo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('modulo', widget.modulo);
  }

  @override
  void initState() {
    super.initState();
    _storeModulo();

    switch (widget.modulo) {
      case "Matemáticas":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _question = getListMAT();
            });
          });
        }
        break;

      case "Inglés":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _question = getListING();
            });
          });
        }
        break;
        ;
    }
  }

  //Methods that receive the list select from dbhelper
  Future<List<question_model>> getListING() async {
    List<question_model> dbQuestions = await handler.QueryING();
    return dbQuestions
        .map((dbQuestion) => question_model.fromMap(dbQuestion.toMap()))
        .toList();
  }

  Future<List<question_model>> getListMAT() async {
    return await handler.QueryMAT();
  }

  Future<void> _onRefresh() async {
    setState(() {
      //hacemos un switch para que sepa que cateogira es la que debe refrescar

      switch (widget.modulo) {
        case "Matemáticas":
          {
            _question = getListING();
          }
          break;

        case "Inglés":
          {
            _question = getListMAT();
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors_colpaner.base,
      body: Column(
        children: const [
          Expanded(child: QuestionWidget()),
        ],
      ),
    );
  }
}

final questionsMat = [
  //para preguntas con imagen se puede usar la clase Question
  // para preguntas sin imagen, se puede usar otra clase comno QuestionNoIMG

  //Pregunta 1
  Question(
    text: "1. ¿Qué es el Diseño de Software? ",
    options: [
      const Option(
          text: 'A. Es el diseño que se le dan a los programas informáticos',
          isCorrect: false),
      const Option(
          text:
              'B. Es el conjunto de actividades TIC dedicadas al proceso de creación, despliegue y compatibilidad de software.',
          isCorrect: false),
      const Option(
          text:
              'C. Es la planificación de una solución de software, necesario para para disminuir el riesgo de desarrollos erróneos.',
          isCorrect: true),
      const Option(
          text:
              'D. Son el conjunto de actividades de software dedicadas al proceso de creación, diseño, despliegue y compatibilidad electrónica',
          isCorrect: false)
    ],
    imagen: '',
  ),

  //Pregunta 2
  Question(
      text:
          "2. Cuantas preguntas contiene la prueba de Desarrollo de Software del ICFES Saber PRO? ",
      options: [
        const Option(text: 'A. 25', isCorrect: false),
        const Option(text: 'B. 30', isCorrect: true),
        const Option(text: 'C. 35', isCorrect: false),
        const Option(text: 'D. 40', isCorrect: false)
      ],
      imagen: ''),

  //Pregunta 3
  Question(
      text:
          "3. Cuál es la estructura de evaluación del modulo(Tomado de la guia de orientacion de modulo de razonamiento cuantitativo saber pro 2016)",
      options: [
        const Option(
            text: 'A. Competencia, afirmación , evidencia ', isCorrect: true),
        const Option(
            text:
                'B. Análisis y comprensión, formulación y representación, interpretación y argumentación',
            isCorrect: false),
        const Option(
            text:
                'C. Investigación y ejecución, interpretación y formulación, argumentación',
            isCorrect: false),
        const Option(text: 'D. Todas las anteriores', isCorrect: false)
      ],
      imagen: ''),

  //Pregunta 4
  Question(
      text:
          '4. Los módulos específicos, como Diseño de Software, están dirigidos a ',
      options: [
        const Option(
            text:
                'A. Estudiantes que hayan aprobado por lo menos el 75 % de los créditos académicos del programa profesional universitario que cursan',
            isCorrect: false),
        const Option(
            text:
                'B. Quienes presentan el examen por primera vez y que sean inscritos directamente por su IES.',
            isCorrect: false),
        const Option(
            text: 'C. Cualquier persona que desee obtenerlos',
            isCorrect: false),
        const Option(text: 'D. A y B son ciertas', isCorrect: true)
      ],
      imagen: ''),

  //Pregunta 5
  Question(
      text: "5. El módulo Diseño de Software se oferta a los programas de ",
      options: [
        const Option(
            text: 'A. Ingeniería de sistemas, telemática y afines.',
            isCorrect: true),
        const Option(text: 'B. Ingeniería mecánica y afines', isCorrect: false),
        const Option(text: 'C. Ingeniería de alimentos', isCorrect: false),
        const Option(text: 'D. Derecho y arquitectura', isCorrect: false)
      ],
      imagen: ''),
];

final questionsIng = [
  //para preguntas con imagen se puede usar la clase Question
  // para preguntas sin imagen, se puede usar otra clase comno QuestionNoIMG

  //Pregunta 1
  Question(
    text: "1. ¿Qué es el Inglés? ",
    options: [
      const Option(
          text: 'A. Es el diseño que se le dan a los programas informáticos',
          isCorrect: false),
      const Option(
          text:
              'B. Es el conjunto de actividades TIC dedicadas al proceso de creación, despliegue y compatibilidad de software.',
          isCorrect: false),
      const Option(
          text:
              'C. Es la planificación de una solución de software, necesario para para disminuir el riesgo de desarrollos erróneos.',
          isCorrect: true),
      const Option(
          text:
              'D. Son el conjunto de actividades de software dedicadas al proceso de creación, diseño, despliegue y compatibilidad electrónica',
          isCorrect: false)
    ],
    imagen: '',
  ),

  //Pregunta 2
  Question(
      text:
          "2. Cuantas preguntas contiene la prueba de Desarrollo de Software del ICFES Saber PRO? ",
      options: [
        const Option(text: 'A. 25', isCorrect: false),
        const Option(text: 'B. 30', isCorrect: true),
        const Option(text: 'C. 35', isCorrect: false),
        const Option(text: 'D. 40', isCorrect: false)
      ],
      imagen: ''),

  //Pregunta 3
  Question(
      text:
          "3. Cuál es la estructura de evaluación del modulo(Tomado de la guia de orientacion de modulo de razonamiento cuantitativo saber pro 2016)",
      options: [
        const Option(
            text: 'A. Competencia, afirmación , evidencia ', isCorrect: true),
        const Option(
            text:
                'B. Análisis y comprensión, formulación y representación, interpretación y argumentación',
            isCorrect: false),
        const Option(
            text:
                'C. Investigación y ejecución, interpretación y formulación, argumentación',
            isCorrect: false),
        const Option(text: 'D. Todas las anteriores', isCorrect: false)
      ],
      imagen: ''),

  //Pregunta 4
  Question(
      text:
          '4. Los módulos específicos, como Diseño de Software, están dirigidos a ',
      options: [
        const Option(
            text:
                'A. Estudiantes que hayan aprobado por lo menos el 75 % de los créditos académicos del programa profesional universitario que cursan',
            isCorrect: false),
        const Option(
            text:
                'B. Quienes presentan el examen por primera vez y que sean inscritos directamente por su IES.',
            isCorrect: false),
        const Option(
            text: 'C. Cualquier persona que desee obtenerlos',
            isCorrect: false),
        const Option(text: 'D. A y B son ciertas', isCorrect: true)
      ],
      imagen: ''),

  //Pregunta 5
  Question(
      text: "5. El módulo Diseño de Software se oferta a los programas de ",
      options: [
        const Option(
            text: 'A. Ingeniería de sistemas, telemática y afines.',
            isCorrect: true),
        const Option(text: 'B. Ingeniería mecánica y afines', isCorrect: false),
        const Option(text: 'C. Ingeniería de alimentos', isCorrect: false),
        const Option(text: 'D. Derecho y arquitectura', isCorrect: false)
      ],
      imagen: ''),
];

final questionsNat = [
  //Pregunta 1
  Question(
    text: "1. ¿Qué es el Diseño de Software? ",
    options: [
      const Option(
          text: 'A. Es el diseño que se le dan a los programas informáticos',
          isCorrect: false),
      const Option(
          text:
              'B. Es el conjunto de actividades TIC dedicadas al proceso de creación, despliegue y compatibilidad de software.',
          isCorrect: false),
      const Option(
          text:
              'C. Es la planificación de una solución de software, necesario para para disminuir el riesgo de desarrollos erróneos.',
          isCorrect: true),
      const Option(
          text:
              'D. Son el conjunto de actividades de software dedicadas al proceso de creación, diseño, despliegue y compatibilidad electrónica',
          isCorrect: false)
    ],
    imagen: '',
  ),

  //Pregunta 2
  Question(
      text:
          "2. Cuantas preguntas contiene la prueba de Desarrollo de Software del ICFES Saber PRO? ",
      options: [
        const Option(text: 'A. 25', isCorrect: false),
        const Option(text: 'B. 30', isCorrect: true),
        const Option(text: 'C. 35', isCorrect: false),
        const Option(text: 'D. 40', isCorrect: false)
      ],
      imagen: ''),

  //Pregunta 3
  Question(
      text:
          "3. Cuál es la estructura de evaluación del modulo(Tomado de la guia de orientacion de modulo de razonamiento cuantitativo saber pro 2016)",
      options: [
        const Option(
            text: 'A. Competencia, afirmación , evidencia ', isCorrect: true),
        const Option(
            text:
                'B. Análisis y comprensión, formulación y representación, interpretación y argumentación',
            isCorrect: false),
        const Option(
            text:
                'C. Investigación y ejecución, interpretación y formulación, argumentación',
            isCorrect: false),
        const Option(text: 'D. Todas las anteriores', isCorrect: false)
      ],
      imagen: ''),

  //Pregunta 4
  Question(
      text:
          '4. Los módulos específicos, como Diseño de Software, están dirigidos a ',
      options: [
        const Option(
            text:
                'A. Estudiantes que hayan aprobado por lo menos el 75 % de los créditos académicos del programa profesional universitario que cursan',
            isCorrect: false),
        const Option(
            text:
                'B. Quienes presentan el examen por primera vez y que sean inscritos directamente por su IES.',
            isCorrect: false),
        const Option(
            text: 'C. Cualquier persona que desee obtenerlos',
            isCorrect: false),
        const Option(text: 'D. A y B son ciertas', isCorrect: true)
      ],
      imagen: ''),

  //Pregunta 5
  Question(
      text: "5. El módulo Diseño de Software se oferta a los programas de ",
      options: [
        const Option(
            text: 'A. Ingeniería de sistemas, telemática y afines.',
            isCorrect: true),
        const Option(text: 'B. Ingeniería mecánica y afines', isCorrect: false),
        const Option(text: 'C. Ingeniería de alimentos', isCorrect: false),
        const Option(text: 'D. Derecho y arquitectura', isCorrect: false)
      ],
      imagen: ''),
];

final questionsLen = [
  //Pregunta 1
  Question(
    text: "1. ¿Qué es el Diseño de Software? ",
    options: [
      const Option(
          text: 'A. Es el diseño que se le dan a los programas informáticos',
          isCorrect: false),
      const Option(
          text:
              'B. Es el conjunto de actividades TIC dedicadas al proceso de creación, despliegue y compatibilidad de software.',
          isCorrect: false),
      const Option(
          text:
              'C. Es la planificación de una solución de software, necesario para para disminuir el riesgo de desarrollos erróneos.',
          isCorrect: true),
      const Option(
          text:
              'D. Son el conjunto de actividades de software dedicadas al proceso de creación, diseño, despliegue y compatibilidad electrónica',
          isCorrect: false)
    ],
    imagen: '',
  ),

  //Pregunta 2
  Question(
      text:
          "2. Cuantas preguntas contiene la prueba de Desarrollo de Software del ICFES Saber PRO? ",
      options: [
        const Option(text: 'A. 25', isCorrect: false),
        const Option(text: 'B. 30', isCorrect: true),
        const Option(text: 'C. 35', isCorrect: false),
        const Option(text: 'D. 40', isCorrect: false)
      ],
      imagen: ''),

  //Pregunta 3
  Question(
      text:
          "3. Cuál es la estructura de evaluación del modulo(Tomado de la guia de orientacion de modulo de razonamiento cuantitativo saber pro 2016)",
      options: [
        const Option(
            text: 'A. Competencia, afirmación , evidencia ', isCorrect: true),
        const Option(
            text:
                'B. Análisis y comprensión, formulación y representación, interpretación y argumentación',
            isCorrect: false),
        const Option(
            text:
                'C. Investigación y ejecución, interpretación y formulación, argumentación',
            isCorrect: false),
        const Option(text: 'D. Todas las anteriores', isCorrect: false)
      ],
      imagen: ''),

  //Pregunta 4
  Question(
      text:
          '4. Los módulos específicos, como Diseño de Software, están dirigidos a ',
      options: [
        const Option(
            text:
                'A. Estudiantes que hayan aprobado por lo menos el 75 % de los créditos académicos del programa profesional universitario que cursan',
            isCorrect: false),
        const Option(
            text:
                'B. Quienes presentan el examen por primera vez y que sean inscritos directamente por su IES.',
            isCorrect: false),
        const Option(
            text: 'C. Cualquier persona que desee obtenerlos',
            isCorrect: false),
        const Option(text: 'D. A y B son ciertas', isCorrect: true)
      ],
      imagen: ''),

  //Pregunta 5
  Question(
      text: "5. El módulo Diseño de Software se oferta a los programas de ",
      options: [
        const Option(
            text: 'A. Ingeniería de sistemas, telemática y afines.',
            isCorrect: true),
        const Option(text: 'B. Ingeniería mecánica y afines', isCorrect: false),
        const Option(text: 'C. Ingeniería de alimentos', isCorrect: false),
        const Option(text: 'D. Derecho y arquitectura', isCorrect: false)
      ],
      imagen: ''),
];

final questionsSoc = [
  //Pregunta 1
  Question(
    text: "1. ¿Qué es el Diseño de Software? ",
    options: [
      const Option(
          text: 'A. Es el diseño que se le dan a los programas informáticos',
          isCorrect: false),
      const Option(
          text:
              'B. Es el conjunto de actividades TIC dedicadas al proceso de creación, despliegue y compatibilidad de software.',
          isCorrect: false),
      const Option(
          text:
              'C. Es la planificación de una solución de software, necesario para para disminuir el riesgo de desarrollos erróneos.',
          isCorrect: true),
      const Option(
          text:
              'D. Son el conjunto de actividades de software dedicadas al proceso de creación, diseño, despliegue y compatibilidad electrónica',
          isCorrect: false)
    ],
    imagen: '',
  ),

  //Pregunta 2
  Question(
      text:
          "2. Cuantas preguntas contiene la prueba de Desarrollo de Software del ICFES Saber PRO? ",
      options: [
        const Option(text: 'A. 25', isCorrect: false),
        const Option(text: 'B. 30', isCorrect: true),
        const Option(text: 'C. 35', isCorrect: false),
        const Option(text: 'D. 40', isCorrect: false)
      ],
      imagen: ''),

  //Pregunta 3
  Question(
      text:
          "3. Cuál es la estructura de evaluación del modulo(Tomado de la guia de orientacion de modulo de razonamiento cuantitativo saber pro 2016)",
      options: [
        const Option(
            text: 'A. Competencia, afirmación , evidencia ', isCorrect: true),
        const Option(
            text:
                'B. Análisis y comprensión, formulación y representación, interpretación y argumentación',
            isCorrect: false),
        const Option(
            text:
                'C. Investigación y ejecución, interpretación y formulación, argumentación',
            isCorrect: false),
        const Option(text: 'D. Todas las anteriores', isCorrect: false)
      ],
      imagen: ''),

  //Pregunta 4
  Question(
      text:
          '4. Los módulos específicos, como Diseño de Software, están dirigidos a ',
      options: [
        const Option(
            text:
                'A. Estudiantes que hayan aprobado por lo menos el 75 % de los créditos académicos del programa profesional universitario que cursan',
            isCorrect: false),
        const Option(
            text:
                'B. Quienes presentan el examen por primera vez y que sean inscritos directamente por su IES.',
            isCorrect: false),
        const Option(
            text: 'C. Cualquier persona que desee obtenerlos',
            isCorrect: false),
        const Option(text: 'D. A y B son ciertas', isCorrect: true)
      ],
      imagen: ''),

  //Pregunta 5
  Question(
      text: "5. El módulo Diseño de Software se oferta a los programas de ",
      options: [
        const Option(
            text: 'A. Ingeniería de sistemas, telemática y afines.',
            isCorrect: true),
        const Option(text: 'B. Ingeniería mecánica y afines', isCorrect: false),
        const Option(text: 'C. Ingeniería de alimentos', isCorrect: false),
        const Option(text: 'D. Derecho y arquitectura', isCorrect: false)
      ],
      imagen: ''),
];
