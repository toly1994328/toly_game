import 'dart:async';

import '../model/types.dart';


mixin GameFaceLogic{
  FaceType _faceType = FaceType.common;

  final StreamController<FaceType> _faceCtrl = StreamController.broadcast();

  Stream<FaceType> get faceStream => _faceCtrl.stream;

  void emit(FaceType faceType){
    if(_faceType==faceType) return;
    _faceCtrl.add(faceType);
    _faceType= faceType;
  }
}

