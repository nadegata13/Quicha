enum CharacterIcons {
  default_human,
  default_bird,
  default_cat,
  default_sheep,
  default_turtle,
  default_wolf,
}

extension IconsPath on CharacterIcons {
  static final path = {
    CharacterIcons.default_human: "assets/images/character_icon/human.svg",
    CharacterIcons.default_bird: "assets/images/character_icon/bird.svg",
    CharacterIcons.default_cat: "assets/images/character_icon/cat.svg",
    CharacterIcons.default_sheep: "assets/images/character_icon/sheep.svg",
    CharacterIcons.default_turtle: "assets/images/character_icon/turtle.svg",
    CharacterIcons.default_wolf: "assets/images/character_icon/wolf.svg",
  };
  String get getPath => path[this]!;

}

