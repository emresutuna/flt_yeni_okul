import 'dart:io';

import 'package:baykurs/util/YOColors.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';
class ForceUpdateService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> checkForUpdate(BuildContext context) async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ),
    );
    await _remoteConfig.fetchAndActivate();

    final forceUpdate = _remoteConfig.getBool('force_update_required');
    final minVersion = _remoteConfig.getString('minimum_version');
    print('MINIMUM VERSION: $minVersion');

    // ✅ Platforma göre farklı update URL al
    final updateUrl = Platform.isAndroid
        ? _remoteConfig.getString('update_url_android')
        : _remoteConfig.getString('update_url_ios');
    final currentVersion = (await PackageInfo.fromPlatform()).version;
    print('CURRENT VERSION: $currentVersion');

    if (forceUpdate && Version.parse(currentVersion) < Version.parse(minVersion)) {
      print("Force update shown: $currentVersion < $minVersion");

      _showForceUpdateDialog(context, updateUrl);
    }else{
      print("No update needed. $currentVersion >= $minVersion");

    }
  }

  void _showForceUpdateDialog(BuildContext context, String updateUrl) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Güncellemelerimiz Var',style: styleBlack16Bold,),
        content: Text('Yüz yüze eğitimin özgün modelini en iyi haliyle kullanabilmen için uygulamayı güncellemen gerekiyor.',style: styleBlack14Regular,),
        actions: [
          TextButton(
            onPressed: () {
              launchUrl(Uri.parse(updateUrl), mode: LaunchMode.externalApplication);
            },
            child: Text('Güncelle',style: styleBlack14Bold.copyWith(color: color5),),
          ),
        ],
      ),
    );
  }
}
