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
          onTap: () {
            Clipboard.setData(
              ClipboardData(text: url,)
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

          // FlatButton(
          //   onPressed: () {
          //     // launch('$url');
          //   }, 
          //   onLongPress: () {
          //     },
          //   child: Icon(Icons.open_in_browser, color: Colors.white,)
          //   )
        ],
        leading: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          child: Icon(Icons.close, color: Colors.white)),
      ),
      body: Builder(
        builder: (context) {
          return WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: url,
            onPageFinished: (texto) {

            },
            onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('$url')) {
              print('Bloquear navegação para $request}');
              return NavigationDecision.prevent;
            }
            print('Permissão de navegação para $request');
            return NavigationDecision.navigate;
          },
          gestureNavigationEnabled: true,
          ); 
        },
      )
    );
  }

  void selecao(String escolha) {
    if (escolha == Constantes.copia) {
      Clipboard.setData(
        ClipboardData(text: url,)
      );
    } else if (escolha == Constantes.chrome) {
      launch(url);
    }
  }
}

