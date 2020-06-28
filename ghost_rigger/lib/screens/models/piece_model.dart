class PieceModel {
  int positionInBoardColumn;
  int positionInBoardRow;
  int arithmeticValue;
  ArithmeticOperation arithmeticOperation;
  bool hastTopCable;
  bool hastRightCable;
  bool hastBottomCable;
  bool hastLeftCable;
  bool isInOrOut;
  PieceModel(
      {
        this.positionInBoardColumn = -1,
        this.positionInBoardRow = -1,
        this.arithmeticValue = 0,
        this.arithmeticOperation,
        this.hastTopCable = false,
        this.hastRightCable = false,
        this.hastBottomCable = false,
        this.hastLeftCable = false,
        this.isInOrOut = false,
      });
}

enum ArithmeticOperation {
  add,
  subtract,
  multiply,
}