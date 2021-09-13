import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morphing/app/bloc/notification/notification_bloc.dart';
import 'package:morphing/app/pages/camera/bloc/camera_bloc.dart';
import 'package:morphing/app/pages/home/model/home_model.dart';
import 'package:morphing/app/pages/register/bloc/register_bloc.dart';
import 'package:morphing/app/routes/routes.dart';
import 'package:morphing/shared/util/loader.dart';

class CameraUI extends StatefulWidget {
  @override
  _CameraUIState createState() => _CameraUIState();
}

class _CameraUIState extends State<CameraUI> {
  late CameraBloc _bloc;
  File? _userSelectedImage, _croppedImageFile;
  final ImagePicker _picker = ImagePicker();
  double _value = 5;
  // late TextEditingController _nameController;
  // late TextEditingController _emailController;
  // late TextEditingController _passController;
  // late TextEditingController _passConfirmController;

  @override
  void initState() {
    // _nameController = TextEditingController();
    // _emailController = TextEditingController();
    // _passController = TextEditingController();
    // _passConfirmController = TextEditingController();

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
          // style: SGTextStyles.pro16darkw600,
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
              // if (state is RegisterLoadingState) {
              //   return Loader.circular();
              // }
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
                        SizedBox(height: 32),
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
        SizedBox(height: 32),
        Container(
          width: (MediaQuery.of(context).size.width - 48) / 2,
          height: ((MediaQuery.of(context).size.width - 48) / 2) * (4 / 3),
          // color: SGColors.,
          child: Image.asset(
            'assets/image/men1.jpg',
            fit: BoxFit.cover,
            // alignment: Alignment.bottomCenter,
          ),
        ),
        SizedBox(height: 16),
        Slider(
          value: _value,
          onChanged: (double val) {
            setState(() {
              _value = val;
            });
          },
          min: 0,
          max: 50,
          activeColor: Colors.amberAccent,
          inactiveColor: Colors.amberAccent.withOpacity(0.5),
        ),
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
          height: ((MediaQuery.of(context).size.width - 48) / 2) * (4 / 3),
          // color: SGColors.,
          child: Image.asset(
            'assets/image/men1.jpg',
            fit: BoxFit.cover,
            // alignment: Alignment.bottomCenter,
          ),
        ),
        SizedBox(height: 36),
        MaterialButton(
          color: Colors.amberAccent,
          child: Text('Men'),
          onPressed: () {
            _showProfileUploadBottomSheet(context);
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
          height: ((MediaQuery.of(context).size.width - 48) / 2) * (4 / 3),
          // color: SGColors.,
          child: Image.asset(
            'assets/image/pet1.jpg',
            fit: BoxFit.cover,
            // alignment: Alignment.bottomCenter,
          ),
        ),
        SizedBox(height: 36),
        MaterialButton(
          color: Colors.amberAccent,
          child: Text('Pet'),
          onPressed: () {},
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
      height: 48,
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
            Text('Morph it',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 24)),
          ],
        ),
      ),
    );
  }

  dynamic _showProfileUploadBottomSheet(BuildContext context) {
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
        height: 236, // _bloc!.isUserHasPhoto ? 236 : 180,
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
              onPressed: () => getCameraImage(context),
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
              onPressed: () => getGalleyImage(context),
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
            Visibility(
              // visible: !_bloc!.isPlaceholderAvatar!,
              child: MaterialButton(
                onPressed: () {}, // => _removeProfilePhoto(context),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 48,
                  child: Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          '• Remove photo',
                          // style: SGTextStyles.pro16dark,
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

  Future<void> getGalleyImage(BuildContext context) async {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    _userSelectedImage = File(pickedFile!.path);
    _croppedImageFile = null;
    _croppedImageFile = await ImageCropper.cropImage(
      sourcePath: _userSelectedImage!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Adjust Image',
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
        title: 'Adjust Image',
        minimumAspectRatio: 1.0,
      ),
    );
    // if (_croppedImageFile != null) _bloc!.setProfilePhoto(_croppedImageFile!);
  }

  Future<void> getCameraImage(BuildContext context) async {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.camera);
    _userSelectedImage = File(pickedFile!.path);
    _croppedImageFile = null;
    _croppedImageFile = await ImageCropper.cropImage(
      sourcePath: _userSelectedImage!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Adjust Image',
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
        title: 'Adjust Image',
        minimumAspectRatio: 1.0,
      ),
    );

    // if (_croppedImageFile != null) _bloc!.setProfilePhoto(_croppedImageFile!);
  }
}
