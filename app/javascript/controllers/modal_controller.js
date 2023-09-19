import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "form"]

  open(event) {
    event.preventDefault();

    this.modalTarget.showModal();

    this.modalTarget.addEventListener('click', (e) => this._backdropClick(e));
  }

  close(event) {
    event.preventDefault();

    this.modalTarget.close();

    this.formTarget.reset()
  }

  _backdropClick(event) {
    event.target === this.modalTarget && this.close(event)
  }
}