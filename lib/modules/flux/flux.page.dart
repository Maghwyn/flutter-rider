import 'package:flutter/material.dart';
import 'package:flutter_project/modules/parties/parties.controller.dart';
import 'package:flutter_project/modules/parties/parties.service.dart';
import 'package:get/get.dart';

class FluxPage extends StatelessWidget {
  const FluxPage({super.key});

  @override
  Widget build(BuildContext context) {
    PartiesController pc =
        Get.put(PartiesController(Get.put(PartiesService())));
    return Scaffold(
        body: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Flux d'activité",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Icon(
                      Icons.auto_graph_outlined,
                      color: Colors.purple,
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.grey[300],
                ),
                Column(
                  children: const [
                    Text(
                      "Last Parties",
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Expanded(
                  flex: 10,
                  child: Obx(
                    () => ListView(
                      children: pc.parties,
                    ),
                  ),
                ),
              ],
            )));
  }
}
