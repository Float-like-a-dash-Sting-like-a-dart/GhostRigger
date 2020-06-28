class PieceModel {
  bool isDraggable;
  int positionInBoardColumn;
  int positionInBoardRow;
  int arithmeticValue;
  bool hastTopCable;
  bool hastRightCable;
  bool hastBottomCable;
  bool hastLeftCable;
  PieceModel(
      {
        this.isDraggable = true,
        this.positionInBoardColumn = -1,
        this.positionInBoardRow = -1,
        this.arithmeticValue = 0,
        this.hastTopCable = false,
        this.hastRightCable = false,
        this.hastBottomCable = false,
        this.hastLeftCable = false,
      });
}