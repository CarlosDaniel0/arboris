import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'constantes.dart';
import 'package:url_launcher/url_launcher.dart';

class Navegador extends StatefulWidget {
  final String url;
  Navegador({Key key, @required this.url}):super(key: key);
  @override
  _NavegadorState createState() => _NavegadorState(url: url);
}

class _NavegadorState extends State<Navegador> {
  _NavegadorState({
    @required this.url
  });
  final String url;
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.text = url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () async {
            Clipboard.setData(
              ClipboardData(text: url,)
            );
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Texto copiado para área de trasnferência"))
            );
          },
          child: Text("$url")),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: selecao,
            itemBuilder: (context) {
              return Constantes.escolhas.map((String selecao) {
                return PopupMenuItem(
                  value: selecao,
                  child: Text(selecao),
                  );
              }).toList();
            }),
        ],
        leading: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          child: Icon(Icons.close, color: Colors.white)),
      ),
      body: 
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: url,
          onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
        gestureNavigationEnabled: true,
        ),
    );
  }

  void selecao(String escolha) async {
    if (escolha == Constantes.copia) {
      Clipboard.setData(
        ClipboardData(text: url,)
      );
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("Texto copiado para área de trasnferência"))
      );
    } else if (escolha == Constantes.chrome) {
      launch(url);
    }
  }
}

