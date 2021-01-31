import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar conta'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              validator: (text) {
                if (text.isEmpty) return 'Nome inválido!';
              },
              decoration: InputDecoration(hintText: 'Nome completo'),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              validator: (text) {
                if (text.isEmpty || !text.contains('@'))
                  return 'E-mail inválido!';
              },
              decoration: InputDecoration(hintText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              validator: (text) {
                if (text.isEmpty || text.length < 6) return 'Senha inválida!';
              },
              decoration: InputDecoration(hintText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              validator: (text) {
                if (text.isEmpty) return 'Endereço inválido!';
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
                  if (_formKey.currentState.validate()) {}
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
      ),
    );
  }
}
