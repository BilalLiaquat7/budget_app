import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggleHidden(){
    let id = this.data.get('toggle')
    let element = document.getElementById(id)
    element.classList.toggle('hidden')
  }

  historyBack(){
    history.back()
  }
}
