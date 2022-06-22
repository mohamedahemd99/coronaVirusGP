// @dart=2.9
import 'package:covid_infected_helper/core/business_logic/auth_provider.dart';
import 'package:covid_infected_helper/core/business_logic/layout_provider.dart';
import 'package:covid_infected_helper/core/business_logic/news_provider.dart';
import 'package:covid_infected_helper/ui/screens/Home/launcher.dart';
import 'package:covid_infected_helper/ui/screens/info.dart';
import 'package:covid_infected_helper/ui/screens/quests/questions.dart';
import 'package:covid_infected_helper/ui/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants.dart';
import '../articles/articles.dart';
import '../articles/aticles_page.dart';
import '../articles/cards/cards.dart';

class HomeScreen extends StatefulWidget {
  bool isAppbar;

  HomeScreen({Key key, this.isAppbar = false}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppbar ? buildAppBar() : null,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        children: [
          //design of app bar
          Container(
            height: 20,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          //for linkat
          Container(
            margin: const EdgeInsets.all(20),
            height: 226,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 8),
                  blurRadius: 24,
                  color: shadow,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                const Text('Covid Infected Helper.', style: subtxtStyle),
                const SizedBox(height: 8),
                //link of ministry page
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const URLLauncher())),
                  child: const CoverLink(
                    text: 'To get the vaccine, please click here',
                  ),
                ),
                const SizedBox(height: 15),
                //link for questions
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Questions(

                          ))),
                  child: const CoverLink(
                    text: 'Check your self after taking vaccine',
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Just for You.', style: subtxtStyle),
                const SizedBox(height: 8),
              ],
            ),
          ),
          free,
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Type Of Masks",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    decoration: TextDecoration.underline)),
          ),
          Provider.of<LayOutProvider>(context,listen: false).masks!=null?
          SizedBox(
            height: 350,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10,
                    child: Container(
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            Provider.of<LayOutProvider>(context)
                                .masks[index]
                                .image,
                            height: 150,
                            width: 300,
                            fit: BoxFit.cover,
                          ),
                          free,
                          Text(
                            "${Provider.of<LayOutProvider>(context).masks[index].title}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          free,
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${Provider.of<LayOutProvider>(context).masks[index].desc}",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10,
                  );
                },
                itemCount: Provider.of<LayOutProvider>(context).masks.length),
          ):Center(child: Text("Loading")),

          free,
          //الاعراض
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Cards of most common Symptoms
                  SymptomCard(
                      image: "images/characters/fever1.png",
                      title: "Fever",
                      press: () {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Some herbs to get rid of Fever',
                                  style: titleStyle,
                                ),
                                content: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      right: -40,
                                      top: -40,
                                      child: InkResponse(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: icons,
                                          child: Icon(Icons.close),
                                        ),
                                      ),
                                    ),
                                    Form(
                                        key: formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Ginger",
                                                style: subtxtStyle,
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Divider(color: mainColor),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Mint",
                                                style: subtxtStyle,
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Divider(color: mainColor),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Basil",
                                                style: subtxtStyle,
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Divider(color: mainColor),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Coriander",
                                                style: subtxtStyle,
                                              ),
                                            ),
                                            //button
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: InkResponse(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 200,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                    color: mainColor,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                      'OK',
                                                      style:
                                                          titleStyle.copyWith(
                                                              color:
                                                                  txtButtons),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              );
                            });
                      }),
                  SizedBox(
                    width: 20,
                  ),
                  SymptomCard(
                      image: "images/characters/cough.png",
                      title: "Cough",
                      press: () {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Container(
                                  decoration: const BoxDecoration(
                                    backgroundBlendMode: BlendMode.softLight,
                                    color: mainColor,
                                  ),
                                  child: const Text(
                                    'Some herbs to get rid of Cough',
                                    style: titleStyle,
                                  ),
                                ),
                                content: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      right: -40,
                                      top: -80,
                                      child: InkResponse(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: icons,
                                          child: Icon(Icons.close),
                                        ),
                                      ),
                                    ),
                                    Form(
                                        key: formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Ginger",
                                                  style: subtxtStyle),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Divider(color: mainColor),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Mint",
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Divider(color: mainColor),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Zaatar",
                                                  style: subtxtStyle),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Divider(color: mainColor),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("tea with honey",
                                                  style: subtxtStyle),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: InkResponse(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 200,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                    color: mainColor,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                      'OK',
                                                      style:
                                                          titleStyle.copyWith(
                                                              color:
                                                                  txtButtons),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              );
                            });
                      }),
                  SizedBox(
                    width: 20,
                  ),
                  SymptomCard(
                      image: "images/characters/exhaution.png",
                      title: "Exhaution",
                      press: () {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Some herbs to get rid of Exhaution',
                                  style: titleStyle,
                                ),
                                content: Stack(
                                  // overflow: Overflow.visible,
                                  children: [
                                    Positioned(
                                      right: -40,
                                      top: -40,
                                      child: InkResponse(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: icons,
                                          child: Icon(Icons.close),
                                        ),
                                      ),
                                    ),
                                    Form(
                                        key: formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Green tea",
                                                  style: subtxtStyle),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Divider(color: mainColor),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Mint",
                                                  style: subtxtStyle),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Divider(color: mainColor),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Rosemary",
                                                  style: subtxtStyle),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Divider(color: mainColor),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Sage",
                                                  style: subtxtStyle),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: InkResponse(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 200,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                    color: mainColor,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                      'OK',
                                                      style:
                                                          titleStyle.copyWith(
                                                              color:
                                                                  txtButtons),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              );
                            });
                      }),
                  SizedBox(
                    width: 20,
                  ),
                  SymptomCard(
                      image: "images/characters/headache.png",
                      title: "Headache",
                      press: () {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Some herbs to get rid of Headache',
                                  style: titleStyle,
                                ),
                                content: Stack(
                                  // overflow: Overflow.visible,
                                  children: [
                                    Positioned(
                                      right: -40,
                                      top: -40,
                                      child: InkResponse(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: icons,
                                          child: Icon(Icons.close),
                                        ),
                                      ),
                                    ),
                                    Form(
                                        key: formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Cinnamon",
                                                  style: subtxtStyle),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Divider(color: mainColor),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Mint",
                                                  style: subtxtStyle),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Divider(color: mainColor),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Galic",
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Divider(color: mainColor),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Turmeric",
                                                  style: subtxtStyle),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Divider(color: mainColor),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Clove",
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              child: Divider(color: mainColor),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("Basil",
                                                  style: subtxtStyle),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: InkResponse(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 200,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                    color: mainColor,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                      'OK',
                                                      style:
                                                          titleStyle.copyWith(
                                                              color:
                                                                  txtButtons),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              );
                            });
                      }),
                ],
              )),
          free,
          //the updates in home page
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Statistic(),
          ),
          //text Articles
          free,

          free,
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  //Cards of less common Symptoms
                  SymptomCard(
                    image: "images/characters/diarhea.png",
                    title: "Diarhea",
                    isActive: true,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SymptomCard(
                    image: "images/characters/rash.png",
                    title: "Rash",
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SymptomCard(
                    image: "images/characters/breath difficult.png",
                    title: "Breathing difficulty",
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SymptomCard(
                    image: "images/characters/aches & pains.png",
                    title: "Aches and Pains",
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SymptomCard(
                    image: "images/characters/sore throat.png",
                    title: "Sore throat",
                  ),
                ],
              )),
          free,
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 20,
            ),
            child: TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ArticlePage())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('ARTICLES:', style: titleStyle.copyWith(color: icons)),
                ],
              ),
            ),
          ),
          //articles body
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * .5,
              color: bg,
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) => Cards(
                  article: articles[index],
                  itemIndex: index,
                  Press: () {},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//for links in the page.
class CoverLink extends StatelessWidget {
  const CoverLink({
    Key key,
    this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: mainColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: titleStyle.copyWith(color: bg),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                Icons.arrow_right_rounded,
                color: icons,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Statistic extends StatelessWidget {
  Statistic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<NewsProvider>(context).summaryModel != null
        ? Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              //side: BorderSide(color: Colors.black,),
            ),
            child: Column(
              children: [
                //header of first card
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.info_outline,
                        color: icons,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Covid-19 Cases",
                        style: titleStyle,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(),
                ),
                //subheader of first Card
                Padding(
                  padding:
                      const EdgeInsets.only(top: 4.0, left: 12.0, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text("Global States", style: headerStyle),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 6.0, bottom: 4, left: 16),
                  child: Row(
                    children: [
                      const Text(
                        "Last Updated :",
                        style: subtxtStyle,
                      ),
                      Text(
                        Provider.of<NewsProvider>(context)
                            .summaryModel
                            .date
                            .substring(0, 10),
                        style: subtxtStyle.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                titleWidget(
                    'Confirmed',
                    '${Provider.of<NewsProvider>(context).summaryModel.global.newConfirmed}',
                    Colors.blue),
                titleWidget(
                    'Recovered',
                    '${Provider.of<NewsProvider>(context).summaryModel.global.newRecovered}',
                    Colors.green),
                titleWidget(
                    'Deaths',
                    '${Provider.of<NewsProvider>(context).summaryModel.global.newDeaths}',
                    Colors.red),
                // Padding(
                //   padding: const EdgeInsets.all(20.0),
                //   child: Container(
                //     height: 80,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(4),
                //       color: Colors.black87,
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         titleContainer(
                //           "Recovered Rate",
                //           "20.20 %",
                //           Colors.green,
                //         ),
                //         titleContainer("Deaths Rate", "3.14 %", Colors.red),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}

Widget titleContainer(title, subtitle, color) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        subtitle,
        style: subtxtStyle.copyWith(color: color),
      ),
      Text(
        title,
        style: titleStyle.copyWith(color: color),
      ),
    ],
  );
}

Widget titleWidget(title, subtitle, color) {
  return ListTile(
    title: Text(
      title,
      style: titleStyle.copyWith(color: color),
    ),
    trailing: Text(
      subtitle,
      style: subtxtStyle.copyWith(color: color),
    ),
  );
}
