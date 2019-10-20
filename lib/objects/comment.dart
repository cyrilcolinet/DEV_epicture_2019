/// Comments of the [Image]
class Comment {
    int id;
    String imageId;
    String comment;
    String author;
    int authorId;
    bool onAlbum;
    String albumCover;
    int ups;
    int downs;
    int points;
    int datetime;
    int parentId;
    bool deleted;
    String platform;
    List<Children> children;

    /// Constructor
    Comment({this.id, this.imageId, this.comment, this.author, this.authorId,
            this.onAlbum, this.albumCover, this.ups, this.downs, this.points,
            this.datetime, this.parentId, this.deleted, this.platform,
            this.children});

    /// Convert json into this class
    Comment.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        imageId = json['image_id'];
        comment = json['comment'];
        author = json['author'];
        authorId = json['author_id'];
        onAlbum = json['on_album'];
        albumCover = json['album_cover'];
        ups = json['ups'];
        downs = json['downs'];
        points = json['points'];
        datetime = json['datetime'];
        parentId = json['parent_id'];
        deleted = json['deleted'];
        platform = json['platform'];
        if (json['children'] != null) {
            children = new List<Children>();
            json['children'].forEach((v) {
                children.add(new Children.fromJson(v));
            });
        }
    }

    /// Convert class into json
    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['image_id'] = this.imageId;
        data['comment'] = this.comment;
        data['author'] = this.author;
        data['author_id'] = this.authorId;
        data['on_album'] = this.onAlbum;
        data['album_cover'] = this.albumCover;
        data['ups'] = this.ups;
        data['downs'] = this.downs;
        data['points'] = this.points;
        data['datetime'] = this.datetime;
        data['parent_id'] = this.parentId;
        data['deleted'] = this.deleted;
        data['platform'] = this.platform;
        if (this.children != null)
            data['children'] = this.children.map((v) => v.toJson()).toList();
        return data;
    }
}

/// Children class depended to [Comment]
class Children {
    int id;
    String imageId;
    String comment;
    String author;
    int authorId;
    bool onAlbum;
    String albumCover;
    int ups;
    int downs;
    int points;
    int datetime;
    int parentId;
    bool deleted;
    String platform;
    List<Children> children;

    /// Constructor
    Children({this.id, this.imageId, this.comment, this.author, this.authorId,
            this.onAlbum, this.albumCover, this.ups, this.downs, this.points,
            this.datetime, this.parentId, this.deleted, this.platform,
            this.children});

    /// Create class from json
    Children.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        imageId = json['image_id'];
        comment = json['comment'];
        author = json['author'];
        authorId = json['author_id'];
        onAlbum = json['on_album'];
        albumCover = json['album_cover'];
        ups = json['ups'];
        downs = json['downs'];
        points = json['points'];
        datetime = json['datetime'];
        parentId = json['parent_id'];
        deleted = json['deleted'];
        platform = json['platform'];
        if (json['children'] != null) {
            children = new List<Children>();
            json['children'].forEach((v) {
                children.add(new Children.fromJson(v));
            });
        }
    }

    /// Convert class to json
    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['image_id'] = this.imageId;
        data['comment'] = this.comment;
        data['author'] = this.author;
        data['author_id'] = this.authorId;
        data['on_album'] = this.onAlbum;
        data['album_cover'] = this.albumCover;
        data['ups'] = this.ups;
        data['downs'] = this.downs;
        data['points'] = this.points;
        data['datetime'] = this.datetime;
        data['parent_id'] = this.parentId;
        data['deleted'] = this.deleted;
        data['platform'] = this.platform;
        if (this.children != null)
            data['children'] = this.children.map((v) => v.toJson()).toList();
        return data;
    }
}