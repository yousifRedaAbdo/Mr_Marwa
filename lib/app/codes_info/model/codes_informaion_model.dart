class GetCodesInfoModel {
  String? state;
  List<Data>? data;

  GetCodesInfoModel({this.state, this.data});

  GetCodesInfoModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? patchid;
  String? teacherid;
  String? patchname;
  List<Patchnumberofcodes>? patchnumberofcodes;
  List<Patchnumberofusedcodes>? patchnumberofusedcodes;
  List<Patchnumberofnotusedcodes>? patchnumberofnotusedcodes;

  Data(
      {this.patchid,
        this.teacherid,
        this.patchname,
        this.patchnumberofcodes,
        this.patchnumberofusedcodes,
        this.patchnumberofnotusedcodes});

  Data.fromJson(Map<String, dynamic> json) {
    patchid = json['patchid'];
    teacherid = json['teacherid'];
    patchname = json['patchname'];
    if (json['patchnumberofcodes'] != null) {
      patchnumberofcodes = <Patchnumberofcodes>[];
      json['patchnumberofcodes'].forEach((v) {
        patchnumberofcodes!.add(new Patchnumberofcodes.fromJson(v));
      });
    }
    if (json['patchnumberofusedcodes'] != null) {
      patchnumberofusedcodes = <Patchnumberofusedcodes>[];
      json['patchnumberofusedcodes'].forEach((v) {
        patchnumberofusedcodes!.add(new Patchnumberofusedcodes.fromJson(v));
      });
    }
    if (json['patchnumberofnotusedcodes'] != null) {
      patchnumberofnotusedcodes = <Patchnumberofnotusedcodes>[];
      json['patchnumberofnotusedcodes'].forEach((v) {
        patchnumberofnotusedcodes!
            .add(new Patchnumberofnotusedcodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patchid'] = this.patchid;
    data['teacherid'] = this.teacherid;
    data['patchname'] = this.patchname;
    if (this.patchnumberofcodes != null) {
      data['patchnumberofcodes'] =
          this.patchnumberofcodes!.map((v) => v.toJson()).toList();
    }
    if (this.patchnumberofusedcodes != null) {
      data['patchnumberofusedcodes'] =
          this.patchnumberofusedcodes!.map((v) => v.toJson()).toList();
    }
    if (this.patchnumberofnotusedcodes != null) {
      data['patchnumberofnotusedcodes'] =
          this.patchnumberofnotusedcodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Patchnumberofcodes {
  String? numberofcodes;

  Patchnumberofcodes({this.numberofcodes});

  Patchnumberofcodes.fromJson(Map<String, dynamic> json) {
    numberofcodes = json['numberofcodes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numberofcodes'] = this.numberofcodes;
    return data;
  }
}

class Patchnumberofusedcodes {
  String? numberofusedcodes;

  Patchnumberofusedcodes({this.numberofusedcodes});

  Patchnumberofusedcodes.fromJson(Map<String, dynamic> json) {
    numberofusedcodes = json['numberofusedcodes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numberofusedcodes'] = this.numberofusedcodes;
    return data;
  }
}

class Patchnumberofnotusedcodes {
  String? numberofnotusedcodes;

  Patchnumberofnotusedcodes({this.numberofnotusedcodes});

  Patchnumberofnotusedcodes.fromJson(Map<String, dynamic> json) {
    numberofnotusedcodes = json['numberofnotusedcodes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numberofnotusedcodes'] = this.numberofnotusedcodes;
    return data;
  }
}
