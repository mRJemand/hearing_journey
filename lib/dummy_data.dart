import 'package:hearing_journey/models/place.dart';

import 'models/tipp.dart';
import 'models/question.dart';

// const DUMMY_QUESTIONS = const [
//   Question(
//       id: 1,
//       question:
//           "Ich habe keine Schwierigkeiten beim Hören, an denen etwas geändert werden müsste.",
//       category: "Precontemplation"),
//   Question(
//       id: 2,
//       question:
//           "Ich glaube, dass ich bereit bin, bei mir selber etwas zu verändern.",
//       category: "Contemplation"),
//   Question(
//       id: 3,
//       question:
//           "Ich setze mich mit den Schwierigkeiten beim Hören auseinander, die mich belasten.",
//       category: "Action"),
//   Question(
//       id: 4,
//       question:
//           "Es könnte sich lohnen, meine Schwierigkeiten beim Hören anzugehen.",
//       category: "Contemplation"),
//   Question(
//       id: 5,
//       question:
//           "Ich habe keine Hörschwierigkeiten. Es macht nicht viel Sinn, dass ich einen Arzt oder Hörakustiker aufsuche.",
//       category: "Precontemplation"),
//   // Question(
//   //     id: 6,
//   //     question:
//   //         "Endlich habe ich angefangen, an meinen Hörschwierigkeiten zu arbeiten.",
//   //     category: "Action"),
//   Question(
//       id: 7,
//       question:
//           "Ich habe schon daran gedacht, dass ich etwas bei mir verändern möchte.",
//       category: "Contemplation"),
//   Question(
//       id: 8,
//       question:
//           "Manchmal fühle ich mich mit meinen Hörschwierigkeiten überfordert, aber ich arbeite daran.",
//       category: "Action"),
//   // Question(
//   //     id: 9,
//   //     question:
//   //         "Einen Arzt oder Hörakustiker aufzusuchen, ist eigentlich eine Zeit-verschwendung, denn Schwierigkeiten beim Hören haben nichts mit mi",
//   //     category: "Precontemplation"),
//   Question(
//       id: 10,
//       question:
//           "Ich hoffe, ich erhalte bei einem Hörakustiker oder einem Arzt Hilfe, um mich besser zu verstehen.",
//       category: "Contemplation"),
//   Question(
//       id: 11,
//       question:
//           "Ich denke schon, dass ich Schwierigkeiten beim Hören habe, aber es gibt nichts, das ich wirklich verändern müsste.",
//       category: "Precontemplation"),
//   // Question(
//   //     id: 12,
//   //     question: "Ich gebe mir wirklich Mühe, etwas bei mir zu verändern.",
//   //     category: "Action"),
//   Question(
//       id: 13,
//       question:
//           "Ich habe Hörschwierigkeiten, und ich bin überzeugt, dass ich daran arbeiten sollte.",
//       category: "Contemplation"),
//   // Question(
//   //     id: 14,
//   //     question:
//   //         "Obwohl es mir nicht immer gelingt, etwas zu verändern, arbeite ich wenigstens an meinem Hörproblem.",
//   //     category: "Action"),
//   Question(
//       id: 15,
//       question:
//           "Ich wünschte, ich hätte mehr Ideen, wie ich mein Hörproblem lösen könnte.",
//       category: "Contemplation"),
//   Question(
//       id: 16,
//       question:
//           "Ich habe angefangen, meine Hörschwierigkeiten anzugehen, aber ich brauche dazu Unterstützung.",
//       category: "Action"),
//   // Question(
//   //     id: 17,
//   //     question: "Vielleicht kann mir ein Hörakustiker oder Arzt helfen.",
//   //     category: "Contemplation"),
//   Question(
//       id: 18,
//       question:
//           "Vielleicht haben die Schwierigkeiten beim Hören mit mir zu tun, aber ich glaube es eigentlich nicht.",
//       category: "Precontemplation"),
//   // Question(
//   //     id: 19,
//   //     question:
//   //         "Ich hoffe, dass mich ein Hörakustiker oder Arzt gut beraten wird.",
//   //     category: "Contemplation"),
//   Question(
//       id: 20,
//       question:
//           "Jeder kann über Veränderung reden; ich aber tue wirklich etwas.",
//       category: "Action"),
//   // Question(
//   //     id: 21,
//   //     question:
//   //         "Psychologisches Gerede finde ich langweilig. Warum kann man seine Hörschwierigkeiten nicht einfach vergessen?",
//   //     category: "Precontemplation"),
//   Question(
//       id: 22,
//       question:
//           "Ich habe schon Schwierigkeiten beim Hören, aber die haben andere auch. Warum Zeit verschwenden, darüber nachzudenken?",
//       category: "Precontemplation"),
//   Question(
//       id: 23,
//       question: "Ich bin aktiv daran, meine Hörschwierigkeiten anzugehen.",
//       category: "Action"),
//   Question(
//       id: 24,
//       question:
//           "Ich möchte mich lieber mit meinen Schwierigkeiten beim Hören akzeptieren, als etwas daran zu ändern.",
//       category: "Precontemplation")
// ];

const DUMMY_PLACES = const [
  Place(
    id: '1',
    title: 'Alltag',
    description:
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
    imageUrl:
        'https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
  ),
  Place(
    id: '2',
    title: 'Bei der Arbeit',
    description:
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
    imageUrl:
        'https://images.unsplash.com/photo-1586281380349-632531db7ed4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8YXJiZWl0fGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
  ),
  Place(
    id: '3',
    title: 'Hilfe holen',
    description:
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
    imageUrl:
        'https://images.unsplash.com/photo-1544027993-37dbfe43562a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
  ),
  Place(
    id: '4',
    title: 'Kommunikation',
    description:
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
    imageUrl:
        'https://images.unsplash.com/uploads/1413222992504f1b734a6/1928e537?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
  ),
  Place(
    id: '5',
    title: 'Reisen',
    description:
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
    imageUrl:
        'https://images.unsplash.com/photo-1504542982118-59308b40fe0c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
  ),
  Place(
    id: '6',
    title: 'Unterhaltung und Kultur',
    description:
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
    imageUrl:
        'https://images.unsplash.com/photo-1603739903239-8b6e64c3b185?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1171&q=80',
  ),
  Place(
    id: '7',
    title: 'Unterwegs',
    description:
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
    imageUrl:
        'https://images.unsplash.com/photo-1516997121675-4c2d1684aa3e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1744&q=80',
  ),
  Place(
    id: '8',
    title: 'Zu Hause',
    description:
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
    imageUrl:
        'https://images.unsplash.com/photo-1587433701752-78cbf88ae429?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1169&q=80',
  ),
];
