// ignore: file_names
import 'package:flutter/material.dart';
import 'package:in_campus/models/Posts.dart';
import '../helper/hexColors.dart';

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    cursorColor: HexColor.fromHex('01579B'),
    style: TextStyle(color: HexColor.fromHex('01579B')),
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: HexColor.fromHex('01579B'),
        ),
        labelText: text,
        labelStyle: TextStyle(color: HexColor.fromHex('01579B')),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: HexColor.fromHex('E6E6E6'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        )),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container signInSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(70, 20, 70, 20),
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        child: Text(
          isLogin ? 'Se Connecter ' : 'S enregister',
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: HexColor.fromHex('01579B')),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return HexColor.fromHex('01579B');
              }
              return HexColor.fromHex('FFD15B');
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
      ));
}

class DismissKeyboard extends StatelessWidget {
  final Widget child;
  const DismissKeyboard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }

  Widget buildposts(Posts post) {
    return Container(
      padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20, right: 30),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(32),
        ),
        color: HexColor.fromHex('2F88FF'),
      ),
      child: Text(
        '${post.Created_by}' +
            '\n' +
            '${post.Created_at}' +
            '\n' +
            '${post.Contenu}',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
