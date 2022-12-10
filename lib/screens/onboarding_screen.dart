import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:onboarding/screens/home_screen.dart';
import 'package:onboarding/widgets/custom_button.dart';
import 'package:onboarding/widgets/custom_link.dart';
import 'package:onboarding/widgets/custom_paginator.dart';
import 'package:onboarding/widgets/custom_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding_Screen extends StatefulWidget {
  const Onboarding_Screen({super.key});

  @override
  State<Onboarding_Screen> createState() => _Onboarding_ScreenState();
}

class _Onboarding_ScreenState extends State<Onboarding_Screen> {

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFF7CD),
      body: SafeArea(
        child: Stack(children: [
          
          PageView(
            controller: _pageController,
            onPageChanged: (int page){
              setState(() {
                _currentPage = page;
              });
            },
            physics: ClampingScrollPhysics(),
            children: [
              CustomSlider(
                imagem: 'assets/onboarding-image-1.png',
                titulo: 'Sua Comida favorita',
                texto: 'Almoço, janta, cafézinho da manhã ou da tarde. A qual quer horário para atendimento.',
              ),
              CustomSlider(
                imagem: 'assets/onboarding-image-2.png',
                titulo: 'Você recebe no conforto de onde estiver',
                texto: 'Seu pedido é atendido pelo restaurante mais próximo, que leva tudo pra você.',
              ),
              CustomSlider(
                imagem: 'assets/onboarding-image-3.png',
                titulo: 'Melhores Chef’s',
                texto:
                    'Chefs, dos quais a maioria vem de restaurantes com estrelas Michelin ou são vencedores de competições de prestígio e títulos.',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 170.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPaginator(page: _currentPage)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  titulo: _currentPage == 2 ? 'QUERO CONHECER' : 'CONTINUAR',
                  irParaPaginaInicial: _currentPage == 2 ? irParaPaginaInicial : proximoCard,
                )
              ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLink(
                  titulo: 'Pular introdução', 
                  irParaPaginaInicial: irParaPaginaInicial
                )
              ]
            ),
          )
        ],),
      ),
    );
  }

  irParaPaginaInicial(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => HomeScreen())));
    _setStado();
  }
  proximoCard(){
    _pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeIn);
  }
  _setStado()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final ativo = prefs.getBool('ativo') ?? false;
    if(!ativo){
      await prefs.setBool('ativo', true);
    }
  }
}