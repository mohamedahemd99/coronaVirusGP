// @dart=2.9
import 'package:covid_infected_helper/constants.dart';
import 'package:flutter/material.dart';
import '../articles.dart';

class Cards extends StatelessWidget {
  const Cards({
    Key key,
    this.Press,
    this.article,
    this.itemIndex,
  }) : super(key: key);
  final int itemIndex; //card nubmber
  final Function Press; //function of clickking on card
  final Article article; //items body of each card
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Press,
      child: CardDesign(
        image: article.photo,
        title: article.title,
        text: article.subTitle,
      ),
    );
  }
}

class CardDesign extends StatelessWidget {
  const CardDesign({Key key, this.title, this.image, this.text})
      : super(key: key);
  final String title, image, text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: size.height * .21,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 8),
                blurRadius: 24,
                color: shadow,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: size.height * .21,
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.fill,
              ),
              width: size.width / 3 - 15,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: FittedBox(
                      child: SizedBox(
                        child: Text(
                          title,
                          maxLines: 4,
                          style: titleStyle.copyWith(
                              overflow: TextOverflow.ellipsis),
                        ),
                        width: size.width / 2.14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: FittedBox(
                      child: SizedBox(
                        child: Text(
                          text,
                          maxLines: 7,
                          style: subtxtStyle,
                        ),
                        width: size.width / 2.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_right_rounded,
              color: icons,
              size: 40,
            ),
          ]),
        ),
      ),
    );
  }
}
