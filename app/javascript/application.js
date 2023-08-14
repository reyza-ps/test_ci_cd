// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// headerbar
const userMenuButton = document.getElementById('user-menu-button')
const userMenu = document.getElementById('user-menu')

userMenuButton.addEventListener('click', () => {
  if (userMenu.classList.contains('hidden')){
    userMenu.classList.remove("hidden")
    userMenu.classList.add("block")
  } else {
    userMenu.classList.remove("block")
    userMenu.classList.add("hidden")
  }
})

// Menu mobile
const closeSidebarButton = document.getElementById('close-sidebar')
const openSidebarButton = document.getElementById('open-sidebar')
const menuMobile = document.getElementById('menu-mobile')

openSidebarButton.addEventListener('click', () => {
  menuMobile.classList.remove("hidden")
  menuMobile.classList.add("block")
})

closeSidebarButton.addEventListener('click', () => {
  menuMobile.classList.remove("block")
  menuMobile.classList.add("hidden")
})
