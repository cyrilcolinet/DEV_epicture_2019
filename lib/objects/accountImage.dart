class AccountImage {
    String id;
    String title;
    String description;
    int datetime;
    String type;
    bool animated;
    int width;
    int height;
    int size;
    int views;
    int bandwidth;
    bool favorite;
    String accountUrl;
    int accountId;
    bool isAd;
    bool inMostViral;
    bool hasSound;
    int adType;
    String adUrl;
    String edited;
    bool inGallery;
    String deletehash;
    String name;
    String link;

    AccountImage(
        {this.id,
            this.title,
            this.description,
            this.datetime,
            this.type,
            this.animated,
            this.width,
            this.height,
            this.size,
            this.views,
            this.bandwidth,
            this.favorite,
            this.accountUrl,
            this.accountId,
            this.isAd,
            this.inMostViral,
            this.hasSound,
            this.adType,
            this.adUrl,
            this.edited,
            this.inGallery,
            this.deletehash,
            this.name,
            this.link});

    AccountImage.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        title = json['title'];
        description = json['description'];
        datetime = json['datetime'];
        type = json['type'];
        animated = json['animated'];
        width = json['width'];
        height = json['height'];
        size = json['size'];
        views = json['views'];
        bandwidth = json['bandwidth'];
        favorite = json['favorite'];
        accountUrl = json['account_url'];
        accountId = json['account_id'];
        isAd = json['is_ad'];
        inMostViral = json['in_most_viral'];
        hasSound = json['has_sound'];
        adType = json['ad_type'];
        adUrl = json['ad_url'];
        edited = json['edited'];
        inGallery = json['in_gallery'];
        deletehash = json['deletehash'];
        name = json['name'];
        link = json['link'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['title'] = this.title;
        data['description'] = this.description;
        data['datetime'] = this.datetime;
        data['type'] = this.type;
        data['animated'] = this.animated;
        data['width'] = this.width;
        data['height'] = this.height;
        data['size'] = this.size;
        data['views'] = this.views;
        data['bandwidth'] = this.bandwidth;
        data['favorite'] = this.favorite;
        data['account_url'] = this.accountUrl;
        data['account_id'] = this.accountId;
        data['is_ad'] = this.isAd;
        data['in_most_viral'] = this.inMostViral;
        data['has_sound'] = this.hasSound;
        data['ad_type'] = this.adType;
        data['ad_url'] = this.adUrl;
        data['edited'] = this.edited;
        data['in_gallery'] = this.inGallery;
        data['deletehash'] = this.deletehash;
        data['name'] = this.name;
        data['link'] = this.link;
        return data;
    }
}