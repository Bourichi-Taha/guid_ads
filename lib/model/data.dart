import 'package:guid/main.dart';

class Data {
  String? appName;
  String? appIcon;
  String? cover;
  String? mainColor;
  String? contact;
  String? about;
  String? privacy;
  String? terms;
  List<Intro>? intro;
  List<Chapters>? chapters;
  List<AdConfig>? adConfig;

  Data(
      {this.appName,
      this.appIcon,
      this.cover,
      this.mainColor,
      this.contact,
      this.about,
      this.privacy,
      this.terms,
      this.intro,
      this.chapters});

  Data.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    appIcon = json['app_icon'];
    cover = json['cover'];
    mainColor = json['main_color'];
    contact = json['contact'];
    about = json['about'];
    privacy = json['privacy'];
    terms = json['terms'];
    if (json['ad_priority'] != null) {
      adConfig = <AdConfig>[];
      json['ad_priority'].forEach((v) {
        adConfig!.add(AdConfig.fromJson(v));
      });

      adConfig!.sort((a, b) => a.priority!.compareTo(b.priority!));

      switch (adConfig![0].network) {
        case 'AdMob':
          selectedAdNetwork = AdNetwork.admob;
          break;
        case 'UnityAds':
          selectedAdNetwork = AdNetwork.unity;
          break;
        case 'MetaAds':
          selectedAdNetwork = AdNetwork.facebook;
          break;
        case 'AppLovin':
          selectedAdNetwork = AdNetwork.applovin;
          break;
      }
    }
    if (json['intro'] != null) {
      intro = <Intro>[];
      json['intro'].forEach((v) {
        intro!.add(Intro.fromJson(v));
      });
    }
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['app_icon'] = appIcon;
    data['cover'] = cover;
    data['main_color'] = mainColor;
    data['contact'] = contact;
    data['about'] = about;
    data['privacy'] = privacy;
    data['terms'] = terms;
    if (intro != null) {
      data['intro'] = intro!.map((v) => v.toJson()).toList();
    }
    if (chapters != null) {
      data['chapters'] = chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdConfig {
  String? network;
  int? priority;

  AdConfig({this.network, this.priority});

  AdConfig.fromJson(Map<String, dynamic> json) {
    network = json['network'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['network'] = network;
    data['priority'] = priority;
    return data;
  }
}

class Intro {
  String? title;
  String? description;
  String? icon;

  Intro({this.title, this.description, this.icon});

  Intro.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class Chapters {
  String? title;
  String? summary;
  String? cover;
  int? order;
  List<Articles>? articles;

  Chapters({this.title, this.summary, this.cover, this.order, this.articles});

  Chapters.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    summary = json['summary'];
    cover = json['cover'];
    order = json['order'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['summary'] = summary;
    data['cover'] = cover;
    data['order'] = order;
    if (articles != null) {
      data['articles'] = articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  String? icon;
  String? title;
  String? shortTitle;
  int? order;
  List<Items>? items;

  Articles({this.icon, this.title, this.shortTitle, this.order, this.items});

  Articles.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    shortTitle = json['shortTitle'];
    order = json['order'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['title'] = title;
    data['shortTitle'] = shortTitle;
    data['order'] = order;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? index;
  String? type;
  String? content;

  Items({this.index, this.type, this.content});

  Items.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    type = json['type'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['index'] = index;
    data['type'] = type;
    data['content'] = content;
    return data;
  }
}
