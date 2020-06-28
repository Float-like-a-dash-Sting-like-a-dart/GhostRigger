class PieceModel {
  String spriteName;
  bool isDraggable;
  int positionInBoardColumn;
  int positionInBoardRow;
  PieceModel(this.spriteName, { this.isDraggable = true, this.positionInBoardColumn = -1, this.positionInBoardRow = -1 });
}