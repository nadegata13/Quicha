// @Default(false) bool isClickedEntryButton,
// @Default(0) int icon,
// @Default("name") String nickname,
// @Default("") String lifeUpTime,
// @Default(0) int lifeCount,


class PassAccountInfoData{

  final String nickname;
  final int icon;
  final String lifeUpdateStr;
  final int lifeCount;


  PassAccountInfoData({required this.icon, required this.nickname,
  required this.lifeUpdateStr, required this.lifeCount});
}

class SuccessUpdateLifeData{
  final int lifeCount;
  final String lifeUpdateStr;
  SuccessUpdateLifeData({required this.lifeCount, required this.lifeUpdateStr});
}
