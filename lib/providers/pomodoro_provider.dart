import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pomodoro/models/pomodoro_models.dart';
import 'package:pomodoro/utils/local_notifications.dart';
import 'package:pomodoro/utils/our_constants.dart';
import 'package:pomodoro/utils/shared_prefs.dart';

class PomodoroProvider extends ChangeNotifier with WidgetsBindingObserver {
  PomodoroModel _model = PomodoroModel();
  Timer? _workTimer;
  Timer? _breakTimer;
  int _pauseTime = 0;
  int _workTime = 0;
  int _breakTime = 0;
  bool _isPaused = false;
  PomodoroState _state = PomodoroState.working;
  int _selectedModelIndex = -1;
  final List<PomodoroModel> _modelList = [];
  AppLifecycleState _appLifecycleState = AppLifecycleState.resumed;

  //TODO: might want to store this somewhere else, e.g. repo
  final _model0 =
  PomodoroModel(name: "Preset #1", workDuration: 25, shortBreakDuration: 5, iteration: 4);
  final _model1 =
  PomodoroModel(name: "Preset #2", workDuration: 50, shortBreakDuration: 10, iteration: 2);
  final _model2 =
  PomodoroModel(name: "Preset #3", workDuration: 45, shortBreakDuration: 5, iteration: 2);

  PomodoroModel get model => _model;
  int get workTime => _workTime;
  int get breakTime => _breakTime;
  bool get isPaused => _isPaused;
  PomodoroState get state => _state;
  int get selectedModelIndex => _selectedModelIndex;
  List<PomodoroModel> get modelList => _modelList;
  AppLifecycleState get appLifecycleState => _appLifecycleState;

  PomodoroProvider() {
    providerInit();
  }

  Future<void> providerInit() async {
    WidgetsBinding.instance.addObserver(this);
    _modelList.add(_model0);
    _modelList.add(_model1);
    _modelList.add(_model2);
    final savedModel = await getSavedPomodoroPreset();
    if (savedModel != null) {
      _modelList.add(savedModel);
    }
    notifyListeners();
  }

  void selectModel(int index) {
    if (_selectedModelIndex != -1 && _selectedModelIndex == index) {
      _selectedModelIndex = -1;
      notifyListeners();
    } else {
      _selectedModelIndex = index;
      notifyListeners();
    }
  }

  //pomodoro timer stuff
  void initPomodoro(PomodoroModel model) async {
    _model = model;
    _state = PomodoroState.working;
    print("init pomodoro, model received: $_model");
    startWorking();
    await Future.delayed(const Duration(seconds: 5));
    LocalNotification().showNotification();
  }

  void startWorking() {
    print("iteration ${_model.iteration}");
    if (_pauseTime == 0) {
      _workTime = _model.workDuration;
      _breakTime = _model.shortBreakDuration;
    }
    _workTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_pauseTime >0) {
        _workTime = _pauseTime;
        _workTime--;
        notifyListeners();
        _pauseTime =0;
      } else if (_workTime < 1 && _model.iteration < 2) {
        _workTimer?.cancel();
        print("Pomodoro finished");
        _state = PomodoroState.finished;
        notifyListeners();
      } else if (_workTime < 1 && _model.iteration > 1) {
        _workTimer?.cancel();
        startBreak();
        notifyListeners();
      } else {
        _state = PomodoroState.working;
        _workTime--;
        print("workTime: $_workTime");
        notifyListeners();
      }
    });
  }

  void startBreak() {
    _state = PomodoroState.shortBreak;
    // _breakTime--;
    notifyListeners();
    _breakTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_pauseTime>0) {
        _breakTime = _pauseTime;
        _breakTime--;
        _pauseTime = 0;
        notifyListeners();
      }
      else if (_breakTime < 1) {
        _breakTimer?.cancel();
        _model.iteration--;
        _state = PomodoroState.working;
        startWorking();
        notifyListeners();
      } else {
        _state = PomodoroState.shortBreak;
        _breakTime--;
        print("breakTime: $_breakTime");
        notifyListeners();
      }
    });
  }

  void pause() {
    _isPaused = true;
    notifyListeners();
    if (_state == PomodoroState.working) {
      _pauseTime = _workTime;
      _workTimer?.cancel();
      print("pausing while working");
    } else if (_state == PomodoroState.shortBreak) {
      _pauseTime = _breakTime;
      _breakTimer?.cancel();
      print("pausing while break");
    } else {
      throw UnimplementedError("No such thing");
    }
  }

  void resume() {
    _isPaused = false;
    notifyListeners();
    if (_state == PomodoroState.working) {
      print("resume pause while working");
      startWorking();
    } else if (_state == PomodoroState.shortBreak) {
      print("resume pause while break");
      startBreak();
    }
  }

  void stopPomodoro() {
    if (_state == PomodoroState.working) {
      _isPaused = false;
      _workTimer?.cancel();
      _state = PomodoroState.stopped;
      notifyListeners();
    } else if (_state == PomodoroState.shortBreak) {
      _isPaused = false;
      _breakTimer?.cancel();
      _state = PomodoroState.stopped;
      notifyListeners();
    } else {
      throw UnimplementedError("No such thing");
    }
  }
  //end of pomodoro timer stuff

  //saved preset logic
  Future<bool> addPomodoroPreset(PomodoroModel model) async {
    const key = PomodoroModelConstants.modelKey;
    final modelMap = model.toMap();
    final modelJson = jsonEncode(modelMap);
    if (await SharedPrefs.isExist(key)) {
      return false; //if false, meaning already has model stored
    } else {
      final res = await SharedPrefs.saveSharedPrefs(key, SharedPrefsType.string, modelJson);
      if (!res) {
        throw Error();
      }
      _modelList.add(model);
      notifyListeners();
      return res;
    }
  }

  Future<PomodoroModel?> getSavedPomodoroPreset() async {
    const key = PomodoroModelConstants.modelKey;
    if (!await SharedPrefs.isExist(key)) {
      return null;
    } else {
      final modelJson = await SharedPrefs.readSharedPrefs(key, SharedPrefsType.string);
      final modelMap = jsonDecode(modelJson);
      return PomodoroModel.fromMap(modelMap);
    }
  }

  Future<bool> deleteSavedPreset() async {
    const key = PomodoroModelConstants.modelKey;
    final isExist = await SharedPrefs.isExist(key);
    if (!isExist) {
      throw Error();
    }
    final res = await SharedPrefs.deleteSharedPrefs(key);
    if (!res) {
      throw Error();
    }
    _modelList.removeLast();
    notifyListeners();
    return res;
  }
  //end of saved preset logic

  //app lifecycle stuff
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _appLifecycleState = state;
    notifyListeners();
    print("appLifecycleState is $_appLifecycleState");
  }

  //end of app lifecycle stuff

  @override
  void dispose() {
    _workTimer?.cancel();
    super.dispose();
  }

  @override
  String toString() {
    return "{ Model: $model";
  }
}

enum PomodoroState { working, shortBreak, finished, paused, stopped }
