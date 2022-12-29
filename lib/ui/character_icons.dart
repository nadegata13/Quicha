enum CharacterIcons {
  default_azarashi,
  penguin,
  default_hippo,
  default_fox,
  default_cow,
  default_wolf;

  static CharacterIcons  getIcon(int index){
  for(var icon in CharacterIcons.values){
    if(icon.index == index) {
      return icon;
    }
  }
  return CharacterIcons.default_azarashi;
}

}

extension IconsPath on CharacterIcons {
  static final path = {
    CharacterIcons.default_azarashi: "assets/images/character_icon/azarashi.png",
    CharacterIcons.penguin: "assets/images/character_icon/penguin.png",
    CharacterIcons.default_hippo: "assets/images/character_icon/hippo.png",
    CharacterIcons.default_fox: "assets/images/character_icon/fox.png",
    CharacterIcons.default_cow: "assets/images/character_icon/cow.png",
    CharacterIcons.default_wolf: "assets/images/character_icon/wolf.png",
  };
  String get getPath => path[this]!;

}

