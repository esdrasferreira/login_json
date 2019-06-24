import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'produto.dart';

class ProdutosPage extends StatefulWidget {
  static String tag = 'ProdutosPage';
  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  var produtos = List<Produto>();

  bool isLoading = false;

  Future<void> _getProdutos() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      Response response = await Dio().get('https://javaworld.com.br/produtos');

      print(response.data);

      Iterable list = response.data;

      setState(() {
        isLoading = false;
        produtos = list.map((model) => Produto.fromJson(model)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista'),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                alignment: Alignment.center,
                color: Colors.black12,
                child: ListView.builder(
                    itemCount: produtos.length,
//            shrinkWrap: true,
                    padding: EdgeInsets.all(40),
                    itemBuilder: (context, i) {
                      return Container(
                        child: Text(
                          produtos[i].nome,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      );
                    }),
              ));
  }
}
