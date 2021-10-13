import 'dart:io';

import 'package:app_scaffold/domain/bloc/socket/socket_bloc_bloc.dart';
import 'package:app_scaffold/domain/entities/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    final socketBloc = context.read<SocketBloc>();
    socketBloc.socket.off('bandas-server');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bandas"),
        backgroundColor: Colors.red,
        actions: const [
          StatusIcon(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Grafica(),
            ListaBandas(),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: addNewBand,
        child: const Icon(
          Icons.add_box_sharp,
        ),
        elevation: 10,
      ),
    );
  }

  void addNewBand() {
    final TextEditingController textController = TextEditingController();

    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("New Banda Name"),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              onPressed: () => addBandToList(textController.text),
              child: const Text("Add"),
              elevation: 5,
              textColor: Colors.red,
            )
          ],
        ),
      );
      return;
    }
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: const Text("New Band"),
              content: CupertinoTextField(
                controller: textController,
              ),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text("Add"),
                  onPressed: () => addBandToList(textController.text),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text("Dissmiss"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ));
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      context.read<SocketBloc>().add(AddBand(name));
    }
    Navigator.pop(context);
  }
}

class Grafica extends StatelessWidget {
  const Grafica({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketBloc, SocketState>(
      builder: (context, state) {
        return SfCircularChart(series: <CircularSeries>[
          PieSeries<Band, String>(
            animationDelay: 1,
            animationDuration: 500,
            dataSource: state.bandas,
            xValueMapper: (Band data, _) => data.name,
            yValueMapper: (Band data, _) => data.votes,
            legendIconType: LegendIconType.circle,
            enableTooltip: true,
            // emptyPointSettings: EmptyPointSettings(
            //     borderColor: Colors.green, color: Colors.red),
            name: 'Bands',
            dataLabelMapper: (band, i) => band.name,
            dataLabelSettings: const DataLabelSettings(
                labelPosition:
                    ChartDataLabelPosition.outside, //?Posición de key
                color: Colors.black,
                isVisible: true,
                connectorLineSettings: ConnectorLineSettings(
                  color: Colors.blue,
                  type: ConnectorType.curve,
                )),
            groupMode: CircularChartGroupMode.point,
            explode: true,
            explodeAll: true,
            sortingOrder: SortingOrder.ascending,
            // emptyPointSettings: EmptyPointSettings(
            //   borderColor: Colors.grey,
            //   color: Colors.grey,
            //   borderWidth: 10,
            // ))
            groupTo: 10,
            // endAngle: 40,
            explodeGesture: ActivationMode.singleTap,
            explodeIndex: 40,
          )
        ]);
      },
    );
  }
}

class ListaBandas extends StatelessWidget {
  const ListaBandas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketBloc, SocketState>(
      builder: (context, state) {
        final bandas = state.bandas ?? [];
        return ListView.builder(
          shrinkWrap: true,
          itemCount: bandas.length,
          itemBuilder: (BuildContext context, int index) =>
              Banda(banda: bandas[index]),
        );
      },
    );
  }
}

class StatusIcon extends StatelessWidget {
  const StatusIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketBloc, SocketState>(
      builder: (context, state) {
        final connectado = state.status == ServerStatus.online;
        final message = connectado ? 'Conectado' : 'Sin conexión';
        return Container(
          padding: const EdgeInsets.only(right: 10),
          child: Tooltip(
            message: 'Server Status $message',
            child: Icon(
              state.status == ServerStatus.online
                  ? CupertinoIcons.bolt_horizontal
                  : CupertinoIcons.bolt_slash,
              size: 30,
            ),
          ),
        );
      },
    );
  }
}

class Banda extends StatelessWidget {
  const Banda({
    Key? key,
    required this.banda,
  }) : super(key: key);

  final Band banda;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        context.read<SocketBloc>().add(DeleteBand(banda));
      },
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.only(left: 10),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Delete",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      key: Key(banda.id),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red[100],
          child: Text(banda.name.substring(0, 2)),
        ),
        title: Text(banda.name),
        trailing: Text(
          "${banda.votes}",
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () => {
          context.read<SocketBloc>().add(VoteBand(banda)),
        },
      ),
    );
  }
}
