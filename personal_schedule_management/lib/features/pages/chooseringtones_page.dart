import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';
import 'package:recase/recase.dart';

class RingtonesPage extends StatefulWidget {
  const RingtonesPage({super.key});

  @override
  State<RingtonesPage> createState() => _RingtonesPageState();
}

class _RingtonesPageState extends State<RingtonesPage> {
  List<String> ringtones = [];
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    getRingtones();
  }

  Future<void> getRingtones() async {
    var assetsFile =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(assetsFile);
    ringtones = manifestMap.keys
        .where((String key) => key.contains("ringtones/"))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Builder(
            builder: (context) => Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(FontAwesomeIcons.circleChevronLeft,
                            size: 40,
                            color: Theme.of(context).colorScheme.primary)),
                  ),
                  body: Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: ringtones.length,
                            itemBuilder: (_, index) {
                              final ringtone = ringtones[index];
                              final String title = ringtone.substring(
                                  ringtone.indexOf("ringtones").toInt() +
                                      "ringtones".length,
                                  ringtone.indexOf(".mp3"));
                              final ReCase rc = ReCase(title);
                              return Card(
                                child: ListTile(
                                  title: Text(rc.titleCase),
                                  onTap: () async {
                                    audioPlayer.play(
                                        AssetSource(ringtone.substring(7)));
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )));
  }
}
