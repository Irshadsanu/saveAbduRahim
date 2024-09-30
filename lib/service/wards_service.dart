import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import '../Views/panjayath_model.dart';
import '../Views/reportModel.dart';
import '../Views/unit_model.dart';
import '../Views/ward_model.dart';

class WardsService{
  Map <dynamic, dynamic> mapDataBase={};
  Map <dynamic, dynamic> hideWardMap={};

  WardsService(this.mapDataBase,this.hideWardMap);
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();



  Future<List<String>> getDistrict() async {
    List<String> list = [];
    Map <dynamic, dynamic> map = await getJason();
    list.add('All');
    map.forEach((key, value) {
      if(!list.contains(value['District'].toString())){
        list.add(value['District'].toString());
      }
    });
    return list;
  }

  Future<List<DistrictDropListModel>> getAllDistrict() async {
    List<DistrictDropListModel> list = [];
    Map <dynamic, dynamic> map = await getJason();
    // list.add('All');
    map.forEach((key, value) {
      if(!list.map((item) => item.district).contains(value['District'].toString())){
        list.add(DistrictDropListModel(value['State'].toString(), value['District'].toString()));
      }
    });
    return list;
  }

  Future<List<AssemblyModel>> getAssembly(String state,String district) async {
    List<AssemblyModel> list = [];
    Map <dynamic, dynamic> map = await getJason();
    list.add(AssemblyModel(district,'All'));

    map.forEach((key, value) {
      if(value['district'].toString()==district&&value['State'].toString()==state){
        if(!list.map((item) => item.assembly).contains(value['assembly'].toString())){
          list.add(AssemblyModel(district, value['assembly'].toString()));
        }
      }
    });
    return list;
  }


  Future<List<AssemblyModel>> fetchAllAssemblies() async {
    List<AssemblyModel> list = [];
    Map <dynamic, dynamic> map = await getJason();
    map.forEach((key, value) {

        if(!list.map((item) => item.assembly).contains(value['assembly'].toString())){
          list.add(AssemblyModel(value['district'].toString(), value['assembly'].toString()));
        }


    });
    return list;
  }


  Future<List<PanjayathModel>> getPanjayath(String district,String assembly) async {


    List<PanjayathModel> list = [];
    Map <dynamic, dynamic> map = await getJason();
    list.add(PanjayathModel(district,assembly,'All',0));

    map.forEach((key, value) {
      if(value['district'].toString()==district&&value['assembly'].toString()==assembly){
        if(!list.map((item) => item.panjayath).contains(value['panchayath'].toString())){
          list.add(PanjayathModel(district,assembly, value['panchayath'].toString(),0));
        }
      }
    });


    return list;
  }

  Future<List<UnitModel>> getUnit(String district,String assembly,String panjayath) async {
    List<UnitModel> list = [];
    Map <dynamic, dynamic> map = await getJason();
    list.add(UnitModel(district,assembly,panjayath,'All'));

    map.forEach((key, value) {
      if(value['district'].toString()==district&&value['assembly'].toString()==assembly&&value['panchayath'].toString()==panjayath){
        if(!list.map((item) => item.unit).contains(value['wardname'].toString())){
          list.add(UnitModel(district, assembly, panjayath, value['wardname'].toString()));
        }
      }
    });

    return list;
  }
  Future<List<WardModel>> getUnitAll() async {
    List<WardModel> list = [];
    Map <dynamic, dynamic> map = await getJason();
    map.forEach((key, value) {
      list.add(WardModel(value['district'].toString(), value['assembly'].toString(), value['panchayath'].toString(),value['wardname'].toString(), value['wardname'].toString()));
    });

    return list;
  }
  Future<Map <dynamic, dynamic>> getJason ()async {
    Map <dynamic, dynamic> map={};
    var jsonText = await rootBundle.loadString('assets/quaide_millat.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map <dynamic, dynamic> jsonMap = await jsonResponse as Map;
    Map <dynamic, dynamic> databaseMap = mapDataBase;
    Map <dynamic, dynamic> databasenewMap = hideWardMap;
    map.addAll(jsonMap);
    map.addAll(databaseMap);
    map.removeWhere((key, value) => hideWardMap.values.any((element) =>
        element['district'].toString() == value['district'].toString() &&
        element['assembly'].toString() == value['assembly'].toString() &&
        element['panchayath'].toString() == value['panchayath'].toString() &&
        element['wardname'].toString() == value['wardname'].toString()));


    return map;
  }
  Future<List<PanjayathModel>> getAllPanjayath() async {
    List<PanjayathModel> list = [];
    int i=0;
    int otherConut=5000;
    Map <dynamic, dynamic> map = await getJason();
    map.forEach((key, value) {
      if(!list.map((item) => (item.panjayath+item.assembly+item.district)).contains(value['panchayath'].toString()+value['assembly'].toString()+value['district'].toString())){

          list.add(PanjayathModel(value['district'].toString(), value['assembly'].toString(), value['panchayath'].toString(),i));
          i=i++;
        // else if(value['district'].toString()!='KASARGOD'){
        //   list.add(PanjayathModel(value['district'].toString(), value['assembly'].toString(), value['panchayath'].toString(),otherConut));
        // }

      }
    });
    list.sort((a, b) =>a.postion.compareTo(b.postion));
    return list;
  }
  Future<List<WardModel>> getUnitChip(String district,String panjayath) async {
    List<WardModel> list = [];
    Map <dynamic, dynamic> map = await getJason();

    map.forEach((key, value) {
      if(value['district'].toString()==district&&value['panchayath'].toString()==panjayath){
        if(!list.map((item) => item.wardName).contains(value['wardname'].toString())){




          list.add(WardModel(district,value['assembly'].toString(), panjayath, value['wardname'].toString(),value['wardname'].toString()));
        }
      }
    });

    return list;
  }

  Future<List<AssemblyDropListModel>> getAssemblyChip(String state,String district) async {
    List<AssemblyDropListModel> list = [];
    Map <dynamic, dynamic> map = await getJason();

    map.forEach((key, value) {
      if(value['State'].toString()==state&&value['District'].toString()==district){
        if(!list.map((item) => item.assembly).contains(value['Assembly'].toString())){




          list.add(AssemblyDropListModel(state,district, value['Assembly'].toString()));
        }
      }
    });

    return list;
  }


}