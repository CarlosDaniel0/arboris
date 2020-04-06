# Arboris

Mapeamento colaborativo

## Informações do projeto

Esse é um projeto desenvolvido em colaboração dos alunos do curso Técnica em Informática de Monsenhor Gil - PI,

## Como funciona

Os dados são coletados e enviados para o [Cloud Firestore](https://firebase.google.com/docs/firestore?hl=pt-br) e com ajuda da [API do Google Maps](https://cloud.google.com/maps-platform/?hl=pt&utm_source=google&utm_medium=cpc&utm_campaign=FY18-Q2-global-demandgen-paidsearchonnetworkhouseads-cs-maps_contactsal_saf&utm_content=text-ad-none-none-DEV_c-CRE_320067021998-ADGP_Hybrid+%7C+AW+SEM+%7C+BKWS+~+Google+Maps+API+BMM-KWID_43700039748702552-kwd-299558370646-userloc_20100&utm_term=KW_%2Bgooglemaps%20%2Bapi-ST_%2Bgooglemaps+%2Bapi&gclid=CjwKCAjwpqv0BRABEiwA-TySwfL88I-Xmr3B3_TDUnZQGHNeuihXiifKEc0AetGALeU45unoeKyvVxoCR7QQAvD_BwE) são disponibilizados para o usuário.
os marcadores são gerados dinamicamente de acordo com os dados recebidos pelo StreamBuilder e são colocados no mapa.

* Esse processo está disposto na página home.dart do app

### Receber dados do Cloud Firestore 

```
StreamBuilder(
  stream: _arvoresArmazenadas,
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Center(child: Text("Erro: ${snapshot.error}"));
    } 
    if (!snapshot.hasData) {
      return Center(
        child:  CircularProgressIndicator(
          value: snapshot.data != null ? 
          snapshot.data.cumulativeBytesLoaded / snapshot.data.expectedTotalBytes : 
          null,
      ));
    }

    return MapaArmazenado(
          documents: snapshot.data.documents,
          initialPosition: const LatLng(-5.565041, -42.608059),
          pinLocationIcon: pinLocationIcon,
        );
  })
```

### Marcadores Dinâmicos 

```
return GoogleMap(
  compassEnabled: true,
  onMapCreated: (GoogleMapController controller) {
  },
  initialCameraPosition: CameraPosition(
    target: initialPosition,
    zoom: 14.5
  ),
  markers: documents
    .map((document) => Marker(
      markerId: MarkerId("${document['idArvore']}"),
      icon: pinLocationIcon,
      position: LatLng(
        document['localizacao'].latitude,
        document['localizacao'].longitude
        ) 
      )
    )).toSet()
);
```

O projeto ainda encontra-se em fase inicial por isso podem ocorrer alguns bugs.

## Imagens utilizadas 

Todas as imagens utilizadas estão disponíveis no Google Drive:
[Acessar Google Drive](https://drive.google.com/drive/folders/1QuQ-9eSuAs0UYsxOFNTdGnxSXXHFJKuf)


## Contribuir

Deseja contribuir com o projeto baixe o app e mande sua sujestão na aba contribuir.

Ou envie-nos um e-mail com dúvidas e sugestões. projetoarboris@gmail.com
