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

  bool simulationRunning = false;
  bool simulationFinished = false;
  List<List<PieceModel>> piecesOnBoard;
  int accumulativeValue = 0;
  int output = 0;
  List<PieceModel> unvisitedPieces = List<PieceModel>();
  List<PieceModel> visitedPieces = List<PieceModel>();

  void clearSolution() {
    simulationRunning = false;
    simulationFinished = false;
    piecesOnBoard = null;
    accumulativeValue = 0;
    output = 0;
    visitedPieces = List<PieceModel>();
    unvisitedPieces = List<PieceModel>();
  }

  bool ensureSimulationIsSetUp() {
    if (!simulationRunning) {
      simulationRunning = true;

      piecesOnBoard.forEach((piecesRow) { piecesRow.where((piece) => piece != null).forEach((piece) { unvisitedPieces.add(piece); }); });
      var initialPiece = unvisitedPieces.firstWhere((piece) => piece.isInOrOut && piece.arithmeticValue != 0, orElse: () => null);
      if (initialPiece == null)
        return false;

      unvisitedPieces.remove(initialPiece);
      unvisitedPieces.insert(0, initialPiece);
    }

    return true;
  }

  bool solvePuzzle(List<List<PieceModel>> pieces) {
    clearSolution();

    this.piecesOnBoard = this.piecesOnBoard ?? pieces;
    if (!ensureSimulationIsSetUp())
      return false;

    while (unvisitedPieces.isNotEmpty) {
      if (!solveNextStep(piecesOnBoard))
        return false;
    }

    return output == goal;
  }

  bool solveNextStep(List<List<PieceModel>> pieces) {
    this.piecesOnBoard = this.piecesOnBoard ?? pieces;
    if (!ensureSimulationIsSetUp())
      return false;

    var piece = unvisitedPieces.length > 0 ? unvisitedPieces.first : null;
    if (piece == null) {
      simulationFinished = true;
      return false;
    }

    var neighbourPieceLeft = ((piece.positionInBoardColumn - 1) >= 0)
        ? piecesOnBoard[piece.positionInBoardRow][piece.positionInBoardColumn - 1]
        : null;
    var neighbourPieceTop = ((piece.positionInBoardRow - 1) >= 0)
        ? piecesOnBoard[piece.positionInBoardRow - 1][piece.positionInBoardColumn]
        : null;
    var neighbourPieceRight = ((piece.positionInBoardColumn + 1) < 8)
        ? piecesOnBoard[piece.positionInBoardRow][piece.positionInBoardColumn + 1]
        : null;
    var neighbourPieceBottom = ((piece.positionInBoardRow + 1) < 5)
        ? piecesOnBoard[piece.positionInBoardRow + 1][piece.positionInBoardColumn]
        : null;

    if (!piece.isInOrOut || piece.arithmeticValue != 0) {
      // We need a valid neighbour piece to continue
      var neighbours = [neighbourPieceLeft, neighbourPieceTop, neighbourPieceRight, neighbourPieceBottom];
      var validNeighbours = neighbours.where((neighbour) => neighbour != null && !visitedPieces.contains(neighbour)).toList();
      var connectedNeighbours = List<PieceModel>();

      // We also check that the neighbour is connected to us
      validNeighbours.forEach((unvisitedNeighbour) {
        var neighbourIsConnected = true;

        if (unvisitedNeighbour == neighbourPieceLeft && (!unvisitedNeighbour.hastRightCable || !piece.hastLeftCable))
          neighbourIsConnected = false;
        else if (unvisitedNeighbour == neighbourPieceTop && (!unvisitedNeighbour.hastBottomCable || !piece.hastTopCable))
          neighbourIsConnected = false;
        else if (unvisitedNeighbour == neighbourPieceRight && (!unvisitedNeighbour.hastLeftCable || !piece.hastRightCable))
          neighbourIsConnected = false;
        else if (unvisitedNeighbour == neighbourPieceBottom && (!unvisitedNeighbour.hastTopCable || !piece.hastBottomCable))
          neighbourIsConnected = false;

        if (neighbourIsConnected)
          connectedNeighbours.add(unvisitedNeighbour);
      });

      if (connectedNeighbours.length != 1) {
        // Either no connected neighbours or too many, no deal
        visitedPieces.add(piece);
        unvisitedPieces.remove(piece);
        simulationFinished = true;
        return false;
      } else {
        // Put the unvisited, connected neighbour at the beginning of the pending ones
        var unvisitedNeighbour = connectedNeighbours.first;
        if (unvisitedNeighbour != null) {
          unvisitedPieces.remove(unvisitedNeighbour);
          unvisitedPieces.insert(0, unvisitedNeighbour);
        }
      }
    }

    visitedPieces.add(piece);
    unvisitedPieces.remove(piece);

    if (!piece.isInOrOut) {
      switch (piece.arithmeticOperation) {
        case ArithmeticOperation.add:
          accumulativeValue += piece.arithmeticValue;
          break;
        case ArithmeticOperation.subtract:
          accumulativeValue -= piece.arithmeticValue;
          break;
        case ArithmeticOperation.multiply:
          accumulativeValue *= piece.arithmeticValue;
          break;
      }
    } else {
      if (piece.arithmeticValue != 0)
        accumulativeValue += piece.arithmeticValue;
      else {
        output = accumulativeValue;
        simulationFinished = true;
      }
    }

    return true;
  }
}