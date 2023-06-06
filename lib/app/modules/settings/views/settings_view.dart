import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ultimate_alarm_clock/app/utils/constants.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var height = Get.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    Get.defaultDialog(
                        titlePadding: EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: ksecondaryBackgroundColor,
                        title: 'API Key',
                        titleStyle: Theme.of(context).textTheme.displaySmall,
                        content: Column(
                          children: [
                            TextField(
                              obscureText: false,
                              controller: controller.apiKey,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              kprimaryColor)),
                                  child: Text(
                                    'Save',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(color: ksecondaryTextColor),
                                  ),
                                  onPressed: () async {
                                    try {
                                      await controller.getLocation();
                                      if (await controller.isApiKeyValid(
                                          controller.apiKey.text)) {
                                        await controller.addKey(
                                            ApiKeys.openWeatherMap,
                                            controller.apiKey.text);
                                        Get.snackbar(
                                            'Success!', "API Key Added!");
                                      } else {
                                        Get.snackbar(
                                            'Error', "Invalid API Key!");
                                      }
                                    } catch (e) {
                                      Get.snackbar(
                                          'Error', "Failed to save API key!");
                                    }
                                  }),
                            )
                          ],
                        ));
                  },
                  child: Container(
                    width: width * 0.91,
                    height: height * 0.1,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        color: ksecondaryBackgroundColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Open Weather Map API',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: kprimaryTextColor,
                                  ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: kprimaryTextColor.withOpacity(0.2),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}