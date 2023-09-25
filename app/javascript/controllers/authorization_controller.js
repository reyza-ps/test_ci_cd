import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ['token', 'message']
  
    connect() {
        console.log(this.element)
    }
    
    create(e) {
      console.log(e.target)
      let data = { 
        client_id: e.target.dataset.clientId, 
        redirect_uri: e.target.dataset.redirectUri, 
        response_type: e.target.dataset.response_type, 
        scope: JSON.parse(e.target.dataset.scope .replace(/&quot;/g, '\"')) 
      }
        const csrfToken = document.querySelector("[name='csrf-token']").content
        fetch('/partner/authorize', {
            method: 'POST', // *GET, POST, PUT, DELETE, etc.
            mode: 'cors', // no-cors, *cors, same-origin
            cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
            credentials: 'same-origin', // include, *same-origin, omit
            headers: {
                'Content-Type': 'application/json',
                // 'X-CSRF-Token': csrfToken
            },
            body: JSON.stringify(data) // body data type must match "Content-Type" header
        }).then(response => response)
          .then(data => {
             console.log(data)
           })
    }
}