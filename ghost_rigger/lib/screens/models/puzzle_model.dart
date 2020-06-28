import 'piece_model.dart';

class PuzzleModel {
  List<List<int>> validCellPositions;
  List<PieceModel> pieces;
  int goal;
  PuzzleModel(
      this.validCellPositions,
      this.pieces,
      this.goal,
      );
}