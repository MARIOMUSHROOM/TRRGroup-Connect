import 'package:flutter/material.dart';

import '../../../provider/contractor_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/contractor/contractor_type/bloc/contractor_type_bloc.dart';

class TestContraactorPage extends StatelessWidget {
  TestContraactorPage({Key key}) : super(key: key);

  String caption = '';

  @override
  Widget build(BuildContext context) {
    var contBloc = BlocProvider.of<ContractorTypeBloc>(context);
    return BlocBuilder<ContractorTypeBloc, ContractorTypeState>(
      builder: (context, state) {
        if (state is ContractorTypeInitial)
          caption = 'Get Contractor Type List';
        else if (state is ContractorTypeLoading)
          caption = 'Please wait...';
        else if (state is ContractorTypeLoaded)
          caption = '${contBloc.contractorTypeList.count}';
        else if (state is ContractorTypeNoData) caption = 'Contractor Type List is empty';
        return Scaffold(
          appBar: AppBar(title: Text('Test API Contractor')),
          body: Align(
            child: TextButton(
              child: Text(caption),
              onPressed: () {
                contBloc.add(ContractorTypeRequestListEvent());
              },
            ),
          ),
        );
      },
    );
  }
}
