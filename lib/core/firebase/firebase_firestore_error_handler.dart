import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreErrorHandler {
  String mapFirebaseFirestoreException(FirebaseException e) {
    switch (e.code) {
      case 'aborted':
        return 'The operation was aborted. Please try again.';
      case 'already-exists':
        return 'The document already exists.';
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'data-loss':
        return 'Unrecoverable data loss or corruption occurred.';
      case 'deadline-exceeded':
        return 'The operation took too long to complete.';
      case 'failed-precondition':
        return 'The operation was rejected because of a failed precondition.';
      case 'internal':
        return 'An internal error occurred. Please try again later.';
      case 'invalid-argument':
        return 'Invalid argument provided for this operation.';
      case 'not-found':
        return 'The requested document was not found.';
      case 'out-of-range':
        return 'The operation was attempted past the valid range.';
      case 'permission-denied':
        return 'You do not have permission to perform this action.';
      case 'resource-exhausted':
        return 'Resource limit exceeded (too many requests or quota exceeded).';
      case 'unauthenticated':
        return 'You need to be authenticated to perform this action.';
      case 'unavailable':
        return 'The service is currently unavailable. Please try again later.';
      case 'unimplemented':
        return 'This operation is not implemented or supported.';
      case 'unknown':
        return 'An unknown error occurred.';
      default:
        return 'An unexpected Firestore error occurred: ${e.message}';
    }
  }
}
