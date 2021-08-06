part of 'test_bloc.dart';

@immutable
abstract class TestState {}

class TestInitial extends TestState {}

class TestChanged extends TestState {
  TestChanged(this.title);
  String title;
  @override
  String toString() => "TestChanged{$title}";
}
