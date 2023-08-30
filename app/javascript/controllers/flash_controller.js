import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "element" ]

  show() {
    this.elementTargets.forEach(el => {
      el.hidden = false
    });
  }

  close() {
    this.elementTargets.forEach(el => {
      el.classList.add('transform', 'opacity-0', 'transition', 'duration-1000');
      setTimeout(() => el.remove(), 500)
    });
  }

  toggle() {
    this.elementTargets.forEach((el) => {
      el.hidden = !el.hidden
    });
  }
}
