class PlayerSettings {
  final int aiSet;
  final int assistanceLevel;
  final bool buttonLock;

  PlayerSettings(this.aiSet, this.assistanceLevel, this.buttonLock);

  List<int> toBytes() {
    return [
      aiSet,
      assistanceLevel,
      buttonLock ? 1 : 0
    ];
  }
}