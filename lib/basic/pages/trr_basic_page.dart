import 'package:flutter/material.dart';
import '../../base_class/pages/ai_base_page.dart';
import '../models/trr_object.dart';

// ignore: must_be_immutable
class TrrBasicPageStatelessWidget extends AiBaseStatelessWidget {
  final TrrData dataObj;

  TrrBasicPageStatelessWidget({Key key, this.dataObj}) : super(key: key);
}

class TrrBasicPageStatefulWidget extends AiBaseStatefulWidget {
  final TrrData dataObj;
  TrrBasicPageStatefulWidget({Key key, this.dataObj}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TrrBasicPageState();
}

class TrrBasicPageState<TrrBasicPageStatefulWidget extends AiBaseStatefulWidget> extends AiBaseState<TrrBasicPageStatefulWidget> {
  // to be implemented in subclass
}
