import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
            child: Text(
              'CRIAR CONTA',
              style: TextStyle(fontSize: 15),
            ),
            textColor: Colors.white,
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: _emailController,
                  validator: (text) {
                    if (text.isEmpty || !text.contains('@'))
                      return 'E-mail inválido!';
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _senhaController,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return 'Senha inválida!';
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Insira seu e-mail para a recuperação!',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        model.recoverPass(_emailController.text);
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Confira seu e-mail!',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Esqueci minha senha',
                      textAlign: TextAlign.right,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                      model.signIn(
                          email: _emailController.text,
                          senha: _senhaController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail);
                    },
                    child: Text(
                      'ENTRAR',
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Falha ao entrar!',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
