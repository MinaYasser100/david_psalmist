import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

abstract class ScannerRepo {
  Future<Either<String, String>> scanQRCode(MobileScannerController controller);
}

class ScannerRepoImpl implements ScannerRepo {
  @override
  Future<Either<String, String>> scanQRCode(
    MobileScannerController controller,
  ) async {
    final completer = Completer<Either<String, String>>();
    StreamSubscription<BarcodeCapture>? subscription;

    try {
      subscription = controller.barcodes.listen(
        (capture) {
          if (capture.barcodes.isNotEmpty && !completer.isCompleted) {
            final scannedCode = capture.barcodes.first.rawValue ?? '';
            if (scannedCode.isNotEmpty) {
              completer.complete(Right(scannedCode));
            }
          }
        },
        onError: (error) {
          if (!completer.isCompleted) {
            completer.complete(Left('Error scanning QR: $error'));
          }
        },
      );

      return await completer.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          return const Left('Scan timed out');
        },
      );
    } catch (e) {
      return Left('Unexpected error: $e');
    } finally {
      await subscription?.cancel();
    }
  }
}
