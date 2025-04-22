import Foundation

class AlertPresenter: AlertPresenterProtocol {
    weak var delegate: AlertPresenterDelegate?
    func setup(delegate: AlertPresenterDelegate) {
            self.delegate = delegate
        }
    func showQuizResult() {
        delegate?.didReceiveQuizResult()
    }
}
