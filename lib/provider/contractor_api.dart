import 'package:ai_flutter/provider/api_provider.dart';
import 'package:http/http.dart' as http;
import './provider_utils.dart' as provUtil;

/* Get Contractor Type from API */
class ContractorTypeAPI extends ApiProvider {
  ContractorTypeAPI();

  Future<dynamic> getContractorType() async {
    String _url = '$endPoint/get_type_contractor';
    return provUtil.getDataFromAPI(_url, this.headers);
    // return await http.get(Uri.parse(_url), headers: headers);
    // return response;
  }

  // Future<dynamic> getContractorTypeAsPostman() async {
  //   var request = http.Request('GET', Uri.parse('https://www.trrgroup.advancedis.co.th/api/get_type_contractor'));
  //   http.StreamedResponse response = await request.send();
  //   return response;
  // }
}

/* Get Contractor List from API */
class ContractorListAPI extends ApiProvider {
  int contractorTypeID;
  int factoryID;

  ContractorListAPI(this.contractorTypeID, this.factoryID);

  Future<dynamic> getContractorList() async {
    // get contractor list by send following parameters - contractorTypeID, factoryID
    // Url should be https://www.trrgroup.advancedis.co.th/api/get_contractor_list/contractoryTypeID/factoryID
    String _url = '$endPoint/get_contractor_list/$contractorTypeID/$factoryID';
    return provUtil.getDataFromAPI(_url, this.headers);

    // return await http.get(Uri.parse(_url), headers: headers);
    // var request = http.Request('GET', Uri.parse(_url));
    // var request = http.Request('GET', Uri.parse('https://www.trrgroup.advancedis.co.th/api/get_contractor_list/$contractorTypeID/$factoryID'));
    // http.StreamedResponse response = await request.send();
    // return response;
  }
}

/* Get Contractor Detail from API */
class ContractorDetailAPI extends ApiProvider {
  int contractorID;

  ContractorDetailAPI(this.contractorID);

  Future<dynamic> getContractorDetail() async {
    // get contractor detail by sending contractorID as parammeter
    String _url = '$endPoint/get_contractor_data/$contractorID';
    return provUtil.getDataFromAPI(_url, this.headers);

    // var response = await getDataFromAPI(_url, this.headers);
    // print((response as http.Response).body);
    // return response;
    // return getDataFromAPI(_url, this.headers);

    // var request = http.Request('GET', Uri.parse('https://www.trrgroup.advancedis.co.th/api/get_contractor_data/$contractorID'));
    // http.StreamedResponse response = await request.send();
    // return response;
  }
}
