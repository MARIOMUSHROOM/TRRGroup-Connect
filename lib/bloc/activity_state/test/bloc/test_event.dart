part of 'test_bloc.dart';

@immutable
abstract class TestEvent {}

class ChangeTitle extends TestEvent {
  ChangeTitle(this.title);
  String title;
  @override
  String toString() => "ChangeTitle{}";
}
