import 'dart:ui';

import 'package:astro_tak/presentation/bloc/astro/astro_bloc.dart';
import 'package:astro_tak/presentation/theme/theme.dart';
import 'package:astro_tak/presentation/widgets/common_widgets.dart';
import 'package:astro_tak/presentation/widgets/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/categories.dart';

class AskQuestion extends StatefulWidget {
  AskQuestion({Key? key}) : super(key: key);

  @override
  _AskQuestionState createState() => _AskQuestionState();
}

const int _walletBalance = 0;

List<String> helpTexts = [
  "Personalized responses provided by our team of Vedic astrologers within 24 hours.",
  "You can seek answers to any part of your life and for most pressing issues. ",
  "Our team of Vedic astrologers will not just p answers but also suggest a remedial solution"
];

class _AskQuestionState extends State<AskQuestion> {
  late AstroBloc _astroBloc;

  @override
  void initState() {
    _astroBloc = context.read<AstroBloc>();
    _astroBloc.add(GetAskQuestionCategory());
    super.initState();
  }

  late List<Data> categories;
  late List<String> suggestions = categories[0].suggestions;
  late List<String> categoriesNames = categories.map((e) => e.name).toList();
  @override
  Widget build(BuildContext context) {
    Widget _buildBody(state) {
      categories = (state as AskQueCategoriesLoaded).categories.data;

      //Bottom banner card
      Widget _buildBottomBannerCard() {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
                color: CupertinoColors.systemIndigo,
                borderRadius: BorderRadius.circular(AppTheme.margin)),
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.margin * 2),
            height: 55,
            width: double.infinity,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "₹ 150 (1 Question on Love)",
                    style: TextStyle(color: Colors.white70),
                  ),
                  CustomButton1(
                    label: "Ask Now",
                    labelTextStyle: const TextStyle(
                        color: CupertinoColors.systemIndigo,
                        fontWeight: FontWeight.w100,
                        fontSize: 12),
                  )
                ]),
          ),
        );
      }

      //Top banner  card
      Widget _buildTopBannerCard() {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.margin * 2),
          height: 60,
          width: double.infinity,
          color: CupertinoColors.systemIndigo,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Wallet Balance : ₹ $_walletBalance",
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.white.withOpacity(.9),
                    ),
              ),
              CustomButton1(
                height: 30,
              ),
            ],
          ),
        );
      }

      Widget _buildTopInstructions() {
        return Container(
          width: double.infinity,
          child: Container(
            margin: const EdgeInsets.all(AppTheme.margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ask a Question",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: AppTheme.margin),
                Text(
                    "Seek accurate answers to your life problems and get guidance towards the right path. Whether the problem is related to love, self, life, business, money, education or work, our astrologers will do an in depth study of your birth chart to provide personalized responses along with remedies.",
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(height: AppTheme.margin * 2),
                Text(
                  "Choose Category",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: AppTheme.margin),
                CustomDropDown(
                  items: categoriesNames,
                  onChanged: (category) {
                    for (var element in categories) {
                      if (element.name == category) {
                        setState(() {
                          suggestions = element.suggestions.toList();
                        });
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }

      //Bottom instructions -
      Widget _buildBottomInstrutions() {
        return Column(
          children: [
            const Text(
                "Seeking accurate answers to difficult questions troubling your mind? Ask credible astrologers to know what future has in store for you."),
            const SizedBox(
              height: AppTheme.margin * 2,
            ),
            Container(
              padding: const EdgeInsets.all(AppTheme.margin * 1.5),
              color: const Color.fromARGB(52, 226, 154, 106),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (String element in helpTexts)
                    Container(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 6, top: 6),
                              height: 7.0,
                              width: 7.0,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 211, 138, 89),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Expanded(
                                child: Text(
                              element,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 211, 138, 89),
                              ),
                            )),
                          ]),
                    )
                ],
              ),
            )
          ],
        );
      }

      return Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppTheme.margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  _buildTopInstructions(),
                  const SizedBox(height: AppTheme.margin * 2),
                  const TextField(
                    maxLength: 150,
                    maxLines: 4,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      hintText: 'Type a question here',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(AppTheme.margin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ideas what to Ask (Select Any)",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: AppTheme.margin * 2),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return Row(
                                children: [
                                  Image.asset(
                                    "assets/images/question_mark.png",
                                    height: 20,
                                  ),
                                  const SizedBox(width: AppTheme.margin),
                                  Expanded(
                                    child: Text(
                                      suggestions[index],
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return const Divider(
                                thickness: 1.5,
                              );
                            },
                            itemCount: suggestions.length),
                        const SizedBox(
                          height: AppTheme.margin * 2,
                        ),
                        _buildBottomInstrutions()
                      ],
                    ),
                  ),
                  const SizedBox(height: 130),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildTopBannerCard(), _buildBottomBannerCard()],
          )
        ],
      );
    }

    Widget _buildLoading() {
      return const Text("Loading");
    }

    Widget _buildError(String error) {
      return Text(error);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Align(
        alignment: const Alignment(1, 0.85),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<AstroBloc, AstroState>(
        builder: (context, state) {
          if (state is AskQueCategoriesError) {
            return _buildError(state.error);
          } else if (state is AskQueCategoriesLoaded) {
            return _buildBody(state);
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }
}
