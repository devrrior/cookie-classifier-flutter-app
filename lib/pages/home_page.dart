import 'package:cookies_recognition_flutter_app/consts/assets_routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //   crear una pagina de inicio, donde se muestra un gif y abajo un boton para clasificar galleta
    // que hasta arriba este el titulo y gif, hasta abajo el boton
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cookies Recognition'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
              width: 300,
              image: AssetImage(cookieGifRoute),
            ),
            const SizedBox(height: 80),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cookie_photo_taker');
              },
              child: Text('Clasificar imagen'),
            ),
          ],
        ),
      ),
    );
  }
}
