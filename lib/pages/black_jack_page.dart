import 'dart:math';

import 'package:black_jack_game/widgets/boton_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/card_grid_widget.dart';

class BlackJackPage extends StatefulWidget {
  const BlackJackPage({super.key});

  @override
  State<BlackJackPage> createState() => _BlackJackPageState();
}

class _BlackJackPageState extends State<BlackJackPage> {
  bool _isGameStarted = false;

  // Listas con imágenes de las cartas
  List<Image> myCards = [];
  List<Image> dealersCards = [];

  // String que indica la carta que corresponde
  // Cartas en juego básicamente
  String? dealerFirstCard;
  String? dealerSecondCard;

  String? playersFirstCard;
  String? playersSecondCard;

  // Puntajes del dealer y player
  int dealersScore = 0;
  int playersScore = 0;

  // El mazo de cartas completo
  final Map<String, int> deck = {
    'assets/cards/2.1.png': 2,
    'assets/cards/2.2.png': 2,
    'assets/cards/2.3.png': 2,
    'assets/cards/2.4.png': 2,
    'assets/cards/3.1.png': 3,
    'assets/cards/3.2.png': 3,
    'assets/cards/3.3.png': 3,
    'assets/cards/3.4.png': 3,
    'assets/cards/4.1.png': 4,
    'assets/cards/4.2.png': 4,
    'assets/cards/4.3.png': 4,
    'assets/cards/4.4.png': 4,
    'assets/cards/5.1.png': 5,
    'assets/cards/5.2.png': 5,
    'assets/cards/5.3.png': 5,
    'assets/cards/5.4.png': 5,
    'assets/cards/6.1.png': 6,
    'assets/cards/6.2.png': 6,
    'assets/cards/6.3.png': 6,
    'assets/cards/6.4.png': 6,
    'assets/cards/7.1.png': 7,
    'assets/cards/7.2.png': 7,
    'assets/cards/7.3.png': 7,
    'assets/cards/7.4.png': 7,
    'assets/cards/8.1.png': 8,
    'assets/cards/8.2.png': 8,
    'assets/cards/8.3.png': 8,
    'assets/cards/8.4.png': 8,
    'assets/cards/9.1.png': 9,
    'assets/cards/9.2.png': 9,
    'assets/cards/9.3.png': 9,
    'assets/cards/9.4.png': 9,
    'assets/cards/10.1.png': 10,
    'assets/cards/10.2.png': 10,
    'assets/cards/10.3.png': 10,
    'assets/cards/10.4.png': 10,
    'assets/cards/J1.png': 10,
    'assets/cards/J2.png': 10,
    'assets/cards/J3.png': 10,
    'assets/cards/J4.png': 10,
    'assets/cards/Q1.png': 10,
    'assets/cards/Q2.png': 10,
    'assets/cards/Q3.png': 10,
    'assets/cards/Q4.png': 10,
    'assets/cards/K1.png': 10,
    'assets/cards/K2.png': 10,
    'assets/cards/K3.png': 10,
    'assets/cards/K4.png': 10,
    'assets/cards/A1.png': 11,
    'assets/cards/A2.png': 11,
    'assets/cards/A3.png': 11,
    'assets/cards/A4.png': 11,
  };

  // Cartas en juego
  Map<String, int> playingCards = {};

  @override
  void initState() {
    super.initState();
    playingCards.addAll(deck);
  }

  // Función para reiniciar el juego
  void startNewRound() {
    _isGameStarted = true;
    // Llena otra vez para empezar nuevo juego
    playingCards = {};
    playingCards.addAll(deck);

    // Reiniciar las listas de imágenes
    myCards = [];
    dealersCards = [];

    // **Generar un número al azar que apunta a una carta del mazo en juego,
    // **luego para evitar que salgan catas repetidas, se remueve del map playingCards
    Random random = Random();
    // Cartas uno y dos del dealer
    String cardOneKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == cardOneKey);
    String cardTwoKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == cardTwoKey);

    // Cartas uno (tres) y dos (cuatro) del jugador
    String cardThreeKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == cardThreeKey);
    String cardFourKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == cardFourKey);

    // Asignar las cartas
    dealerFirstCard = cardOneKey;
    dealerSecondCard = cardTwoKey;

    playersFirstCard = cardThreeKey;
    playersSecondCard = cardFourKey;

    // Agregar imágenes de dealer para mostrarlas en el gridview
    dealersCards.add(Image(image: AssetImage(dealerFirstCard!)));
    dealersCards.add(Image(image: AssetImage(dealerSecondCard!)));

    //Puntaje dealer
    dealersScore = deck[dealerFirstCard]! + deck[dealerSecondCard]!;

    // Agregar imágenes de player para mostrarlas en el gridview
    myCards.add(Image(image: AssetImage(playersFirstCard!)));
    myCards.add(Image(image: AssetImage(playersSecondCard!)));

    //Puntaje player
    playersScore = deck[playersFirstCard]! + deck[playersSecondCard]!;

    if (dealersScore <= 14) {
      String thirdDealerCard =
          playingCards.keys.elementAt(random.nextInt(playingCards.length));

      dealersCards.add(Image(image: AssetImage(thirdDealerCard)));

      dealersScore += deck[thirdDealerCard]!;

      playingCards.removeWhere((key, value) => key == thirdDealerCard);
    }

    setState(() {});
  }

  // Función para agregar cartas a los jugadores
  void addCard() {
    Random random = Random();

    if (playingCards.length > 0) {
      String cardKey =
          playingCards.keys.elementAt(random.nextInt(playingCards.length));

      playingCards.removeWhere(
        (key, value) => key == cardKey,
      );

      // Agrega una nueva carta a las cartas del jugador
      myCards.add(Image(image: AssetImage(cardKey)));

      playersScore = playersScore + deck[cardKey]!;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isGameStarted
          ? SafeArea(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Dealer\'s score: $dealersScore',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: dealersScore <= 21
                                  ? Colors.green
                                  : Colors.red),
                        ),
                        cardGrid(cards: dealersCards)
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Player\'s score: $playersScore',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: playersScore <= 21
                                  ? Colors.green
                                  : Colors.red),
                        ),
                        cardGrid(cards: myCards)
                      ],
                    ),
                    IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          botonWidget(onPressed: (){
                            addCard();}, label: 'Add Card'),
                          botonWidget(onPressed: (){
                            startNewRound();
                          }, label: 'New Round')
                        ],
                      ),
                    )
                  ]),
            )
          : Center(
              child: botonWidget(onPressed: () {
                startNewRound();
              },
              label: 'Start Game',)
            ),
    );
  }
}


