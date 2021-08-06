import 'package:ai_flutter/bloc/activity_state/test/bloc/test_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestBlocPage extends StatefulWidget {
  const TestBlocPage({Key key}) : super(key: key);

  @override
  _TestBlocPageState createState() => _TestBlocPageState();
}

class _TestBlocPageState extends State<TestBlocPage> {
  String title = "";
  TestBloc _testBloc;
  @override
  Widget build(BuildContext context) {
    _testBloc = BlocProvider.of<TestBloc>(context);
    return BlocBuilder<TestBloc, TestState>(
      builder: (context, state) {
        if (state is TestInitial) {
          _testBloc.add(ChangeTitle("first"));
        } else if (state is TestChanged) {
          title = _testBloc.titleClass;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Column(
            children: [
              Text('AA'),
              Text('AgCCain'),
              Text(_testBloc.titleClass == null ? "" : _testBloc.titleClass),
            ],
          ),
        );
      },
    );
  }
}
