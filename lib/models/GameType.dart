enum GameType {
  phoneAI,      // Used if the board is using the phone AI instead of built-in AI.
  remoteGame,   // Used for playing over the board with a remote game like Lichess.
  remote,       // Not used for board play
  lesson,       // Special Mode for lessons
  phoneOTB,     // Used when playing over the board but wit the phone's assistance instead of the builtin assistance.
  buildinAI,    // Sets the board to built in AI mode. The phone doesn’t have to set this. This is set if the user button toggles over to AI mode.
  noPhoneOTB,   // Default value. Chosen through UI button. N/A for phone.
}