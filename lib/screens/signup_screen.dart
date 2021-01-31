import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _enderecoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Criar conta'),
        centerTitle: true,
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
                  controller: _nomeController,
                  validator: (text) {
                    if (text.isEmpty) return 'Nome inválido!';
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Nome completo'),
                ),
                SizedBox(
                  height: 16,
                ),
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
                  height: 16,
                ),
                TextFormField(
                  controller: _enderecoController,
                  validator: (text) {
                    if (text.isEmpty) return 'Endereço inválido!';
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Endereço'),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          'nome': _nomeController.text,
                          'email': _emailController.text,
                          'endereco': _enderecoController.text
                        };

                        model.signUp(
                            userData: userData,
                            senha: _senhaController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail);
                      }
                    },
                    child: Text(
                      'CRIAR CONTA',
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
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Usuário criado com sucesso!',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Falha ao criar usuário!',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
