class MapPoint {
  String id;
  String name;
  Sex sex;

  MapPoint(this.id, this.name, {this.sex = Sex.NONE});
}

enum Sex { MAN, FEMALE, NONE }
