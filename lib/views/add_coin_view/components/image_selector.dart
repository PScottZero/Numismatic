import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numislog/components/my_elevated_button.dart';
import 'package:numislog/constants/view_constants.dart';
import 'package:numislog/model/app_model.dart';
import 'package:provider/provider.dart';

import 'deletable_image.dart';

class ImageSelector extends StatefulWidget {
  final List<String> existingImages;
  final Function(List<String>) callback;

  const ImageSelector({
    required this.existingImages,
    required this.callback,
    Key? key,
  }) : super(key: key);

  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  AppModel? modelRef;
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    _images = widget.existingImages;
  }

  _addImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      var base64 = base64Encode(await image.readAsBytes());
      setState(() {
        _images.add(base64);
        widget.callback(_images);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, model, child) {
        modelRef = model;
        return Column(
          children: [
            const SizedBox(height: ViewConstants.gapSmall),
            _images.isNotEmpty
                ? SizedBox(
                    height: 180,
                    child: ReorderableListView(
                      scrollDirection: Axis.horizontal,
                      onReorder: (oldIndex, newIndex) {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        setState(() {
                          _images.insert(newIndex, _images.removeAt(oldIndex));
                          widget.callback(_images);
                        });
                      },
                      children: _images.map(
                        (image) {
                          var index = _images.indexOf(image);
                          return Container(
                            key: Key('$index'),
                            margin: _images.indexOf(image) != _images.length - 1
                                ? const EdgeInsets.only(
                                    right: ViewConstants.gapSmall)
                                : EdgeInsets.zero,
                            child: DeletableImage(
                              image: base64Decode(image),
                              onDelete: () {
                                setState(() {
                                  _images.removeAt(index);
                                  widget.callback(_images);
                                });
                              },
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  )
                : const Text('No Images'),
            MyElevatedButton(
              label: 'Upload Images',
              onPressed: _addImage,
            ),
            const SizedBox(height: ViewConstants.gapLarge),
          ],
        );
      },
    );
  }
}
