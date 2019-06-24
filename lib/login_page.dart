import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'produtos_page.dart';
import 'constantes.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffolddKey = GlobalKey<ScaffoldState>();
  final usuario = TextEditingController();
  final senha = TextEditingController();

  bool escondido = true;
  bool muda = true;
  void mudaIcone() {
    setState(() {
      escondido = !escondido;
      if (muda == true) {
        muda = false;
      } else {
        muda = true;
      }
    });
  }

  void _login(String usuario, String senha) async {
    try {
      Response response = await Dio().post('https://javaworld.com.br/logar',
          data: {"usuario": usuario, "senha": senha});

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, ProdutosPage.tag);
      }
    } on DioError catch (error) {
      print(error.toString());

      if (error.response.statusCode == 401) {
        final snackbar = SnackBar(
            content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Erro ao logar'),
            SizedBox(width: 20),
            Icon(Icons.error)
          ],
        ));
        _scaffolddKey.currentState.showSnackBar(snackbar);
      } else if (error.response.statusCode == 403) {
        final snackbar = SnackBar(
            content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Usuario não encontrado'),
            SizedBox(width: 20),
            Icon(Icons.error)
          ],
        ));
        _scaffolddKey.currentState.showSnackBar(snackbar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffolddKey,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24, right: 24),
          children: <Widget>[
            SizedBox(height: 50),
            EntradaLogin(usuario: usuario),
            SizedBox(height: 8),
            TextFormField(
              controller: senha,
              obscureText: muda,
              autofocus: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: entradaAtiva, width: 2),
                  borderRadius: BorderRadius.circular(32),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(color: entradaInativa, width: 2),
                ),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: mudaIcone,
                  icon: escondido
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
                hintText: 'senha',
                contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 5),
              child: Material(
                borderRadius: BorderRadius.circular(30),
                color: Colors.indigoAccent,
                child: MaterialButton(
                  splashColor: Colors.purple,
                  height: 42,
                  onPressed: () {
                    _login(usuario.text, senha.text);
                  },
                  child: Text(
                    'Log in',
                    style: kTextStyle,
                  ),
                ),
              ),
            ),
            FlatButton(
              child: Text(
                'Esqueceu a senha',
                style: kTextStyle,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class EntradaLogin extends StatelessWidget {
  const EntradaLogin({Key key, @required this.usuario}) : super(key: key);

  final TextEditingController usuario;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: usuario,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: entradaAtiva, width: 2),
            borderRadius: BorderRadius.circular(32)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: entradaInativa, width: 2),
            borderRadius: BorderRadius.circular(32)),
        prefixIcon: Icon(Icons.person_outline),
        hintText: 'usuário',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }
}
