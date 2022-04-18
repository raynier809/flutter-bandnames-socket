import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:band_name/services/socket_service.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context, listen: true);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ServerStatus: ${socketService.serverStatus}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: () {
          //Tarea
          socketService.socket.emit('nuevo-mensaje',
              {'nombre': 'Raynier', 'mensaje': 'desde flutter'});
        },
      ),
    );
  }
}
