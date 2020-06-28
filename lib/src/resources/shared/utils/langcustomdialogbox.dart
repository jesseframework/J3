import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:j3enterprise/src/resources/repositories/user_repository.dart';
import '../../../../main.dart';
const String ENGLISH = 'en';
const String SPANISH = 'es';
const String HINDI = 'sk';
const String LANGUAGE_CODE_KEY = 'languageCode';
String selecteditem = ENGLISH;

class LangCustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(top: 40),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              height: 70,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 18.0, left: 15),
                child: Text(
                  "Language",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            DropWid(selecteditem),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(width: 10.0),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 85,
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                      child: Text(
                        "OK",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 85,
                    alignment: Alignment.center,
                    color: Colors.grey.shade700,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                      child: Text(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

class DropWid extends StatefulWidget {
  final String list;

  DropWid(this.list);

  @override
  _DropWidState createState() => _DropWidState();
}

class _DropWidState extends State<DropWid> {
  @override
  void didChangeDependencies() async{
   await getIt<UserRepository>().getLocale().then((value) {
      setState(() {
        selecteditem = value.languageCode;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DropdownButton(
          isExpanded: true,
          value: selecteditem,
          items: [
            DropdownMenuItem(
              child: Text("English"),
              value: ENGLISH,
            ),
            DropdownMenuItem(
              child: Text('Spanish'),
              value: SPANISH,
            ),
            DropdownMenuItem(
              child: Text("Hindi"),
              value: HINDI,
            ),
          ],
          onChanged: _changeLanguage,
        ),
      ),
    );
  }

  void _changeLanguage(String language) async {
    Locale locale = await getIt<UserRepository>().setLocale(language);
    App.setLocale(context, locale);
    setState(() {
      selecteditem = language;
    });
  }
}

class Consts {
  Consts._();

  static const double padding = 12.0;
  static const double avatarRadius = 66.0;
}
