/// id : 72
/// title : "Công Nghệ Thay Đổi Cuộc Sống: Tương Lai Đang Gõ Cửa"
/// slug : "công-nghệ-thay-đổi-cuộc-sống:-tương-lai-đang-gõ-cửa"
/// content : "<h3 id=\"1-m-u\"><strong>1. Mở đầu</strong></h3><p><br>Chúng ta đang sống trong một kỷ nguyên mà mọi thứ đều có thể được số hóa. Từ việc mua sắm, học tập, đến chăm sóc sức khỏe — công nghệ đã và đang len lỏi vào mọi khía cạnh của cuộc sống. Nhưng liệu bạn đã thực sự hiểu rõ công nghệ sẽ thay đổi tương lai của chúng ta như thế nào?</p><hr><h3 id=\"2-tr-tu-nhn-to-ai-ngi-ng-hnh-mi\"><strong>2. Trí Tuệ Nhân Tạo (AI): Người Đồng Hành Mới</strong></h3><p><br>Không chỉ xuất hiện trong phim viễn tưởng, AI ngày nay đã được ứng dụng rộng rãi trong cuộc sống thực:</p><ul><li><p>Từ ChatGPT trả lời câu hỏi của bạn,</p></li><li><p>Đến các trợ lý ảo như Siri hay Google Assistant,</p></li><li><p>Hay các hệ thống đề xuất thông minh trên Netflix và Shopee.</p></li></ul><p>👉 <strong>Tương lai?</strong> AI có thể thay thế con người trong nhiều lĩnh vực như chăm sóc khách hàng, kế toán, thậm chí là y tế.</p><hr><h3 id=\"3-internet-vn-vt-iot-mi-th-u-kt-ni\"><strong>3. Internet Vạn Vật (IoT): Mọi Thứ Đều Kết Nối</strong></h3><p><br>Tủ lạnh biết khi nào hết sữa, đèn tự động bật khi bạn về nhà, hệ thống nhà thông minh giúp tiết kiệm điện… Tất cả là nhờ IoT.</p><p>🔗 Dự đoán đến năm 2030, sẽ có hơn <strong>50 tỷ thiết bị kết nối Internet</strong> trên toàn cầu.</p><hr><h3 id=\"4-cng-ngh-sinh-hc-cuc-cch-mng-trong-y-t\"><strong>4. Công Nghệ Sinh Học: Cuộc Cách Mạng Trong Y Tế</strong></h3><p><br>Ứng dụng AI trong phân tích gene, in 3D nội tạng thay thế, vaccine mRNA phát triển siêu tốc... Tất cả đang làm nên bước tiến vượt bậc trong lĩnh vực chăm sóc sức khỏe.</p><p>🧬 <strong>Tương lai gần:</strong> Bệnh hiểm nghèo sẽ được phát hiện và điều trị ngay từ giai đoạn đầu nhờ dữ liệu lớn (Big Data) và AI y tế.</p><hr><h3 id=\"5-kt-lun-bn-sn-sng-cho-tng-lai\"><strong>5. Kết luận: Bạn Sẵn Sàng Cho Tương Lai?</strong></h3><p><br>Công nghệ không chỉ là công cụ, nó là <strong>chìa khóa mở ra thế giới mới</strong>. Việc hiểu, học và thích nghi với công nghệ là cách duy nhất để không bị tụt lại phía sau.</p>"
/// description : "Chúng ta đang sống trong một kỷ nguyên mà mọi thứ đều có thể được số hóa. Từ việc mua sắm, học tập, đến chăm sóc sức khỏe"
/// thumbnailUrl : "https://pub-edf0065f73cf45bdac72556af3e3d438.r2.dev/image-1-1.png"
/// createdAt : "21/04/2025"
/// isPublished : true
/// categoryDto : {"id":5,"name":"Deploy","slug":"deploy"}
/// seriesId : null
/// isSeries : null
/// seriesOrder : null
/// authorDto : {"username":"nguyentan1378","email":"tannmo@gmail.com","displayName":"nguyen tan","createdAt":"2025-04-09T06:59:47.499561"}
/// tableOfContents : [{"text":"1. Mở đầu","level":3,"orderNumber":0},{"text":"2. Trí Tuệ Nhân Tạo (AI): Người Đồng Hành Mới","level":3,"orderNumber":1},{"text":"3. Internet Vạn Vật (IoT): Mọi Thứ Đều Kết Nối","level":3,"orderNumber":2},{"text":"4. Công Nghệ Sinh Học: Cuộc Cách Mạng Trong Y Tế","level":3,"orderNumber":3},{"text":"5. Kết luận: Bạn Sẵn Sàng Cho Tương Lai?","level":3,"orderNumber":4}]

class BlogDetailEntity {
  BlogDetailEntity({
      int? id, 
      String? title, 
      String? slug, 
      String? content, 
      String? description, 
      String? thumbnailUrl, 
      String? createdAt, 
      bool? isPublished, 
      CategoryDto? categoryDto, 
      dynamic seriesId, 
      dynamic isSeries, 
      dynamic seriesOrder, 
      AuthorDto? authorDto, 
      List<TableOfContents>? tableOfContents,}){
    _id = id;
    _title = title;
    _slug = slug;
    _content = content;
    _description = description;
    _thumbnailUrl = thumbnailUrl;
    _createdAt = createdAt;
    _isPublished = isPublished;
    _categoryDto = categoryDto;
    _seriesId = seriesId;
    _isSeries = isSeries;
    _seriesOrder = seriesOrder;
    _authorDto = authorDto;
    _tableOfContents = tableOfContents;
}

  BlogDetailEntity.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _slug = json['slug'];
    _content = json['content'];
    _description = json['description'];
    _thumbnailUrl = json['thumbnailUrl'];
    _createdAt = json['createdAt'];
    _isPublished = json['isPublished'];
    _categoryDto = json['categoryDto'] != null ? CategoryDto.fromJson(json['categoryDto']) : null;
    _seriesId = json['seriesId'];
    _isSeries = json['isSeries'];
    _seriesOrder = json['seriesOrder'];
    _authorDto = json['authorDto'] != null ? AuthorDto.fromJson(json['authorDto']) : null;
    if (json['tableOfContents'] != null) {
      _tableOfContents = [];
      json['tableOfContents'].forEach((v) {
        _tableOfContents?.add(TableOfContents.fromJson(v));
      });
    }
  }
  int? _id;
  String? _title;
  String? _slug;
  String? _content;
  String? _description;
  String? _thumbnailUrl;
  String? _createdAt;
  bool? _isPublished;
  CategoryDto? _categoryDto;
  dynamic _seriesId;
  dynamic _isSeries;
  dynamic _seriesOrder;
  AuthorDto? _authorDto;
  List<TableOfContents>? _tableOfContents;

  int? get id => _id;
  String? get title => _title;
  String? get slug => _slug;
  String? get content => _content;
  String? get description => _description;
  String? get thumbnailUrl => _thumbnailUrl;
  String? get createdAt => _createdAt;
  bool? get isPublished => _isPublished;
  CategoryDto? get categoryDto => _categoryDto;
  dynamic get seriesId => _seriesId;
  dynamic get isSeries => _isSeries;
  dynamic get seriesOrder => _seriesOrder;
  AuthorDto? get authorDto => _authorDto;
  List<TableOfContents>? get tableOfContents => _tableOfContents;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['slug'] = _slug;
    map['content'] = _content;
    map['description'] = _description;
    map['thumbnailUrl'] = _thumbnailUrl;
    map['createdAt'] = _createdAt;
    map['isPublished'] = _isPublished;
    if (_categoryDto != null) {
      map['categoryDto'] = _categoryDto?.toJson();
    }
    map['seriesId'] = _seriesId;
    map['isSeries'] = _isSeries;
    map['seriesOrder'] = _seriesOrder;
    if (_authorDto != null) {
      map['authorDto'] = _authorDto?.toJson();
    }
    if (_tableOfContents != null) {
      map['tableOfContents'] = _tableOfContents?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// text : "1. Mở đầu"
/// level : 3
/// orderNumber : 0

class TableOfContents {
  TableOfContents({
      String? text, 
      int? level, 
      int? orderNumber,}){
    _text = text;
    _level = level;
    _orderNumber = orderNumber;
}

  TableOfContents.fromJson(dynamic json) {
    _text = json['text'];
    _level = json['level'];
    _orderNumber = json['orderNumber'];
  }
  String? _text;
  int? _level;
  int? _orderNumber;

  String? get text => _text;
  int? get level => _level;
  int? get orderNumber => _orderNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['level'] = _level;
    map['orderNumber'] = _orderNumber;
    return map;
  }

}

/// username : "nguyentan1378"
/// email : "tannmo@gmail.com"
/// displayName : "nguyen tan"
/// createdAt : "2025-04-09T06:59:47.499561"

class AuthorDto {
  AuthorDto({
      String? username, 
      String? email, 
      String? displayName, 
      String? createdAt,}){
    _username = username;
    _email = email;
    _displayName = displayName;
    _createdAt = createdAt;
}

  AuthorDto.fromJson(dynamic json) {
    _username = json['username'];
    _email = json['email'];
    _displayName = json['displayName'];
    _createdAt = json['createdAt'];
  }
  String? _username;
  String? _email;
  String? _displayName;
  String? _createdAt;

  String? get username => _username;
  String? get email => _email;
  String? get displayName => _displayName;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    map['email'] = _email;
    map['displayName'] = _displayName;
    map['createdAt'] = _createdAt;
    return map;
  }

}

/// id : 5
/// name : "Deploy"
/// slug : "deploy"

class CategoryDto {
  CategoryDto({
      int? id, 
      String? name, 
      String? slug,}){
    _id = id;
    _name = name;
    _slug = slug;
}

  CategoryDto.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
  }
  int? _id;
  String? _name;
  String? _slug;

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    return map;
  }

}