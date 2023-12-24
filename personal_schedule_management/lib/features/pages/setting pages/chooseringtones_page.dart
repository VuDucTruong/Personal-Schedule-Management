import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_schedule_management/core/constants/constants.dart';
import 'package:personal_schedule_management/features/controller/settings_controller.dart';
import 'package:recase/recase.dart';

class RingtonesPage extends StatefulWidget {
  const RingtonesPage({super.key});

  @override
  State<RingtonesPage> createState() => _RingtonesPageState();
}

class _RingtonesPageState extends State<RingtonesPage> {
  List<String> ringtones = [];
  AudioPlayer audioPlayer = AudioPlayer();
  SettingsController settingsController = SettingsController();
  String currentRingtone = DEFAULT_RINGTONE;
  bool hasCalledGetData = false;

  @override
  void initState() {
    getRingtones();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.stop();
    setRingtones();
    super.dispose();
  }

  Future<void> setRingtones() async {
    await settingsController.SetRingtone(currentRingtone);
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

  Future<void> getData() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    currentRingtone =
        await settingsController.GetRingtone() ?? DEFAULT_RINGTONE;
    if (currentRingtone == '') currentRingtone = DEFAULT_RINGTONE;
    Navigator.of(context, rootNavigator: true).pop();
    setState(() {});
    hasCalledGetData = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(builder: (context) {
        if (!hasCalledGetData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            getData(); // Gọi hàm getData sau khi frame đã hoàn thành
          });
        }
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text("Nhạc chuông"),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back,
                    size: 40, color: Theme.of(context).colorScheme.primary)),
          ),
          body: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: ringtones.length,
                    itemBuilder: (_, index) {
                      String ringtone = ringtones[index];
                      final String title = ringtone.substring(
                          ringtone.indexOf("ringtones").toInt() +
                              "ringtones".length,
                          ringtone.indexOf(".mp3"));
                      final ReCase rc = ReCase(title);
                      return Card(
                        child: RadioListTile(
                          secondary: const Icon(FontAwesomeIcons.music),
                          title: Text(rc.titleCase),
                          value: ringtone,
                          groupValue: currentRingtone,
                          toggleable: true,
                          onChanged: (String? newValue) async {
                            newValue ??= ringtone;
                            await audioPlayer.stop();
                            audioPlayer
                                .play(AssetSource(newValue.substring(7)));
                            setState(() {
                              currentRingtone = newValue ?? DEFAULT_RINGTONE;
                            });
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
