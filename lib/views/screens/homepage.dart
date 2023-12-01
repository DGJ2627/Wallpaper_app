import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallpaper/Helper/api_helper.dart';
import 'package:wallpaper/Model/wallpaper_model.dart';


import '../../Global/Global_variable.dart';
import '../../Provider/plat_from.dart';
import '../../Provider/theme_provider.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true  ,
      appBar: AppBar(
        title: const Text("API"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          color: (Provider.of<theme_provider>(context).app_theme.isDark
              ? Colors.black
              : Colors.white),
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) => SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // camera
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            XFile? image =
                                                await picker.pickImage(
                                                    source: ImageSource.camera);
                                            Provider.of<Plat_form_convertor>(
                                                    BuildContext
                                                        as BuildContext,
                                                    listen: false)
                                                .change_img_camera(
                                                    File(image!.path));
                                            Navigator.of(BuildContext
                                                    as BuildContext)
                                                .pop();
                                          },
                                          icon: const Icon(
                                            Icons.flip_camera_ios_outlined,
                                            size: 40,
                                          ),
                                        ),
                                        const Text("Camera"),
                                      ],
                                    ),

                                    //gallery
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            XFile? image =
                                                await picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            Provider.of<Plat_form_convertor>(
                                                    context,
                                                    listen: false)
                                                .change_img_camera(
                                                    File(image!.path));
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(
                                            Icons.photo_outlined,
                                            size: 40,
                                          ),
                                        ),
                                        const Text("Gallery"),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 50,
                        foregroundImage: (imgfile != null)
                            ? FileImage(imgfile as File)
                            : null,
                        child: const Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: (Provider.of<theme_provider>(context).app_theme.isDark
                      ? Colors.white
                      : Colors.black),
                ),
                title: Text(
                  "Setting",
                  style: (Provider.of<theme_provider>(context).app_theme.isDark
                      ? const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)
                      : const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('setting_page');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.sunny,
                  color: (Provider.of<theme_provider>(context).app_theme.isDark
                      ? Colors.white
                      : Colors.black),
                ),
                title: Text(
                  "Theme",
                  style: (Provider.of<theme_provider>(context).app_theme.isDark
                      ? const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)
                      : const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('setting_page');
                },
                trailing: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Switch(
                      value:
                          Provider.of<theme_provider>(context).app_theme.isDark,
                      onChanged: (val) {
                        Provider.of<theme_provider>(context, listen: false)
                            .change_app_theme(val);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: Apihelper.apihelper.Getwallpaper(search: search),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<wallpapermodel> wallpaper = snapshot.data;
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onChanged: (val) {
                        setState(() {
                          search = val;
                        });
                        // Provider.of<search_provider>(context,listen: false).Image_Search(val);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                      childAspectRatio: 1/2,
                    ),
                    itemBuilder: (context, index) {
                      return ListView(
                        children: [
                          Container(
                            height: 300,
                            decoration:  BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(image: NetworkImage(wallpaper[index].largeimages),fit: BoxFit.cover)
                            ),
                          )
                        ],
                      );
                    },
                    itemCount: wallpaper.length,
                  ),
                ),
              ],
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("Assets/vegeta.gif"),
              const SizedBox(height: 50,),
              const Text("Check Your Internet"),
              const SizedBox(height: 50,),
              const CircularProgressIndicator(),
            ],
          );
        },
      ),
    );
  }
}
