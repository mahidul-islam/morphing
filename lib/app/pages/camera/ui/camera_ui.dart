import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morphing/app/bloc/notification/notification_bloc.dart';
import 'package:morphing/app/pages/camera/bloc/camera_bloc.dart';
import 'package:morphing/shared/util/loader.dart';

class CameraUI extends StatefulWidget {
  @override
  _CameraUIState createState() => _CameraUIState();
}

class _CameraUIState extends State<CameraUI> {
  late CameraBloc _bloc;
  XFile? _manImageFile;
  XFile? _petImageFile;

  File? _croppedMenImageFile, _croppedPetImageFile, _tempCropped;
  double _sliderDefaultValue = 5;

  @override
  void initState() {
    _bloc = CameraBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Face Morphing',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: BlocProvider<CameraBloc>(
          create: (BuildContext context) => _bloc,
          child: BlocConsumer<CameraBloc, CameraState>(
            listener: (BuildContext context, CameraState state) {
              // if (state is RegisterErrorState) {
              //   BlocProvider.of<NotificationBloc>(context)
              //       .add(ErrorNotificationEvent(state.error));
              // } else if (state is RegisterSuccessState) {
              //   // TODO : Navigate to profile
              // }
            },
            builder: (BuildContext context, CameraState state) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(width: 16),
                            _menImage(),
                            SizedBox(width: 16),
                            _petImage(),
                            SizedBox(width: 16),
                          ],
                        ),
                        SizedBox(height: 16),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 2,
                            color: Colors.amber),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: _getMorphButton(context),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 2,
                            color: Colors.amber),
                        _morphedImage(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _morphedImage() {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Container(
          width: (MediaQuery.of(context).size.width - 48) / 1.4,
          height: ((MediaQuery.of(context).size.width - 48) / 1.4),
          child: Image.asset(
            'assets/image/ready/sample/${_sliderDefaultValue.toInt()}.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: MediaQuery.of(context).size.width / 1.2,
          child: Slider(
            value: _sliderDefaultValue,
            onChanged: (double val) {
              setState(() {
                _sliderDefaultValue = val;
              });
            },
            min: 1,
            max: 39,
            activeColor: Colors.amberAccent,
            inactiveColor: Colors.amberAccent.withOpacity(0.5),
          ),
        ),
        SizedBox(height: 100),
      ],
    );
  }

  Widget _menImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Container(
          width: (MediaQuery.of(context).size.width - 48) / 2,
          height: ((MediaQuery.of(context).size.width - 48) / 2), // * (4 / 3),
          child: _croppedMenImageFile == null
              ? Image.asset(
                  'assets/image/ready/1.png',
                  fit: BoxFit.cover,
                )
              : Image.file(
                  _croppedMenImageFile!,
                  fit: BoxFit.cover,
                ),
        ),
        SizedBox(height: 16),
        MaterialButton(
          color: Colors.amberAccent,
          child: Text('Men'),
          onPressed: () {
            _showProfileUploadBottomSheet(men: true);
          },
        ),
      ],
    );
  }

  Widget _petImage() {
    return Column(
      children: [
        SizedBox(height: 16),
        Container(
          width: (MediaQuery.of(context).size.width - 48) / 2,
          height: ((MediaQuery.of(context).size.width - 48) / 2), // * (4 / 3),
          // color: SGColors.,
          child: _croppedPetImageFile == null
              ? Image.asset(
                  'assets/image/ready/pet.jpg',
                  fit: BoxFit.cover,
                )
              : Image.file(
                  _croppedPetImageFile!,
                  fit: BoxFit.cover,
                ),
        ),
        SizedBox(height: 16),
        MaterialButton(
          color: Colors.amberAccent,
          child: Text('Pet'),
          onPressed: () {
            _showProfileUploadBottomSheet(men: false);
          },
        ),
      ],
    );
  }

  Widget _getMorphButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      height: 56,
      // width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: RawMaterialButton(
        onPressed: () {
          // Navigator.of(context)
          //     .pushNamed(Routes.performance_time_in_zone_graph);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Morph it',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _takeFromGallery({required bool men}) async {
    final ImagePicker _picker = ImagePicker();
    String? _path;
    if (men) {
      _manImageFile = await _picker.pickImage(source: ImageSource.gallery);
      _path = _manImageFile?.path;
    } else {
      _petImageFile = await _picker.pickImage(source: ImageSource.gallery);
      _path = _petImageFile?.path;
    }
    _tempCropped = null;
    if (_path != null) {
      _tempCropped = await ImageCropper.cropImage(
        sourcePath: men ? _manImageFile!.path : _petImageFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Try To Focus Face',
            toolbarColor: Colors.amberAccent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        cropStyle: CropStyle.circle,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        maxHeight: 512,
        maxWidth: 512,
        iosUiSettings: IOSUiSettings(
          title: 'Try To Focus Face',
          minimumAspectRatio: 1.0,
        ),
      );
    }
    if (_tempCropped != null) {
      if (men) {
        _croppedMenImageFile = _tempCropped;
      } else {
        _croppedPetImageFile = _tempCropped;
      }
    }
    setState(() {});
    Navigator.of(context).pop();
  }

  Future<void> _cropImage({required bool men}) async {
    if (men && _croppedMenImageFile == null) {
      return;
    }
    if (!men && _croppedPetImageFile == null) {
      return;
    }
    _tempCropped = null;
    if (men && _croppedMenImageFile != null) {
      _tempCropped = await ImageCropper.cropImage(
        sourcePath:
            men ? _croppedMenImageFile!.path : _croppedPetImageFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Try To Focus Face',
            toolbarColor: Colors.amberAccent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        cropStyle: CropStyle.circle,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        maxHeight: 512,
        maxWidth: 512,
        iosUiSettings: IOSUiSettings(
          title: 'Try To Focus Face',
          minimumAspectRatio: 1.0,
        ),
      );
    }
    if (_tempCropped != null) {
      if (men) {
        _croppedMenImageFile = _tempCropped;
      } else {
        _croppedPetImageFile = _tempCropped;
      }
    }
    setState(() {});
    Navigator.of(context).pop();
  }

  Future<void> _removeProfilePhoto({required bool men}) async {
    if (men) {
      _croppedMenImageFile = null;
    } else {
      _croppedPetImageFile = null;
    }
    setState(() {});
    Navigator.of(context).pop();
  }

  dynamic _showProfileUploadBottomSheet({required bool men}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) => Container(
        margin: const EdgeInsets.only(
          top: 36,
        ),
        height: 290 + MediaQuery.of(context).padding.bottom,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(
                bottom: 16,
                right: 20,
                left: 20,
              ),
              child: Text(
                'Update Photo',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              onPressed: () => null,
              child: Container(
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        '• Open Camera',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            MaterialButton(
              onPressed: () => _takeFromGallery(men: men),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 48,
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        '• Select from Gallery',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            MaterialButton(
              onPressed: () => _cropImage(men: men),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 48,
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        '• Crop Image',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              child: MaterialButton(
                onPressed: () => _removeProfilePhoto(men: men),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 48,
                  child: Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          '• Remove photo',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //   final PickedFile? pickedFile =
  //       await _picker.getImage(source: ImageSource.camera);
  //   _userSelectedImage = File(pickedFile!.path);
  //   _croppedImageFile = null;
  //   _croppedImageFile = await ImageCropper.cropImage(
  //     sourcePath: _userSelectedImage!.path,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //     ],
  //     androidUiSettings: AndroidUiSettings(
  //         toolbarTitle: 'Adjust Image',
  //         toolbarColor: Colors.amberAccent,
  //         toolbarWidgetColor: Colors.white,
  //         initAspectRatio: CropAspectRatioPreset.square,
  //         lockAspectRatio: false),
  //     aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
  //     cropStyle: CropStyle.circle,
  //     compressFormat: ImageCompressFormat.jpg,
  //     compressQuality: 100,
  //     maxHeight: 512,
  //     maxWidth: 512,
  //     iosUiSettings: IOSUiSettings(
  //       title: 'Adjust Image',
  //       minimumAspectRatio: 1.0,
  //     ),
  //   );

  //   // if (_croppedImageFile != null) _bloc!.setProfilePhoto(_croppedImageFile!);
  // }
}
